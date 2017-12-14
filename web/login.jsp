
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
        <link rel="stylesheet" type="text/css" href="style.css">
        <title>Code Blue CRM Login Page</title>
        <script> 
        function validate()
        { 
            var username = document.form.username.value; 
            var password = document.form.password.value;
            if (username==null || username=="")
            { 
                alert("Username cannot be blank"); 
                return false; 
            }
            else if(password==null || password=="")
            { 
                alert("Password cannot be blank"); 
                return false; 
            } 
        }
        </script> 
    </head>
    <body>
        <div style="text-align:center"><h1>Code Blue CRM </h1> </div>
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
        </form>
    </body>
</html>