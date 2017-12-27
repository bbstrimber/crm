
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@ include file="header.jspf" %> 
        <title>Code Blue CRM Login Page</title>
        
    </head>
    <body>
        <div class="jumbotron">
            <h2 class="display-3">CodeBlue CRM</h2>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    
                    <form action="Login" method="post" class="form-horizontal">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                            <input type="text" class="form-control" name="username" id="username" placeholder="Username"/>
                        </div>
                        <div class="input-group ">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                            <input type="password" class="form-control" name="password" id="password" placeholder="Password"/>
                        </div>
                        <hr/>
                        <span style="color:red"><%=(request.getAttribute("errMessage") == null) ? "": request.getAttribute("errMessage")%></span>
                        <button type="submit" class="form-control">Submit</button>
                    </form>
                    <hr/>
                </div>
            </div>
        </div>
        
        <!--<div style="text-align:center"><h1>Code Blue CRM </h1> </div>
        <br>
        <form name="form" action="LoginServlet" method="post" onsubmit="return validate()">
            <table align="center">
                <tr>
                    <td>Username</td>
                    <td><input type="text" name="username" /></td>
                </tr>
                <tr>
                    <td>Password</td>
                    <td><input type="password" name="password" /></td>
                </tr>
                <tr> 
                    <td><span style="color:red"><%=(request.getAttribute("errMessage") == null) ? "": request.getAttribute("errMessage")%></span></td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <input type="submit" value="Login"></input>
                        <input type="reset" value="Reset"></input>
                    </td>
                </tr>
            </table>
        </form>-->
        <%@ include file="footer.jspf" %> 
    </body>
</html>