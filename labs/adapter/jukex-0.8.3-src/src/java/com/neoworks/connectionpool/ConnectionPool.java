/***************************************************************************
    Copyright          : (C) 2002 by Neoworks Limited. All rights reserved
    URL                : http://www.neoworks.com
 ***************************************************************************/
/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

package com.neoworks.connectionpool;

import java.sql.*;
import java.util.*;
import java.io.*;

import org.apache.log4j.*;

/**
 * Class to represent and manage a pool of database connections.
 * Connections may be used and then released as required, enabling a small
 * number of connections to service a large number of database operations
 * from different 
 *
 * @author Nick Vincent (<a href="mailto:nick@neoworks.com">nick@neoworks.com</a>)
 */
public class ConnectionPool
{
	private static final Category log = Category.getInstance(ConnectionPool.class.getName());
	private static final boolean logDebugEnabled = log.isDebugEnabled();
	private static final boolean logInfoEnabled = log.isInfoEnabled();
	
	private String name = null;
	private String URL = null;
	private String user = null;
	private String password = null;
	private int maxConns = 0;
	private int timeOut = 0;
	
	private int checkedOut = 0;
	private Vector freeConnections = new Vector();

	/**
	 * Public constructor
	 *
	 * @param name The name of this connection pool
	 * @param URL The database URL
	 * @param user The database username
	 * @param password The database password
	 * @param maxConns The maximum number of database connections to open
	 * @param initConns The initial number of database connections to open
	 * @param timeOut The maximum time for a client to wait for a connection from the pool
	 */
	public ConnectionPool(String name, String URL, String user, String password, int maxConns, int initConns, int timeOut)
	{	
		this.name = name;
		this.URL = URL;
		this.user = user;
		this.password = password;
		this.maxConns = maxConns;
		this.timeOut = timeOut > 0 ? timeOut : 5;
		
		initPool(initConns);

		String lf = System.getProperty("line.separator");

		if (logDebugEnabled) 
		{
			log.debug("New pool created"+ lf +
				" url=" + URL + lf +
				" user=" + user + lf +
				" password=" + password + lf +
				" initconns=" + initConns + lf +
				" maxconns=" + maxConns + lf +
				" logintimeout=" + this.timeOut + lf +
				getStats() 
			);
		}
	}

	/**
	 * Initialise the connection pool
	 *
	 * @param initConns The initial number of connections to open.
	 */
	private void initPool(int initConns)
	{
		for (int i = 0; i < initConns; i++)
		{
			try
			{
				Connection pc = newConnection();
				freeConnections.addElement(pc);
			}
			catch (SQLException e)
			{
				log.warn("Exception encountered while attempting to open initial connections", e);
			}
		}
	}

	/**
	 * Get a connection from the pool.
	 *
	 * @return The next available Connection
	 * @exception SQLException If the request for a connection times out or fails.
	 */
	public Connection getConnection() throws SQLException
	{
		//Log.report("Request for connection received", Log.DEBUG);
		try
		{
			Connection conn = getConnection(timeOut * 1000);
			return new ConnectionWrapper(conn, this);
		}
		catch (SQLException e)
		{
			log.error("Encountered an exception getting a database connection", e);
			throw e;
		}
	}

	/**
	 * Return a Connection to the pool.
	 *
	 * @param conn The Connection to return.
	 */
	synchronized void wrapperClosed(Connection conn)
	{
		// Put the connection at the end of the Vector
		freeConnections.addElement(conn);
		checkedOut--;
		notifyAll();
		if (logDebugEnabled) log.debug( "Returned connection to pool\n" + getStats() );
	}

