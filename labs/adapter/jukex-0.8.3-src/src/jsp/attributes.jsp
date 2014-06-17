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
	ResourceBundle interfaceResources = (ResourceBundle)request.getAttribute("resources");
	String removeAttributeStr = interfaceResources.getString("removeAttribute");
	String addAttributeStr = interfaceResources.getString("addAttribute");
	String actionsStr = interfaceResources.getString("actions");
	String attributeStr = interfaceResources.getString("attribute");
	String typeStr = interfaceResources.getString("type");
	String systemAttributesStr = interfaceResources.getString("systemAttributes");
%>

<html>
<head>
	<link rel="stylesheet" type="text/css" href="../jukex.css" />
</head>
<body>

<jukex:box width="400" bevel="no" padding="20" title="<%=systemAttributesStr%>">
	<table cellpadding="3" cellspacing="1" border="0" bgcolor="#C7C6C7">
		<tr bgcolor="#D9D4D9">
			<td><div class="tableHead"><%=attributeStr%></div></td>
			<td><div class="tableHead"><%=typeStr%></div></td>
			<td><div class="tableHead"><%=actionsStr%></div></td>
		</tr>
<%
	Iterator i = attributes.iterator();
	Attribute a = null;
		while (i.hasNext())
		{
			a = (Attribute)i.next();
%>
		<tr bgcolor="#EFEBEF">
			<td><div class="bodyText"><%=a.getName()%></div></td>
			<td><div class="bodyText"><%= ( ( a.getType() == Attribute.TYPE_STRING ) ? "String" : "Integer" ) %></div></td>
			<td><a class="actionLink" href="<%=contextRootURL%>servlet/JukeXAdmin?view=attributes&action=attributes.remove&attributes.name=<%=a.getName()%>"><%=removeAttributeStr%></a></td>
		</tr>
<%
		}
%>
		<form method="POST" action="<%=contextRootURL%>servlet/JukeXAdmin" name="addattribute">
			<input type="hidden" name="view" value="attributes">
			<input type="hidden" name="action" value="attributes.add">
		<tr bgcolor="#EFEBEF">
			<td><input class="forminput" type="text" name="attributes.name" /></td>
			<td>
				<select class="forminput" name="attributes.type">
					<option>String
					<option>Integer
				</select>
			</td>
			<td>
				<script><!--
					document.write('<a href="javascript:document.addattribute.submit()" class="actionLink"><%=Escaper.XMLEscape(addAttributeStr)%></a>');
				--></script>
				<noscript>
					<input class="forminput" type="submit" name="attributes.add" value="<%=addAttributeStr%>" />
				</noscript>
			</td>
		</tr>

	</table>
</jukex:box>






</form>

</body>
</html>
