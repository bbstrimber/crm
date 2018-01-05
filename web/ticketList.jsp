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
                <h5><strong>Filter:</strong></h5>
                <div class="row">
                    <form class="form col-sm-3" method="POST" action="Filter" name="filter">
                        <div class="form-group">
                            <input type="hidden" name="perPage" value="${perPage}"/>
                            <select class="form-control" id="status" name="status" onchange="this.form.submit()">
                                <option selected>By Status</option>
                                <option>new</option>
                                <option>Assigned</option>
                                <option>Resolved</option>
                                <option>Working On</option>
                            </select>
                        </div>
                    </form>
                    <c:if test="${Developer == null}">
                    <form class="form col-sm-3" method="POST" action="Filter" name="filter">
                    <div class="form-group">
                        <input type="hidden" name="perPage" value="${perPage}"/>
                        <select class="form-control" id="developer" name="developer" onchange="this.form.submit()">
                            <option selected>By Developer</option>
                            
                            <c:forEach items="${developers}" var="developer">
                            <option>${developer}</option>
                            </c:forEach>
                        </select>
                    </div>
                    </form>
                    </c:if>
                    <form class="form col-sm-3" method="POST" action="Filter" name="filter">
                    <div class="form-group">
                        <c:choose>
                            <c:when test="${filterStatus != null}">
                                <input type="hidden" name="status" value="${filterStatus}"/>
                            </c:when>
                            <c:when test="${filterDeveloper != null}">
                                <input type="hidden" name="developer" value="${filterDeveloper}"/>
                            </c:when>
                        </c:choose>
                        <select class="form-control" id="perPage" name="perPage" onchange="this.form.submit()">
                            <option selected>View Per Page</option>
                            <option>View All</option>
                            <option>2</option>
                            <option>8</option>
                            <option>10</option>
                        </select>
                    </div>
                    </form>
                    <!--<div class="input-group input-daterange">
                        <input type="date" name="dateMin" class="form-control">
                        <div class="input-group-addon">to</div>
                        <input type="date" name="dateMax" class="form-control" onchange="javascript:document.filter.submit();">
                    </div>-->
                    <a href="Tickets" type="button" class="btn btn-default col-sm-3">Clear Filters</a>
                </div>
            </fieldset>
            
            <c:if test="${numOfPages!=1}">
                <nav aria-label="pagination for tickets">
                    <ul class="pagination">
                        <c:if test="${pageNumber != 1}">
                            <c:url var="myURLPrevious" value="Pagination?perPage=${perPage}&pageNumber=${pageNumber-1}&sort=${sort}">
                                <c:choose>
                                    <c:when test="${filterDeveloper != null}">
                                        <c:param name="developer" value="${filterDeveloper}"/>
                                    </c:when>
                                    <c:when test="${filterStatus != null}">
                                        <c:param name="status" value="${filterStatus}"/>
                                    </c:when>
                                </c:choose>
                            </c:url>
                            <li class="page-item"><a class="page-link" 
                                href="${myURLPrevious}">
                                    <span class="glyphicon glyphicon-chevron-left"></span>
                                    Previous</a>
                            </li>
                        </c:if>

                        <c:forEach begin="1" end="${numOfPages}" var="i">
                            <c:choose>
                                <c:when test="${pageNumber eq i}">
                                    <li class="page-item active"><a class="page-link">
                                            ${i} <span class="sr-only">(current)</span></a>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <c:url var="myURLNumber" value="Pagination?perPage=${perPage}&pageNumber=${i}&sort=${sort}">
                                        <c:choose>
                                            <c:when test="${filterDeveloper != null}">
                                                <c:param name="developer" value="${filterDeveloper}"/>
                                            </c:when>
                                            <c:when test="${filterStatus != null}">
                                                <c:param name="status" value="${filterStatus}"/>
                                            </c:when>
                                        </c:choose>
                                    </c:url>
            
                                    <li class="page-item"><a class="page-link" 
                                        href="${myURLNumber}">${i}</a>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>

                        <c:if test="${pageNumber lt numOfPages}">
                            <c:url var="myURLNext" value="Pagination?perPage=${perPage}&pageNumber=${pageNumber+1}&sort=${sort}">
                                <c:choose>
                                    <c:when test="${filterDeveloper != null}">
                                        <c:param name="developer" value="${filterDeveloper}"/>
                                    </c:when>
                                    <c:when test="${filterStatus != null}">
                                        <c:param name="status" value="${filterStatus}"/>
                                    </c:when>
                                </c:choose>
                            </c:url>
            
                            <li class="page-item"><a class="page-link" 
                                href="${myURLNext}">Next
                                    <span class="glyphicon glyphicon-chevron-right"></span>
                                </a>
                            </li>
                        </c:if>              
                    </ul>
                </nav>
            </c:if>
            <table id="ticketList" class="table table-hover table-responsive ">
                <thead class="thead-light">

                    <tr>
                        <th scope="col"><a href="Sort?sort=id&perPage=${perPage}">Id</a></th>
                        <th scope="col"><a href="Sort?sort=date&perPage=${perPage}">Date</a></th>
                        <th scope="col"><a href="Sort?sort=title&perPage=${perPage}">Title</a></th>
                        <th scope="col"><a href="Sort?sort=status&perPage=${perPage}">Status</a></th>
                        <th scope="col"><a href="Sort?sort=developer&perPage=${perPage}">Developer</a></th>
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
