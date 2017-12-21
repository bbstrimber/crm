<%-- 
    Document   : developer
    Created on : Sep 14, 2017, 12:49:28 PM
    Author     : Code Blue
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="utils.TicketBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@ include file="header.jspf" %> 
        <title>Developer Home</title>
    </head>
    <body>
        <%@ include file="navbar.jspf" %>
        <h1>Welcome <%=request.getSession().getAttribute("Developer") %>!</h1>
        
        <%
            String newTicket = (String)request.getAttribute("newTicket");
            String fail = (String)request.getAttribute("failAdd");
            
            if(newTicket != null){ %>
            <script language="javascript">
                alert("Ticket successfully sent")
            </script>
            <% } else if(fail != null){ %>
            <script language="javascript">
                alert("Send failed. Please fill out required fields")
            </script>
        <% } %>
        <br/>
        
        <%@ include file="footer.jspf" %>
    </body>
</html>
