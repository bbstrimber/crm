<%-- 
    Document   : newTicket
    Created on : Dec 20, 2017, 1:59:44 PM
    Author     : Blumie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@ include file="header.jspf" %> 
        <title>New Ticket</title>
    </head>
    <body>
        <%@ include file="navbar.jspf" %>
        
        <h2>New Ticket</h2>
                
        <form action="AddTicket" method="POST" enctype="multipart/form-data" class="form-horizontal" id="newTicketForm">
            <div class="form-group">
                <label for="title" class="control-label col-sm-2">Title: </label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="title" required/>
                </div>
            </div>
            <div class="form-group">
                <label for="content" class="control-label col-sm-2">Content: </label>
                <div class="col-sm-8">
                    <textarea id="content" class="form-control" rows="3" required></textarea>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-8">
                    <input type="file" id="attachment" class="form-control-file" </td>
                </div>
            </div>
            <div class="form-group"> 
                <div class="col-sm-offset-2 col-sm-8">
                    <button type="submit" class="btn btn-primary btn-block">Submit</button>
                </div>
            </div>
        </form>
        
        <%@ include file="footer.jspf" %> 
    </body>
</html>
