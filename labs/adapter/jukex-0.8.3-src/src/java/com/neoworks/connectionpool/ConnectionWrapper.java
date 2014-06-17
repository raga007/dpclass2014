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

import org.apache.log4j.Category;

/**
 * This class is a wrapper around a Connection, overriding the
 * close method to just inform the pool that it's available for
 * reuse again, and the isClosed method to return the state
 * of the wrapper instead of the Connection.
 *
 * @author Nick Vincent (<a href="nick@neoworks.com">nick@neoworks.com</a>)
 */
class ConnectionWrapper implements Connection
{
  private static final Category log = Category.getInstance(ConnectionWrapper.class.getName());
  private static final boolean logDebugEnabled = log.isDebugEnabled();
  private static final boolean logInfoEnabled = log.isInfoEnabled();

  // realConn should be private but we use package scope to
  // be able to test removal of bad connections
  Connection realConn;
  private ConnectionPool pool;
  private boolean isClosed = false;
  private boolean autoCommit = true;

  /**
   * Public constructor
   *
   * @param realConn The actual database connection we are wrapping
   * @param pool The ConnectionPool this Connection has been borrowed from
   */
  public ConnectionWrapper(Connection realConn, ConnectionPool pool)
  {
    this.realConn = realConn;
    this.pool = pool;

    try
    {
      safeSetAutoCommit(true);			// Get the connection into a known state
    }
    catch (SQLException se)
    {
      if (logDebugEnabled) log.debug("Possible problem - could not setAutoCommit on real connection upon construction");
    }
  }

  private void handleIsClosed() throws SQLException
  {
    if (isClosed)
    {
      throw new SQLException("Pooled connection is closed");
    }
  }

  /**
   * Inform the ConnectionPool that the ConnectionWrapper
   * is closed.
   * TODO: need to set isClosed as true;
   * call pool.wrapperClosed to close the realConn
   * @exception SQLException
   */
  public void close() throws SQLException
  {
  }

  /**
   * Returns true if the ConnectionWrapper is closed, false
   * otherwise.
   *
   * @exception SQLException
   */
  public boolean isClosed() throws SQLException
  {
    return isClosed;
  }

  // WRAPPED CONNECTION METHODS

  /**
   * Clear warnings
   *
   * @exception SQLException
   */
  public void clearWarnings() throws SQLException
  {
    handleIsClosed();
    realConn.clearWarnings();
  }

  public void commit() throws SQLException
  {
    handleIsClosed();
    realConn.commit();
  }

  public Statement createStatement() throws SQLException
  {
    handleIsClosed();
    return realConn.createStatement();
  }

  public Statement createStatement(int resultSetType, int resultSetConcurrency) throws SQLException
  {
    handleIsClosed();
    return realConn.createStatement(resultSetType, resultSetConcurrency);
  }

  public Statement createStatement(int resultSetType, int resultSetConcurrency, int resultSetHoldability) throws SQLException
  {
    handleIsClosed();
    return realConn.createStatement(resultSetType, resultSetConcurrency, resultSetHoldability);
  }

  public boolean getAutoCommit() throws SQLException
  {
    handleIsClosed();
    // Note that this is cached as changing the autocommit can take a very
    // long time.  Also Sybase reports a big fat error here, so this can be
    // a pain.
    return autoCommit;
  }

  public String getCatalog() throws SQLException
  {
    handleIsClosed();
    return realConn.getCatalog();
  }

  public DatabaseMetaData getMetaData() throws SQLException
  {
    handleIsClosed();
    return realConn.getMetaData();
  }

  public int getTransactionIsolation() throws SQLException
  {
    handleIsClosed();
    return realConn.getTransactionIsolation();
  }

  public Map<String, Class<?>> getTypeMap() throws SQLException
  {
    handleIsClosed();
    return realConn.getTypeMap();
  }

  public SQLWarning getWarnings() throws SQLException
  {
    handleIsClosed();
    return realConn.getWarnings();
  }

  public boolean isReadOnly() throws SQLException
  {
    handleIsClosed();
    return realConn.isReadOnly();
  }

  public String nativeSQL(String sql) throws SQLException
  {
    handleIsClosed();
    return realConn.nativeSQL(sql);
  }

  public CallableStatement prepareCall(String sql) throws SQLException
  {
    handleIsClosed();
    return realConn.prepareCall(sql);
  }

