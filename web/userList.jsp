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
            
        <br/>
         
        <button type="button" class="btn btn-default" onclick="showForm()" id="showForm">Add User</button>
        <script language="javascript">
            function showForm() {
                document.getElementById("addUserForm").style.display="block";
                document.getElementById("showForm").style.display="none";
            }
        </script>
        
        <form action="AddUser" method="POST" class="form-inline" id="addUserForm" style="display:none">
            <h4>Add User: </h4>
            <div class="form-group ">
                <label for="username">Username: </label>
                <input type="text" class="form-control" id="username" required>
            </div>
            <div class="form-group">
                <label for="password">Password: </label>
                <input type="password" class="form-control" id="password" required>
            </div>
            <div class="form-group">
                <label for="userType">User Type: </label>
                <select class="form-control" id="userType" required>
                    <option disabled selected>Select User Type</option>
                    <option>developer</option>
                    <option>client</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Add User</button>
        </form>
        
        <%@ include file="footer.jspf" %>    
    </body>
</html>
