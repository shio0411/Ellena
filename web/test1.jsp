<%-- 
    Document   : test1
    Created on : Feb 26, 2022, 9:42:09 PM
    Author     : vankh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <% String s="Hello"; %>
        <%@include file="test2.jsp" %>
        <%= s %>
    </body>
</html>
