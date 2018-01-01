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
        <% java.text.DateFormat df = new java.text.SimpleDateFormat("MM/dd/yyyy"); %>
    
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
                    <div class="form-group">
                        <select class="form-control" id="developer" name="developer" onchange="javascript:document.filter.submit();">
                            <option selected>By Developer</option>
                            <%
                                List<String> developers = (ArrayList<String>)request.getAttribute("developers");
                                for(String developer : developers) {
                            %>
                            <option><%=developer %></option>
                            <%}%>
                        </select>
                    </div>
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
            <nav aria-label="Page navigation example">
                <ul class="pager">
                    <% 
                        int pageNumber = 0;
                        if(request.getSession().getAttribute("pageNumber") != null){
                            pageNumber = (Integer) request.getSession().getAttribute("pageNumber");
                        } 
                    %>
                    <script language="javascript">
                        var pageNumber = <%=pageNumber %>;
                        if(pageNumber < 1){
                            document.getElementById("previous").disabled=true;
                        }

                    </script>
                    
                    <li class="previous" id="previous"><a href="Pagination?page=-1"> < Previous </a></li>
                    <li class="next" id="next"><a href="Pagination?page=+1">Next ></a></li>
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
                    <%  
                       List<TicketBean> tickets = (ArrayList<TicketBean>) request.getAttribute("ticketList");
                       for(TicketBean ticket : tickets){
                    %>

                    <tr>
                        <td><%= ticket.getId()%></td>
                        <td><%= df.format(ticket.getDate())%></td>
                        <td><%= ticket.getTitle()%></td>
                        <td><%= ticket.getStatus()%></td>
                        <td><%= ticket.getDeveloper()%></td>
                        <td class="text-center">
                            <form action="ViewTicket" method="POST" id="viewTicket">
                                <input type="hidden" name="id" value=<%=ticket.getId()%>>
                                <button type="submit" class="btn btn-default">
                                    <span class="glyphicon glyphicon-th-list pull-left"></span>
                                    &nbsp;View Details
                                </button>
                            </form>
                        </td>
                    </tr>
                    <% } %>            
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
