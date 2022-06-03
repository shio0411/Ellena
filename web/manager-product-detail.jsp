<%-- 
    Document   : manager-product-detail
    Created on : May 30, 2022, 1:07:00 PM
    Author     : ASUS
--%>

<%@page import="store.shopping.ProductError"%>
<%@page import="store.shopping.CategoryDTO"%>
<%@page import="java.util.List"%>
<%@page import="store.shopping.ProductDTO"%>
<%@page import="store.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chỉnh sửa sản phẩm | Manager</title>
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

            ProductError productError = (ProductError) request.getAttribute("PRODUCT_ERROR");
            if (productError == null) {
                productError = new ProductError();
            }

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








        <!--sideNav-->
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
                <h1>Chỉnh sửa sản phẩm </h1> <!-- fix/update later -->
            </div>


            <!--row form and productImage-->
            <div class="row">



                <!-- Edit form -->  
                <div class="col-6">


                    <%
                        ProductDTO product = (ProductDTO) session.getAttribute("PRODUCT");
                        List<CategoryDTO> listCategory = (List<CategoryDTO>) session.getAttribute("LIST_CATEGORY");
                    %>
                    <form action="MainController" method="POST">
                        <!--productID and productName row-->
                        <div class="row">
                            <div class="form-outline">
                                <label class="form-label" for="productID">ID sản phẩm</label>
                                <input class="form-control form-control-lg" type="number" name="productID" id="productID" readonly="" value="<%= product.getProductID()%>"/>
                            </div>

                            <div class="form-outline">
                                <label class="form-label" for="productName">Tên sản phẩm</label>
                                <%= productError.getProductName()%>
                                <input class="form-control form-control-lg" type="text" name="productName" id="productName" value="<%= product.getProductName()%>"/>
                            </div>
                        </div>

                        <!--categoryID and lowStockLimit row--> 
                        <div class="row">
                            <div class="form-outline">
                                <label class="form-label" for="categoryID">Loại sản phẩm</label>
                                <select class="form-control form-control-lg" name="categoryID" id="categoryID">
                                    <%
                                        for (CategoryDTO category : listCategory) {
                                    %>
                                    <option value="<%= category.getCategoryID()%>" <%if (product.getCategoryID() == category.getCategoryID()) {%>selected <%}%>><%= category.getCategoryName()%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>

                            <div class="form-outline">
                                <label class="form-label" for="lowStockLimit">Giới hạn số lượng thấp</label>
                                <input class="form-control form-control-lg" type="text" name="lowStockLimit" id="lowStockLimit" value="<%= product.getLowStockLimit()%>"/>
                            </div>
                        </div>

                        <!--price, discount and status row-->
                        <div class="row">
                            <div class="form-outline">
                                <label class="form-label" for="price">Giá tiền</label>
                                <%= productError.getPrice()%>
                                <input class="form-control form-control-lg" type="int" name="price" id="price" value="<%= product.getPrice()%>"/>
                            </div>

                            
                            <div class="form-outline">
                                <label class="form-label" for="price">Giảm giá</label>
                                <%= productError.getDiscount()%>
                                <input class="form-control form-control-lg" type="int" name="price" id="price" value="<%= product.getDiscount()%>"/>
                            </div>
                            
                            <div class="form-outline">
                                <label class="form-label" for="lowStockLimit">Trạng thái</label>
                                <select class="form-control form-control-lg" name="status" id="status">
                                    <option value="true" <%if (product.isStatus() == true) {%>selected <%}%>>Active</option>
                                    <option value="false" <%if (product.isStatus() == false) {%>selected <%}%>>Inactive</option>
                                </select>
                            </div>
                        </div>

                        <!--description row-->
                        <div class="row">
                            <div class="form-outline" >
                                <label class="form-label" for="description">Mô tả sản phẩm</label>
                                <%= productError.getDescription()%>
                                <textarea class="form-control form-control-lg" name="description" id="productID" style="resize: vertical; overflow: auto; width: 436.28px; height: 100px;"><%= product.getDescription()%></textarea>
                            </div> 
                        </div>

                        <!--cập nhật button-->
                        <button class="btn btn-default" type="submit" name="action" value="ManagerUpdateProduct">Cập nhật</button>
                    </form>
                </div>

                <!--product images-->
                <div class="col-6">
                    <h3>Images</h3>
                    <%
                        List<ProductDTO> listImage = (List<ProductDTO>) request.getAttribute("LIST_IMAGE");
                        for (ProductDTO image : listImage) {
                    %>
                    <img src="<%= image.getImage()%>.jpg" style="height: 100px; width: 100px;"/>
                    <%
                        }
                    %>
                </div>
            </div>
            <!--product detail list-->
            <div class="row">
                <!--list include : colorSizeID, color, size, quantity and option for update (where image update will be)-->
            </div>






        </div>


        <script>
            $(document).ready(function () {
                $("#myModal").modal();
            });
        </script>  


    </body>
</html>
