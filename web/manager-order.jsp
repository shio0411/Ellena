<%@page import="store.shopping.OrderDAO"%>
<%@page import="store.shopping.OrderStatusDTO"%>
<%@page import="store.shopping.OrderDetailDTO"%>
<%@page import="store.shopping.OrderDTO"%>
<%@page import="java.util.List"%>
<%@page import="store.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lí đơn hàng | Manager</title>
        <jsp:include page="meta.jsp" flush="true"/>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    </head>
    <body>

        <%
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            String message = (String) request.getAttribute("MESSAGE");
            String searchValue = request.getAttribute("SEARCH") != null ? (String) request.getAttribute("SEARCH") : "";
            String sOrderStatusID = request.getAttribute("STATUS_ID") != null ? (String) request.getAttribute("STATUS_ID") : "";
            int orderStatusID = 0;
            if (!sOrderStatusID.isEmpty()) {
                orderStatusID = Integer.parseInt(sOrderStatusID);
            }
            String dateFrom = request.getAttribute("DATE_FROM") != null ? (String) request.getAttribute("DATE_FROM") : "";
            String dateTo = request.getAttribute("DATE_TO") != null ? (String) request.getAttribute("DATE_TO") : "";
            if (dateFrom.equals("") || dateTo.equals("")) {
                dateFrom = dateTo = "";
            }
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
        </div>
        <%
            }
        %>

        <div class="sidenav">
            <a href="ManagerStatisticController"><i class="fa fa-bar-chart fa-lg"></i>Số liệu thống kê</a>
            <a href="ManagerShowProductController"><i class="fa fa-archive fa-lg"></i>Quản lí sản phẩm</a>
            <a href="ShowOrderController" style="color: #873e23; font-weight: bold;"><i class="fa fa-cart-plus fa-lg"></i>Quản lí đơn hàng</a>
        </div> 

        <div class="main">

            <form action="MainController" method="POST" style="margin-left: 65%;">  
                Xin chào, <a href="my-profile.jsp"><%= loginUser.getFullName()%></a>
                <input type="submit" name="action" value="Logout" style="margin-left: 4%;">
            </form>
            <h1>Danh sách đơn hàng</h1>
            <form action="MainController" method="POST">
                <input type="text" name="search" value="<%= searchValue%>" id="search-search" placeholder="Tìm kiếm đơn hàng">
                Trạng thái
                <select name="search-statusID" id="search-statusID">

                    <%
                        OrderDTO orderDTO = new OrderDTO();
                        if (orderStatusID == 0) {
                    %>
                    <option value="" selected hidden>Chọn một trạng thái</option>

                    <%
                        }
                        for (int i = 1; i <= 7; i++) {
                    %>
                    <option value="<%= i%>" <% if (i == orderStatusID) { %> selected  <% }%>>
                        <%= orderDTO.getStatus(i)%>
                    </option>
                    <%}%>
                </select>
                Từ
                <input type="date" name="dateFrom" id="search-dateFrom" value="<%= dateFrom%>"/>
                đến
                <input type="date" name="dateTo" id="search-dateTo" value="<%= dateTo%>"/>
                <button type="submit" name="action" value="SearchOrder" class="btn-outline-dark" style="width: 15%; padding: 0.5% 0.1%;"><i class="fa fa-search fa-lg"></i>Search</button>
            </form>   
            ${requestScope.EMPTY_LIST_MESSAGE}
            <!--phân trang-->
            <%
                List<OrderDTO> listOrder = (List<OrderDTO>) request.getAttribute("LIST_ORDER");
                OrderDAO dao = new OrderDAO();
                if (listOrder != null) {
                    if (listOrder.size() > 0) {
                
                        int numberOfPages = (int) Math.ceil(listOrder.size() / 10.0);
                        int numberOfOrderPerPage = 10;
            %>
            <div class="tab-content">
            
            
            <%            int id = 1;
                        for (int i = 1; i <= numberOfPages; i++) {
            %>
                <div id="page<%= i%>" class="tab-pane fade <% if (i == 1) {%> in active <%}%>"> 
                
                <table class="table table-hover table-bordered">
                    <tr style="background-color: #b57c68">
                        <th>ID</th>
                        <th>Ngày đặt hàng</th>                
                        <th>Tổng tiền</th>
                        <th>Tên khách hàng</th>
                        <th>Trạng thái</th>
                        <th>Cập nhật trạng thái</th>
                        <th>Trạng thái đơn hàng</th>

                    </tr>
            <%
                            for (int j = (i - 1) * numberOfOrderPerPage + 1; j <= (i * numberOfOrderPerPage > listOrder.size() ? listOrder.size() : i * numberOfOrderPerPage); j++) {
                                OrderDTO order = listOrder.get(j - 1);
            %>
                                     
                    
                    <tr>
                        <td style="font-weight: bold"><%= order.getOrderID()%></td>
                    <td><%= order.getOrderDate()%></td>
                    <td><%= order.getTotal()%></td>
                    <td><%= order.getUserName()%></td>
                    <td><%= order.getStatusName()%></td>

                    <!--pop-up xem chi tiết và chỉnh trạng thái đơn hàng-->
                    <td>
                        <div class="modal fade" id="myModal<%=id%>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                            <div class="modal-dialog" id="<%=id%>" >
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h4 class="modal-title" id="myModalLabel">Chỉnh sửa đơn hàng</h4>
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                                    </div>
                                    <form action="MainController" method="POST">
                                        <div class="modal-body" >

                                            <div class="row">
                                                <div class="col-md-6 mb-4 pb-2">

                                                    <div class="form-outline">
                                                        <label class="form-label" for="orderID">ID đơn hàng</label>
                                                        <input type="text" readonly="" name="orderID" value="<%= order.getOrderID()%>" id="orderID" class="form-control form-control-lg" />
                                                    </div>

                                                </div>

                                                <div class="col-md-6 mb-4 pb-2">

                                                    <div class="form-outline">
                                                        <label class="form-label" for="statusID">Trạng thái</label>
                                                        <select class="form-control form-control-lg" name="statusID">
                                                            <%
                                                                for (int k = 1; k <= 7; k++) {
                                                            %>
                                                            <option value="<%= k%>" 
                                                                    <%if (order.getStatusID() == k) {%>
                                                                    selected 
                                                                    <%}
                                                                        if (k < order.getStatusID() || ((k == 5 || k == 6) && order.getStatusID() != 1) || ((k == 7) && (order.getStatusID() != 6))) {%>
                                                                    disabled 
                                                                    <%}%> >
                                                                <%= order.getStatus(k)%>
                                                            </option>
                                                            <%}%>
                                                        </select> 
                                                    </div>

                                                </div>

                                            </div>

                                            <div class="row">
                                                <div class="col-md-12 mb-4">

                                                    <div class="form-outline">
                                                        <label class="form-label" for="fullName">User name</label>
                                                        <input type="text" name="fullName" value="<%= order.getUserName()%>" readonly="" id="userID" class="form-control form-control-lg" />
                                                    </div>

                                                </div>

                                            </div>

                                            <div class="row">
                                                <div class="col-md-6 mb-4 pb-2">

                                                    <div class="form-outline">
                                                        <label class="form-label" for="orderDate">Ngày đặt hàng</label>
                                                        <input type="text" readonly="" name="orderDate" value="<%= order.getOrderDate()%>" id="orderDate" class="form-control form-control-lg" />

                                                    </div>

                                                </div>


                                                <div class="col-md-6 mb-4 pb-2">

                                                    <div class="form-outline">
                                                        <label class="form-label" for="total">Tổng tiền</label>
                                                        <input type="text" readonly="" name="total" value="<%= order.getTotal()%>" id="total" class="form-control form-control-lg" />

                                                    </div>

                                                </div>

                                            </div>
                                            <div class="row">

                                                <div class="col-md-6 mb-4 pb-2">

                                                    <div class="form-outline">
                                                        <label class="form-label" for="payType">Hình thức thanh toán</label>
                                                        <input type="text" name="payType" readonly="" value="<%= order.getPayType()%>" id="payType" class="form-control form-control-lg" />
                                                    </div>

                                                </div>
                                                <div class="col-md-6 mb-4 pb-2">

                                                    <div class="form-outline">
                                                        <label class="form-label" for="trackingID">Tracking ID</label>
                                                        <input type="text" name="trackingID" value="<%= order.getTrackingID()%>" id="trackingID" class="form-control form-control-lg" />
                                                    </div>

                                                </div>
                                                <!--thêm icon edit ở đây-->

                                            </div>
                                            <div class="row">
                                                <div class="col-md-12 mb-4">
                                                    <label class="form-label" for="">Chi tiết đơn hàng</label>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6 mb-4 pb-2">
                                                    <div class="form-outline">
                                                        <label class="form-label" for="fullname">Người nhận</label>
                                                        <input type="text" value="<%= order.getFullName()%>" readonly="" class="form-control form-control-lg"/>
                                                    </div>
                                                </div>




                                                <div class="col-md-6 mb-4 pb-2">
                                                    <div class="form-outline">
                                                        <label class="form-label" for="fullname">Số điện thoại</label>
                                                        <input type="text" value="<%= order.getPhone()%>" readonly="" class="form-control form-control-lg"/>
                                                    </div>

                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12 mb-4 pb-2">
                                                    <div class="form-outline">
                                                        <label class="form-label" for="address">Địa chỉ giao hàng</label>
                                                        <input type="text" value="<%= order.getAddress()%>" readonly="" class="form-control form-control-lg"/>
                                                    </div>

                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6 mb-4 pb-2">
                                                    <div class="form-outline">
                                                        <label class="form-label" for="email">Email</label>
                                                        <input type="text" value="<%= order.getEmail()%>" readonly="" class="form-control form-control-lg"/>
                                                    </div>

                                                </div>
                                                <div class="col-md-6 mb-4 pb-2">
                                                    <div class="form-outline">
                                                        <label class="form-label" for="transactionNumber">Mã giao dịch</label>
                                                        <input type="text" <% if (!order.getPayType().equals("COD")) {%>value="<%= order.getTransactionNumber()%>" <%} else {%> value="" <%}%> readonly="" class="form-control form-control-lg"/>
                                                    </div>

                                                </div>
                                            </div>

                                            <!--sửa if chỗ này thành [is not empty]-->
                                            <% if (order.getNote() != null) {%> 
                                            <div class="row">
                                                <div class="col-md-12 mb-4 pb-2">
                                                    <div class="form-outline">
                                                        <label class="form-label" for="note">Ghi chú</label>
                                                        <input type="text" value="<%= order.getNote()%>" readonly="" class="form-control form-control-lg"/>
                                                    </div>

                                                </div>
                                            </div>
                                            <%}%>
                                            <table border="1">
                                                <thead>
                                                    <tr>
                                                        <th>Sản phẩm</th>
                                                        <th>Đơn giá</th>
                                                        <th>Số lượng</th>
                                                        <th>Size</th>
                                                        <th>Màu</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        List<OrderDetailDTO> orderDetailList = dao.getOrderDetail(order.getOrderID());
                                                        for (OrderDetailDTO orderDetail : orderDetailList) {


                                                    %>

                                                    <tr>
                                                        <td><%= orderDetail.getProductName()%></td>
                                                        <td><%= orderDetail.getPrice()%></td>
                                                        <td><%= orderDetail.getQuantity()%></td>
                                                        <td><%= orderDetail.getSize()%></td>
                                                        <td><%= orderDetail.getColor()%></td>
                                                    </tr>

                                                    <%
                                                        }
                                                    %>
                                                </tbody>
                                            </table>

                                        </div>
                                        <input type="hidden" name="payType" value="<%= order.getPayType()%>"/>
                                        <input type="hidden" name="userID" value="<%= loginUser.getUserID()%>"/>
                                        <input type="hidden" name="roleID" value="<%= loginUser.getRoleID()%>"/>
                                        <input type="hidden" name="search" id="update-search" value="<%= searchValue%>"/>
                                        <input type="hidden" name="dateFrom" id="update-dateFrom" value="<%= dateFrom%>"/>
                                        <input type="hidden" name="dateTo" id="update-dateTo" value="<%= dateTo%>"/>
                                        <input type="hidden" name="search-statusID" id="update-statusID" value="<%= sOrderStatusID%>"/>
                                        <div class="modal-footer">
                                            <button class="btn btn-default" type="submit" name="action" value="UpdateOrder">Cập nhật</button>
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                                        </div>
                                    </form>

                                </div>
                            </div>
                        </div>
                        <button type="button" data-toggle="modal" data-target="#myModal<%=id++%>">Chỉnh sửa</button>

                    </td>
                    <!--Pop-up lịch sử trạng thái đơn hàng-->
                    <td>
                        <div class="modal fade" id="myModal<%=id%>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                            <div class="modal-dialog" id="<%=id%>" >
                                <div class="modal-content" >
                                    <div class="modal-header">
                                        <h4 class="modal-title" id="myModalLabel">Trạng thái đơn hàng</h4>
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                                    </div>
                                    <div>
                                        <table class="table table-hover table-bordered">
                                            <thead>
                                                <tr>
                                                    <th>Trạng thái</th>
                                                    <th>Ngày</th>
                                                    <th>Chỉnh sửa bởi</th>
                                                    <th>RoleID</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    List<OrderStatusDTO> orderStatusList = dao.getUpdateStatusHistory(order.getOrderID());
                                                    for (OrderStatusDTO orderStatus : orderStatusList) {
                                                %>
                                                <tr>
                                                    <td><%= orderStatus.getStatusName()%></td>
                                                    <td><%= orderStatus.getUpdateDate()%></td>
                                                    <td><%= orderStatus.getUserID()%></td>
                                                    <td><%= orderStatus.getRoleID()%></td>
                                                </tr>
                                                <%
                                                    }
                                                %>
                                            </tbody>
                                        </table>

                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                                    </div>

                                </div>
                            </div>
                        </div>
                        <button type="button" data-toggle="modal" data-target="#myModal<%=id++%>">Chi tiết</button>
                    </td>
                    </tr>
            <%
                            }
            %>
                 </table>
                </div>
                
            <%
                        }
                    
            %>
            </div>
            <% if (numberOfPages > 1) {%>
            <ul class="pagination">
                <li class="active"><a data-toggle="tab" href="#page1">1</a></li>
                <%  
                    
                        for (int i = 1; i < numberOfPages; i++) {
                %>
                <li><a data-toggle="tab" href="#page<%= i + 1%>"><%= i + 1%></a></li>
                <%      }
                            }
                        }
                    }
                %>

            </ul>  
        </div>
        <script>
            $(document).ready(function () {
                $("#myModal").modal();
            });
        </script>
    </body>
</html>
