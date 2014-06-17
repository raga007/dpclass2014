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
	Collection attributes = (Collection)request.getAttribute("attributes");
	AttributeValueResultSet results = (AttributeValueResultSet)request.getAttribute("tracklist");
	List queries = (List)request.getAttribute("queries");
	Set sortedAttributes = new TreeSet();
	sortedAttributes.addAll(attributes);

	ResourceBundle interfaceResources = (ResourceBundle)request.getAttribute("resources");
	String advancedSearchStr = interfaceResources.getString("advancedSearch");
	String newSearchTermStr = interfaceResources.getString("newSearchTerm");
	String currentSearchTermsStr = interfaceResources.getString("currentSearchTerms");
	String equalsStr = interfaceResources.getString("equals");
	String startsWithStr = interfaceResources.getString("startsWith");
	String containsStr = interfaceResources.getString("contains");
	String matchesStr = interfaceResources.getString("matches");
	String isLessThanStr = interfaceResources.getString("isLessThan");
	String isGreaterThanStr = interfaceResources.getString("isGreaterThan");
	String ANDStr = interfaceResources.getString("AND");
	String ORStr = interfaceResources.getString("OR");
	String updateQueryStr = interfaceResources.getString("updateQuery");
	String clearQueryStr = interfaceResources.getString("clearQuery");
	String runSearchStr = interfaceResources.getString("runSearch");

	Locale currentLocale = request.getLocale();
%>
<html>

<head>
	<link rel="stylesheet" type="text/css" href="../jukex.css" />
</head>

<body>

<jukex:box width="500" title="<%=advancedSearchStr%>" padding="20" bevel="no">
	<form method="POST" action="<%=contextRootURL%>servlet/JukeX" name="advancedsearch">
		<input type="hidden" name="view" value="advancedsearch">

		<table cellpadding="3" cellspacing="1" border="0" bgcolor="#C7C6C7">
<%	if ( queries != null ) 
	{
%>
		<tr bgcolor="#D9D4D9">
			<td colspan="4">
				<div class="tableHead"><%=currentSearchTermsStr%></div>
			</td>
		</tr>
<%
	}

	Iterator i = null;
	Attribute a = null;

	if (queries != null)
	{
%>
		<tr bgcolor="#EFEBEF">
			<td>&nbsp;</td><!-- No logical operator for the first line -->
<%
	if (queries.size() > 0)
	{
		// fill in existing queries
		Iterator q = queries.iterator();
		Iterator sq = null;
		AttributeQuery aq = null;
		List subQueries = null;
		int row = 0;
		int col = 0;
		while (q.hasNext())
		{
			subQueries = (List)q.next();
			sq = subQueries.iterator();
			row = queries.indexOf(subQueries);
			while (sq.hasNext())
			{
				aq = (AttributeQuery)sq.next();
				col = subQueries.indexOf(aq);
%>
			<td>
				<select class="forminput" name="asearch.attribute.<%=row%>.<%=col%>">
<%
				i = sortedAttributes.iterator();
				while (i.hasNext())
				{
					a = (Attribute)i.next();
%>
					<option value="<%=a.getName()%>" <%=(a.getName().equals(aq.getAttribute().getName()))?"SELECTED":""%>><%=a.getLocalisedName(currentLocale)%>
<%
				}
%>
				</select>
			</td>
			<td>
				<select class="forminput" name="asearch.comparator.<%=row%>.<%=col%>">
					<option value="=" <%=(aq.getComparator().equals("="))?"SELECTED":""%>><%=equalsStr%>
					<option value="x%" <%=(aq.getComparator().equals("x%"))?"SELECTED":""%>><%=startsWithStr%>
					<option value="%x%" <%=(aq.getComparator().equals("%x%"))?"SELECTED":""%>><%=containsStr%>
					<option value="~=" <%=(aq.getComparator().equals("~="))?"SELECTED":""%>><%=matchesStr%>
					<option value="<" <%=(aq.getComparator().equals("<"))?"SELECTED":""%>><%=isLessThanStr%>
					<option value=">" <%=(aq.getComparator().equals(">"))?"SELECTED":""%>><%=isGreaterThanStr%>
				</select>
			</td>
			<td>
				<input class="forminput" type="text" name="asearch.text.<%=row%>.<%=col%>" value="<%=aq.getValue()%>">
			</td>
		</tr>
<%
				if (sq.hasNext()) {
%>
		<tr bgcolor="#EFEBEF">
			<td>
				<select class="forminput" name="asearch.relop.<%=row%>.<%=col%>">
					<option value="OR"><%=ORStr%>
					<option value="AND"><%=ANDStr%>
				</select>
			</td>
<%
				} else if (q.hasNext()) {
%>
		<tr bgcolor="#EFEBEF">
			<td>
				<select class="forminput" name="asearch.relop.<%=row%>.<%=col%>">
					<option value="AND"><%=ANDStr%>
					<option value="OR"><%=ORStr%>
				</select>
			</td>
<%
				}
			}
		}
	} else {
%>
		</tr>
<%
		}
	}
%>

	<%--
		Add new query option
	--%>

		<tr bgcolor="#D9D4D9">
			<td colspan="4">
				<div class="tableHead"><%=newSearchTermStr%></div>
			</td>
		</tr>

		<tr bgcolor="#EFEBEF">
<%
	if (queries != null) {
%>
			<td>
				<select class="forminput" name="asearch.relop">
					<option value=" ">
					<option value="AND"><%=ANDStr%>
					<option value="OR"><%=ORStr%>
				</select>
			</td>
<%
	}
	else
	{
%>
			<td>&nbsp;</td>
<%
	}
%>
			<td>
				<select class="forminput" name="asearch.attribute">
<%
	i = sortedAttributes.iterator();
	while (i.hasNext())
	{
		a = (Attribute)i.next();
%>
					<option value="<%=a.getName()%>"><%=a.getLocalisedName(currentLocale)%>
<%
	}
%>
				</select>
			</td>
			<td>
				<select class="forminput" name="asearch.comparator">
					<option value="="><%=equalsStr%>
					<option value="x%"><%=startsWithStr%>
					<option value="%x%"><%=containsStr%>
					<option value="~="><%=matchesStr%>
					<option value="<"><%=isLessThanStr%>
					<option value=">"><%=isGreaterThanStr%>
				</select>
			</td>
			<td>
				<input class="forminput" type="text" name="asearch.text">
			</td>
		</tr>
		<tr bgcolor="#EFEBEF">
			<td colspan="4">
				<table cellpadding="0" cellspacing="0" width="100%" border="0">
					<tr>
						<td>
							<div align="left">
							<input class="forminput" type="submit" name="asearch.setquery" value="<%=updateQueryStr%>">
							<input class="forminput" type="submit" name="asearch.clearquery" value="<%=clearQueryStr%>">
							</div>
						</td>
						<td>
							<div align="right">
							<input class="forminput" type="submit" name="asearch.runquery" value="<%=runSearchStr%>">
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
