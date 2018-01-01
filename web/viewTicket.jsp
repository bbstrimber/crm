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
        <%@ include file="header.jspf" %>
        <title>View Ticket</title>
    </head>
    <body>
        <%@ include file="navbar.jspf" %>
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
           java.text.DateFormat df = new java.text.SimpleDateFormat("MM/dd/yyyy hh:mm a"); 
            String headerColspan = "8";
            if(request.getSession().getAttribute("Developer") != null){
                headerColspan = "9";
            }
            if(request.getSession().getAttribute("Admin") != null){
                headerColspan="10";
            }
        %>
        <span class="col-sm-offset-1 col-sm-10">
            <h2>View Ticket Details</h2>
            <a href="Tickets" type="button" class="btn btn-link" > <span class="glyphicon glyphicon-chevron-left"></span>Back to Ticket List</a>
            <table id="ticketDetails" class="table table-bordered table-responsive">
                <thead class="thead-light">
                    <tr>
                        <th class="text-center" colspan=<%=headerColspan%>>Ticket # <%=ticket.getId() %></th>
                    </tr>
                    <tr>
                        <th scope="col">Id</th>
                        <th scope="col">Date</th>
                        <th scope="col">Sent From</th>
                        <th scope="col">Title</th>
                        <th scope="col">Content</th>
                        <th scope="col">Status</th>
                        <th scope="col">Developer</th>
                        <th scope="col">View Attachment</th>
                        <% if(request.getSession().getAttribute("Client") == null){ %>
                        <th scope="col">Update Status</th>

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
                            <form action="UpdateTicket" method="POST" id="updateStatusForm" >
                                <input type="hidden" name="id" value=<%=ticket.getId()%>>
                                <div class="form-group">
                                    <select id="status" name="status" class="form-control input-sm" onchange="showHideSelect()">
                                        <option selected>Update Status</option>
                                        <option>new</option>
                                        <option>Assigned</option>
                                        <option>Working On</option>
                                        <option>Resolved</option>
                                    </select>
                                </div>
                                <button type="submit" class="btn btn-default btn-sm" name="updateTicket" id="updateTicketSubmit">Update</button>
                            </form>
                        </td> 
                        <% } %>
                        <% if(request.getSession().getAttribute("Admin") != null) { %>
                        <td>
                            <%if(ticket.getDeveloper().equals("Not Assigned")){ %>
                            <form action="UpdateTicketServlet" method="POST" id="assignForm">
                                <input type="hidden" name="id" value=<%=ticket.getId()%>>
                                <div class="form-check">
                                    <label class="form-check-label" id="assignLabel">
                                      <input class="form-check-input" type="checkbox" id="assign" name="assign" onchange="showHideSelect()">
                                        Assign to Developer
                                    </label>
                                </div>
                                <div class="form-group">
                                    <select class="form-control input-sm" id="developerList" name="developer" style="display:none">
                                        <option disabled selected>Assign to Developer</option>
                                        <%
                                            List<String> developers = (ArrayList<String>)request.getAttribute("developers");
                                            for(String developer : developers) {
                                        %>
                                        <option><%=developer %></option>
                                        <%}%>
                                    </select>
                                </div>
                                <button type="submit" class="btn btn-default btn-sm" name="updateTicket" id="assignSubmit" style="display:none">Assign</button>
                            </form>
                            <% } %>

                        </td>
                        <%  } %>
                        </br>
                    </tr>
                    
                </tbody>
            </table>
            <fieldset class="well">
                <h4>Comments</h4>
                <div class="list-group">
                <% 
                List<CommentBean> comments = (ArrayList<CommentBean>)request.getAttribute("comments");
                for(CommentBean comment : comments){
                    if(request.getSession().getAttribute("Client") == null || comment.getClientView().equals("true")){
                %>
                    <div class="list-group-item">
                        <h4 class="list-group-item-heading"><%=comment.getComment()%></h4>
                        <p class="list-group-item-text">-<%=comment.getAuthor() %></p>
                        <p class="list-group-item-text"><%= df.format(comment.getDate()) %></p>
                    </div>
                <%          
                    }
                }
                %>
                </div>
                
                        
                <%if(request.getSession().getAttribute("Client") == null){%>

                <form action="AddComment" method="POST" id="addComment" class="form-horizontal">
                    <input type="hidden" name="id" value=<%=ticket.getId()%>>
                    <div class="form-group row">
                        <label for="comment" class="control-label col-sm-2">Add Comment </label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="comment" id="comment">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="clientView" class="col-sm-3">Can client view comment?</label>
                        <div class="col-sm-9">
                            <div class="form-check">
                                <input class="form-check-input" name="clientView" type="checkbox">
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-offset-1">
                        <button type="submit" class="btn btn-primary">Submit</button>
                    </div>
                </form>

                <% } %>
            </fieldset>
        </span>
        
        <%@ include file="footer.jspf" %>  
</html>
