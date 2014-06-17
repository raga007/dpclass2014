<%--
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
--%>
<%@page language="java" %>
<%@page import="com.neoworks.jukex.client.html.standard.*" %>
<%@page import="com.neoworks.jukex.*" %>
<%@page import="java.util.*" %>
<%@page import="com.neoworks.jukex.query.*" %>
<%@page errorPage="error.jsp" %>
<%@page contentType="text/html"%>

<%
	String contextRootURL = request.getContextPath() + "/";
	AttributeValueResultSet avrs = (AttributeValueResultSet) request.getAttribute( "tracklist" );
	String browseLetter = (String)request.getAttribute("browseLetter");
	String queryString = (String)request.getAttribute("queryString");
	List columns = (List)request.getAttribute("browseColumnAttributes");
	Attribute sortAttribute = (Attribute)request.getAttribute("sortAttribute");
	boolean useGrouping = false;
	if (request.getAttribute("useGrouping") != null)
	{
		useGrouping = ((Boolean)request.getAttribute("useGrouping")).booleanValue();
	}
	ResourceBundle interfaceResources = (ResourceBundle)request.getAttribute("resources");
	String playStr = interfaceResources.getString("play");
	String detailsStr = interfaceResources.getString("details");
	String otherStr = interfaceResources.getString("other");
	String configureColumnsStr = interfaceResources.getString("configureColumns");
	
	String[] alphabet = {otherStr,"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"};

	String sourceFrame = request.getParameter("source");
	StringBuffer playLinkTagBuilder = new StringBuffer();
	String playLinkTag = null;
	String viewLinkTag = null;
	String sourceParam = "";
	viewLinkTag = "<a class=\"navbarLink\"href=\"?view=trackattributes&trackid=";
	if (sourceFrame != null)
	{
		if (sourceFrame.equals("sidebar"))
		{
			playLinkTagBuilder.append("<a class=\"navbarLink\" href=\"?view=browse&source=sidebar");
			if (browseLetter != null)
			{
				playLinkTagBuilder.append("&query.letter=").append(browseLetter);
			}
			playLinkTagBuilder.append("&action=addtrack.personal&trackid=");
		}
		playLinkTag = playLinkTagBuilder.toString();
		sourceParam = "&source=" + sourceFrame;
	} else {
		playLinkTag = "<a class=\"navbarLink\" target=\"topleft\" href=\"?view=topleft&action=addtrack.personal&trackid=";
	}
	int trackCount = 0;
	int border = 0;
	String imgRoot = "../";

	Locale currentLocale = request.getLocale();
%>

<html>
<head>
	<title><%=(browseLetter!=null)?browseLetter:"JukeX - Browse"%></title>
	<link rel="stylesheet" type="text/css" href="../jukex.css" />
</head>
<body>
	<table cellpadding="3" cellspacing="1" border="0" bgcolor="#6699CC" width="100%">
		<tr bgcolor="#D3E1F0">
<%
	for (int x=0;x<alphabet.length;x++)
	{
%>
			<td>
				<div align="center">
<%
		if (!alphabet[x].equals(browseLetter)) {
%>
					<a class="browseletters" href="?view=browse<%=sourceParam%>&query.letter=<%=alphabet[x]%>"><%=alphabet[x]%></a>
<%
		} else {
%>
					<div class="browseletters"><%=alphabet[x]%></div>
<%
		}
%>
				</div>
			</td>
<%
	}
%>
		</tr>
	</table>

	<br />
	
	<% if ( avrs != null ) { %> 
	<div align="center">
	<table cellpadding="3" cellspacing="1" border="0" width="90%">
		<tr>
			<td>
				<table width="100%">
					<tr>
						<td align="left">
							<div class="tableBody" align="left" title="JukeXQL: <%=queryString%>"><%=(queryString != null)?"<b>Browsing results of query</b>":""%></div>
						</td>
						<td align="right">
				<div align="right"><a class="navbarLink" href="<%=contextRootURL%>servlet/JukeX?view=browsecolumns<%=(browseLetter != null)?("&query.letter=" + browseLetter):""%>"><nobr><%=configureColumnsStr%></nobr></a></div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<table cellpadding="3" cellspacing="1" border="0" bgcolor="#C7C6C7" width="100%">
					<tr bgcolor="#D9D4D9" class="highlightrow">
						<td>
							<div class="tableHead">Action</div>
						</td>
<%
		Iterator i = columns.iterator();
		Attribute column = null;
		if (i.hasNext() && useGrouping)
		{
			// throw away the first column
			column = (Attribute)i.next();
		}
		while (i.hasNext())
		{
			column = (Attribute)i.next();
%>
						<td>
							<div class="tableHead">
<%
			if (!useGrouping) 
			{
				if ( sortAttribute.equals(column) )
				{
					out.write( "<u>" );
				}
				else
				{	%>
								<a class="actionLink" href="?view=browse<%=sourceParam%><%=(browseLetter != null)?("&query.letter=" + browseLetter):""%>&action=browse.sort&browse.sortattribute=<%=column.getName()%>">
<%				}
			}
			out.write( column.getLocalisedName(currentLocale) );
			if (!useGrouping) 
			{
				out.write( ((sortAttribute.equals(column))?"</u>":"</a>") );
			}	%>
							</div>
						</td>
<%		}	%>
					</tr>
<% 
		String labelRow = "";
		int startCol = 1;
		if (useGrouping)
		{
			startCol = 2;
		}
		while ( avrs.next() )
		{
			long trackid = avrs.getTrackId();
			if (useGrouping && !labelRow.equals(avrs.getString(1)))
			{
				labelRow = avrs.getString(1);
%>
					<tr bgcolor="#D3E1F0" class="highlightrow"><td colspan="<%=String.valueOf(columns.size() + 1)%>"><div align="center" class="tableHead"><%=labelRow%></div></td></tr>
<%
			}
%>
					<tr bgcolor="#EFEBEF" class="highlightrow">
						<td width="10"><nobr><div class="tableBody"><%=playLinkTag%><%=trackid%>">[<%=playStr%>]</a> <%=viewLinkTag%><%=trackid%>">[<%=detailsStr%>]</a></div></nobr></td>
<%
			for (int j = startCol; j < columns.size() + 1; j++)
			{
%>
						<td><div class="tableBody"><%=avrs.getString(j)%></div></td>
<%
			}
%>
					</tr>
<%
			trackCount++;
		}
%>
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<span align="left" class="tableHead"><%=trackCount%> results found</span>
			</td>
		</tr>
	</table>
	</div>
	<% } %>
</body>
</html>
