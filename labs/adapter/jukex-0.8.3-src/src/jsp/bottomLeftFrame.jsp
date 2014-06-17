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
<%@page errorPage="error.jsp" %>

<%@ taglib uri="/jukexTags.tld" prefix="jukex" %>

<%
	String contextRootURL = request.getContextPath() + "/";
	boolean isPaused = false;
	if (request.getAttribute("paused") != null)
	{
		isPaused = ((Boolean)request.getAttribute("paused")).booleanValue();
	}
	Track nowPlaying = (Track)request.getAttribute("playing");

	ResourceBundle interfaceStrings = (ResourceBundle)request.getAttribute("resources");
	String searchStr = interfaceStrings.getString("search");
	String actionsStr = interfaceStrings.getString("actions");
	String playStr = interfaceStrings.getString("play");
	String pauseStr = interfaceStrings.getString("pause");
	String skipStr = interfaceStrings.getString("skip");
	String goStr = interfaceStrings.getString("go");
	String browseStr = interfaceStrings.getString("browse");
	String pipelineStr = interfaceStrings.getString("pipeline");
	String attributesStr = interfaceStrings.getString("attributes");
	String advancedSearchStr = interfaceStrings.getString("advancedSearch").toLowerCase();
	String adminSearchStr = interfaceStrings.getString("adminSearch").toLowerCase();

	// Display variables
	int border = 0;
	String imgRoot = "../images/";
	String shim = "../images/shim.gif";
%>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="../jukex.css" />
</head>
<body topmargin="0" leftmargin="0" bgcolor="#ffffee">

<table cellpadding="3" cellspacing="0" border="0">
<tr><td>
<jukex:box title="<%=searchStr%>" width="154">
<form method="post" action="<%=contextRootURL%>servlet/JukeX" target="right" name="searchform">
	<input type="hidden" name="view" value="search">
	<table cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td>
				<input class="forminput" size="14" type="text" name="quicksearch">
			</td>
			<td>
				<img src="<%=shim%>" width="10" height="1" />
			</td>
			<td>
				<script><!--
					document.write('<a class="actionLink" href="javascript:document.searchform.submit()"><%=goStr%></a>');
				--></script>
				<noscript><input class="forminput" type="submit" name="quicksearch" value="<%=goStr%>"></noscript>
			</td>
		</tr>
	</table>
</form>
</jukex:box>
</td></tr>
<tr><td>
<jukex:box title="<%=actionsStr%>" width="154">
	<table cellpadding="0" cellspacing="0" border="<%=border%>">
			<tr><td>
				<div class="navbarLink" align="left">
<%
if (nowPlaying == null || isPaused) {
%>
					[<a class="navbarLink" href="?action=play&view=left" target="left"><%=playStr%></a>]<img src="<%=shim%>" width="4" />
<%
}
if (!isPaused) {
%>
					[<a class="navbarLink" href="?action=pause&view=left" target="left"><%=pauseStr%></a>]<img src="<%=shim%>" width="4" />
<%
}
%>
					[<a class="navbarLink" href="?action=skip&view=topleft" target="topleft"><%=skipStr%></a>]<br />
					<img src="<%=shim%>" height="4" />
					<div align="center"><img src="<%=imgRoot%>nav_sepbar.gif" /></div>
					[<a class="navbarlink" href="<%=contextRootURL%>servlet/JukeX?view=browse" target="right"><%=browseStr%></a>]<img src="<%=shim%>" width="5" height="1" />
					[<a class="navbarlink" href="<%=contextRootURL%>servlet/JukeX?view=search" target="right"><%=searchStr.toLowerCase()%></a>]<br />
					[<a class="navbarlink" href="<%=contextRootURL%>servlet/JukeX?view=advancedsearch" target="right"><%=advancedSearchStr%></a>]<br />
					<img src="<%=shim%>" height="4" />
					<div align="center"><img src="<%=imgRoot%>nav_sepbar.gif" /></div>
					[<a class="navbarlink" href="<%=contextRootURL%>servlet/JukeXAdmin?view=pipeline" target="right"><%=pipelineStr%></a>]<img src="<%=shim%>" width="5" height="1" />
					[<a class="navbarlink" href="<%=contextRootURL%>servlet/JukeXAdmin?view=attributes" target="right"><%=attributesStr%></a>]<br />
					[<a class="navbarlink" href="<%=contextRootURL%>servlet/JukeXAdmin?view=adminsearch" target="right"><%=adminSearchStr%></a>]
				</div>
			</td></tr>
		</table>
</jukex:box>

</td></tr>
</table>

</body>
</html>
