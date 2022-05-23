<%@page import="store.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile của tôi</title>
        <jsp:include page="meta.jsp" flush="true"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    </head>
    <body>
        <%
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
        %>
        <div class="sidenav">
            <a href="ShowAccountController" style="color: #873e23; font-weight: bold;"><i class="fa fa-address-card fa-lg"></i>Quản lý tài khoản</a>
            <a href="ShowManagerController"><i class="fa fa-group fa-lg"></i>Quản lý manager</a>
            <a href="ShowCategoryController"><i class="fa fa-cart-plus fa-lg"></i>Quản lý loại sản phẩm</a>
        </div>

        <div class="main">
            <h3>Profile của tôi</h3>
            <br>
            <table class="profile">
                <tr>
                    <th>Tên tài khoản</th>
                    <td><%= loginUser.getUserID()%></td>
                </tr>
                <tr>
                    <th>Họ và tên</th>   
                    <td><%= loginUser.getFullName()%>
                        <div class="modal fade" id="myModal3" role="dialog" aria-labelledby="myModalLabel">
                            <div class="modal-dialog">
                                <div class="modal-content" >
                                    <div class="modal-header">
                                        <h4 class="modal-title" id="myModalLabel">Thay đổi tên</h4>
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                                    </div>
                                    <div class="modal-body">
                                        <form action="MainController" method="POST">
                                            <div class="row">
                                                <div class="col-md-12 mb-4">

                                                    <div class="form-outline">
                                                        <label class="form-label" for="newName">Tên mới</label>
                                                        <input type="text" name="newName" id="newName" maxlength="100" class="form-control form-control-lg" />
                                                        <p style="color: red">${requestScope.USER_ERROR.password}</p>
                                                    </div>

                                                </div>

                                            </div>
                                            
                                </div>
                                <div class="modal-footer">
                                    <button class="btn btn-default" type="submit" name="action" value="UpdateName">Cập nhật</button>
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                                </div>
                            </div>
                        </div>
                        </div>
                        <i class="fa fa-edit fa-2x" data-toggle="modal" data-target="#myModal3" style="margin-left: 12px;"></i>
                    </td>
                </tr>
                <tr>   
                    <th>Mật khẩu</th>
                    <td>************ 
                        <div class="modal fade" id="myModal1" role="dialog" aria-labelledby="myModalLabel">
                            <div class="modal-dialog">
                                <div class="modal-content" >
                                    <div class="modal-header">
                                        <h4 class="modal-title" id="myModalLabel">Thay đổi mật khẩu</h4>
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                                    </div>
                                    <div class="modal-body">
                                        <form action="MainController">
                                            <div class="row">
                                                <div class="col-md-12 mb-4">

                                                    <div class="form-outline">
                                                        <label class="form-label" for="currentPassword">Mật khẩu hiện tại</label>
                                                        <input type="password" name="currentPassword" id="currentPassword" maxlength="100" class="form-control form-control-lg" />
                                                        <p style="color: red">${requestScope.USER_ERROR.password}</p>
                                                    </div>

                                                </div>

                                            </div>
                                            <div class="row">
                                                <div class="col-md-12 mb-4">

                                                    <div class="form-outline">
                                                        <label class="form-label" for="newPassword">Mật khẩu mới</label>
                                                        <input type="password" name="newPassword" id="newPassword" class="form-control form-control-lg" />
                                                        <p style="color: red">${requestScope.USER_ERROR.confirm}</p>
                                                    </div>

                                                </div>

                                            </div>
                                            <div class="row">
                                                <div class="col-md-12 mb-4">

                                                    <div class="form-outline">
                                                        <label class="form-label" for="confirmNewPassword">Nhập lại mật khẩu mới</label>
                                                        <input type="password" name="confirmNewPassword" id="confirmNewPassword" class="form-control form-control-lg" />
                                                    </div>

                                                </div>

                                            </div>
                                </div>
                                <div class="modal-footer">
                                    <button class="btn btn-default" type="submit" name="action" value="UpdatePassword">Cập nhật</button>
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                                </div>
                            </div>
                        </div>
                        </div>
                        <i class="fa fa-edit fa-2x" data-toggle="modal" data-target="#myModal1" style="margin-left: 12px;"></i>
                    </td>
                </tr>
                <tr>   
                    <th>Số điện thoại</th>
                    <td><%= loginUser.getPhone()%></td>
                </tr>
                <tr>
                    <th>Địa chỉ</th>
                    <td><%= loginUser.getAddress()%>
                        <div class="modal fade" id="myModal2" role="dialog" aria-labelledby="myModalLabel">
                            <div class="modal-dialog">
                                <div class="modal-content" >
                                    <div class="modal-header">
                                        <h4 class="modal-title" id="myModalLabel">Thay đổi địa chỉ</h4>
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                                    </div>
                                    <div class="modal-body">
                                        <form action="MainController">
                                            <div class="row">
                                                <div class="col-md-12 mb-4">

                                                    <div class="form-outline">
                                                        <label class="form-label" for="newAddress">Địa chỉ mới</label>
                                                        <input type="text" name="newAddress" id="newAddress" class="form-control form-control-lg" />
                                                        <p style="color: red">${requestScope.USER_ERROR.password}</p>
                                                    </div>

                                                </div>

                                            </div>
                                            
                                </div>
                                <div class="modal-footer">
                                    <button class="btn btn-default" type="submit" name="action" value="UpdateAddress">Cập nhật</button>
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                                </div>
                            </div>
                        </div>
                        </div>
                        <i class="fa fa-edit fa-2x" data-toggle="modal" data-target="#myModal2" style="margin-left: 12px;"></i>
                    </td>
                </tr>
        </div>
    </body>
</html>
