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
<%@page errorPage="error.jsp" %>

<%
	String contextRootURL = request.getContextPath() + "/";
%>
<html>
<head><title>JukeX</title></head>
<frameset rows="*,215" frameborder="no">
	<frame name="topsidebar" src="<%=contextRootURL%>servlet/JukeX?view=topsidebar">
	<frame name="bottomsidebar" src="<%=contextRootURL%>servlet/JukeX?view=bottomsidebar">
	<noframes>
		Oh dear, this client doesn't support frames. :(
	</noframes>
</frameset>
</html>
