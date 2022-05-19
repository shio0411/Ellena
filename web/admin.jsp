<%@page import="store.user.UserDAO"%>
<%@page import="java.util.List"%>
<%@page import="store.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administrator Page</title>
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
            UserDAO dao = new UserDAO();

        %>
        <div class="sidenav">
            <a href="admin.jsp"><i class="fa fa-address-card fa-lg"></i>Quản lý tài khoản</a>
            <a href="#"><i class="fa fa-group fa-lg"></i>Quản lý manager</a>
            <a href="#"><i class="fa fa-cart-plus fa-lg"></i>Quản lý loại sản phẩm</a>
        </div>
        
        <div class="main">
            <form action="MainController" method="POST">
                <input type="text" name="search" required="" value="<%= search%>" placeholder="Tìm kiếm tài khoản">
                Quyền
                <select name="roleID">
                    <option value="%" selected hidden>Chọn một quyền</option>
                    <option value="AD">Người quản trị</option>
                    <option value="MN">Người quản lý</option>
                    <option value="EM">Nhân viên</option>
                    <option value="CM">Khách hàng</option>
                </select>
                Trạng thái
                <select name="status">
                    <option value="true">Active</option>
                    <option value="false">Inactive</option>
                </select>
                <input type="submit" name="action" value="Search" class="btn-outline-dark">
            </form>   
            <%
            List<UserDTO> listUser = (List<UserDTO>) request.getAttribute("LIST_USER");
            if(search == "") listUser = dao.getAllUsers();
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
                    <td><%= user.getPhone()%></td>
                    <td><%= user.getRoleID()%></td>
                    <td>
                        <select name="status">
                            <option value="true" <% if(user.isStatus()) {%> selected <% }%>>Active</option>
                            <option value="false" <% if(!user.isStatus()) {%> selected <% }%>>Inactive</option>
                        </select>
                    </td>
                </tr>
            <% } } }%>
        </table>
        </div>
        
    </body>
</html>
