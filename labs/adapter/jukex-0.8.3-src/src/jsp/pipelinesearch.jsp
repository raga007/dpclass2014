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
<%@page import="com.neoworks.jukex.tracksource.*" %>
<%@page import="com.neoworks.jukex.*" %>
<%@page import="java.util.*" %>
<%@page errorPage="error.jsp" %>

<%@ taglib uri="/jukexTags.tld" prefix="jukex" %>

<%
	String contextRootURL = request.getContextPath() + "/";
	TrackSourcePipelineElement search = (TrackSourcePipelineElement)request.getAttribute("search");
	TrackSourcePipeline pipeline = (TrackSourcePipeline)request.getAttribute("pipeline");
	String query = (String)request.getAttribute("query");
	ResourceBundle interfaceResources = (ResourceBundle)request.getAttribute("resources");
	String defineSearchStr = interfaceResources.getString("defineSearch");
	String saveThisQueryStr = interfaceResources.getString("saveThisQuery");
%>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="../jukex.css" />
</head>
<body>
<%if (search == null) {%>
	<jukex:box width="400" bevel="no" padding="20" title="Error">
		<h1>ERROR - no search</h1>
	</jukex:box>
<%} else {%>
	<jukex:box width="400" bevel="no" padding="20" title="<%=defineSearchStr%>">
		Enter the query to use for track selection:<br>
		<form method="POST" action="<%=contextRootURL%>servlet/JukeXAdmin" name="setquery">
			<input type="hidden" name="view" value="pipeline">
			<input type="hidden" name="action" value="search.setquery">
			<input type="hidden" name="search.index" value="<%=pipeline.indexOf(search)%>">
		
		<div align="center">
		<table cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td>
					<textarea class="forminput" rows="3" cols="40" name="search.query"><%=(query != null)?query:""%></textarea>
				</td>
			</tr>
			<tr>
				<td>
					<div align="right">
					<script>
						<!--
						document.write('<a class="actionLink" href="javascript:document.setquery.submit()"><%=saveThisQueryStr%></a>');
						-->
					</script>
					<noscript>
						<input class="forminput" type="submit" name="search.setquery" value="<%=saveThisQueryStr%>">
					</noscript>
					</div>
				</td>
			</tr>
		</table>
		</div>

		</form>
	</jukex:box>
<%}%>
</body>
</html>