  public CallableStatement prepareCall(String sql, int x, int y) throws SQLException
  {
    handleIsClosed();
    return realConn.prepareCall(sql,x,y);
  }

  public CallableStatement prepareCall(String sql, int resultSetType, int resultSetConcurrency, int resultSetHoldability) throws SQLException
  {
    handleIsClosed();
    return realConn.prepareCall(sql, resultSetType, resultSetConcurrency, resultSetHoldability);
  }

  public PreparedStatement prepareStatement(String sql) throws SQLException
  {
    handleIsClosed();
    return realConn.prepareStatement(sql);
  }

  public PreparedStatement prepareStatement(String sql, int autoGeneratedKeys) throws SQLException
  {
    handleIsClosed();
    return realConn.prepareStatement(sql, autoGeneratedKeys);
  }

  public PreparedStatement prepareStatement(String sql, int[] columnIndexes) throws SQLException
  {
    handleIsClosed();
    return realConn.prepareStatement(sql, columnIndexes);
  }

  public PreparedStatement prepareStatement(String sql, String[] columnNames) throws SQLException
  {
    handleIsClosed();
    return realConn.prepareStatement(sql, columnNames);
  }

  public PreparedStatement prepareStatement(String sql, int resultSetType, int resultSetConcurrency) throws SQLException
  {
    handleIsClosed();
    return realConn.prepareStatement(sql, resultSetType, resultSetConcurrency);
  }

  public PreparedStatement prepareStatement(String sql, int resultSetType, int resultSetConcurrency, int resultSetHoldability) throws SQLException
  {
    handleIsClosed();
    return realConn.prepareStatement(sql, resultSetType, resultSetConcurrency, resultSetHoldability);
  }

  public void rollback() throws SQLException
  {
    handleIsClosed();
    realConn.rollback();
  }

  public void setAutoCommit(boolean autoCommit) throws SQLException
  {
    handleIsClosed();
    if ( autoCommit == this.autoCommit ) return;			// Already in the required state, so return.
    safeSetAutoCommit(autoCommit);
  }

  private void safeSetAutoCommit(boolean autoCommit) throws SQLException
  {
    try
    {
      realConn.setAutoCommit(autoCommit);
      this.autoCommit = autoCommit;
    }
    catch (SQLException e)
    {
      if ( e.getMessage().startsWith("SET CHAINED command not allowed within multi-statement transaction") ) 		//Feel the power of my bodge.
      {
        realConn.commit();
        realConn.setAutoCommit(autoCommit);
      }
      else
      {
        throw e;
      }
    }
  }

  public void setCatalog(String catalog) throws SQLException
  {
    handleIsClosed();
    realConn.setCatalog(catalog);
  }

  public void setReadOnly(boolean readOnly) throws SQLException
  {
    handleIsClosed();
    realConn.setReadOnly(readOnly);
  }

  public void setTransactionIsolation(int level) throws SQLException
  {
    handleIsClosed();
    realConn.setTransactionIsolation(level);
  }

  public void setTypeMap(Map<String, Class<?>> map) throws SQLException
  {
    handleIsClosed();
    realConn.setTypeMap(map);
  }

  public void setHoldability(int x) throws SQLException
  {
    handleIsClosed();
    realConn.setHoldability(x);
  }

  public int getHoldability() throws SQLException
  {
    handleIsClosed();
    return realConn.getHoldability();
  }

  public Savepoint setSavepoint() throws SQLException
  {
    handleIsClosed();
    return realConn.setSavepoint();
  }

  public Savepoint setSavepoint(String name) throws SQLException
  {
    handleIsClosed();
    return realConn.setSavepoint(name);
  }

  public void releaseSavepoint(Savepoint savepoint) throws SQLException
  {
    handleIsClosed();
    realConn.releaseSavepoint(savepoint);
  }

  public void rollback(Savepoint savepoint) throws SQLException
  {
    handleIsClosed();
    realConn.rollback(savepoint);
  }

  public void setClientInfo(String name, String value) throws SQLClientInfoException
  {
    realConn.setClientInfo(name, value);
  }

  public void setClientInfo(Properties properties) throws SQLClientInfoException
  {
    realConn.setClientInfo(properties);
  }

  public String toString()
  {
    return ( "ConnectionWrapper with real connection ["+this.realConn+"] from pool ["+this.pool+"]" );
  }

  // TODO add necessary methods to implement the java.sql.Connection;
}
