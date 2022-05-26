<%-- 
    Document   : manager-product
    Created on : May 22, 2022, 11:55:03 AM
    Author     : Jason 2.0
--%>

<%@page import="store.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Danh sách sản phẩm | Manager</title>
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
            <a href="manager-statistic.jsp" style="color: #873e23; font-weight: bold; font-size: 100%;"><i class=""></i>Số liệu thống kê</a>
            <a href="manager-statistic.jsp" style="text-indent: 25px;"><i class=""></i>Tổng quan</a>
            <a href="manager.jsp" style="text-indent: 25px;"><i class=""></i>Doanh thu sản phẩm</a>
            <a href="manager-product.jsp" style="color: #873e23; font-weight: bold; font-size: 120%;"><i class=""></i>Quản lí sản phẩm</a>
            <a href="manager-product.jsp" style="color: #873e23; font-weight: bold; text-indent: 25px; font-size: 100%;"><i class=""></i>Danh sách sản phẩm</a>
            <a href="manager.jsp" style="color: #873e23; font-weight: bold; font-size: 100%;"><i class=""></i>Quản lí đơn hàng</a>
            <a href="manager.jsp" style="text-indent: 25px;"><i class=""></i>Danh sách đơn hàng</a>
        </div>

        <div class="main">
            <!--logout row-->
            <div class="row">
                <a href="login.jsp" class="col-12 text-right" style="font-size: 200%;">Logout</a> <!<!-- Need to add LogoutController -->
            </div>

            <!--h1 title row-->
            <div class="row" style="margin: 0;">
                <h1>Danh sách sản phẩm</h1>
            </div>

            <!--search bar and add product row-->
            <div class="row">
                <!--search bar-->
                <div class="col-9">
                    <form action="MainController" method="POST">
                        <input type="text" name="search" value="<%= search%>" placeholder="Tìm kiem san pham">

                        <select name="orderBy" required="">
                            <option value="%" selected hidden>Sắp xếp theo</option>
                            <option value="quantity">Số lượng</option>
                            <option value="importDate">Ngày nhập</option>
                            <option value="categoryID">Danh mục</option>
                        </select>

                        Trạng thái
                        <select name="status">
                            <option value="true">Active</option>
                            <option value="false">Inactive</option>
                        </select>

                        <button type="submit" name="action" value="SearchAccount" class="btn-outline-dark" style="width: 7%; padding: 0.5% 2%;"><i class="fa fa-search fa-lg"></i></button>
                    </form>
                </div>


                <!--add new product-->
                <div class="col-3" style="text-align: center; display: flex; justify-content: center; align-items: center;">
                    <a href="">Them san pham moi</a>
                </div>
            </div>
               
            <!--display product list-->            


        </div>
    </body>
</html>
