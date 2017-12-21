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
        
        <h2>Tickets</h2>
        <table id="ticketList" class="table table-responsive table-hover">
            <thead class="thead-light">
                
                <tr>
                    <th scope="col"><a href="DisplayTickets?sort=id">Id</a></th>
                    <th scope="col"><a href="DisplayTickets?sort=date">Date</a></th>
                    <th scope="col"><a href="DisplayTickets?sort=title">Title</a></th>
                    <th scope="col"><a href="DisplayTickets?sort=status">Status</a></th>
                    <th scope="col"><a href="DisplayTickets?sort=developer">Developer</a></th>
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
                    <td>
                        <form action="ViewTicketServlet" method="POST" id="viewTicket">
                            <input type="hidden" name="id" value=<%=ticket.getId()%>>
                            <input type="submit" value="View Details" name="viewTickets" id="ViewTicketSubmit">
                        </form>
                    </td>
                </tr>
                <% } %>            
            </tbody>
        </table> 
        
        <button onclick="showTicketForm()" id="showTicket">Create Ticket</button>
        <script language="javascript">
            function showTicketForm() {
                document.getElementById("newTicketForm").style.display="block";
                document.getElementById("showTicketForm").style.display="none";
            }
        </script>        
                
        <table border="0" id="newTicketForm" style="display: none" >
            <thead>
                <tr>
                    <th colspan="2">Create Ticket</th>
                </tr>
            </thead>
            <tbody>
                <form action="AddTicket" method="POST" enctype="multipart/form-data">
                    <tr>
                        <td> Title:</td>
                        <td><input type="text" name="title" required/> </td>
                    </tr>
                    <tr>
                        <td> Content: </td>
                        <td> <textarea name="content" rows="4" cols="20" required></textarea> </td>
                    </tr>
                    <tr>
                        <td> <input type="file" name="attachment" </td>
                    </tr>
                    <tr>
                        <td><button class="btn btn-primary" type="submit"  name="submit">Submit</button></td>
                    </tr>
                </form>
            </tbody>
        </table>
        <br/>    
            
    <body>
        
</html>
