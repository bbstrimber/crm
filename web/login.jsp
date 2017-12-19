
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="style.css">
        <link rel="stylesheet" href="Bootstrap/css/bootstrap.min.css" />
        <title>Code Blue CRM Login Page</title>
        
    </head>
    <body>
        <div class="jumbotron">
            <h2 class="display-3">CodeBlue CRM</h2>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <div id="formAlert" class="alert hide">  
                        <a class="close">×</a>  
                         Make sure all fields are filled and try again.
                    </div>
                    <form action="LoginServlet" method="post" class="form-horizontal">
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
        <script src="Bootstrap/js/jquery-3.2.1.min.js"></script>
        <script src="Bootstrap/js/bootstrap.min.js"></script>
    </body>
</html>