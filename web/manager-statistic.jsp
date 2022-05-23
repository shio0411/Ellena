<%-- 
    Document   : manager
    Created on : May 22, 2022, 7:57:21 AM
    Author     : Jason 2.0
--%>

<%@page import="store.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trang chủ | Manager</title>
        <jsp:include page="meta.jsp" flush="true"/>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    </head>
    <body>
        <%
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            String search = request.getParameter("search");
            if (search == null) {
                search = "";
            }
            if (loginUser == null || !"MN".equals(loginUser.getRoleID())) {
                response.sendRedirect("login.jsp");
                return;
            }
        %>
        <div class="sidenav">
            <a href="manager-statistic.jsp" style="color: #873e23; font-weight: bold; font-size: 120%;"><i class=""></i>Số liệu thống kê</a>
            <a href="manager-statistic.jsp" style="color: #873e23; font-weight: bold; text-indent: 25px; font-size: 100%;"><i class=""></i>Tổng quan</a>
            <a href="manager.jsp" style="text-indent: 25px;"><i class=""></i>Doanh thu sản phẩm</a>
            <a href="manager-product.jsp" style="color: #873e23; font-weight: bold; font-size: 100%;"><i class=""></i>Quản lí sản phẩm</a>
            <a href="manager-product.jsp" style="text-indent: 25px;"><i class=""></i>Danh sách sản phẩm</a>
            <a href="manager.jsp" style="color: #873e23; font-weight: bold; font-size: 100%;"><i class=""></i>Quản lí đơn hàng</a>
            <a href="manager.jsp" style="text-indent: 25px;"><i class=""></i>Danh sách đơn hàng</a>
        </div>
        <div class="main">
            <h1>Thống kê</h1>
        </div>
        
        
        
        
    </body>
</html>
