<%-- 
    Document   : error
    Created on : May 30, 2022, 9:27:55 PM
    Author     : giama
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>  
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error Page</title>
    </head>
    <body>
        <h1>Exception/Error Details</h1>>
        
        <strong>Status Code: ${sessionScope.STATUS_CODE}</strong>
        
        
    </body>
</html>
