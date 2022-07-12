<%@page import="store.shopping.ReturnDTO"%>
<%@page import="javafx.util.Pair"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="store.shopping.ProductDTO"%>
<%@page import="java.util.List"%>
<%@page import="store.shopping.OrderDetailDTO"%>
<%@page import="store.shopping.OrderDTO"%>
<%@page import="store.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Return Page</title>
        <jsp:include page="meta.jsp" flush="true"/>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    </head>
    <body>
        <%
            String updateMsg = (String) request.getAttribute("UPDATE_MESSAGE");
            if (updateMsg != null) {
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
                        <p><%=updateMsg%></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                    </div>
                </div>

            </div>
        </div>
        <%
            }
        %>
        <%
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            OrderDTO order = (OrderDTO) request.getAttribute("ORDER");
            List<ProductDTO> productList = (List<ProductDTO>) request.getAttribute("PRODUCT_LIST");
        
            if (loginUser.getRoleID().equals("EM")) {    
        %>
        
        <div class="sidenav">
            <a href="ShowOrderController" style="color: #873e23; font-weight: bold;"><i class="fa fa-cart-plus fa-lg"></i>Quản lí đơn hàng</a>
            <a href="https://www.tawk.to/"><i class="fa fa-archive fa-lg"></i>Quản lí Q&A</a>
        </div> 
        
        <%  } else {%>
        <div class="sidenav">
            <a href="ManagerStatisticController"><i class="fa fa-bar-chart fa-lg"></i>Số liệu thống kê</a>
            <a href="ManagerShowProductController"><i class="fa fa-archive fa-lg"></i>Quản lí sản phẩm</a>
            <a href="ShowOrderController" style="color: #873e23; font-weight: bold;"><i class="fa fa-cart-plus fa-lg"></i>Quản lí đơn hàng</a>
        </div> 
        <%  }%>

        <div class="main">

            <form action="MainController" method="POST" style="margin-left: 65%;">  
                Xin chào, <a href="my-profile.jsp"><%= loginUser.getFullName()%></a>
                <input type="submit" name="action" value="Logout" style="margin-left: 4%;">
            </form>
            <ul class="pagination">
                <li class="active"><a href="#">Đổi</a></li>
                <li><a href="MainController?action=Refund&orderID=<%= order.getOrderID()%>">Trả</a></li>
            </ul>
            <h3>Chọn sản phẩm muốn đổi</h3>
            <div>


                <table class="table table-hover table-bordered">
                    <thead>
                        <tr style="background-color: #b57c68">
                            <th>Sản phẩm</th>
                            <th>Đơn giá</th>
                            <th>Số lượng</th>
                            <th>Màu</th>
                            <th>Size</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            int id = 1;
                            for (OrderDetailDTO orderDetail : order.getOrderDetail()) {
                        %>

                        <tr>
                            <td><%= orderDetail.getProductName()%></td>
                            <td>
                                <%
                                    if (productList.get(id - 1).getPrice() != orderDetail.getPrice()) {
                                %>
                                <s><%= productList.get(id - 1).getPrice()%></s><br>
                                    <%}%>
                                    <%= orderDetail.getPrice()%>
                            </td>
                            <td><%= orderDetail.getQuantity()%></td>
                            <td><%= orderDetail.getColor()%></td>
                            <td><%= orderDetail.getSize()%></td>
                            <!--Pop-up thay đổi sản phẩm trong đơn hàng-->
                            <td>
                                <div class="modal fade" id="myModal<%=id%>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                    <div class="modal-dialog" id="<%=id%>" >
                                        <div class="modal-content" >
                                            <div class="modal-header">
                                                <h4 class="modal-title" id="myModalLabel">Chỉnh sửa</h4>
                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                                            </div>
                                            <form action="MainController">
                                                <div class="modal-body">
                                                    <div>
                                                        <span>Số lượng</span>
                                                        <input type="number" min="1" max="<%= orderDetail.getQuantity()%>" required="" name="newQuantity" value="1">
                                                    </div>
                                                    <span>Đổi thành</span><br>
                                                    <span>Chọn phân loại:</span>
                                                    <select name="sizeColor" required="">
                                                        <option hidden>Chọn phân loại</option>
                                                        <%
                                                            ProductDTO product = productList.get(id - 1);
                                                            product.getProductID();
                                                            product.getProductName();
                                                            Iterator<List<String>> colorSizeIt = product.getColorSizeQuantity().keySet().iterator();
                                                            while (colorSizeIt.hasNext()) {
                                                                List<String> colorSize = colorSizeIt.next();
                                                                if (product.getColorSizeQuantity().get(colorSize) > 0) {
                                                        %>
                                                        <option value="<%= colorSize.get(0) + "/" + colorSize.get(1)%>"><%= colorSize.get(0) + "/" + colorSize.get(1)%></option>
                                                        <%
                                                                }
                                                            }
                                                        %>
                                                    </select><br> 
                                                    <span>Lý do:</span><br>
                                                    <label>
                                                        <input type="radio" name="note" value="Sản phẩm bị lỗi/hỏng" id="note1" checked="">
                                                        Sản phẩm bị lỗi/hỏng
                                                    </label><br>
                                                    <label>
                                                        <input type="radio" name="note" value="Đổi size" id="note2">
                                                        Đổi size
                                                    </label><br>
                                                    <label>
                                                        <input type="radio" name="note" value="Đổi màu" id="note3">
                                                        Đổi màu
                                                    </label><br>
                                                    <label>
                                                        <div style="float:left;">
                                                            <input type="radio" name="note" value="Khác" id="note4"> Khác: 
                                                        </div>
                                                        <div style="float:left;">
                                                            <input type="text" id="note5" name="note" value="" placeholder="Nhập lí do"/>
                                                        </div>
                                                        <div style="clear:both;"></div>
                                                    </label>
                                                </div>
                                                <input type="hidden" name="oldColor" value="<%= orderDetail.getColor()%>"/>
                                                <input type="hidden" name="oldSize" value="<%= orderDetail.getSize()%>"/>
                                                <input type="hidden" name="price" value="<%= orderDetail.getPrice()%>"/>
                                                <input type="hidden" name="oldQuantity" value="<%= orderDetail.getQuantity()%>"/>
                                                <input type="hidden" name="orderID" value="<%= order.getOrderID()%>"/>
                                                <input type="hidden" name="productID" value="<%= orderDetail.getProductID()%>"/>
                                                <input type="hidden" name="orderDetailID" value="<%= orderDetail.getOrderDetailID()%>"/>
                                                <div class="modal-footer">
                                                    <button class="btn btn-default" type="submit" name="action" value="UpdateOrderDetail">Cập nhật</button>
                                                    <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <button type="button" data-toggle="modal" data-target="#myModal<%=id++%>">Chi tiết</button>
                            </td>
                        </tr>

                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
            <%
                List<ReturnDTO> returnList = (List<ReturnDTO>) request.getAttribute("RETURN_LIST");
                if (returnList.size() > 0) {
            %>
            <h5>Lịch sử đổi/trả: </h5>
            <table class="table table-hover table-bordered">
                <thead>
                    <tr style="background-color: #b57c68">
                        <th>Sản phẩm</th>
                        <th>Đơn giá</th>
                        <th>Số lượng</th>
                        <th>Màu</th>
                        <th>Size</th>
                        <th>Ghi chú</th>
                        <th>Đổi/trả</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (ReturnDTO returnDTO : returnList) {
                    %>


                    <tr>
                        <td><%= returnDTO.getProductName()%></td>
                        <td><%= returnDTO.getPrice()%></td>
                        <td><%= returnDTO.getReturnQuantity()%></td>
                        <td><%= returnDTO.getColor()%></td>
                        <td><%= returnDTO.getSize()%></td>
                        <td><%= returnDTO.getNote()%></td>
                        <td><%= returnDTO.getReturnType()%></td>
                    </tr>

                    <%
                        }
                    %>
                </tbody>
            </table>
            <%}%>
        </div>
        <script>
            function getNoteValue() {
                document.getElementById('note4').value = document.getElementById('note5').value;
            }
            $(document).ready(function () {
                $("#myModal").modal();
            });

        </script>
    </body>
</html>
