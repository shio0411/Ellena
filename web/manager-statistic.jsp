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
            <a href="manager-statistic.jsp" style="color: #873e23; font-weight: bold;"><i class=""></i>Số liệu thống kê</a>
            <a href="ManagerShowProductController" style="color: #873e23; font-weight: bold;"><i class=""></i>Quản lí sản phẩm</a>
            <a href="manager-order.jsp" style="color: #873e23; font-weight: bold;"><i class=""></i>Quản lí đơn hàng</a>
        </div>

        <div class="row">
            <form action="MainController" method="POST" class="col-12 text-right"">                
                <input type="submit" name="action" value="Logout" style="margin-left: 4%;">
            </form>
        </div>

        <div class="main">
            <h1>Thống kê</h1>
        </div>




    </body>
</html>
