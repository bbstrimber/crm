<%-- 
    Document   : admin
    Created on : Sep 14, 2017, 12:49:07 PM
    Author     : Code Blue
--%>

<%@page import="utils.TicketBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="style.css">

        <title>Admin</title>
    </head>
    <body>
        <h1>Welcome Admin!</h1>
        
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
        
        <%
            String userAdded = (String)request.getAttribute("newUser");
            String userFailed = (String)request.getAttribute("fail");
            if(userAdded != null){ %>
            <script language="javascript">
                alert("user successfully added")
            </script>
        <% } else if(userFailed != null){ %>
            <script language="javascript">
                alert("That is not a valid username. Please select a new username.")
            </script>
        <% }
           java.text.DateFormat df = new java.text.SimpleDateFormat("MM/dd/yyyy"); %>
        
        Filter:
        </br>   
        <form action="FilterServlet" method="POST" id="filter">
            <select name="status">
                <option disabled selected>Status</option>
                <option>new</option>
                <option>Assigned</option>
                <option>Resolved</option>
            </select>
            <div border ="1"> Date:  
                From<input type="date" name="dateMin">
                To<input type="date" name="dateMax">
            </div>
            <select name="developer">
                <option disabled selected>Developer</option>
                <%
                    List<String> developers = (ArrayList<String>)request.getAttribute("developers");
                    for(String developer : developers) {
                %>
                <option><%=developer %></option>
                <%}%>
            </select>
            <input type="submit" value="Filter" name="submit">
        </form> 
        </br> 
        <table id="ticketList" border="1" align="center">
            <thead>
                <tr>
                    <th colspan="6">Tickets</th>
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

        <br/>  
        
         <form action="DisplayUsersServlet" method="POST" id="showUsersForm">
            <input type="submit" value="View Users" name="submit" />
        </form>
                
        <br/>
        
        <button onclick="showForm()" id="showForm">Add User</button>
        <script language="javascript">
            function showForm() {
                document.getElementById("addUserForm").style.display="block";
                document.getElementById("showForm").style.display="none";
            }
        </script>
        
        <form action="AddUserServlet" method="POST" id="addUserForm" style="display: none">
             Username: <input type="text" name="username" required/> <br/>
             Password: <input type="text" name="password" required/> <br/>
             User Type 
            <select name="userType" required>
                <option disabled selected>Select User Type</option>
                <option>developer</option>
                <option>client</option>
            </select>
             <br/>
             <input type="submit" value="Add User" name="submit" />
        </form>
        
        <br/>
        <br/>
        
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
        
        <br/>
        
    </body>
</html>