	/**
	 * Get a connection from the pool within a certain length of time.
	 *
	 * @param timeout Maximum time to wait for a connection to become available
	 * @return The next available Connection
	 * @exception SQLException If the request times out.
	 */
	private synchronized Connection getConnection(long timeout) throws SQLException
	{
		// Get a pooled Connection from the cache or a new one.
		// Wait if all are checked out and the max limit has
		// been reached.
		long startTime = System.currentTimeMillis();
		long remaining = timeout;
		Connection conn = null;
		while ((conn = getPooledConnection()) == null)
		{
			try
			{
				if (logDebugEnabled) log.debug( "Waiting for connection. Timeout=" + remaining );
				wait(remaining);
			}
			catch (InterruptedException e)
			{ }
			remaining = timeout - (System.currentTimeMillis() - startTime);
			if (remaining <= 0)
			{
				// Timeout has expired
				if (logDebugEnabled) log.debug( "Timeout while waiting for connection" );
				throw new SQLException("getConnection() timed-out");
			}
		}
		
		// Check if the Connection is still OK
		if (!isConnectionOK(conn))
		{
			// It was bad. Try again with the remaining timeout
			if (logDebugEnabled) log.debug( "Removed selected bad connection from pool" );
			return getConnection(remaining);
		}
		checkedOut++;
		if (logDebugEnabled) log.debug( "Delivered connection from pool\n" + getStats() );
		return conn;
	}

	/**
	 * Test whether A Connection is OK.
	 *
	 * @param conn The Connection to test
	 * @return Success
	 */
	private boolean isConnectionOK(Connection conn)
	{
		Statement testStmt = null;
		try
		{
			if (!conn.isClosed())
			{
				// Try to createStatement to see if it's really alive
				testStmt = conn.createStatement();
				testStmt.close();
			}
			else
			{
				return false;
			}
		}
		catch (SQLException e)
		{
			if (testStmt != null)
			{
				try
				{
					testStmt.close();
				}
				catch (SQLException se)
				{ }
			}
			if (logDebugEnabled) log.debug( "Pooled connection was not okay" , e );
			return false;
		}
		return true;
	}

	/**
	 * Get the next free connection, creating a new one if necessary.
	 *
	 * @return The next available Connection.
	 * @exception SQLException
	 */
	private Connection getPooledConnection() throws SQLException
	{
		Connection conn = null;
		if (freeConnections.size() > 0)
		{
			// Pick the first Connection in the Vector
			// to get round-robin usage
			conn = (Connection) freeConnections.firstElement();
			freeConnections.removeElementAt(0);
		}
		else if (maxConns == 0 || checkedOut < maxConns)
		{
			conn = newConnection();
		}
		return conn;
	}

	/**
	 * Open a new connection to the database.
	 *
	 * @return the new Connection
	 * @exception SQLException
	 */
	private Connection newConnection() throws SQLException
	{
		Connection conn = null;
		if ( ( user == null) || ( user.length() == 0 ) )
		{
			conn = DriverManager.getConnection(URL);
		}
		else
		{
			conn = DriverManager.getConnection(URL, user, password);
		}
		if (logDebugEnabled) log.debug("Opened a new physical connection");
		return conn;
	}

	/**
	 * Return a Connection to the pool.
	 *
	 * @param conn The Connection to free
	 */
	public synchronized void freeConnection(Connection conn)
	{
		// Put the connection at the end of the Vector
		freeConnections.addElement(conn);
		checkedOut--;
		notifyAll();
		if (logDebugEnabled) log.debug( "Returned connection to the pool\n" + getStats() );
	}

	/**
	 * Release all free database connections.
	 */
	public synchronized void release()
	{
		Enumeration allConnections = freeConnections.elements();
		while (allConnections.hasMoreElements())
		{
			Connection con = (Connection) allConnections.nextElement();
			try
			{
				con.close();
				if (logDebugEnabled) log.debug("Closed physical connection");
			}
			catch (SQLException e)
			{
				log.warn( "Couldn't close connection" , e );
			}
		}
		freeConnections.removeAllElements();
	}

	/**
	 * Get statistical information about this ConnectionPool as a String
	 *
	 * @return A String containing the statistical information.
	 */
	private String getStats()
	{
		return "Total connections: " + (freeConnections.size() + checkedOut) + " Available: " + freeConnections.size() + " Checked-out: " + checkedOut;
	}

}
