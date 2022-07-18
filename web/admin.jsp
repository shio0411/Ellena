<%@page import="store.user.UserDAO"%>
<%@page import="java.util.List"%>
<%@page import="store.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trang chủ | Administrator</title>
        <jsp:include page="meta.jsp" flush="true"/>
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
            List<UserDTO> listUser = (List<UserDTO>) request.getAttribute("LIST_USER");
            String roleID = request.getParameter("roleID"); // also use storing request param for pagnation
            if (roleID == null) {
                roleID = "%";
            }
            // pageNav vars
            boolean searchAll = false;
            String status = request.getParameter("status");//For storing request param for pagnation

            String message = (String) request.getAttribute("MESSAGE");
            if (message != null) {
        %>

        <!-- Pop-up thông báo cập nhật thành công -->
        <div class="modal fade" id="myModal" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Thông báo</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>

                    </div>
                    <div class="modal-body">
                        <p><%=message%></p>
                    </div>
                    <div class="modal-footer">
                        <a href="MainController?action=SearchAccount&search=<%=search%>&roleID=<%= roleID%>"><button type="button" class="btn btn-default">Đóng</button></a>
                    </div>
                </div>

            </div>
        </div> <%}%>

        <div class="sidenav">
            <a href="ShowAccountController" style="color: #873e23; font-weight: bold;"><i class="fa fa-address-card fa-lg"></i>Quản lý tài khoản</a>
            <a href="ShowManagerController"><i class="fa fa-group fa-lg"></i>Quản lý manager</a>
            <a href="ShowCategoryController"><i class="fa fa-cart-plus fa-lg"></i>Quản lý loại sản phẩm</a>
        </div>

        <div class="main">

            <form action="MainController" method="POST" style="margin-left: 65%;">                
                Xin chào, <a href="my-profile.jsp"><%= loginUser.getFullName()%></a>
                <input type="submit" name="action" value="Logout" style="margin-left: 4%;">
            </form>

            <form action="MainController" method="POST">
                <input type="text" name="search" value="<%= search%>" placeholder="Tìm kiếm tài khoản">
                Quyền
                <select name="roleID">
                    <option value="%" selected hidden>Chọn một quyền</option>
                    <option value="AD">Quản trị viên</option>
                    <option value="MN">Người quản lý</option>
                    <option value="EM">Nhân viên</option>
                    <option value="CM">Khách hàng</option>
                </select>
                Trạng thái
                <select name="status">
                    <option value="all" selected hidden>Chọn trạng thái</option>
                    <option value="true">Active</option>
                    <option value="false">Inactive</option>
                </select>
                <button type="submit" name="action" value="SearchAccount" class="btn-outline-dark" style="width: 15%; padding: 0.5% 0.1%;"><i class="fa fa-search fa-lg"></i>Search</button>
                <!--switch to SearchController page count after submit form-->
                        <%
                            searchAll = (boolean) request.getAttribute("SWITCH_SEARCH");
                        %>
            </form>   
                
                
            <a href="add-account.jsp">Tạo tài khoản mới</a>
            <%
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
                    int id = 1;
                    for (UserDTO user : listUser) {
                %>
                <tr>
                    <td style="font-weight: bold"><%= user.getUserID()%></td>
                    <td><%= user.getFullName()%></td>
                    <td><%= user.getPhone()%></td>
                    <td><%= user.getRoleID()%></td>
                    <td>
                        <%
                            if (user.isStatus()) {
                        %>
                        <a href="MainController?action=DeactivateAccount&userID=<%=user.getUserID()%>&search=<%= search%>&roleID=<%= roleID%>&from=ShowAccount">Vô hiệu hoá</a>
                        <%} else {
                        %>
                        <a href="MainController?action=ActivateAccount&userID=<%=user.getUserID()%>&search=<%= search%>&roleID=<%= roleID%>&from=ShowAccount">Kích hoạt</a>
                        <%
                            }
                        %>
                    </td>

                    <!-- Chỉnh sửa chi tiết account-->
                    <td>
                        <div class="modal fade" id="myModal<%=id%>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                            <div class="modal-dialog" id="<%=id%>" >
                                <div class="modal-content" >
                                    <div class="modal-header">
                                        <h4 class="modal-title" id="myModalLabel">Chỉnh sửa tài khoản</h4>
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                                    </div>
                                    <div class="modal-body">
                                        <form action="MainController">
                                            <div class="row">
                                                <div class="col-md-12 mb-4">

                                                    <div class="form-outline">
                                                        <label class="form-label" for="email">Email</label>
                                                        <input type="email" name="userID" value="<%= user.getUserID()%>" readonly="" id="userID" class="form-control form-control-lg" />
                                                    </div>

                                                </div>

                                            </div>

                                            <div class="row">
                                                <div class="col-md-6 mb-4 pb-2">

                                                    <div class="form-outline">
                                                        <label class="form-label" for="fullName">Họ và tên</label>
                                                        <input type="text" name="fullName" value="<%= user.getFullName()%>" id="fullName" class="form-control form-control-lg" />

                                                    </div>

                                                </div>
                                                <div class="col-md-6 mb-4 pb-2">

                                                    <div class="form-outline">
                                                        <label class="form-label" required="" for="roleID">Quyền</label>
                                                        <% if (user.getRoleID().equals("CM")) {%><input type="text" name="roleID" readonly="" value="<%=user.getRoleID()%>" class="form-control form-control-lg"><%} else {%>
                                                        <select class="form-control form-control-lg" <%if (user.getRoleID().equals("AD")) {%> style="background: #eee; /*Simular campo inativo - Sugestão @GabrielRodrigues*/
                                                                pointer-events: none;
                                                                touch-action: none;" tabindex="-1" aria-disabled="true"<%}%> name="roleID">
                                                            <option value="AD" <%if (user.getRoleID().equals("AD")) {%>selected <%}%>>AD</option>
                                                            <option value="MN" <%if (user.getRoleID().equals("MN")) {%>selected <%}%>>MN</option>  
                                                            <option value="EM" <%if (user.getRoleID().equals("EM")) {%>selected <%}%>>EM</option>
                                                        </select> 
                                                        <%}%>
                                                    </div>
                                                </div>        

                                            </div>
                                            <div class="row">
                                                <div class="col-md-6 mb-4 d-flex align-items-center">

                                                    <div class="form-outline datepicker w-100">
                                                        <label for="birthdayDate" class="form-label">Ngày sinh</label>
                                                        <input type="date" name="birthday" value="<%= user.getBirthday()%>" class="form-control form-control-lg" id="birthdayDate" />

                                                    </div>

                                                </div>
                                                <div class="col-md-6 mb-4">

                                                    <h6 class="mb-2 pb-1">Giới tính: </h6>

                                                    <div class="form-check form-check-inline">

                                                        <input class="form-check-input" type="radio" name="sex" id="maleGender"
                                                               value="true" <% if (user.getSex() == true) {%> checked <% }%>/>
                                                        <label class="form-check-label" for="maleGender">Nam</label>
                                                    </div>

                                                    <div class="form-check form-check-inline">
                                                        <input class="form-check-input" type="radio" name="sex" id="femaleGender"
                                                               value="false" <% if (user.getSex() == false) {%> checked <% }%>/>
                                                        <label class="form-check-label" for="femaleGender">Nữ</label>
                                                    </div>



                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-md-6 mb-4 pb-2">

                                                    <div class="form-outline">
                                                        <label class="form-label" for="address">Địa chỉ</label>
                                                        <input type="text" name="address" value="<%=user.getAddress()%>" id="address" class="form-control form-control-lg" />
                                                    </div>

                                                </div>
                                                <div class="col-md-6 mb-4 pb-2">

                                                    <div class="form-outline">
                                                        <label class="form-label" required="" for="phoneNumber">Số điện thoại</label>
                                                        <input type="tel" id="phoneNumber" value="<%=user.getPhone()%>" name="phone" class="form-control form-control-lg" />
                                                    </div>
                                                </div>
                                            </div>



                                    </div>
                                    <div class="modal-footer">
                                        <button class="btn btn-default" type="submit" name="action" value="UpdateAccount">Cập nhật</button>
                                        <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                                        <!--<button type="button" class="btn btn-primary">Save changes</button>-->
                                    </div>
                                    </form>

                                </div>
                            </div>
                        </div>
                        <button type="button" data-toggle="modal" data-target="#myModal<%=id++%>">Chỉnh sửa</button>

                    </td>

                </tr>
                <%         }
                        }
                    }else{
                        %>
                        <div style="text-align:center">Không có kết quả tìm kiếm.</div>
                <%
                        }%>
            </table>



            <!--page nav-->

            <%
                if (listUser != null) { // if no user in list, page nav won't display


            %>
            <div class="row pagination__option" style="justify-content: center; align-items: center; text-align: center;">
                <% 
                    int currentPage = (int) request.getAttribute("currentPage");
                    int noOfPages = (int) request.getAttribute("noOfPages");
                    int noOfPageLinks = 5; // amount of page links to be displayed
                    int minLinkRange = noOfPageLinks / 2; // minimum link range ahead/behind

//                    -------------------------------Calculating the begin and end of pageNav for loop-------------------------------
                    //  int begin = ((currentPage - minLinkRange) > 0 ? ((currentPage - minLinkRange) < (noOfPages - noOfPageLinks + 1) ? (currentPage - minLinkRange) : (noOfPages - noOfPageLinks)) : 0) + 1; (referance)
                    int begin = 0;
                    if ((currentPage - minLinkRange) > 0) {
                        if ((currentPage - minLinkRange) < (noOfPages - noOfPageLinks + 1) || (noOfPages < noOfPageLinks)) { // add in (noOfPages < noOfPageLinks) in order to prevent negative page link
                            begin = (currentPage - minLinkRange);
                        } else {
                            begin = (noOfPages - noOfPageLinks + 1);
                        }
                    } else {
                        begin = 1;
                    }

                    //  int end = (currentPage + minLinkRange) < noOfPages ? ((currentPage + minLinkRange) > noOfPageLinks ? (currentPage + minLinkRange) : noOfPageLinks) : noOfPages; (referance)
                    int end = 0;
                    if ((currentPage + minLinkRange) < noOfPages) {
                        if ((currentPage + minLinkRange) > noOfPageLinks) {
                            end = (currentPage + minLinkRange);
                        } else {
                            end = noOfPageLinks;
                        }
                    } else {
                        end = noOfPages;
                    }
//                    -----------------------------------------------------------------------------------------------------------------------------

                    if (searchAll) { //Currently at ShowController

                        //start of pageNav
                        if (currentPage != 1) {
                %>

                <!-- For displaying 1st page link except for the 1st page -->
                <a href="ShowAccountController?page=1"><i class="glyphicon glyphicon-menu-left"></i><i class="glyphicon glyphicon-menu-left"></i></a>
                
                <!-- For displaying Previous link except for the 1st page -->
                <a href="ShowAccountController?page=<%= currentPage - 1%>"><i class="glyphicon glyphicon-menu-left"></i></a>
                    <%
                        }
                    %>

                <!--For displaying Page numbers. The when condition does not display a link for the current page-->

                <%  for (int i = begin; i <= end; i++) {
                        if (currentPage == i) {
                %>
                <a class="active" style="background: #000000; color: #ffffff"><%= i%></a>  <!-- There is no active class for pagination (currenly hard code) -->
                <%
                } else {
                %>
                <a href="ShowAccountController?page=<%= i%>" style="text-decoration: none;"><%= i%></a>
                <%
                        }
                    }
                %>


                <!--For displaying Next link -->
                <%
                    if (currentPage < noOfPages) {
                %>
                <a href="ShowAccountController?page=<%= currentPage + 1%>"><i class="glyphicon glyphicon-menu-right"></i></a>
                
                <!-- For displaying last page link except for the last page -->
                <a href="ShowAccountController?page=<%= noOfPages %>"><i class="glyphicon glyphicon-menu-right"></i><i class="glyphicon glyphicon-menu-right"></i></a>
                
                    <%
                        }

                        //                end of pageNav
                    %>
                <%            
                    } // end ShowController
                    else {//Currently at SearchController
                    //                    start of pageNav
                    if (currentPage != 1) {
                %>
                
                <!-- For displaying 1st page link except for the 1st page -->
                <a href="SearchAccountController?search=<%= search%>&roleID=<%= roleID%>&status=<%= status%>&page=1"><i class="glyphicon glyphicon-menu-left"></i><i class="glyphicon glyphicon-menu-left"></i></a>
                
                <!-- For displaying Previous link except for the 1st page -->
                <a href="SearchAccountController?search=<%= search%>&roleID=<%= roleID%>&status=<%= status%>&page=<%= currentPage - 1%>" style="text-decoration: none;"><i class="glyphicon glyphicon-menu-left"></i></a>
                    <%
                        }
                    %>

                <!--For displaying Page numbers. The when condition does not display a link for the current page--> 

                <%  for (int i = begin; i <= end; i++) {
                        if (currentPage == i) {
                %>
                <a class="active" style="background: #000000; color: #ffffff"><%= i%></a>  <!-- There is no active class for pagination (currenly hard code) -->
                <%
                } else {
                %>
                <a href="SearchAccountController?search=<%= search%>&roleID=<%= roleID%>&status=<%= status%>&page=<%= i%>"><%= i%></a>
                <%
                        }
                    }
                %>


                <!--For displaying Next link -->
                <%
                    if (currentPage < noOfPages) {
                %>
                <a href="SearchAccountController?search=<%= search%>&roleID=<%= roleID%>&status=<%= status%>&page=<%= currentPage + 1%>"><i class="glyphicon glyphicon-menu-right"></i></a>
                
                <!-- For displaying last page link except for the last page -->
                <a href="SearchAccountController?search=<%= search%>&roleID=<%= roleID%>&status=<%= status%>&page=<%= noOfPages %>"><i class="glyphicon glyphicon-menu-right"></i><i class="glyphicon glyphicon-menu-right"></i></a>
                
                    <%
                            }

                            
                        }
                        //                end of pageNav
                        
                    %>
                
                
                
            </div>
            <%                
                } // end of the "No product" if statement
            %>







        </div>
        <script>
            $(document).ready(function () {
                $("#myModal").modal();
            });
        </script>
    </body>
</html>
