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
        <%@ include file="header.jspf" %> 
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Users</title>
    </head>
    <body>
        <%@ include file="navbar.jspf" %>
        <h1>Users:</h1>
        
        <table class="table table-bordered table-striped">
            <thead class="thead-light">
                <tr>
                    <th scope="col">Id</th>
                    <th scope="col">Username</th>
                    <th scope="col">Password</th>
                    <th scope="col">User Type</th>
                    <th scope="col">Company Name</th>
                </tr>
            </thead>
            <tbody>
                <%
                   List<UserBean> users = (ArrayList<UserBean>) request.getAttribute("users");
                   for(UserBean user : users){
                %>
                   
                <tr>
                    <td><%= user.getId()%></td>
                    <td><%= user.getUsername()%></td>
                    <td><%= user.getPassword()%></td>
                    <td><%= user.getUserType()%></td>
                    <td><%= user.getCompany()%></td>
                </tr>
                <% } %>
            </tbody>
        </table>
            
        <button onclick="showForm()" id="showForm">Add User</button>
        <script language="javascript">
            function showForm() {
                document.getElementById("addUserForm").style.display="block";
                document.getElementById("showForm").style.display="none";
            }
        </script>
        
        <form action="AddUser" method="POST" id="addUserForm" style="display: none">
             Username: <input type="text" name="username" required/> <br/>
             Password: <input type="text" name="password" required/> <br/>
             User Type 
            <select name="userType" required>
                <option disabled selected>Select User Type</option>
                <option>developer</option>
                <option>client</option>
            </select>
             <br/>
             <input type="submit" value="Add User" name="submit" />
        </form>
            
        <%@ include file="footer.jspf" %>    
    </body>
</html>
