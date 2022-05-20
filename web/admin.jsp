<%@page import="store.user.UserDAO"%>
<%@page import="java.util.List"%>
<%@page import="store.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administrator Page</title>
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
            <a href="admin.jsp" style="color: #873e23; font-weight: bold;"><i class="fa fa-address-card fa-lg"></i>Quản lý tài khoản</a>
            <a href="ShowManagerController"><i class="fa fa-group fa-lg"></i>Quản lý manager</a>
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
                <button type="submit" name="action" value="SearchAccount" class="btn-outline-dark" style="width: 7%; padding: 0.5% 2%;"><i class="fa fa-search fa-lg"></i></button>
            </form>   

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
                    <th>Chỉnh sửa</th>
                </tr>
                <%
                    for (UserDTO user : listUser) {
                %>
                <form action="MainController" method="POST">
                <tr>
                    <td style="font-weight: bold"><%= user.getUserID()%></td>
                    <td><%= user.getFullName()%></td>
                    <td><%= user.getPhone()%></td>
                    <td><%= user.getRoleID()%></td>
                    <td>
                        <%
                            if (user.isStatus()) {
                        %>
                                Active
                        <%} else {
                        %>
                                Inactive
                        <%
                            }
                        %>
                    </td>
                    <td>
                        <button type="submit" name="action" value="UpdateAccount">Chỉnh sửa</button>
                    </td>
                </tr>
                </form>
                <% }
                    }
                }%>
            </table>
        </div>

    </body>
</html>
