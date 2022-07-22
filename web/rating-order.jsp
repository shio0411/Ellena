<%-- 
    Document   : rating-order
    Created on : Jul 7, 2022, 11:16:08 PM
    Author     : ASUS
--%>

<%@page import="store.shopping.RatingDTO"%>
<%@page import="store.user.UserDTO"%>
<%@page import="store.shopping.OrderDetailDTO"%>
<%@page import="javafx.util.Pair"%>
<%@page import="store.shopping.OrderDTO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Đánh giá sản phẩm</title>

        <!-- Google Font -->
        <link href="https://fonts.googleapis.com/css2?family=Cookie&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">

        <jsp:include page="meta.jsp" flush="true"/>
    </head>
    <body>
        <jsp:include page="header.jsp" flush="true"/>
        <%
            UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
            // get cart message
            String message = (String) request.getAttribute("MESSAGE");
            if (message == null) {
                message = "";
            }
        %>

        <!-- Breadcrumb Begin -->
        <div class="breadcrumb-option">
            <div class="container">
                <!--Message row-->
                <div class="row">
                    <div class="col-12" style="text-align: center; color: red">
                        <%if (message == "SUCCESS") {
                        %>
                        <div class="alert alert-success" role="alert">
                            <strong>Thành công!!</strong> Cảm ơn bạn đã đánh giá.
                            <button type="button" class="close" data-toggle="alert">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <%
                            }%>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="breadcrumb__links">
                            <a href="./"><i class="fa fa-home"></i> Trang chủ</a>
                            <a href="MainController?action=ViewOrderHistory&userID=<%=user.getUserID()%>"> Lịch sử mua hàng</a>
                            <span> Đánh giá sản phẩm</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Breadcrumb End -->

        <%
            Pair<OrderDTO, List<OrderDetailDTO>> order = (Pair<OrderDTO, List<OrderDetailDTO>>) request.getAttribute("ORDER_DETAILS");
            List<RatingDTO> listRating = (List<RatingDTO>) request.getAttribute("PRODUCT_RATING_LIST");
        %>



        <!--rating-order Begin-->
        <section class="shop-cart spad">
            <div class="container">
                <div class="row" style="margin-bottom: 50px">
                    <div class="col-lg-12">
                        <article class="card">
                            <header class="card-header">
                                Mã Đơn Hàng: <%= order.getKey().getOrderID()%>
                            </header>
                            <div class="card-body">


                                <div class="col-lg-12">
                                    <div class="shop__cart__table mb-20">
                                        <table>
                                            <!-- Table headers -->
                                            <thead>
                                                <tr>
                                                    <th>Sản Phẩm</th>
                                                    <th>Giá</th>
                                                </tr>
                                            </thead>
                                            <!-- Table body -->
                                            <tbody>
                                                <%
                                                    for (OrderDetailDTO orderDetail : order.getValue()) {
                                                %>
                                                <!-- Product rows -->
                                                <tr style="border-bottom: none !important;"> 
                                                    <td class="cart__product__item">
                                                        <img src="<%= orderDetail.getImage()%>" alt="product-image" style="width: 80px;">
                                                        <div class="cart__product__item__title">
                                                            <a href="ProductRouteController?productID=<%= orderDetail.getProductID()%>">
                                                                <h6 class="mb-3"><%= orderDetail.getProductName()%></h6>
                                                            </a>
                                                            <%= orderDetail.getColor()%>, <%= orderDetail.getSize()%> x <%= orderDetail.getQuantity()%>

                                                        </div>
                                                    </td>
                                                    <td class="cart__price">
                                                        <%= orderDetail.getPrice() / 1000%>.000₫ 
                                                    </td>
                                                <tr>
                                                    <!-- Rating rows -->    
                                                <tr>
                                                    <td>
                                                        <!-- button to rating product page -->
                                                        <%
                                                            if (listRating == null || listRating.size() == 0) { // check if listRating is null
%>
                                                        <a href="CreateRatingFormController?productID=<%= orderDetail.getProductID()%>&productImage=<%= orderDetail.getImage()%>&orderID=<%= order.getKey().getOrderID()%>&productName=<%= orderDetail.getProductName()%>"><button class="primary-btn"><i class="fa fa-star"></i>Ðánh giá sản phẩm</button></a>
                                                        <%
                                                        } else { // begin test with for
                                                            boolean checkRating = false;
                                                            for (RatingDTO rating : listRating) {
                                                                if (rating.getProductID() == orderDetail.getProductID()) {
                                                                    if (!rating.getContent().isEmpty()) {
                                                                        checkRating = true;
                                                                        break;
                                                                    }
                                                                }
                                                            }
                                                            if (checkRating) { // if there's a rating for this product in this order (disable and gray out)
                                                        %>
                                                        <a href="#"><button class="primary-btn" disabled="" style="background: #dbdbdb;"><i class="fa fa-star"></i>Ðánh giá sản phẩm</button></a>
                                                        <%
                                                        } else { // display normal link if there is no rating for that product
%>
                                                        <a href="CreateRatingFormController?productID=<%= orderDetail.getProductID()%>&productImage=<%= orderDetail.getImage()%>&orderID=<%= order.getKey().getOrderID()%>&productName=<%= orderDetail.getProductName()%>"><button class="primary-btn"><i class="fa fa-star"></i>Ðánh giá sản phẩm</button></a>
                                                        <%
                                                                }
                                                            }
                                                        %>


                                                    </td>
                                                    <td>

                                                    </td>
                                                </tr>
                                                <%}%>

                                                <!-- Total rows -->
                                                <tr style="border-bottom: none;">
                                                    <td></td>
                                                    <td class="cart__total" style="font-size: 24px;">Tổng: <%= (int) (order.getKey().getTotal()) / 1000%>.000₫ </td>
                                                </tr>    




                                            </tbody>


                                        </table>
                                    </div>
                                </div>


                            </div>
                        </article>
                    </div>  
                </div>
            </div>
        </section>


        <!--rating-order End-->





        <jsp:include page="footer.jsp" flush="true" />
        <!-- Js Plugins -->
        <jsp:include page="js-plugins.jsp" flush="true" />
    </body>
</html>
