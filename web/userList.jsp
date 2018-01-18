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
        <%@ include file="/WEB-INF/jspf/header.jspf" %> 
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Users</title>
    </head>
    <body>
        <%@ include file="/WEB-INF/jspf/navbar.jspf" %>
        
        
        <span class="col-sm-offset-1 col-sm-10">
            <h2>Users:</h2>
            <table class="table table-bordered table-striped">
                <thead class="thead-light">
                    <tr>
                        <th scope="col">Id</th>
                        <th scope="col">Username</th>
                        <th scope="col">User Type</th>
                        <th scope="col">Company Name</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${users}" var="user">
                    <tr>
                        <td>${user.getId()}</td>
                        <td>${user.getUsername()}</td>
                        <td>${user.getUserType()}</td>
                        <td>${user.getCompany()}</td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>

            <br/>

            <button type="button" class="btn btn-primary" onclick="showForm()" id="showForm"><i class="fas fa-user-plus"></i>&nbsp;Add User</button>
            <script language="javascript">
                function showForm() {
                    document.getElementById("addUserForm").style.display="block";
                    document.getElementById("showForm").style.display="none";
                }
            </script>
        </span>
        
        <form action="AddUser" method="POST" class="col-sm-offset-1 col-sm-10" id="addUserForm" style="display:none">
            <h4>Add User: </h4>
            <fieldset class="well ">
                <div class="form-row">
                    <div class="form-group col-sm-3">
                        <label for="username">Username: </label>
                        <input type="text" class="form-control" id="username" name="username" required>
                    </div>
                    <div class="form-group col-sm-3">
                        <label for="password">Password: </label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <div class="form-group col-sm-3">
                        <label for="userType">User Type: </label>
                        <select class="form-control" id="userType" name="userType" required>
                            <option disabled selected>Select User Type</option>
                            <option>developer</option>
                            <option>client</option>
                        </select>
                    </div>
                    <div class="form-group col-sm-3">
                        <label for="companyName">Company </label>
                        <select class="form-control" id="companyName" name="companyName" required>
                            <option disabled selected>Select Company Name</option>
                            <c:forEach items="${companies}" var="company">
                            <option>${company}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="text-center"> 
                    <button type="submit" class="btn btn-primary">Add User</button>
                </div>
            </fieldset>
        </form>
        
        <%@ include file="/WEB-INF/jspf/footer.jspf" %>    
    </body>
</html>
