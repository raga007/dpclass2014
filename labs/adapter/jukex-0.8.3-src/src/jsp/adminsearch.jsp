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
<%@page import="com.neoworks.jukex.client.html.standard.AttributeQuery" %>
<%@page import="com.neoworks.jukex.query.*" %>
<%@page import="com.neoworks.jukex.*" %>
<%@page import="java.util.*" %>
<%@page errorPage="error.jsp" %>

<%@ taglib uri="/jukexTags.tld" prefix="jukex" %>

<%
	String contextRootURL = request.getContextPath() + "/";
	AttributeValueResultSet results = (AttributeValueResultSet)request.getAttribute("tracklist");
	List columns = (List)request.getAttribute("columns");
	String query = (String)request.getAttribute("query");
	String errorStr = (String)request.getAttribute("error");

	ResourceBundle interfaceResources = (ResourceBundle)request.getAttribute("resources");
	String adminSearchStr = interfaceResources.getString("adminSearch");
	String searchStr = interfaceResources.getString("search");
	String configureColumnsStr = interfaceResources.getString("configureColumns");
	String playStr = interfaceResources.getString("play");
	String detailsStr = interfaceResources.getString("details");
%>
<html>

<head>
	<link rel="stylesheet" type="text/css" href="../jukex.css" />
</head>

<body>

	<jukex:box width="600" bevel="no" title="<%=adminSearchStr%>">
		<table cellpadding="0" cellspacing="5" border="0">
			<tr>
				<td colspan="2">
					<div class="navbarPlaylist">
						<p>This interface enables advanced searches to be built from JukeXQL. JukeXQL queries have a similar syntax to SQL, i.e. <i>SELECT Artist,Title WHERE Album="The White Album"</i> will query for the Artist and Title of each track from a well known Album.
						</p>
						<p>
						The first part of the SELECT clause is built automatically from the results column selection, therefore only terms following the WHERE keyword are entered at this interface, e.g. <i>Album="The White Album"</i>.<br>
						String literals must be enclosed in double quotes (&quot;).</p>
					</div>
				</td>
			</tr>
			<tr>
				<td valign="top">
					<div class="navbarPlaylist">

						<table cellpadding="0" cellspacing="0" border="0">
							<tr>
								<td><div class="navbarPlaylist"><b>Attributes</b></div></td>
							</tr>
							<tr>
								<td><div class="navbarPlaylist">Artist</div></td>
							</tr>
							<tr>
								<td><div class="navbarPlaylist">Album</div></td>
							</tr>
							<tr>
								<td><div class="navbarPlaylist">Title</div></td>
							</tr>
							<tr>
								<td><div class="navbarPlaylist">TrackNumber</div></td>
							</tr>
							<tr>
								<td><div class="navbarPlaylist">Genre</div></td>
							</tr>
							<tr>
								<td><div class="navbarPlaylist">Bitrate</div></td>
							</tr>
							<tr>
								<td><div class="navbarPlaylist">SampleRate</div></td>
							</tr>
						</table>

						<p><b>Example queries:</b></p>

						<i>Artist = "Pink Floyd" AND Title = "Money"</i><br>
						<i>Bitrate > 100</i>
						<br>
					</div>
				</td>
				<td valign="bottom" align="right">
<%
if (errorStr != null) {
%>
					<div class="navbarPlaylist" style="color: #ff0000;"><%=errorStr%></div>
<%
}
%>
					<form method="POST" action="<%=contextRootURL%>servlet/JukeXAdmin" name="adminsearchform">
						<input type="hidden" name="view" value="adminsearch">
						<table cellpadding="3" cellspacing="1" border="0">
							<tr>
								<td>
									<textarea class="forminput" name="adminsearch.query" rows="6" cols="40" ><%=(query != null)?query:""%></textarea>
								</td>
							</tr>
							<tr>
								<td>
									<div align="right">
										<script><!--
											document.write('<a href="javascript:document.adminsearchform.submit()" class="actionLink"><%=searchStr%></a>');
										--></script>
										<noscript>
											<input class="forminput" type="submit" name="adminsearch.setquery" value="<%=searchStr%>">
										</noscript>
									</div>
								</td>
							</tr>
						</table>
					</form>

				</td>
			</tr>
		</table>
	</jukex:box>

<%
if (results != null && columns != null) {
%>


	<table cellpadding="3" cellspacing="1" border="0" bgcolor="#C7C6C7" width="100%">
		<tr bgcolor="#FFFFFF">
			<td colspan="<%=columns.size() + 1%>">
				<div align="right"><a class="navbarLink" href="<%=contextRootURL%>servlet/JukeXAdmin?view=browsecolumns&returnview=adminsearch"><%=configureColumnsStr%></a></div>
			</td>
		</tr>
		<tr bgcolor="#D9D4D9">
			<td><div class="tableHead">Actions</div></td>
<%
	Iterator i = columns.iterator();
	Attribute a = null;
	while (i.hasNext())
	{
		a = (Attribute)i.next();
%>
			<td><div class="tableHead"><%=a.getName()%></div></td>
<%
	}
	while (results.next())
	{
%>
		</tr>
		<tr bgcolor="#EFEBEF">
			<td>
				<a class="navbarLink" href="<%=contextRootURL%>servlet/JukeX?view=topleft&action=addtrack.personal&trackid=<%=results.getTrackId()%>" target="topleft">[<%=playStr%>]</a> <a class="navbarLink" href="<%=contextRootURL%>servlet/JukeX?view=trackattributes&trackid=<%=results.getTrackId()%>">[<%=detailsStr%>]</a>
			</td>
<%
	for (int j = 1; j <= columns.size(); j++)
	{
%>
			<td>
				<div class="bodyText"><%=results.getString(j)%></div>
			</td>
<%
	}
%>
		</tr>
<%
	}
} else {
%>
<%
}
%>
	</table>
</body>
</html>
