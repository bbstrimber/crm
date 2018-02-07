<%-- 
    Document   : ticketList
    Created on : Dec 20, 2017, 11:18:36 AM
    Author     : Blumie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Tickets</title>
        <%@ include file="/WEB-INF/jspf/header.jspf" %> 
    </head>
    <body>
        <%@ include file="/WEB-INF/jspf/navbar.jspf" %>
    
        <span class="col-sm-offset-1 col-sm-10">
            <h2>Tickets</h2>
            <br>
            <button type="button" class="btn btn-primary" id="newTicket" data-toggle="modal" data-target="#newTicketForm">
                <i class="fas fa-list-alt"></i>
                New Ticket
            </button>
            
            <div class="modal fade" id="newTicketForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="myModalLabel">New Ticket</h4>
                        </div>
                        <div class="modal-body">
                            <form action="AddTicket" method="POST" enctype="multipart/form-data" class="form-horizontal">
                                <div class="form-group">
                                    <label for="title" class="control-label col-sm-2">Title: </label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="title" name="title" required/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="content" class="control-label col-sm-2">Content: </label>
                                    <div class="col-sm-8">
                                        <textarea id="content" name="content" class="form-control" rows="5" required></textarea>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="priority" class="control-label col-sm-2">Priority</label>
                                    <div class="col-sm-8">
                                        <select class="form-control" id="priority" name="priority">
                                            <option style="color: gold">Low</option>
                                            <option selected style="color: #419641">Medium</option>
                                            <option style="color: red">High</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-offset-2 col-sm-8">
                                        <input type="file" id="attachment" name="attachment" class="form-control-file" multiple="multiple"/>
                                    </div>
                                </div>
                                <div class="form-group"> 
                                    <div class="col-sm-offset-2 col-sm-8">
                                        <button type="submit" class="btn btn-primary btn-block">Submit</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <br>
            <br>
            <fieldset>
                <div class="row">
                    <form class="form col-sm-3" method="POST" action="Tickets" name="filter">
                        <div class="form-group">
                            <input type="hidden" name="perPage" value="${perPage}"/>
                            <select class="form-control" id="status" name="status" onchange="this.form.submit()">
                                <option selected>Filter By Status</option>
                                <option>new</option>
                                <option>Assigned</option>
                                <option>Resolved</option>
                                <option>Working On</option>
                            </select>
                        </div>
                    </form>
                    <form class="form col-sm-3" method="POST" action="Tickets" name="filter">
                    <div class="form-group">
                        <input type="hidden" name="perPage" value="${perPage}"/>
                        <select class="form-control" id="developer" name="developer" onchange="this.form.submit()">
                            <option selected>Filter By Developer</option>
                            <c:forEach items="${developers}" var="developer">
                            <option>${developer}</option>
                            </c:forEach>
                        </select>
                    </div>
                    </form>
                    <form class="form col-sm-3" method="POST" action="Tickets" name="filter">
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
                        <th scope="col"><a href="Tickets?sort=id&perPage=${perPage}">Id</a></th>
                        <th scope="col"><a href="Tickets?sort=priority&perPage=${perPage}">Priority</a></th>
                        <th scope="col"><a href="Tickets?sort=date&perPage=${perPage}">Date</a></th>
                        <th scope="col"><a href="Tickets?sort=title&perPage=${perPage}">Title</a></th>
                        <th scope="col"><a href="Tickets?sort=status&perPage=${perPage}">Status</a></th>
                        <th scope="col"><a href="Tickets?sort=developer&perPage=${perPage}">Developer</a></th>
                        <th scope="col"></th>
                    </tr>
                </thead>
                <tbody>
                    
                    <c:forEach items="${ticketList}" var="ticket">
                    <tr>
                        <td>${ticket.getId()}</td>
                        <td>
                            <c:choose>
                                <c:when test="${ticket.getPriority() eq 'Low'}">
                                    <p style="color: gold">${ticket.getPriority()} </p>
                                </c:when>
                                <c:when test="${ticket.getPriority() eq 'High'}">
                                    <p style="color: red">${ticket.getPriority()} </p>
                                </c:when>
                                <c:otherwise>
                                    <p style="color: #419641">${ticket.getPriority()} </p>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td><fmt:formatDate value="${ticket.getDate()}" pattern="MM/dd/yyyy"/></td>
                        <td>${ticket.getTitle()}</td>
                        <td>${ticket.getStatus()}</td>
                        <td>${ticket.getDeveloper()}</td>
                        <td class="text-center">
                            <div class ="row">
                                <div class="col-lg-2">
                                    <c:if test="${ticket.hasAttachment()}">
                                        <i class="fas fa-paperclip"></i>
                                    </c:if>
                                </div>
                                <div class="col-lg-10">
                                    <form action="ViewTicket" method="POST" id="viewTicket">
                                        <input type="hidden" name="id" value=${ticket.getId()}>
                                        <input type="hidden" name="perPage" value=${perPage}>
                                        <input type="hidden" name="pageNumber" value=${pageNumber}>
                                        <input type="hidden" name="sort" value=${sort}>
                                        <button type="submit" class="btn btn-default">
                                            <span class="glyphicon glyphicon-th-list pull-left"></span>
                                            &nbsp;View Details
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </td>
                    </tr>
                    </c:forEach>            
                </tbody>
            </table>  
            <c:if test="${perPage > 5 && numOfPages != 1}">
                <%@ include file="/WEB-INF/jspf/pagination.jspf" %> 
            </c:if>
            
        </span>
                
               
        <br/>
        <%@ include file="/WEB-INF/jspf/footer.jspf" %>    
    <body>
</html>
