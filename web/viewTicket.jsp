<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- 
    Document   : viewTicket
    Created on : Nov 2, 2017, 3:15:37 PM
    Author     : Code Blue
--%>

<%@page import="utils.CommentBean"%>
<%@page import="utils.TicketBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="style.css">
        <title>View Ticket</title>
    </head>
    <body>
        
        <script language="javascript">
            
            function showHideSelect()
            { 
                if(document.getElementById('assign').checked) {
                    document.getElementById('developerList').style.display="block";
                    document.getElementById('assignSubmit').style.display="block";
                }
                if(!document.getElementById('assign').checked){
                    document.getElementById('developerList').style.display="none";
                    document.getElementById('assignSubmit').style.display="none";
                }
            }
            function viewAttachment()
            {
                document.getElementById('attachmentModel').style.display="block";
                document.getElementById("caption").innerHTML = document.getElementById('attachment').alt;
                
                // When the user clicks on <span> (x), close the modal
                document.getElementsByClassName("close")[0].onclick = function() { 
                    document.getElementById('attachmentModel').style.display = "none";
                }
            }
        </script>
        
        <% 
           TicketBean ticket = (TicketBean)request.getAttribute("ticket");
           java.text.DateFormat df = new java.text.SimpleDateFormat("MM/dd/yyyy HH:mm"); 
            String headerColspan = "8";
            String commentsColspan = "7";
            if(request.getSession().getAttribute("Developer") != null){
                headerColspan = "9";
            }
            if(request.getSession().getAttribute("Admin") != null){
                headerColspan="10";
                commentsColspan="8";
            }
        %>
        <table id="ticketList" border="1" align="center" onload="checkResolved()">
            <thead>
                <tr>
                    
                    <th colspan=<%=headerColspan%>>Ticket # <%=ticket.getId() %></th>
                </tr>
                <tr>
                    <th>Id</th>
                    <th>Date</th>
                    <th>Sent From</th>
                    <th>Title</th>
                    <th>Content</th>
                    <th>Status</th>
                    <th>Developer</th>
                    <th>View Attachment</th>
                    <% if(request.getSession().getAttribute("Client") == null){ %>
                    <th>Update Status</th>
                    
                    <% if(request.getSession().getAttribute("Admin") != null){%>
                    <th>Assign</th>
                    <% } 
                    }%>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><%= ticket.getId()%></td>
                    <td><%= df.format(ticket.getDate())%></td>
                    <td><%= ticket.getSenderName()%></td>
                    <td><%= ticket.getTitle()%></td>
                    <td><%= ticket.getContent()%></td>
                    <td><%= ticket.getStatus()%></td>
                    <td><%= ticket.getDeveloper()%></td>
                    
                    <% if(ticket.getAttachment() != null){ %>
                    <td>
                        <button onclick="viewAttachment()">View Attachment </button>
                        </br>
                        <%=ticket.getAttachmentName()%>
                        <div id="attachmentModel" class="model">
                            <span class="close">&times;</span>
                            <img id="attachment" src="${pageContext.request.contextPath}/attachments/${ticket.getAttachmentName()}" alt="${ticket.getAttachmentName()}">
                            <div id="caption"></div>
                        </div>
                    </td>
                    
                    <% }else{ %>
                    <td>No Attachment</td>
                    <% } %>
                    
                    <% if(request.getSession().getAttribute("Client") == null){ %>
                    <td>
                        <form action="UpdateTicketServlet" method="POST" id="updateStatusForm" >
                            <input type="hidden" name="id" value=<%=ticket.getId()%>>

                            <select id="status" name="status" onchange="showHideSelect()">
                                <option selected>Update Status</option>
                                <option>new</option>
                                <option>Assigned</option>
                                <option>Working On</option>
                                <option>Resolved</option>
                            </select>
                            </br>
                            <input type="submit" value="update" name="updateTicket" id="updateTicketSubmit"/>
                        </form>
                    </td> 
                    <% } %>
                    <% if(request.getSession().getAttribute("Admin") != null) { %>
                    <td>
                        <%if(ticket.getDeveloper().equals("Not Assigned")){ %>
                        <form action="UpdateTicketServlet" method="POST" id="assignForm">
                            <input type="hidden" name="id" value=<%=ticket.getId()%>/>
                            <input type="checkbox" id="assign" name="assign" onchange="showHideSelect()"/> Assign to Developer
                            <select id="developerList" name="developer" style="display:none">
                                <option disabled selected>Assign to Developer</option>
                                <%
                                    List<String> developers = (ArrayList<String>)request.getAttribute("developers");
                                    for(String developer : developers) {
                                %>
                                <option><%=developer %></option>
                                <%}%>
                            </select>
                            <input type="submit" value="assign" name="updateTicket" id="assignSubmit" style="display:none"/>
                        </form>
                        <% } %>
                        
                    </td>
                    <%  } %>
                    </br>
                </tr>
                <tr>
                    <td colspan=<%=headerColspan%>></td>
                </tr>
                <tr>
                    <td>Comments</td>
                    <td colspan=<%=commentsColspan%>>
                    <% 
                        List<CommentBean> comments = (ArrayList<CommentBean>)request.getAttribute("comments");
                        for(CommentBean comment : comments){
                            if(request.getSession().getAttribute("Client") == null || comment.getClientView().equals("true")){
                    %>
                            <p><%=comment.getComment()%></p>
                            <p> -<%=comment.getAuthor() %> </p>
                            <p><%= df.format(comment.getDate()) %></p>
                    <%          
                            }
                        }
                    %>
                    </td>
                    <%if(request.getSession().getAttribute("Client") == null){%>
                    <td>
                        <form action="AddComment" method="POST" id="addComment">
                            <input type="hidden" name="id" value=<%=ticket.getId()%>>
                            Add Comment: <input type="text" size="50" name="comment">
                            </br>
                            Can client view comment?<input type="checkbox" name="clientView" />
                            <input type="submit" value="submit" name="updateComment">
                        </form>
                    </td> 
                    <% } %>
                </tr>
            </tbody>
        </table>
        </br>
        
        <button><a href="DisplayTicketsServlet">Home</a></button>                       
    </body>
</html>
