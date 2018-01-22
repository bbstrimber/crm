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
        <%@ include file="/WEB-INF/jspf/header.jspf" %>
        <title>View Ticket</title>
    </head>
    <body>
        <%@ include file="/WEB-INF/jspf/navbar.jspf" %>
        <script language="javascript">
            
            function showAssignForm()
            { 
                var x = document.getElementById("assignForm");
                if (x.style.display === "none") {
                    x.style.display = "block";
                } else {
                    x.style.display = "none";
                }
            }
            function showStatusForm() {
                var x = document.getElementById("updateStatusForm");
                if (x.style.display === "none") {
                    x.style.display = "block";
                } else {
                    x.style.display = "none";
                }
            }
        </script>
        
        <c:set var="headerColspan" value="8" /> 
        
        <span class="col-sm-offset-1 col-sm-10">
            <h2>Ticket Details</h2>
            <a href="Pagination?perPage=${perPage}&pageNumber=${pageNumber}&sort=${sort}" type="button" class="btn btn-link" > <span class="glyphicon glyphicon-chevron-left"></span>Back to Ticket List</a>
            <table id="ticketDetails" class="table table-bordered table-responsive">
                <thead class="thead-light">
                    <tr>
                        <th class="text-center" colspan=${headerColspan}>Ticket # ${ticket.getId()}</th>
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
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>${ticket.getId()}</td>
                        <td>
                            <fmt:formatDate value="${ticket.getDate()}" pattern="MM/dd/yyyy"/>
                            </br>
                            <fmt:formatDate value="${ticket.getDate()}" pattern="hh:mm a"/>
                        </td>
                        <td>${ticket.getSenderName()}</td>
                        <td>${ticket.getTitle()}</td>
                        <td>${ticket.getContent()}</td>
                        <td>
                            ${ticket.getStatus()}
                            <br>
                            <c:if test="${Client == null}">
                                <c:if test="${ticket.getStatus() != 'Resolved' || Admin != null}">
                                    <button type="button" class="btn btn-default btn-sm" onclick="showStatusForm()">
                                        <i class="fas fa-edit"></i> Update Status
                                    </button>
                                    
                                    <form action="UpdateTicket" method="POST" id="updateStatusForm" style="display:none" >
                                        <input type="hidden" name="id" value=${ticket.getId()}>
                                        <input type="hidden" name="perPage" value=${perPage}>
                                        <input type="hidden" name="pageNumber" value=${pageNumber}>
                                        <input type="hidden" name="sort" value=${sort}>
                                        <div class="form-group" >
                                            <select id="status" name="status" class="form-control input-sm" onchange="showHideSelect()">
                                                <option selected>Update Status</option>
                                                <option>Working On</option>
                                                <option>Resolved</option>
                                            </select>
                                        </div>
                                        <button type="submit" class="btn btn-default btn-sm" name="updateTicket" id="updateTicketSubmit">Update</button>
                                    </form>
                                </c:if>
                            </c:if>
                        </td>
                        <td>
                            ${ticket.getDeveloper()}
                            <br>
                            <c:if test="${Admin != null}">
                                <button type="button" class="btn btn-default btn-sm" onclick="showAssignForm()">
                                    <i class="fas fa-edit"></i> 
                                    <c:choose>
                                        <c:when test="${ticket.getStatus() eq 'new'}">
                                          Assign to Developer
                                        </c:when>
                                        <c:otherwise>
                                            Switch Developer
                                        </c:otherwise>
                                    </c:choose>
                                </button>
                                <form action="UpdateTicket" class="form" method="POST" id="assignForm" style="display:none">
                                    <input type="hidden" name="id" value=${ticket.getId()}>
                                    <input type="hidden" name="perPage" value=${perPage}>
                                    <input type="hidden" name="pageNumber" value=${pageNumber}>
                                    <input type="hidden" name="sort" value=${sort}>
                                    <div class="form-group">
                                        <select class="form-control input-sm" id="developerList" name="developer">
                                            <option disabled selected>Assign to Developer</option>
                                            <c:forEach items="${developers}" var="developer">
                                                <option>${developer}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <button type="submit" class="btn btn-default btn-sm" name="updateTicket" id="assignSubmit">Assign</button>
                                </form>
                            </c:if>
                        </td>
                        <c:choose>
                            <c:when test="${ticket.getAttachmentName() != null}">
                                <td>
                                    ${ticket.getAttachmentName()}
                                    </br>
                                    <button type="button" class="btn btn-default btn-sm" data-toggle="modal" data-target="#myModal">
                                        <i class="fas fa-paperclip"></i> View Attachment
                                    </button>
                                    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                                        <div class="modal-dialog modal-lg" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                    <h4 class="modal-title" id="myModalLabel">${ticket.getAttachmentName()}</h4>
                                                </div>
                                                <div class="modal-body">
                                                    <c:choose>
                                                        <c:when test="${imageAttachment != null}">
                                                            <img id="attachment" class="img-responsive" src="${pageContext.request.contextPath}/attachments/${ticket.getAttachmentName()}" alt="${ticket.getAttachmentName()}">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <object id="attachment" data="${pageContext.request.contextPath}/attachments/${ticket.getAttachmentName()}" type='application/pdf' width='100%' height="500" style="height: 85vh;"></object>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </c:when>
                            <c:otherwise>
                                <td>No Attachment</td>
                            </c:otherwise>
                        </c:choose>
                    </tr>
                </body>
            </table>
            
            </br>
                    
            <fieldset class="well">
                <h4>Comments</h4>
                <div class="list-group">
                    <c:forEach items="${comments}" var="comment">
                        <c:if test="${Client == null || comment.getClientView() eq 'true'}">
                            <div class="list-group-item">
                                <h5 class="list-group-item-heading">${comment.getComment()}</h5>
                                <p class="list-group-item-text text-muted">-${comment.getAuthor()}</p>
                                <p class="list-group-item-text text-muted"><fmt:formatDate value="${comment.getDate()}" pattern="MM/dd/yyyy hh:mm a"/></p>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
                <c:if test="${Client == null}"> 
                    <form action="AddComment" method="POST" id="addComment" class="form-horizontal">
                        <input type="hidden" name="id" value=${ticket.getId()}>
                        <div class="form-group row">
                            <label for="comment" class="control-label col-sm-2">Add Comment </label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="comment" id="comment">
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="clientView" class="col-sm-2" style="text-align:right">Can client view comment?</label>
                            <div>
                                <div class="form-check">
                                    <input class="form-check-input" name="clientView" type="checkbox">
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-offset-1">
                            <button type="submit" class="btn btn-primary">Submit</button>
                        </div>
                    </form>
                </c:if>
            </fieldset>
        </span>
        
        <%@ include file="/WEB-INF/jspf/footer.jspf" %>  
</html>
