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

<%@ taglib uri="/jukexTags.tld" prefix="jukex" %>

<%
	String contextRootURL = request.getContextPath() + "/";
	int border = 0;
	String imgRoot = "../";
	String queryString = (String)request.getAttribute("queryString");
	String servletName = (String)request.getAttribute("servlet");
	Set attributes = (Set)request.getAttribute("allAttributes");

	List columns = (List)request.getAttribute("browseColumnAttributes");
	if ( columns == null ) columns = new LinkedList();

	int MAX_COLS = ((Integer)request.getAttribute("maxBrowseColumns")).intValue();
	
	Boolean tempGrouping = (Boolean)request.getAttribute("useGrouping");
	boolean useGrouping = ( tempGrouping != null ) ? tempGrouping.booleanValue() : false;

	String sourceFrame = request.getParameter("source");
	String returnView = (String)request.getAttribute("returnView");
	if (returnView == null)
	{
		returnView = "browse";
	}

	ResourceBundle interfaceResources = (ResourceBundle)request.getAttribute("resources");
	String columnConfigurationStr = interfaceResources.getString("columnConfiguration");
	String chooseColumnsStr = interfaceResources.getString("chooseColumns");
	String columnStr = interfaceResources.getString("column");
	String groupTracksByFirstColumnStr = interfaceResources.getString("groupTracksByFirstColumn");
	String saveStr = interfaceResources.getString("save");

	Locale currentLocale = request.getLocale();
%>

<html>
<head>
	<title>JukeX - Choose columns</title>
	<link rel="stylesheet" type="text/css" href="../jukex.css" />
</head>
<body>

<form method="POST" action="<%=contextRootURL%>servlet/<%=servletName%>" name="configurecolumnsform">
	<input type="hidden" name="view" value="<%=returnView%>">
<% if (queryString != null) { %>
	<input type="hidden" name="query.letter" value="<%=queryString%>">
<% } %>
	<input type="hidden" name="action" value="browse.setcolumns">
<% if (sourceFrame != null) { %>
	<input type="hidden" name="source" value="<%=(sourceFrame != null)?sourceFrame:""%>">
<% } %>
	<jukex:box title="<%=columnConfigurationStr%>" width="300" bevel="no" padding="20">

	<div align="center">
	<table cellpadding="5" cellspacing="1" border="0" bgcolor="#C7C6C7">			
		<tr bgcolor="#D9D4D9">
			<td><div class="tableHead"><%=chooseColumnsStr%></div></td>
		</tr>
<%
	Attribute a = null;
	for (int i = 0; i < MAX_COLS; i++)
	{
%>
		<tr bgcolor="#EFEBEF">
			<td>
				<div align="right">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td>
							<div class="bodyText"><%=columnStr%> <%= (i+1) %>: </div>
						</td>
						<td>&nbsp;</td>
						<td>
							<select class="forminput" name="browse.column.<%=i%>">
								<option>none
<%
		Iterator j = attributes.iterator();
		while (j.hasNext())
		{
			a = (Attribute)j.next();
%>
								<option value="<%=a.getName()%>" <%=(columns.size() > i && a.equals(columns.get(i)))?"selected":""%>><%=a.getLocalisedName(currentLocale)%>
<%
		}
%>
							</select>
						</td>
					</tr>
				</table>
				</div>
			</td>
		</tr>
<%
	}
%>
		<tr bgcolor="#EFEBEF">
			<td>
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td><input class="forminput" type="checkbox" name="browse.usegrouping" <%=(useGrouping)?"checked":""%>></td>
						<td>&nbsp;</td>
						<td><div class="bodyText"><%=groupTracksByFirstColumnStr%></div></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr bgcolor="#EFEBEF">
			<td>
				<div align="right">
				<script><!--
					document.write('<a class="actionLink" href="javascript:document.configurecolumnsform.submit()"><%=saveStr%></a>');
				--></script>
				<noscript>
					<input class="forminput" type="submit" name="browse.setcolumns" value="<%=saveStr%>">
				</noscript>
				</div>
			</td>
		</tr>
	</table>
	</div>

	</jukex:box>
</form>
</body>
</html>
