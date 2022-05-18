<%-- 
    Document   : admin
    Created on : May 17, 2022, 12:51:35 PM
    Author     : giama
--%>

<%@page import="java.util.List"%>
<%@page import="store.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Page</title>
        <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css">
        <link rel="stylesheet" href="css/slicknav.min.css" type="text/css">
        <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
        <link rel="stylesheet" href="css/style.css" type="text/css">
    </head>
    <body>
        <%
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            String search = request.getParameter("search");
            if (search == null) {
                search = "";
            }
            if (loginUser == null || !"AD".equals(loginUser.getRoleID())) {
                response.sendRedirect("login.jsp");
                return;
            }

        %>
        <div class="sidenav">
            <a href="MainController?action=Search&search="><i class="fa fa-address-card fa-lg"></i>Quản lý tài khoản</a>
            <a href="#"><i class="fa fa-group fa-lg"></i>Quản lý manager</a>
            <a href="#"><i class="fa fa-cart-plus fa-lg"></i>Quản lý loại sản phẩm</a>
        </div>
        
        <div class="main">
            
            
            <%
            List<UserDTO> listUser = (List<UserDTO>) request.getAttribute("LIST_USER");
            if (listUser != null) {
                if (listUser.size() > 0) {
            %>      
            <table class="table table-hover table-bordered">
                <tr style="background-color: #b57c68">
                <th>Tên tài khoản</th>
                <th>Họ và tên</th>                
                <th>Số điện thoại</th>
                <th>Quyền</th>
                <th>Trạng thái</th>
            </tr>
            <%  
                for (UserDTO user : listUser) {
            %>
                <tr>
                    <td style="font-weight: bold"><%= user.getUserID()%></td>
                    <td><%= user.getFullName()%></td>
                    <td><%= user.getPhone()%>></td>
                    <td><%= user.getRoleID()%></td>
                    <td>
                        <select name="status">
                            <option value="true" <% if(user.isStatus()) {%> selected <% }%>>true</option>
                            <option value="false" <% if(!user.isStatus()) {%> selected <% }%>>false</option>
                        </select>
                    </td>
                </tr>
            <% } } }%>
        </table>
        </div>
        
    </body>
</html>
