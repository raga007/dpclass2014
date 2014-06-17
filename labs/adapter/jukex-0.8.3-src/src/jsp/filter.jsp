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
<%@page import="com.neoworks.jukex.tracksource.filter.*" %>
<%@page import="com.neoworks.jukex.tracksource.*" %>
<%@page import="com.neoworks.jukex.*" %>
<%@page import="java.util.*" %>
<%@page errorPage="error.jsp" %>

<%@ taglib uri="/jukexTags.tld" prefix="jukex" %>

<%
	String contextRootURL = request.getContextPath() + "/";
	FilterPipelineElement filter = (FilterPipelineElement)request.getAttribute("filter");
	TrackStore ts = TrackStoreFactory.getTrackStore();
	TrackSourcePipeline pipeline = (TrackSourcePipeline)request.getAttribute("pipeline");
	ResourceBundle interfaceResources = (ResourceBundle)request.getAttribute("resources");
	String filterConfigurationStr = interfaceResources.getString("filterConfiguration");
	String addANewFilterStr = interfaceResources.getString("addANewFilter");
	String addNewFilterStr = interfaceResources.getString("addNewFilter");
	String existingFiltersStr = interfaceResources.getString("existingFilters");
	String equalsStr = interfaceResources.getString("equals");
	String startsWithStr = interfaceResources.getString("startsWith");
	String matchesStr = interfaceResources.getString("matches");
	String removeFilterStr = interfaceResources.getString("removeFilter");

	Locale currentLocale = request.getLocale();
%>

<%!
private class AttributeComparator implements Comparator
{
	public int compare(Object o1, Object o2)
	{
		if (o1 instanceof Attribute && o2 instanceof Attribute)
		{
			return String.CASE_INSENSITIVE_ORDER.compare(((Attribute)o1).getName(),((Attribute)o2).getName());
		}
		throw new ClassCastException();
	}

	public boolean equals(Object o)
	{
		if (o instanceof AttributeComparator)
		{
			return true;
		}
		return false;
	}
}
%>

<html>
<head>
	<link rel="stylesheet" type="text/css" href="../jukex.css" />
</head>
<body>
<%if (filter == null) {%>
	<jukex:box title="Error" width="500" bevel="no" padding="20">
		<h1>ERROR - Could not find a filter</h1>
	</jukex:box>
<%} else {%>

<jukex:box title="<%=filterConfigurationStr%>" width="600" bevel="no" padding="20">
	<table cellpadding="3" cellspacing="1" border="0" bgcolor="#C7C6C7">
		
		<tr bgcolor="#D9D4D9">
			<td colspan="4">
				<div class="tableHead"><%=addANewFilterStr%></div>
			</td>
		</tr>

		<%-- Now put controls at the bottom to add extra conditions --%>
		<form method="POST" action="<%=contextRootURL%>servlet/JukeX" name="addnew">
			<input type="hidden" name="view" value="filter">
			<input type="hidden" name="action" value="filter.add">
			<input type="hidden" name="filter.index" value="<%=pipeline.indexOf(filter)%>">
		
			 <tr bgcolor="#EFEBEF">
				<td>
					<select name="filter.attribute">
<%
	Set attributes = new TreeSet(new AttributeComparator());
	attributes.addAll(ts.getAttributes());
	Iterator i = attributes.iterator();
	String attributeName = null;
	Attribute attribute = null;
	while (i.hasNext())
	{
			attribute = (Attribute)i.next();
%>
						<option <%=(attribute.getName().equals("Artist"))?"SELECTED":""%> ><%=attribute.getLocalisedName(currentLocale)%>
<%
	}
%>
					</select>
				</td>
				<td>
					<select name="filter.type">
						<option value="equals"><%=equalsStr%>
						<option value="startswith"><%=startsWithStr%>
						<option value="matches"><%=matchesStr%>
					</select>
				</td>
				<td>
					<input type="text" name="filter.value">
				</td>
				<td>
					<script><!--
						document.write('<div class="tableBody"><a href="javascript:document.addnew.submit()"><%=addNewFilterStr%></a></div>');
					--></script>
					<noscript>
						<input class="forminput" type="submit" value="<%=addNewFilterStr%>" />
					</noscript>
				</td>
			</tr>
		</form>
		<%-- Done with all form stuff now --%>

		<tr bgcolor="#D9D4D9">
			<td colspan="4"><div class="tableHead"><%=existingFiltersStr%></div></td>
		</tr>
<%
	Iterator i2 = filter.iterator();
	TrackFilter f = null;
	while (i2.hasNext())
	{
		f = (TrackFilter)i2.next();
		if (f instanceof AttributeTrackFilter) {
%>
		<tr bgcolor="#EFEBEF">
			<td><div class="tableBody"><%=((AttributeTrackFilter)f).getAttribute().getLocalisedName(currentLocale)%></td>
			<td><div class="tableBody"><%=f.getComparatorDescription()%></td>
			<td>
				<div class="tableBody">
<%
			if (((AttributeTrackFilter)f).getAttribute().getType() == Attribute.TYPE_STRING) 
			{
				out.write( ((AttributeTrackFilter)f).getValue().getString() );
			} 
			else 
			{
				out.write( new Integer(((AttributeTrackFilter)f).getValue().getInt()).toString() );
			}
		}
%>
				</div>
			</td>
			<td><div class="tableBody"><a href="<%=contextRootURL%>servlet/JukeX?view=filter&action=filter.remove&filter.index=<%=pipeline.indexOf(filter)%>&filter.filterindex=<%=filter.indexOf(f)%>"><%=removeFilterStr%></a></div></td>
		</tr>
<%
	}
%>
	</table>
</jukex:box>

<%}%>
</body>
</html>
