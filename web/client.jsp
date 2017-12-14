<%-- 
    Document   : client
    Created on : Sep 14, 2017, 12:49:41 PM
    Author     : Code Blue
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="utils.TicketBean"%>
<%@page import="java.sql.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="style.css">
        <title>Client Home</title>
    </head>
    <body>
        
         <%java.text.DateFormat df = new java.text.SimpleDateFormat("MM/dd/yyyy"); %>
        <h1>Welcome <%=request.getSession().getAttribute("Client") %>!</h1>
        
        <br/>
        
        <%
            String newTicket = (String)request.getAttribute("newTicket");
            String fail = (String)request.getAttribute("failAdd");
            
            if(newTicket != null){ %>
            <script language="javascript">
                alert("Ticket successfully sent")
            </script>
            <% } else if(fail != null){ %>
            <script language="javascript">
                alert("Send failed. Please fill out required fields")
            </script>
        <% } %>

        </br>
        
        <table id="ticketList" border="1" align="center">
            <thead>
                <tr>
                    <th colspan="6">Your tickets</th>
                </tr>
                <tr>
                    <th><a href="DisplayTicketsServlet?sort=id">Id</a></th>
                    <th><a href="DisplayTicketsServlet?sort=date">Date</a></th>
                    <th><a href="DisplayTicketsServlet?sort=title">Title</a></th>
                    <th><a href="DisplayTicketsServlet?sort=status">Status</a></th>
                    <th><a href="DisplayTicketsServlet?sort=developer">Developer</a></th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <% List<TicketBean> tickets = new ArrayList<TicketBean>();
                   tickets = (ArrayList<TicketBean>) request.getAttribute("ticketList");
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
                        <td><input type="submit" value="submit" name="submit" /></td>
                    </tr>
                </form>
            </tbody>
        </table>
        <br/>
        <button><a href="LogoutServlet">Logout</a></button>
    </body>
</html>




