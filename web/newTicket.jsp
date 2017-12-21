<%-- 
    Document   : newTicket
    Created on : Dec 20, 2017, 1:59:44 PM
    Author     : Blumie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@ include file="header.jspf" %> 
        <title>New Ticket</title>
    </head>
    <body>
        <%@ include file="navbar.jspf" %>
              
                
        <table border="0" id="newTicketForm" >
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
        
        <%@ include file="footer.jspf" %> 
    </body>
</html>
