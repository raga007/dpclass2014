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
<%@page import="java.net.URLDecoder" %>
<%@page import="java.net.URLEncoder" %>
<%@page errorPage="error.jsp" %>

<%@ taglib uri="/jukexTags.tld" prefix="jukex" %>

<%
	String contextRootURL = request.getContextPath() + "/";
	Collection attributes = (Collection)request.getAttribute("attributes");
	Track t = (Track)request.getAttribute("track");
	ResourceBundle interfaceResources = (ResourceBundle)request.getAttribute("resources");
	String trackAttributesStr = interfaceResources.getString("trackAttributes");
	String attributeStr = interfaceResources.getString("attribute");
	String typeStr = interfaceResources.getString("type");
	String valueStr = interfaceResources.getString("value");
	String playTrackStr = interfaceResources.getString("playTrack");
	String searchGoogleTrackStr = interfaceResources.getString("searchGoogleTrack");
	String editAttributesStr = interfaceResources.getString("editAttributes");
	Locale currentLocale = request.getLocale();
%>

<html>

<head>
	<link rel="stylesheet" type="text/css" href="../jukex.css" />
</head>

<body>
	<jukex:box title="<%=trackAttributesStr%>" width="500" bevel="no" padding="20">

		<table cellpadding="3" cellspacing="1" border="0" bgcolor="#C7C6C7">
			<tr bgcolor="#D9D4D9">
				<td><div class="tableHead"><%=attributeStr%></div></td>
				<td><div class="tableHead"><%=typeStr%></div></td>
				<td><div class="tableHead"><%=valueStr%></div></td>
			</tr>
<%
	if (t != null)
	{
	%>
			<tr bgcolor="#EFEBEF">
				<td><div class="bodyText">URL</div></td>
				<td><div class="bodyText">System</div></td>
				<td><div class="bodyText"><a href="<%=t.getURL().toString()%>"><%=URLDecoder.decode(t.getURL().toString(),"UTF-8")%></a></div></td>
			</tr>
	<%
		Iterator i = attributes.iterator();
		Attribute a = null;
		while (i.hasNext())
		{
			a = (Attribute)i.next();
%>
			<tr bgcolor="#EFEBEF">
				<td><div class="bodyText"><%=a.getLocalisedName(currentLocale)%></div></td>
				<td>
<%
			if (a.getType() == Attribute.TYPE_STRING) {
			try{
%>
					<div class="bodyText">String</div>
				</td>
				<td><div class="bodyText"><%=(t.getAttributeValue(a) != null)?t.getAttributeValue(a).getString():"NULL"%></div></td>
			</tr>
<%
			} catch (Exception e) {
%>
				</td>
				<td>
					<div class="bodyText" style="color:#ff0000;">Unexpected Value</div>
				</td>
			</tr>
<%
			}
			} else {
%>
					<div class="bodyText">Integer</div>
				</td>
				<td><div class="bodyText"><%=(t.getAttributeValue(a) != null)?String.valueOf(t.getAttributeValue(a).getInt()):"NULL"%></div></td>
			</tr>
<%
			}
		}
	} else {
%>
			<tr bgcolor="#EFEBEF">
				<td><div class="bodyText">Null Track</div></td>
			</tr>
<%
	}
%>
			<tr bgcolor="#EFEBEF">
				<td colspan="3">
					<table cellpadding="0" cellspacing="0" border="0" width="100%">
						<tr>
							<td>
								<div>
									<a class="actionLink" href="<%=contextRootURL%>servlet/JukeX?view=topleft&trackid=<%=t.getId()%>&action=addtrack.personal" target="topleft"><%=playTrackStr%></a>
								</div>
							</td>
							<td>
								<div align="left">
									<a class="actionLink" href="http://www.google.com/search?q=%22<%=URLEncoder.encode(t.getAttributeValue("Artist").toString(),"UTF-8")%>%22+%22<%=URLEncoder.encode(t.getAttributeValue("Title").toString(),"UTF-8")%>%22"><%=searchGoogleTrackStr%></a>
								</div>
							</td>
							<td>
								<div align="right">
									<a class="actionLink" href="<%=contextRootURL%>servlet/JukeX?view=editattributes&trackid=<%=t.getId()%>"><%=editAttributesStr%></a>
								</div>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</jukex:box>
</body>
</html>
