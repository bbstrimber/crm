<%-- 
    Document   : ticketList
    Created on : Dec 20, 2017, 11:18:36 AM
    Author     : Blumie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Ticket List</title>
        <%@ include file="/WEB-INF/jspf/header.jspf" %> 
    </head>
    <body>
        <%@ include file="/WEB-INF/jspf/navbar.jspf" %>
    
        <span class="col-sm-offset-1 col-sm-10">
            <h2>Tickets</h2>
            
            <fieldset >
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
                    <a href="Tickets" type="button" class="btn btn-primary col-sm-3">Clear Filters</a>
                </div>
            </fieldset>
            <c:if test="${numOfPages!=1}">
                <%@ include file="/WEB-INF/jspf/pagination.jspf" %> 
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
            <c:if test="${perPage > 5 && numOfPages != 1}">
                <%@ include file="/WEB-INF/jspf/pagination.jspf" %> 
            </c:if>
            <a href="NewTicket" type="button" class="btn btn-default" id="newTicket">
                <i class="fas fa-list-alt"></i>
                &nbsp;New Ticket
            </a>
        </span>
                
               
        <br/>
        <%@ include file="/WEB-INF/jspf/footer.jspf" %>    
    <body>
</html>
