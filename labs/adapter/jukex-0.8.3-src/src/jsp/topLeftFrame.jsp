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
	Track nowPlaying = (Track)request.getAttribute("playing");
	List playlist = (List)request.getAttribute("upcoming");
	boolean isPaused = false;
	if (request.getAttribute("paused") != null)
	{
		isPaused = ((Boolean)request.getAttribute("paused")).booleanValue();
	}
	Iterator pit = playlist.iterator();
	Long timeRemainingObject = (Long)request.getAttribute("timeremaining");
	long timeRemaining = 0;
	if (timeRemainingObject != null)
	{
		timeRemaining = timeRemainingObject.longValue();
	}
	long secondsToRefresh = timeRemaining / 1000;
	if (secondsToRefresh < 1)
	{
		secondsToRefresh = 30;
	}

	ResourceBundle interfaceStrings = (ResourceBundle)request.getAttribute("resources");
	String currentlyPlayingStr = interfaceStrings.getString("currentlyPlaying");
	String comingNextStr = interfaceStrings.getString("comingNext");
	String pauseStr = interfaceStrings.getString("pause");
	String personalPlaylistStr = interfaceStrings.getString("personalPlaylist");
	String actionsStr = interfaceStrings.getString("actions");
	String noTracksStr = interfaceStrings.getString("noTracks");
	String delStr = interfaceStrings.getString("del");
	String enterDetailsStr = interfaceStrings.getString("enterDetails");
	String stoppedStr = interfaceStrings.getString("stopped").toUpperCase();
	String pausedStr = pauseStr.toUpperCase();

	TrackStore ts = TrackStoreFactory.getTrackStore();
	Locale currentLocale = request.getLocale();
	String artistStr = ts.getAttribute("Artist").getLocalisedName(currentLocale);
	String titleStr = ts.getAttribute("Title").getLocalisedName(currentLocale);

	// Display variables
	int border = 0;
	String imgRoot = "../images/";
	String shim = "../images/shim.gif";
%>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="../jukex.css" />
	<meta http-equiv="refresh" content="<%=secondsToRefresh%>;url=<%=contextRootURL%>servlet/JukeX?view=topleft">
</head>
<body topmargin="0" leftmargin="0" bgcolor="#ffffee">

<table cellpadding="3" cellspacing="0" border="0">
<tr><td align="center" valign="middle">
	<a href="<%=contextRootURL%>servlet/JukeX?view=topleft" target="topleft"><img src="<%=imgRoot%>nav_head.gif" border="0" /></a>
</td></tr>
<tr><td>

<jukex:box title="<%=currentlyPlayingStr%>" width="154">
	<table cellpadding="0" cellspacing="0" border="<%=border%>">
		<tr><td><div align="left" class="navbarPlaylist">
	<% if (isPaused){%>
		<%=pausedStr%>
	<% } else if (nowPlaying != null) { %>
		<%=artistStr%>: <a class="navbarPlaylistLink" href="<%=contextRootURL%>servlet/JukeX?view=trackattributes&trackid=<%=nowPlaying.getId()%>" target="right"><%=(!nowPlaying.getAttributeValue("Artist").toString().equals(""))?(nowPlaying.getAttributeValue("Artist").toString()):"[" + enterDetailsStr + "]"%></a></div><div align="left" class="navbarPlaylist"><%=titleStr%>: <a class="navbarPlaylistLink" href="<%=contextRootURL%>servlet/JukeX?view=trackattributes&trackid=<%=nowPlaying.getId()%>" target="right"><%=(!nowPlaying.getAttributeValue("Title").toString().equals(""))?(nowPlaying.getAttributeValue("Title").toString()):"[" + enterDetailsStr + "]"%></a>
	<%} else {%>
		<%=stoppedStr%>
	<%}%>
		</div></td></tr>
	</table>
</jukex:box>

</td></tr>
<tr><td>

<jukex:box title="<%=comingNextStr%>" width="154">
	<table cellpadding="0" cellspacing="0" border="<%=border%>">
	<%
		Track t = null;
		while ( pit.hasNext() )
		{
			t = (Track)pit.next();
	%>
		<tr><td><a class="navbarPlaylistLink" target="right" href="<%=contextRootURL%>servlet/JukeX?view=trackattributes&trackid=<%=t.getId()%>"><%=t.getAttributeValue("Artist")%> - <%=t.getAttributeValue("Title")%></a></td></tr>
		<% if ( pit.hasNext() ) { %><tr><td><div align="center"><img src="<%=imgRoot%>nav_sepbar.gif" /></div></td></tr><% } %>
	<% } %>
	</table>
</jukex:box>

</td></tr>
<tr><td>

<jukex:box title="<%=personalPlaylistStr%>" width="154">
	<table cellpadding="0" cellspacing="0" border="<%=border%>">
<%
	Playlist personalPlaylist = (Playlist)request.getAttribute("pplaylist");
	if ( personalPlaylist != null && personalPlaylist.size() > 0 )
	{
		Iterator personalPlaylistIter = personalPlaylist.iterator();
		while ( personalPlaylistIter.hasNext() )
		{
			Track personalTrack = (Track) personalPlaylistIter.next();
%>
		<tr><td><a class="navbarPlaylistLink" target="right" href="<%=contextRootURL%>servlet/JukeX?view=trackattributes&trackid=<%=personalTrack.getId()%>"><%=personalTrack.getAttributeValue("Artist")%> - <%=personalTrack.getAttributeValue("Title")%></a></td></tr>
		<tr><td><div align="left" class="navbarPlaylist">[<a href="<%=contextRootURL%>servlet/JukeX?view=topleft&action=pplaylist.remove&pplaylist.index=<%=personalPlaylist.indexOf(personalTrack)%>" target="topleft"><%=delStr%></a>]</div></td></tr>
<%			if ( personalPlaylistIter.hasNext() ) { %><tr><td><div align="center"><img src="<%=imgRoot%>nav_sepbar.gif" /></div></td></tr><% } %>
<% 
		}
	}
	else
	{
%>
		<tr><td><div align="left" class="navbarPlaylist"><%=noTracksStr%></div></td></tr>
<%	
	} 
%>
	</table>
</jukex:box>

</td></tr>
</table>

</body>
</html>
