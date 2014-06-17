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
<%@page errorPage="error.jsp" %>

<%@ taglib uri="/jukexTags.tld" prefix="jukex" %>

<%
	int portNo = request.getServerPort();
	String portStr = null;
	if (portNo != 80)
	{
		portStr = String.valueOf(request.getServerPort());
	}
	String contextRootURL = "http" + ((request.isSecure())?"s":"") + "://" + request.getServerName() + ((portStr != null)?(":" + portStr):"") + request.getContextPath() + "/";
	String pageContents = (String)request.getAttribute("pageContent");
	String imageRoot = "../images";
	int border = 0;
	
	TrackStore ts = TrackStoreFactory.getTrackStore();

	String versionStr = "Beta 0.8.3";
%>
<html>
<head>
<SCRIPT LANGUAGE="JavaScript">
   function addJukexPanel() { 
      if ((typeof window.sidebar == "object") && (typeof window.sidebar.addPanel == "function")) 
      { 
         window.sidebar.addPanel ("JukeX", 
         "<%=contextRootURL%>servlet/JukeX?view=sidebar",""); 
      } 
      else 
      { 
         var rv = window.confirm ("This page is enhanced for use with Netscape 6.  " + "Would you like to upgrade now?"); 
         if (rv) 
            document.location.href = "http://home.netscape.com/download/index.html";
      } 
   }
</SCRIPT>
	<link rel="stylesheet" type="text/css" href="../jukex.css" />
</head>

<body>
<table cellpadding="0" cellspacing="0" border="0" width="100%" height="100%">
	<tr>
		<td valign="center">
			
			<div align="center">
				<table cellpadding="0" cellspacing="0" border="0" width="401">
					<tr height="112">
						<td colspan="3"><a href="http://www.jukex.org"><img src="<%=imageRoot%>/splash/SplashTop.jpg" border="0" /></a></td>
					</tr>
					<tr>
						<td><img src="<%=imageRoot%>/splash/SplashLeft.jpg" border="0" /></td>
						<td width="378" valign="top">
							<table cellpadding="5" cellspacing="0" border="0" width="100%" height="100%"><tr><td>
								<div align="center" class="splashBold">JukeX Jukebox System</div>
								<div class="splashNormal">
									<br />
									Version: <%=versionStr%><br />
									Currently Storing: <%= ts.getTrackCount() %> Tracks<br />
								</div>
							</td></tr>
							<tr><td valign="bottom">
								<div align="center" valign="bottom" class="splashNormal">Copyright &copy; 2002 NeoWorks Limited. All rights reserved.</div>
								<div align="center" valign="bottom" class="splashNormal">This software is released under the <a href="http://www.fsf.org/licenses/gpl.html" target="_new">GNU General Public License</a>.</div>
							</td></tr></table>
						</td>
						<td><img src="<%=imageRoot%>/splash/SplashRight.jpg" border="0" /></td>
					</tr>
					<tr>
						<td colspan="3"><a href="http://www.neoworks.com" target="_top"><img src="<%=imageRoot%>/splash/SplashBottom.jpg" border="0" /></a></td>
					</tr>
				</table>
			</div>
			
		</td>
	</tr>
	<tr>
		<td>
			<div align="center"><a class="navbarlink" href="javascript:addJukexPanel();">Add a JukeX panel to the Mozilla/Netscape side panel</a></div>
		</td>
	</tr>
</table>


</body>
</html>
