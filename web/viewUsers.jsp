<%-- 
    Document   : viewUsers
    Created on : Sep 18, 2017, 3:12:36 PM
    Author     : Code Blue
--%>

<%@page import="utils.UserBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Users</title>
    </head>
    <body>
        <h1>Users:</h1>
        
        <table border="1">
            <thead>
                <tr>
                    <th>Id</th>
                    <th>Username</th>
                    <th>Password</th>
                    <th>User Type</th>
                </tr>
            </thead>
            <tbody>
                <% List<UserBean> users = new ArrayList<UserBean>();
                   users = (ArrayList<UserBean>) request.getAttribute("users");
                   for(UserBean user : users){
                %>
                   
                <tr>
                    <td><%= user.getId()%></td>
                    <td><%= user.getUsername()%></td>
                    <td><%= user.getPassword()%></td>
                    <td><%= user.getUserType()%></td>
                </tr>
                <% } %>
            </tbody>
        </table>
            
        <br/>
        <button><a href="DisplayTicketsServlet">Home</a></button>   
    </body>
</html>
