<%-- 
    Document   : companyList
    Created on : Dec 20, 2017, 1:23:18 PM
    Author     : Blumie
--%>

<%@page import="utils.CompanyBean"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@ include file="header.jspf" %> 
        <title>Companies</title>
    </head>
    <body>
        <%@ include file="navbar.jspf" %>
        
        <span class="col-sm-offset-1 col-sm-10">
            <h2>Companies:</h2>
            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th scope="col">Id</th>
                        <th scope="col">Name</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${companies}" var="company">
                    <tr>
                        <td>${company.getId()}</td>
                        <td>${company.getName()}</td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>
        <button type="button" class="btn btn-primary" onclick="showForm()" id="showForm"><i class="fas fa-users"></i>+&nbsp;Add Company</button>
            <script language="javascript">
                function showForm() {
                    document.getElementById("addCompanyForm").style.display="block";
                    document.getElementById("showForm").style.display="none";
                }
            </script>
        </span>
        
        <form action="AddUser" method="POST" class="col-sm-offset-2 col-sm-8" id="addCompanyForm" style="display:none">
            <h4>Add Company: </h4>
            <fieldset class="well ">
                <div class="form-row">
                    <div class="form-group">
                        <label for="name">Company Name: </label>
                        <input type="text" class="form-control" id="name" required>
                    </div>
                </div>
                <div class="text-center"> 
                    <button type="submit" class="btn btn-primary">Add Company</button>
                </div>
            </fieldset>
        </form>
        
        <%@ include file="footer.jspf" %>
    </body>
</html>
