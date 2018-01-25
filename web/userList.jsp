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
            <h2>Users</h2>
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

            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addUserForm">
                <i class="fas fa-user-plus"></i>
                Add User</button>
            </button>
        </span>
        
        <div class="modal fade" id="addUserForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">Add User</h4>
                    </div>
                    <div class="modal-body">
                        <form action="AddUser" method="POST" id="addUserForm">
                            <div class="form-row">
                                <div class="form-group col-sm-6">
                                    <label for="username">Username: </label>
                                    <input type="text" class="form-control" id="username" name="username" required>
                                </div>
                                <div class="form-group col-sm-6">
                                    <label for="password">Password: </label>
                                    <input type="password" class="form-control" id="password" name="password" required>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-sm-6">
                                    <label for="userType">User Type: </label>
                                    <select class="form-control" id="userType" name="userType" required>
                                        <option disabled selected>Select User Type</option>
                                        <option>developer</option>
                                        <option>client</option>
                                    </select>
                                </div>
                                <div class="form-group col-sm-6">
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
                                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        
        <%@ include file="/WEB-INF/jspf/footer.jspf" %>    
    </body>
</html>
