<%-- 
    Document   : newTicket
    Created on : Dec 20, 2017, 1:59:44 PM
    Author     : Blumie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@ include file="/WEB-INF/jspf/header.jspf" %> 
        <title>New Ticket</title>
    </head>
    <body>
        <%@ include file="/WEB-INF/jspf/navbar.jspf" %>
        
        
                
        <form action="AddTicket" method="POST" enctype="multipart/form-data" class="form-horizontal col-sm-8 col-sm-offset-2" id="newTicketForm">
            <h2>New Ticket</h2>
            <fieldset class="well">
                <div class="form-group">
                    <label for="title" class="control-label col-sm-2">Title: </label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" id="title" name="title" required/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="content" class="control-label col-sm-2">Content: </label>
                    <div class="col-sm-8">
                        <textarea id="content" name="content" class="form-control" rows="5" required></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-8">
                        <input type="file" id="attachment" name="attachment" class="form-control-file" </td>
                    </div>
                </div>
                <div class="form-group"> 
                    <div class="col-sm-offset-2 col-sm-8">
                        <button type="submit" class="btn btn-primary btn-block">Submit</button>
                    </div>
                </div>
            </fieldset>
        </form>
        
        <%@ include file="/WEB-INF/jspf/footer.jspf" %> 
    </body>
</html>
