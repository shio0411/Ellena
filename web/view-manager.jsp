<%@page import="java.util.List"%>
<%@page import="store.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View all the managers</title>
        <jsp:include page="meta.jsp" flush="true"/>
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
            <a href="ShowAccountController"><i class="fa fa-address-card fa-lg"></i>Quản lý tài khoản</a>
            <a href="view-manager.jsp" style="color: #873e23; font-weight: bold;"><i class="fa fa-group fa-lg"></i>Quản lý manager</a>
            <a href="#"><i class="fa fa-cart-plus fa-lg"></i>Quản lý loại sản phẩm</a>
        </div>
        
        <div class="main">
            <form action="MainController" method="POST">
                <input type="text" name="search" required="" value="<%= search%>" placeholder="Tìm kiếm manager">
                Trạng thái
                <select name="status">
                    <option value="true">Active</option>
                    <option value="false">Inactive</option>
                </select>
                <button type="submit" name="action" value="SearchManager" class="btn-outline-dark" style="width: 7%; padding: 0.5% 2%;"><i class="fa fa-search fa-lg"></i></button>
            </form>   
            <%
            List<UserDTO> listManager = (List<UserDTO>) request.getAttribute("LIST_MANAGER");
            if (listManager != null) {
                if (listManager.size() > 0) {
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
                for (UserDTO user : listManager) {
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
