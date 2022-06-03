<%@page import="store.shopping.CategoryDTO"%>
<%@page import="store.shopping.ProductDTO"%>
<%@page import="java.util.List"%>
<%@page import="store.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chi tiết sản phẩm</title>
        <jsp:include page="meta.jsp" flush="true"/>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    </head>
    <body>
        <%
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            String message = (String) request.getAttribute("MESSAGE");
            if (message != null) {
        %>
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
            <a href="ManagerStatisticController"><i class=""></i>Số liệu thống kê</a>
            <a href="ManagerShowProductController" style="color: #873e23; font-weight: bold;"><i class=""></i>Quản lí sản phẩm</a>
            <a href="manager-order.jsp"><i class=""></i>Quản lí đơn hàng</a>
        </div>

        <div class="main">
            <div class="row">
                <form action="MainController" method="POST" class="col-12 text-right"">                
                    Xin chào, <a href="my-profile.jsp"><%= loginUser.getFullName()%></a>
                    <input type="submit" name="action" value="Logout" style="margin-left: 4%;">
                </form>
            </div>

            <div class="row" style="margin: 0;">
                <h1>Chi tiết sản phẩm </h1> 
            </div>


            <div class="row">

                    <%
                        ProductDTO product = (ProductDTO) session.getAttribute("LIST_PRODUCT");
                        List<CategoryDTO> listCategory = (List<CategoryDTO>) session.getAttribute("LIST_CATEGORY");
                    %>
                    <form action="MainController" method="POST">
                        <div class="row">
                            <div class="form-outline">
                                <label class="form-label" for="productID">ID sản phẩm</label>
                                <input class="form-control form-control-lg" type="number" name="productID" id="productID" readonly="" value="<%= product.getProductID()%>"/>
                            </div>

                            <div class="form-outline">
                                <label class="form-label" for="productName">Tên sản phẩm</label>
                                <input class="form-control form-control-lg" type="text" name="productName" id="productName" value="<%= product.getProductName()%>"/>
                            </div>
                        </div>

                        <div class="row">
                            <div class="form-outline">
                                <label class="form-label" for="categoryID">Loại sản phẩm</label>
                                <select class="form-control form-control-lg" name="categoryID" id="categoryID">
                                    <%
                                        for (CategoryDTO category : listCategory) {
                                    %>
                                    <option value="<%= category.getCategoryID()%>" <%if (product.getCategoryName().equalsIgnoreCase(category.getCategoryName())) {%>selected <%}%>><%= category.getCategoryName()%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>

                            <div class="form-outline">
                                <label class="form-label" for="lowStockLimit">Giới hạn số lượng thấp</label>
                                <input class="form-control form-control-lg" type="number" name="lowStockLimit" id="lowStockLimit" value="<%= product.getLowStockLimit()%>"/>
                            </div>
                        </div>

                        <div class="row">
                            <div class="form-outline">
                                <label class="form-label" for="price">Giá tiền</label>
                                <input class="form-control form-control-lg" type="int" name="price" id="price" value="<%= product.getPrice()%>"/>
                            </div>


                            <div class="form-outline">
                                <label class="form-label" for="price">Giảm giá</label>
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

                        <div class="row">
                            <div class="form-outline" >
                                <label class="form-label" for="description">Mô tả sản phẩm</label>
                                <textarea class="form-control form-control-lg" name="description" id="productID" style="resize: vertical; overflow: auto; width: 436.28px; height: 100px;"><%= product.getDescription()%></textarea>
                            </div> 
                        </div>

                        <button class="btn btn-default" type="submit" name="action" value="ManagerUpdateProduct">Cập nhật</button>
                   
                </div>
                </form>
            </div>

        </div>


        <script>
            $(document).ready(function () {
                $("#myModal").modal();
            });
        </script>  

    </body>
</html>
