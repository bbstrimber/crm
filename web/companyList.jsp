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
        
        <h1>Companies:</h1>
        <table class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th scope="col">Id</th>
                    <th scope="col">Name</th>
                </tr>
            </thead>
            <tbody>
                <%
                   List<CompanyBean> companies = (ArrayList<CompanyBean>) request.getAttribute("companies");
                   for(CompanyBean company : companies){
                %>
                <tr>
                    <td><%= company.getId()%></td>
                    <td><%= company.getName()%></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        
        <%@ include file="footer.jspf" %>
    </body>
</html>
