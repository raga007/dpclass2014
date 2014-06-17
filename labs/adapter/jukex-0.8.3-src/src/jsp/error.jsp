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
<%@page import="java.io.*" %>
<%@page isErrorPage="true" %>

<html>
<head><title>JukeX Error</title></head>
<body>
<center><h1>JukeX Error</h1></center>
<b><%= exception.getMessage() %></b><br>
<p>With the following stack trace:

<pre>
<% 
	ByteArrayOutputStream baos = new ByteArrayOutputStream();
	exception.printStackTrace(new PrintStream(baos));
	out.print(baos);
%>
</b></pre>
</body>
</html>
