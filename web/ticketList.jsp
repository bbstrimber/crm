<%-- 
    Document   : ticketList
    Created on : Dec 20, 2017, 11:18:36 AM
    Author     : Blumie
--%>
<%@page import="utils.TicketBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Ticket List</title>
        <%@ include file="header.jspf" %> 
    </head>
    <body>
        <%@ include file="navbar.jspf" %>
    
        <span class="col-sm-offset-1 col-sm-10">
            <h2>Tickets</h2>
            
            <fieldset class="well">
                <form class="form-inline" method="POST" action="Filter" name="filter">
                    <div class="form-group">
                        <label>Filter: </label>
                        <select class="form-control" id="status" name="status" onchange="javascript:document.filter.submit();">
                            <option selected>By Status</option>
                            <option>new</option>
                            <option>Assigned</option>
                            <option>Resolved</option>
                            <option>Working On</option>
                        </select>
                    </div>
                    <c:if test="${Developer == null}">
                    <div class="form-group">
                        <select class="form-control" id="developer" name="developer" onchange="javascript:document.filter.submit();">
                            <option selected>By Developer</option>
                            
                            <c:forEach items="${developers}" var="developer">
                            <option>${developer}</option>
                            </c:forEach>
                        </select>
                    </div>
                    </c:if>
                    <div class="form-group">
                        <select class="form-control" id="perPage" name="perPage" onchange="javascript:document.filter.submit();">
                            <option selected>View Per Page</option>
                            <option>View All</option>
                            <option>6</option>
                            <option>8</option>
                            <option>10</option>
                        </select>
                    </div>
                    <!--<div class="input-group input-daterange">
                        <input type="date" name="dateMin" class="form-control">
                        <div class="input-group-addon">to</div>
                        <input type="date" name="dateMax" class="form-control" onchange="javascript:document.filter.submit();">
                    </div>-->
                    <a href="Tickets" type="button" class="btn btn-default">Clear Filters</a>
                </form>
                        
            </fieldset>
            <nav aria-label="pagination for tickets">
                <ul class="pagination">
                    <c:if test="${pageNumber != 0}">
                        <li class="page-item"><a class="page-link" 
                            href="Pagination?perPage=${perPage}&pageNumber=${pageNumber-1}">Previous</a>
                        </li>
                    </c:if>

                    <c:forEach begin="1" end="${numOfPages}" var="i">
                        <c:choose>
                            <c:when test="${pageNumber+1 eq i}">
                                <li class="page-item active"><a class="page-link">
                                        ${i} <span class="sr-only">(current)</span></a>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="page-item"><a class="page-link" 
                                    href="Pagination?perPage=${perPage}&pageNumber=${i}">${i}</a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <c:if test="${pageNumber lt numOfPages-1}">
                        <li class="page-item"><a class="page-link" 
                            href="Pagination?perPage=${perPage}&pageNumber=${pageNumber+1}">Next ></a>
                        </li>
                    </c:if>              
                </ul>
            </nav>
            <table id="ticketList" class="table table-hover table-responsive ">
                <thead class="thead-light">

                    <tr>
                        <th scope="col"><a href="Tickets?sort=id">Id</a></th>
                        <th scope="col"><a href="Tickets?sort=date">Date</a></th>
                        <th scope="col"><a href="Tickets?sort=title">Title</a></th>
                        <th scope="col"><a href="Tickets?sort=status">Status</a></th>
                        <th scope="col"><a href="Tickets?sort=developer">Developer</a></th>
                        <th scope="col"></th>
                    </tr>
                </thead>
                <tbody>
                    
                    <c:forEach items="${ticketList}" var="ticket">
                    <tr>
                        <td>${ticket.getId()}</td>
                        <td><fmt:formatDate value="${ticket.getDate()}" pattern="MM/dd/yyyy"/></td>
                        <td>${ticket.getTitle()}</td>
                        <td>${ticket.getStatus()}</td>
                        <td>${ticket.getDeveloper()}</td>
                        <td class="text-center">
                            <form action="ViewTicket" method="POST" id="viewTicket">
                                <input type="hidden" name="id" value=${ticket.getId()}>
                                <button type="submit" class="btn btn-default">
                                    <span class="glyphicon glyphicon-th-list pull-left"></span>
                                    &nbsp;View Details
                                </button>
                            </form>
                        </td>
                    </tr>
                    </c:forEach>            
                </tbody>
            </table>     
            <a href="NewTicket" type="button" class="btn btn-default" id="newTicket">
                <i class="fas fa-list-alt"></i>
                &nbsp;New Ticket
            </a>
        </span>
                
               
        <br/>
        
    <body>
</html>
