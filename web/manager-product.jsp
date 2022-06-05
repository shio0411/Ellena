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
                Xin chào, <a href="my-profile.jsp"><%= loginUser.getFullName()%></a>
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

                        <select name="orderBy">
                            <option value="(SELECT NULL)" selected hidden>Sắp xếp theo</option><!-- SQL for ORDER BY "NONE" -->
                            <option value="productName">Tên sản phẩm</option>
                            <option value="categoryName">Loại sản phẩm</option><!-<!-- Fix/update later -->
                        </select>

                        Trạng thái
                        <select name="status">
                            <option value="true">Active</option>
                            <option value="false">Inactive</option>
                        </select>

                        <button type="submit" name="action" value="ManagerSearchProduct" class="btn-outline-dark" style="width: 7%; padding: 0.5% 2%;"><i class="fa fa-search fa-lg"></i></button>
                        <!--switch to SearchController page count after submit form-->
                        <%
                            searchAll = (boolean) request.getAttribute("SWITCH_SEARCH");
                        %>
                    </form>
                </div>


                <!--add new product-->
                <div class="col-3" style="text-align: center; display: flex; justify-content: center; align-items: center;">
                    <a href="">Thêm sản phẩm mới</a>
                </div>
            </div>

            <!--display product list-->
            <%  List<ProductDTO> listProduct = (List<ProductDTO>) request.getAttribute("LIST_PRODUCT");
                if (listProduct != null) {
                    if (listProduct.size() > 0) {
            %>  
            <table class="table table-hover table-bordered">
                <tr style="background-color: #b57c68">
                    <th>ID Sản phẩm</th>
                    <th>Tên Sản phẩm</th>                
                    <th>Loại sản phẩm</th>
                    <th>Trạng thái</th>
                    <th>Chỉnh sửa</th>
                </tr>
                <%
                    for (ProductDTO list : listProduct) {
                %>
                <tr>
                    <td style="font-weight: bold"><%= list.getProductID()%></td>
                    <td><%= list.getProductName()%></td>
                    <td><%= list.getCategoryName()%></td>
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
                        <button type="button" onclick="document.location='ManagerShowProductDetailController?productID=<%=list.getProductID()%>'">Chỉnh sửa</button>
                    </td>

                </tr>
                <%         }
                        }
                    }%>
            </table>



            <!--page nav-->
            <% 
                if (listProduct!=null) { //if no product in list, page nav won't display
                        
                    
            %>
            <div class="row pagination__option" style="justify-content: center; align-items: center; text-align: center;">

                <%
                    int currentPage = (int) request.getAttribute("currentPage");
                    int noOfPages = (int) request.getAttribute("noOfPages");
                    int noOfPageLinks = 5; // amount of page links to be displayed
                    int minLinkRange = noOfPageLinks/2; // minimum link range ahead/behind
                    
//                    -------------------------------Calculating the begin and end of pageNav for loop-------------------------------
                    
                  //  int begin = ((currentPage - minLinkRange) > 0 ? ((currentPage - minLinkRange) < (noOfPages - noOfPageLinks + 1) ? (currentPage - minLinkRange) : (noOfPages - noOfPageLinks)) : 0) + 1; (referance)
                    int begin = 0;
                    if ((currentPage - minLinkRange) > 0) {
                        if ((currentPage - minLinkRange) < (noOfPages - noOfPageLinks + 1)) {
		begin = (currentPage - minLinkRange);
                        } else {
		begin = (noOfPages - noOfPageLinks+1);
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

                <!-- For displaying Previous link except for the 1st page -->
                <a href="ManagerShowProductController?page=<%= currentPage - 1%>"><i class="glyphicon glyphicon-menu-left"></i></a>
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
                        <a href="ManagerShowProductController?page=<%= i%>" style="text-decoration: none;"><%= i%></a>
                            <%
                                    }
                                }
                            %>
                    

                <!--For displaying Next link -->
                <%
                    if (currentPage < noOfPages) {
                %>
                <a href="ManagerShowProductController?page=<%= currentPage + 1%>"><i class="glyphicon glyphicon-menu-right"></i></a>
                <%
                    }

                    //                end of pageNav
                %>



                <%            } else {//Currently at SearchController
                    //                    start of pageNav
                    if (currentPage != 1) {
                %>

                <!-- For displaying Previous link except for the 1st page -->
                <a href="ManagerSearchProductController?search=<%= search%>&orderBy=<%= orderBy%>&status=<%= status%>&page=<%= currentPage - 1%>" style="text-decoration: none;"><i class="glyphicon glyphicon-menu-left"></i></a>
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
                        <a href="ManagerSearchProductController?search=<%= search%>&orderBy=<%= orderBy%>&status=<%= status%>&page=<%= i%>"><%= i%></a>
                            <%
                                    }
                                }
                            %>
                    

                <!--For displaying Next link -->
                <%
                    if (currentPage < noOfPages) {
                %>
                <a href="ManagerSearchProductController?search=<%= search%>&orderBy=<%= orderBy%>&status=<%= status%>&page=<%= currentPage + 1%>"><i class="glyphicon glyphicon-menu-right"></i></a>
                <%
                        }

                        //                end of pageNav
                    }

                %>

            </div>
            <% 
                } //end of the "No product" if statement
            %>


        </div>
        <script>
            $(document).ready(function () {
                $("#myModal").modal();
            });
        </script>    

    </body>
</html>
