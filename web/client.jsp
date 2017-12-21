<%-- 
    Document   : client
    Created on : Sep 14, 2017, 12:49:41 PM
    Author     : Code Blue
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="utils.TicketBean"%>
<%@page import="java.sql.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@ include file="header.jspf" %> 
        <title>Client Home</title>
    </head>
    <body>
        <%@ include file="navbar.jspf" %>
        <h1>Welcome <%=request.getSession().getAttribute("Client") %>!</h1>
        
        <br/>
        
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

        </br>
        
        <button onclick="showTicketForm()" id="showTicket">Create Ticket</button>
        <script language="javascript">
            function showTicketForm() {
                document.getElementById("newTicketForm").style.display="block";
                document.getElementById("showTicketForm").style.display="none";
            }
        </script>        
                
        <table border="0" id="newTicketForm" style="display: none" >
            <thead>
                <tr>
                    <th colspan="2">Create Ticket</th>
                </tr>
            </thead>
            <tbody>
                <form action="AddTicket" method="POST" enctype="multipart/form-data">
                    <tr>
                        <td> Title:</td>
                        <td><input type="text" name="title" required/> </td>
                    </tr>
                    <tr>
                        <td> Content: </td>
                        <td> <textarea name="content" rows="4" cols="20" required></textarea> </td>
                    </tr>
                    <tr>
                        <td> <input type="file" name="attachment" </td>
                    </tr>
                    <tr>
                        <td><input type="submit" value="submit" name="submit" /></td>
                    </tr>
                </form>
            </tbody>
        </table>
        <br/>
        
        <%@ include file="footer.jspf" %>
    </body>
</html>




