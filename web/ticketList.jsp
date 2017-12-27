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
            <table id="ticketList" class="table table-bordered table-hover table-responsive ">
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
