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
<%@page import="com.neoworks.jukex.query.AttributeValueResultSet" %>
<%@page import="com.neoworks.jukex.*" %>
<%@page import="java.util.*" %>
<%@page errorPage="error.jsp" %>

<%@ taglib uri="/jukexTags.tld" prefix="jukex" %>

<%
	String contextRootURL = request.getContextPath() + "/";
	AttributeValueResultSet results = (AttributeValueResultSet)request.getAttribute("tracklist");
	List columns = (List)request.getAttribute("browseColumnAttributes");
	ResourceBundle interfaceResources = (ResourceBundle)request.getAttribute("resources");
	String searchStr = interfaceResources.getString("search");

	Locale currentLocale = request.getLocale();
	TrackStore ts = TrackStoreFactory.getTrackStore();
	String artistStr = ts.getAttribute("Artist").getLocalisedName(currentLocale);
	String albumStr = ts.getAttribute("Album").getLocalisedName(currentLocale);
	String titleStr = ts.getAttribute("Title").getLocalisedName(currentLocale);
	String tracknoStr = ts.getAttribute("TrackNumber").getLocalisedName(currentLocale);
%>
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="../jukex.css" />
	</head>
	<body>
		<jukex:box bevel="no" width="400" padding="20" title="<%=searchStr + \" JukeX\"%>" >
		<form method="post" action="<%=contextRootURL%>servlet/JukeX" name="searchform">
			<input type="hidden" name="view" value="search">

		<table cellpadding="3" cellspacing="1" border="0" bgcolor="#C7C6C7">
			<tr>
				<td bgcolor="#EFEBEF">
					<table cellpadding="3" cellspacing="0" border="0">
						<tr>
							<td><div class="bodyText"><%=artistStr%></div></td>
							<td><input class="forminput" size="40" type="text" name="search.artist"></td>
						</tr>
						<tr>
							<td><div class="bodyText"><%=albumStr%></div></td>
							<td><input class="forminput" size="40" type="text" name="search.album"></td>
						</tr>
						<tr>
							<td><div class="bodyText"><%=titleStr%></div></td>
							<td><input class="forminput" size="40" type="text" name="search.title"></td>
						</tr>
						<tr>
							<td><div class="bodyText"><%=tracknoStr%></div></td>
							<td><input class="forminput" size="3" type="text" name="search.tracknumber"></td>
						</tr>
						<tr>
							<td colspan="2">
								<div align="right">
									<script><!--
										document.write('<a href="javascript:document.searchform.submit()" class="actionLink"><%=searchStr%></a>');
									--></script>
									<noscript>
										<input class="forminput" type="submit" name="search" value="<%=searchStr%>">
									</noscript>
								</div>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>

		</form>
		</jukex:box>
	</body>

</html>
