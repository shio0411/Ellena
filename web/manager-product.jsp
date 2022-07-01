<%@page import="store.shopping.ProductDTO"%>
<%@page import="java.util.List"%>
<%@page import="store.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lý sản phẩm</title>
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
        %>
        <div class="sidenav">
            <a href="ManagerStatisticController"><i class="fa fa-bar-chart fa-lg"></i>Số liệu thống kê</a>
            <a href="ManagerShowProductController" style="color: #873e23; font-weight: bold;"><i class="fa fa-archive fa-lg"></i>Quản lí sản phẩm</a>
            <a href="ShowOrderController"><i class="fa fa-cart-plus fa-lg"></i>Quản lí đơn hàng</a>
        </div>

        <div class="main">
            <form action="MainController" method="POST" style="margin-left: 65%;">                
                Xin chào, <a href="my-profile.jsp"><%= loginUser.getFullName()%></a>
                <input type="submit" name="action" value="Logout" style="margin-left: 4%;">
            </form>

            <div class="row" style="margin: 0;">
                <h1>Danh sách sản phẩm</h1>
            </div>

            <!--search bar and add product row-->
            <div class="row">
                <!--search bar-->
                <div class="col-9">
                    <form action="MainController">
                        <input type="text" name="search" value="<%= search%>" placeholder="Tìm kiếm sản phẩm">

                        Trạng thái
                        <select name="status">
                            <option value="all">Chọn trạng thái</option>
                            <option value="true">Active</option>
                            <option value="false">Inactive</option>
                        </select>

                        <button type="submit" name="action" value="ManagerSearchProduct" class="btn-outline-dark" style="width: 15%; padding: 0.5% 0.1%;"><i class="fa fa-search fa-lg"></i>Search</button>
                    </form>
                </div>



            </div>
            <a href="add-product.jsp">Thêm sản phẩm mới</a>
            
            <%  List<ProductDTO> listProduct = (List<ProductDTO>) request.getAttribute("LIST_PRODUCT");
                if (listProduct != null) {
                    if (listProduct.size() > 0) {
            %>  
            <table class="table table-hover table-bordered">
                <tr style="background-color: #b57c68">
                    <th>ID Sản phẩm</th>
                    <th>Tên Sản phẩm</th>                
                    <th>Loại sản phẩm</th>
                    <th>Giá</th>
                    <th>Giảm giá (%)</th>
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
                    <td><%= list.getPrice()%></td>
                    <td><%= Math.round(list.getDiscount() * 100)%></td>
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
                        <a href="ManagerShowProductDetailController?productID=<%=list.getProductID()%>">Chi tiết</a>
                    </td>

                </tr>
                <%         }
                        }
                    }%>
            </table>


        </div>
    </body>
</html>
