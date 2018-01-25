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
        <%@ include file="/WEB-INF/jspf/header.jspf" %> 
        <title>Companies</title>
    </head>
    <body>
        <%@ include file="/WEB-INF/jspf/navbar.jspf" %>
        
        <span class="col-sm-offset-1 col-sm-10">
            <h2>Companies</h2>
            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th scope="col">Id</th>
                        <th scope="col">Name</th>
                        <th scope="col">City</th>
                        <th scope="col">State</th>
                        <th scope="col">Zip Code</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${companies}" var="company">
                    <tr>
                        <td>${company.getId()}</td>
                        <td>${company.getName()}</td>
                        <td>${company.getCity()}</td>
                        <td>${company.getState()}</td>
                        <td>${company.getZip()}</td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>
        
        
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addCoForm">
                <i class="fas fa-users"></i>
                Add Company
            </button>
        </span>
        <div class="modal fade" id="addCoForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">Add Company</h4>
                    </div>
                    <div class="modal-body">
                        <form action="AddCompany" method="POST" id="addCompanyForm">
                            <div class="form-group">
                                <label for="name">Company Name: </label>
                                <input type="text" class="form-control" name="name" id="name" required>
                            </div
                            <div class="row">
                                <div class="form-group col-sm-4">
                                    <label for="city">City: </label>
                                    <input type="text" class="form-control" name="city" id="city" required>
                                </div>
                                <div class="form-group col-sm-4">
                                    <label for="name">State: </label>
                                    <input type="text" class="form-control" id="state" name="state" required>
                                </div>
                                <div class="form-group col-sm-4">
                                    <label for="name">Zip Code: </label>
                                    <input type="text" class="form-control" id="zip" name="zip" required>
                                </div>
                            </div>
                            <div class="form-group text-center"> 
                                <button type="submit" class="btn btn-primary">Add Company</button>
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
