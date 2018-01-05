<%-- 
    Document   : admin
    Created on : Sep 14, 2017, 12:49:07 PM
    Author     : Code Blue
--%>

<%@page import="utils.TicketBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@ include file="header.jspf" %> 
        <title>Home</title>
    </head>
    <body>
        <%@ include file="navbar.jspf" %>
        
        <div class="jumbotron">
            <h1>Welcome ${sessionScope.userName}!</h1>
        </div>
        
        <c:if test="${newTicket != null}">
        <script language="javascript">
            alert("Ticket successfully sent")
        </script>
        </c:if>
        <c:if test="${fail != null}">
        <script language="javascript">
            alert("Send failed. Please fill out required fields")
        </script>
        </c:if>
        <c:if test="${userAdded != null}">
        <script language="javascript">
            alert("user successfully added")
        </script>
        </c:if>
        <c:if test="${userFailed != null}">
        <script language="javascript">
            alert("That is not a valid username. Please select a new username.")
        </script> 
        </c:if>
        
        <br/>
        <%@ include file="footer.jspf" %>  
    </body>
</html>
