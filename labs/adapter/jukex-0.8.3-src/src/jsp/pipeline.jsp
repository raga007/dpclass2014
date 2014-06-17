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
<%@page import="java.util.Iterator" %>
<%@page import="java.util.ResourceBundle" %>
<%@page errorPage="error.jsp" %>

<%@ taglib uri="/jukexTags.tld" prefix="jukex" %>

<%
	String sourceFrame = request.getParameter("sourceFrame");
	String contextRootURL = request.getContextPath() + "/";
	TrackSourcePipeline pipeline = (TrackSourcePipeline)request.getAttribute("pipeline");

	ResourceBundle interfaceResources = (ResourceBundle)request.getAttribute("resources");
	String pipelineStr = interfaceResources.getString("Pipeline");
	String removeStr = interfaceResources.getString("remove");
	String configureStr = interfaceResources.getString("configure");

	String imageRoot = "../images";
	request.setAttribute("ticker","poo");
%>

<html>
<head>
	<link rel="stylesheet" type="text/css" href="../jukex.css" />
</head>
<body>
<%if (pipeline == null) {%>
	<jukex:box title="Error" width="300" bevel="no">
		<h1>ERROR - No pipeline</h1>
	</jukex:box>
<%} else {%>
	<jukex:box title="<%=pipelineStr%>" width="300" bevel="no" padding="20">
		<div align="center">
		<table cellpadding="0" cellspacing="0" border="0">
			<tr><td>
				<div align="center"><img src="<%=imageRoot%>/Speaker.gif" /></div>
			</td></tr>
<%
	Iterator i = pipeline.iterator();
	TrackSource ts = null;
	int pos = 0;
	while (i.hasNext())
	{
		ts = (TrackSource)i.next();
		pos = pipeline.indexOf(ts);
%>
			<tr><td align="center">
				<form method="POST" action="<%=contextRootURL%>servlet/JukeXAdmin">
				<input type="hidden" name="view" value="pipeline" />
				<input type="hidden" name="pipeline.index" value="<%=pos%>" />
				<input type="hidden" name="action" value="pipeline.edit" />
				<input type="hidden" name="pipeline.name" value="<%=pipeline.getName()%>" />
				<jukex:pipe 
					enabled="<%= new Boolean(ts.isEnabled()).toString() %>" 
					width="150" 
					color="<%= ((ts instanceof RoundRobinPipelineElement)?\"red\":\"grey\") %>" 
					showarrow="true" 
					title="<%= ts.getName() %>"
				>
					<div class="navbarPlaylist"><%=ts.getSummary().replaceAll("\\n","<br />")%></div>
					
					<a href="<%=contextRootURL%>servlet/JukeXAdmin?view=pipeline&action=pipeline.remove&pipeline.index=<%=pos%>" class="navbarlink"><%=removeStr%></a><br />
<%		if (ts instanceof FilterPipelineElement ) { %>
					<a href="<%=contextRootURL%>servlet/JukeX?view=filter&filter.index=<%=pos%>" class="navbarlink"><%=configureStr%></a>
<%		} else if (ts instanceof SearchPipelineElement) { %>
					<a href="<%=contextRootURL%>servlet/JukeXAdmin?view=searchpipeline&search.index=<%=pos%>" class="navbarlink"><%=configureStr%></a>
<%		} else if (ts instanceof NoRepeatPipelineElement) { %>
					<a href="<%=contextRootURL%>servlet/JukeXAdmin?view=norepeat&norepeat.index=<%=pos%>" class="navbarlink"><%=configureStr%></a>
<%		} %>
				</jukex:pipe>
				</form>
			</td></tr>
<%	}%>
		</table>
		</div>
	</jukex:box>
<%}%>

</body>
</html>
