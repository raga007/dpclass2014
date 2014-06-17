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
<%@page import="com.neoworks.util.Escaper" %>
<%@page import="java.util.*" %>
<%@page errorPage="error.jsp" %>

<%@ taglib uri="/jukexTags.tld" prefix="jukex" %>

<%
	String contextRootURL = request.getContextPath() + "/";
	Collection attributes = (Collection)request.getAttribute("attributes");
	Track t = (Track)request.getAttribute("track");
	ResourceBundle interfaceResources = (ResourceBundle)request.getAttribute("resources");
	String editTrackAttributesStr = interfaceResources.getString("editTrackAttributes");
	String attributeStr = interfaceResources.getString("attribute");
	String typeStr = interfaceResources.getString("type");
	String valueStr = interfaceResources.getString("value");
	String updateStr = interfaceResources.getString("update");
	Locale currentLocale = request.getLocale();
%>

<html>

<head>
	<link rel="stylesheet" type="text/css" href="../jukex.css" />
</head>

<body>
	<jukex:box title="<%=editTrackAttributesStr%>" width="500" bevel="no" padding="20">
		<form method="post" action="<%=contextRootURL%>servlet/JukeX" name="changeattributes">
			<input type="hidden" name="action" value="updateattributes">
			<input type="hidden" name="view" value="editattributes">
			<input type="hidden" name="trackid" value="<%=t.getId()%>">
			
		<table cellpadding="3" cellspacing="1" border="0" bgcolor="#C7C6C7">
			<tr bgcolor="#D9D4D9">
				<td><div class="tableHead"><%=attributeStr%></div></td>
				<td><div class="tableHead"><%=typeStr%></div></td>
				<td><div class="tableHead"><%=valueStr%></div></td>
			</tr>
<%
	if (t != null)
	{
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
				<td>
					<input class="forminput" type="text" size="40" name="editattributes.<%=a.getName()%>" value="<%=(t.getAttributeValue(a) != null)?Escaper.XMLEscape(t.getAttributeValue(a).getString()):""%>" />
				</td>
			</tr>
<%
			} catch (Exception e) {
%>
				</td>
				<td>
					<div class="bodyText" style="color: #ff0000">Urk. Erreur.</div>
				</td>
			</tr>
<%
			}
			} else {
%>
					<div class="bodyText">Integer</div>
				</td>
				<td>
					<input class="forminput" type="text" size="40" name="editattributes.<%=a.getName()%>" value="<%=(t.getAttributeValue(a) != null)?String.valueOf(t.getAttributeValue(a).getInt()):""%>">
				</td>
			</tr>
<%
			}
		}
	} else {
%>
			<tr>
				<td><div class="bodyText">Null Track</div></td>
			</tr>
<%
	}
%>
		<tr bgcolor="#EFEBEF">
			<td colspan="3">
				<div align="right">
					<script><!--
						document.write('<a href="javascript:document.changeattributes.submit()" class="actionLink">Update</a>');
					--></script>
					<noscript>
						<input class="forminput" type="submit" name="editattributes.submit" value="<%=updateStr%>">
					</noscript>
				</div>
			</td>
		</tr>
	</table>

</form>
</jukex:box>

</body>
</html>
