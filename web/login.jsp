<%-- 
    Document   : login
    Created on : May 17, 2022, 12:43:51 PM
    Author     : giama
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
    </head>
    <body>
        <form action="MainController" method="post">
        <div class="form-group first">
            <label for="username">Email</label>
            <input type="text" name="userID" class="form-control" placeholder="Your UserID" id="username">
        </div>
        <div class="form-group last mb-3">
            <label for="password">Password</label>
            <input type="password" name="password" class="form-control" placeholder="Your Password" id="password">
        </div>
        <input type="submit" name="action" value="Login">
        <p>${requestScope.ERROR}</p>
    </form>
    </body>
</html>
