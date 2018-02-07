<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- 
    Document   : viewTicket
    Created on : Nov 2, 2017, 3:15:37 PM
    Author     : Code Blue
--%>


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
            function showAttachmentForm() {
                var x = document.getElementById("addAttachmentForm");
                if (x.style.display === "none") {
                    x.style.display = "block";
                } else {
                    x.style.display = "none";
                }
            }
            function showEditPriorityForm() {
                var x = document.getElementById("editPriorityForm");
                if (x.style.display === "none") {
                    x.style.display = "block";
                } else {
                    x.style.display = "none";
                }
            }
            
        </script>
        
        <c:set var="headerColspan" value="9" /> 
        
        <span class="col-sm-offset-1 col-sm-10">
            <h2>Ticket Details</h2>
            <a href="Tickets?perPage=${perPage}&pageNumber=${pageNumber}&sort=${sort}" type="button" class="btn btn-link" > <span class="glyphicon glyphicon-chevron-left"></span>Back to Ticket List</a>
            <table id="ticketDetails" class="table table-bordered table-responsive">
                <thead class="thead-light">
                    <tr>
                        <th class="text-center" colspan=${headerColspan}>Ticket # ${ticket.getId()}</th>
                    </tr>
                    <tr>
                        <th scope="col">Id</th>
                        <th scope="col">Priority</th>
                        <th scope="col">Date</th>
                        <th scope="col">Sent From</th>
                        <th scope="col">Title</th>
                        <th scope="col">Content</th>
                        <th scope="col">Status</th>
                        <th scope="col">Developer</th>
                        <th scope="col">View Attachment(s)</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>${ticket.getId()}</td>
                        <td class="text-center">
                            <c:choose>
                                <c:when test="${ticket.getPriority() eq 'Low'}">
                                    <h5 style="color: gold">${ticket.getPriority()} </h5>
                                </c:when>
                                <c:when test="${ticket.getPriority() eq 'High'}">
                                    <h5 style="color: red">${ticket.getPriority()} </h5>
                                </c:when>
                                <c:otherwise>
                                    <h5 style="color: #419641">${ticket.getPriority()} </h5>
                                </c:otherwise>
                            </c:choose>
                            <c:if test="${Client == null}">
                                <button type="button" class="btn btn-default btn-sm" onclick="showEditPriorityForm()">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <form action="UpdateTicket" class="form" method="POST" id="editPriorityForm" style="display:none">
                                    <input type="hidden" name="id" value=${ticket.getId()}>
                                    <input type="hidden" name="perPage" value=${perPage}>
                                    <input type="hidden" name="pageNumber" value=${pageNumber}>
                                    <input type="hidden" name="sort" value=${sort}>
                                    <div class="form-group">
                                        <select class="form-control input-sm" id="priorityList" name="priority">
                                            <option disabled selected>Edit Priority</option>
                                            <option style="color: gold">Low</option>
                                            <option style="color: #419641">Medium</option>
                                            <option style="color: red">High</option>
                                        </select>
                                    </div>
                                    <button type="submit" class="btn btn-default btn-sm" name="updateTicket" id="editPrioritySubmit">Update</button>
                                </form>
                            </c:if>
                        </td>
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
                            <c:if test="${Client == null}">
                                <c:if test="${ticket.getStatus() != 'Resolved' || Admin != null}">
                                    <c:if test="${ticket.getDeveloper() ne 'Unassigned'}">
                                        <button type="button" class="btn btn-default btn-sm" onclick="showStatusForm()">
                                            <i class="fas fa-edit"></i>
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
                                                    <c:if test="${Admin != null}">
                                                        <option>Closed</option>
                                                    </c:if>
                                                </select>
                                            </div>
                                            <button type="submit" class="btn btn-default btn-sm" name="updateTicket" id="updateTicketSubmit">Update</button>
                                        </form>
                                    </c:if>
                                </c:if>
                            </c:if>
                        </td>
                        <td>
                            ${ticket.getDeveloper()} 
                            <c:if test="${Admin != null}">
                                <button type="button" class="btn btn-default btn-sm" onclick="showAssignForm()">
                                    <i class="fas fa-edit"></i> 
                                    
                                </button>
                                <form action="UpdateTicket" class="form" method="POST" id="assignForm" style="display:none">
                                    <input type="hidden" name="id" value=${ticket.getId()}>
                                    <input type="hidden" name="perPage" value=${perPage}>
                                    <input type="hidden" name="pageNumber" value=${pageNumber}>
                                    <input type="hidden" name="sort" value=${sort}>
                                    <div class="form-group">
                                        <select class="form-control input-sm" id="developerList" name="developer">
                                            <c:choose>
                                                <c:when test="${ticket.getStatus() eq 'new'}">
                                                    <option disabled selected>Assign to Developer</option>
                                                </c:when>
                                                <c:otherwise>
                                                    <option disabled selected>Reassign Developer</option>
                                                </c:otherwise>
                                            </c:choose>
                                            
                                            <c:forEach items="${developers}" var="developer">
                                                <option>${developer}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <button type="submit" class="btn btn-default btn-sm" name="updateTicket" id="assignSubmit">Assign</button>
                                </form>
                            </c:if>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${!attachments.isEmpty()}">
                                    <c:forEach items="${attachments}" var="attachment" varStatus="vs">
                                        <a href="#" data-toggle="tooltip" title="${attachment.getAttachmentName()}">
                                            <button type="button" class="btn btn-default btn-sm" data-toggle="modal" data-target="#attachment${vs.index}">
                                                <i class="fas fa-paperclip"></i>
                                            </button>
                                        </a>
                                        <div class="modal fade" id="attachment${vs.index}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                                            <div class="modal-dialog modal-lg" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                        <h4 class="modal-title" id="myModalLabel">${attachment.getAttachmentName()}</h4>
                                                    </div>
                                                    <div class="modal-body">
                                                        <c:choose>
                                                            <c:when test="${attachment.getAttachmentType() eq 'image'}">
                                                                <img id="attachment" class="img-responsive" src="${pageContext.request.contextPath}/attachments/${attachment.getAttachmentName()}" alt="${attachment.getAttachmentName()}">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <object id="attachment" data="${pageContext.request.contextPath}/attachments/${attachment.getAttachmentName()}" type='application/pdf' width='100%' height="500" style="height: 85vh;"></object>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                
                                </c:when>
                                <c:otherwise>
                                No Attachment 
                                </c:otherwise>
                            </c:choose>
                             <button type="button" class="btn btn-default btn-sm" onclick="showAttachmentForm()">
                                <i class="glyphicon glyphicon-circle-arrow-up"></i>
                            </button>
                            <form action="AddAttachment" method="POST" enctype="multipart/form-data" id="addAttachmentForm"  style="display:none">
                                <input type="hidden" name="id" value=${ticket.getId()}>
                                    <input type="hidden" name="perPage" value=${perPage}>
                                    <input type="hidden" name="pageNumber" value=${pageNumber}>
                                    <input type="hidden" name="sort" value=${sort}>
                                <input type="file" id="attachment" name="attachment" class="form-control-file" multiple="multiple"/>
                                <button type="submit" class="btn btn-default btn-sm" name="addAttachment">Add Attachment</button>
                            </form>
                        </td>
                    </tr>
                </body>
            </table>
            
            </br>
                    
            <fieldset class="well">
                <h4>Comments</h4>
                <div class="list-group">
                    <c:forEach items="${comments}" var="comment" varStatus="vs">
                        <c:if test="${Client == null || comment.getClientView() eq 'true'}">
                            <div class="list-group-item">
                                <h5 class="list-group-item-heading">${comment.getComment()}</h5>
                                <p class="list-group-item-text text-muted">-${comment.getAuthor()}</p>
                                <p class="list-group-item-text text-muted"><fmt:formatDate value="${comment.getDate()}" pattern="MM/dd/yyyy hh:mm a"/></p>
                                
                                <c:if test="${Client == null && comment.isWithin24Hrs()}">
                                    <button type="button" class="btn btn-default btn-sm" data-toggle="modal" data-target="#editComment${vs.index}">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <div class="modal fade" id="editComment${vs.index}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                    <h4 class="modal-title" id="myModalLabel">Edit Comment</h4>
                                                </div>
                                                <div class="modal-body">
                                                    <form action="Comment" method="POST" class="form">
                                                        <input type="hidden" name="id" value=${ticket.getId()}>
                                                        <input type="hidden" name="commentId" value=${comment.getId()}>
                                                        <input type="hidden" name="perPage" value=${perPage}>
                                                        <input type="hidden" name="pageNumber" value=${pageNumber}>
                                                        <input type="hidden" name="sort" value=${sort}>
                                                        <input type="hidden" name="commentAction" value="addEdit">
                                                        <div class="form-row">
                                                            <textarea name="comment" class="form-control" rows="2">${comment.getComment()}</textarea>
                                                        </div>
                                                        <div class="form-row">
                                                            <div class="form-check">
                                                                <label for="clientView" style="text-align:right">
                                                                <c:choose>
                                                                    <c:when test="${comment.getClientView() eq 'true'}">
                                                                        Can client view? <input class="form-check-input" name="clientView" type="checkbox" checked>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        Can client view? <input class="form-check-input" name="clientView" type="checkbox"> 
                                                                    </c:otherwise>
                                                                </c:choose>
                                                                </label>
                                                            </div>
                                                        </div>
                                                        <div class="form-row text-center"> 
                                                            <button type="submit" class="btn btn-primary">Edit Comment</button>
                                                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                
                                    <c:if test="${comment.getAuthor() eq userName}">
                                        <button type="button" class="btn btn-danger btn-sm" data-toggle="modal" data-target="#deleteComment${vs.index}">
                                            <i class="fas fa-trash-alt"></i>
                                        </button>
                                        <div class="modal fade" id="deleteComment${vs.index}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                                            <div class="modal-dialog" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                        <h4 class="modal-title" id="myModalLabel">Delete Comment</h4>
                                                    </div>
                                                    <div class="modal-body">
                                                        <form action="Comment" method="POST" class="form">
                                                            <input type="hidden" name="id" value=${ticket.getId()}>
                                                            <input type="hidden" name="commentId" value=${comment.getId()}>
                                                            <input type="hidden" name="perPage" value=${perPage}>
                                                            <input type="hidden" name="pageNumber" value=${pageNumber}>
                                                            <input type="hidden" name="sort" value=${sort}>
                                                            <input type="hidden" name="commentAction" value="delete">
                                                            <div class="form row text-center">
                                                                <h5>Are you sure you want to delete this comment?</h5>
                                                            </div>
                                                            <div class="form-row text-center"> 
                                                                <button type="submit" class="btn btn-danger"><i class="fas fa-trash-alt"></i> Delete Comment</button>
                                                                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                                                            </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:if>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
                <c:if test="${Client == null}"> 
                    <form action="Comment" method="POST" id="addComment" class="form-horizontal">
                        <input type="hidden" name="id" value=${ticket.getId()}>
                        <input type="hidden" name="perPage" value=${perPage}>
                        <input type="hidden" name="pageNumber" value=${pageNumber}>
                        <input type="hidden" name="sort" value=${sort}>
                        <input type="hidden" name="commentAction" value="addEdit">
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
