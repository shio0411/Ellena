<%-- 
    Document   : manager-product
    Created on : May 22, 2022, 11:55:03 AM
    Author     : Jason 2.0
--%>

<%@page import="java.util.List"%>
<%@page import="store.shopping.ProductDTO"%>
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
            String orderBy = request.getParameter("orderBy");//For storing request param for pagnation
            String status = request.getParameter("status");//For storing request param for pagnation
            String search = request.getParameter("search");
            if (search == null) {
                search = "";
            }
            if (loginUser == null || !"MN".equals(loginUser.getRoleID())) {
                response.sendRedirect("login.jsp");
                return;
            }

//            checking if using ShowController or SearchController page count
            boolean searchAll = false;

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
                        <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                    </div>
                </div>

            </div>
        </div> <%}%>






        <div class="sidenav">
            <a href="manager-statistic.jsp" style="color: #873e23; font-weight: bold;"><i class=""></i>Số liệu thống kê</a>
            <a href="ManagerShowProductController" style="color: #873e23; font-weight: bold;"><i class=""></i>Quản lí sản phẩm</a>
            <a href="manager-order.jsp" style="color: #873e23; font-weight: bold;"><i class=""></i>Quản lí đơn hàng</a>
        </div>

        <div class="main">
            <!--logout row-->
            <div class="row">
                <form action="MainController" method="POST" class="col-12 text-right"">                
                    <input type="submit" name="action" value="Logout" style="margin-left: 4%;">
                </form>
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
                        <input type="text" name="search" value="<%= search%>" placeholder="Tìm kiếm sản phẩm">

                        <select name="orderBy" required="">
                            <option value="(SELECT NULL)" selected hidden>Sắp xếp theo</option><!-- SQL for ORDER BY "NONE" -->
                            <option value="productName">Tên sản phẩm</option>
                            <option value="productID">Mã sản phẩm</option>
                        </select>

                        Trạng thái
                        <select name="status">
                            <option value="true">Active</option>
                            <option value="false">Inactive</option>
                        </select>

                        <button type="submit" name="action" value="ManagerSearchProduct" class="btn-outline-dark" style="width: 7%; padding: 0.5% 2%;"><i class="fa fa-search fa-lg"></i></button>
                        <!--switch to SearchController page count after submit form-->
                        <% searchAll = (boolean) request.getAttribute("SWITCH_SEARCH"); %>
                    </form>
                </div>


                <!--add new product-->
                <div class="col-3" style="text-align: center; display: flex; justify-content: center; align-items: center;">
                    <a href="">Thêm sản phẩm mới</a>
                </div>
            </div>

            <!--display product list-->
            <%
                List<ProductDTO> listProduct = (List<ProductDTO>) request.getAttribute("LIST_PRODUCT");
                if (listProduct != null) {
                    if (listProduct.size() > 0) {
            %>  
            <table class="table table-hover table-bordered">
                <tr style="background-color: #b57c68">
                    <th>Tên Sản phẩm</th>
                    <th>ID Sản phẩm</th>                
                    <th>ID Danh mục</th>
                    <th>Trạng thái</th>
                    <th>Chỉnh sửa</th>
                </tr>
                <%
                    int id = 1;
                    for (ProductDTO list : listProduct) {
                %>
                <tr>
                    <td style="font-weight: bold"><%= list.getProductName()%></td>
                    <td><%= list.getProductID()%></td>
                    <td><%= list.getCategoryID()%></td>
                    <td>
                        <%
                            if (list.isStatus()) {
                        %>
                        <a href="MainController?action=DeactivateProduct&productID=<%=list.getProductID()%>">Vô hiệu hoá</a> 
                        <%} else {
                        %>
                        <a href="MainController?action=ActivateProduct&productID=<%=list.getProductID()%>">Kích hoạt</a> 
                        <%
                            }
                        %>
                    </td>

                    <!-- Chỉnh sửa chi tiết product-->
                    <td>
                        <button type="button" data-toggle="modal" data-target="#myModal<%=id++%>">Chỉnh sửa</button>
                    </td>

                </tr>
                <%         }
                        }
                    }%>
            </table>
            


            <!--page nav-->
            <div class="row" style="justify-content: center; align-items: center; text-align: center;">



                <%
                    int currentPage = (int) request.getAttribute("currentPage");
                    int noOfPages = (int) request.getAttribute("noOfPages");

                    if (searchAll) { //Currently at ShowController

    //                start of pageNav
                        if (currentPage != 1) {
                %>

                <!-- For displaying Previous link except for the 1st page -->
                <td><a href="ManagerShowProductController?page=<%= currentPage - 1%>">Previous</a></td>
                <%
                    }
                %>

                <!--For displaying Page numbers. The when condition does not display a link for the current page-->
                <table border="1" cellspacing="5" cellpadding="5">
                    <tr>
                        <%  for (int i = 1; i <= noOfPages; i++) {
                                if (currentPage == i) {
                        %>
                        <td><%= i%></td>
                        <%
                        } else {
                        %>
                        <td><a href="ManagerShowProductController?page=<%= i%>"><%= i%></a></td>
                            <%
                                    }
                                }
                            %>
                    </tr>
                </table>

                <!--For displaying Next link -->
                <%
                    if (currentPage < noOfPages) {
                %>
                <td><a href="ManagerShowProductController?page=<%= currentPage + 1%>">Next</a></td>
                <%
                    }

    //                end of pageNav
                %>



                <%            } else {//Currently at SearchController
    //                    start of pageNav
                    if (currentPage != 1) {
                %>

                <!-- For displaying Previous link except for the 1st page -->
                <td><a href="ManagerSearchProductController?page=<%= currentPage - 1%>&search=<%= search%>&orderBy=<%= orderBy%>&status=<%= status%>">Previous</a></td>
                <%
                    }
                %>

                <!--For displaying Page numbers. The when condition does not display a link for the current page-->
                <table border="1" cellspacing="5" cellpadding="5">
                    <tr>
                        <%  for (int i = 1; i <= noOfPages; i++) {
                                if (currentPage == i) {
                        %>
                        <td><%= i%></td>
                        <%
                        } else {
                        %>
                        <td><a href="ManagerSearchProductController?page=<%= i%>&search=<%= search%>&orderBy=<%= orderBy%>&status=<%= status%>"><%= i%></a></td>
                            <%
                                    }
                                }
                            %>
                    </tr>
                </table>

                <!--For displaying Next link -->
                <%
                    if (currentPage < noOfPages) {
                %>
                <td><a href="ManagerSearchProductController?page=<%= currentPage + 1%>&search=<%= search%>&orderBy=<%= orderBy%>&status=<%= status%>">Next</a></td>
                <%
                        }

    //                end of pageNav
                    }

                %>

            </div>



        </div>
        <script>
            $(document).ready(function () {
                $("#myModal").modal();
            });
        </script>    

    </body>
</html>
