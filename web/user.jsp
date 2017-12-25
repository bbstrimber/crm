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
        <% String username;
        if(request.getSession().getAttribute("Developer") != null)
        {
            username = (String)request.getSession().getAttribute("Developer");
        }
        else if(request.getSession().getAttribute("Client") != null)
        {
           username = (String)request.getSession().getAttribute("Client");
        }
        else
        {
            username = (String)request.getSession().getAttribute("Admin");
        }
        %>
        
        <h1>Welcome <%= username %>!</h1>
        
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
        
        <%
            String userAdded = (String)request.getAttribute("newUser");
            String userFailed = (String)request.getAttribute("fail");
            if(userAdded != null){ %>
            <script language="javascript">
                alert("user successfully added")
            </script>
        <% } else if(userFailed != null){ %>
            <script language="javascript">
                alert("That is not a valid username. Please select a new username.")
            </script>
        <% }
           java.text.DateFormat df = new java.text.SimpleDateFormat("MM/dd/yyyy"); %>
        
        <!--Filter:
        </br>   
        <form action="FilterServlet" method="POST" id="filter">
            <select name="status">
                <option disabled selected>Status</option>
                <option>new</option>
                <option>Assigned</option>
                <option>Resolved</option>
            </select>
            <div border ="1"> Date:  
                From<input type="date" name="dateMin">
                To<input type="date" name="dateMax">
            </div>
            <select name="developer">
                <option disabled selected>Developer</option>
                <%--<%
                    List<String> developers = (ArrayList<String>)request.getAttribute("developers");
                    for(String developer : developers) {
                %>--%>
                <option><%--<%=developer %>--%></option>
                <%--<%}%>--%>
            </select>
            <input type="submit" value="Filter" name="submit">
        </form> 
         -->
        <br/>
        <%@ include file="footer.jspf" %>  
    </body>
</html>
