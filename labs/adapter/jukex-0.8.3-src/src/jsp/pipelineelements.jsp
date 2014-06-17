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
<%@page import="com.neoworks.jukex.*" %>
<%@page import="java.util.Collection" %>
<%@page import="java.util.Iterator" %>
<%@page import="java.util.Enumeration" %>
<%@page errorPage="error.jsp" %>

<%@ taglib uri="/jukexTags.tld" prefix="jukex" %>

<%
	String contextRootURL = request.getContextPath() + "/";
	String insertPosStr = (String)request.getAttribute("pipeline.insertPos");
	int insertPos = Integer.parseInt(insertPosStr);
	Collection playlists = (Collection)request.getAttribute("playlists");
	
	String[][] elements = 	{
				{ "Annoying" , "annoying" },
				{ "Audio Banner" , "audiobanner" },
				{ "Search" , "search" },
				{ "Randomiser" , "randomiser" },
				{ "Search Randomiser" , "searchrandomiser" },
				{ "Round Robin" , "roundrobin" },
				{ "Filter" , "filter" },
				{ "No Repeat" , "norepeat" },
				};
%>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="../jukex.css" />
</head>
<body>
	<form method="GET" action="<%=contextRootURL%>servlet/JukeXAdmin" name="chooseelement">
		<input type="hidden" name="view" value="pipeline" />
		<input type="hidden" name="action" value="pipeline.newElementChosen" />
		<input type="hidden" name="pipeline.pos" value="<%= insertPosStr %>" />
		<input type="hidden" name="pipeline.name" value="<%= request.getAttribute("pipeline.name") %>" />
				
	<jukex:box title="Add Pipeline Element" width="400" bevel="no">
		<table cellpadding="5" cellspacing="0" border="0">
			<tr><td><div class="bodytext">Name:</div></td><td><input class="forminput" type="text" name="pipeline.elementName" size="20" /></td></tr>
			<tr>
				<td valign="top"><div class="bodytext">Type:</div></td>
				<td>
					<table cellpadding="0" cellspacing="2" border="0">
<%
for ( int x=0; x < elements.length ; x++ )
{
%>
					<tr><td><input class="forminput" type="radio" name="pipeline.elementtype" value="<%=elements[x][1]%>" /></td><td><div class="bodytext"><%=elements[x][0]%></div></td></tr>
<%
}
%>
					</table>
				</td>
			</tr>

			<tr>
				<td colspan="2">
					<div align="center">
					<input type="submit" value="Add this Element" />
					</div>
				</td>
			</tr>
		</table>
	</jukex:box>
	</form>
</body>
</html>
