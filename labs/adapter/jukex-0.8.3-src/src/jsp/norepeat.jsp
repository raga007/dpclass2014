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
        NoRepeatPipelineElement noRepeat = (NoRepeatPipelineElement)request.getAttribute("norepeat");
        TrackStore ts = TrackStoreFactory.getTrackStore();
        TrackSourcePipeline pipeline = (TrackSourcePipeline)request.getAttribute("pipeline");
                        
        ResourceBundle interfaceResources = (ResourceBundle)request.getAttribute("resources");
                        
        Locale currentLocale = request.getLocale();
%>                      
                        
<html>                  
<head>                          
        <link rel="stylesheet" type="text/css" href="../jukex.css" />
</head>
<body>
<%if (noRepeat == null) {%>
        <jukex:box title="Error" width="500" bevel="no" padding="20">
                <h1>ERROR - Could not find a no repeat element</h1>
        </jukex:box>
<%} else {%>
        
<jukex:box title="No Repeat Configuration" width="600" bevel="no" padding="20">
        <form method="POST" action="<%=contextRootURL%>servlet/JukeXAdmin">
                <input type="hidden" name="view" value="pipeline">
                <input type="hidden" name="action" value="norepeat.setinterval">
                <input type="hidden" name="norepeat.index" value="<%=pipeline.indexOf(noRepeat)%>">
		<span class="bodyText">Minimum number of tracks to play between repeats</span>
                <input type="text" size="5" name="norepeat.interval" value="<%=noRepeat.getInterval()%>">
                <input type="submit" name="norepeat.submit" value="Update">
        </form>
</jukex:box>

<%}%>
</body> 
</html>
