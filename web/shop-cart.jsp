<%@page import="java.util.List"%>
<%@page import="store.shopping.CartProduct"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Cart Page</title>

        <!-- Google Font -->
        <link href="https://fonts.googleapis.com/css2?family=Cookie&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
        <!-- Css Styles -->
        <jsp:include page="meta.jsp" flush="true"/>
    </head>
    <body>
        <jsp:include page="header.jsp" flush="true"/>
        <%
            // get cart message
            String message = (String) request.getAttribute("CART_MESSAGE");
            if (message == null) {
                message = "";
            }
        %>


        <!-- Breadcrumb Begin -->
        <div class="breadcrumb-option">
            <div class="container">
                <!--Message row-->
                <div class="row">
                    <div class="col-12" style="text-align: center;">
                        <%= message%>
                    </div>
                </div>
                    
                <div class="row">
                    <div class="col-lg-12">
                        <div class="breadcrumb__links">
                            <a href="./index.html"><i class="fa fa-home"></i> Home</a>
                            <span>Shopping cart</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Breadcrumb End -->
        <% List<CartProduct> cart = (List<CartProduct>) session.getAttribute("CART");
            int total = 0;
        %>
        <!-- Shop Cart Section Begin -->
        <%
            if (cart != null) {
                if (cart.size() > 0) {
        %>


        <section class="shop-cart spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="shop__cart__table">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Sản phẩm</th>
                                        <th>Màu</th>
                                        <th>Size</th>
                                        <th>Đơn giá</th>
                                        <th>Số lượng</th>
                                        <th>Số tiền</th>
                                        <th>Xóa</th>
                                    </tr>

                                </thead>

                                <tbody>

                                    <%
                                        int i = 1;
                                        for (CartProduct item : cart) {
                                            total += (item.getPrice() - item.getDiscount()) * item.getQuantity();
                                    %>

                                    <tr>
                                        <td class="cart__product__item">
                                            <img src="<%= item.getImage()%>" alt="product-image" style="width: 80px;">
                                            <div class="cart__product__item__title">
                                                <a href="ProductRouteController?productID=<%= item.getProductID()%>">
                                                    <h6><%= item.getProductName()%></h6>
                                                </a>
                                            </div>
                                        </td>
                                        <td class="cart__color">
                                            <%= item.getColor()%>
                                        </td>
                                        <td class="cart__size">
                                            <%= item.getSize()%>
                                        </td>
                                        <td class="cart__price">

                                            <%
                                                if (item.getDiscount() != 0) {
                                            %>
                                            <s style="color: #B1B0B0; font-weight: normal;"><%= item.getPrice() / 1000%>.000</s> <br>    
                                            <%= (item.getPrice() - item.getDiscount()) / 1000%>.000
                                            <%
                                            } else {
                                            %>
                                            <%= item.getPrice() / 1000%>.000
                                            <%
                                                }
                                            %>
                                        </td>

                                        <td class="cart__quantity">
                                            <div class="pro-qty">
                                                <input type="text" value="<%= item.getQuantity()%>" id="_quantity#<%= i%>">
                                            </div>
                                        </td>
                                        <td class="cart__total"><%= (item.getQuantity() * (item.getPrice() - item.getDiscount())) / 1000%>.000</td>
                                        <td class="cart__close">
                                            <a href="MainController?action=DeleteCartItem&productID=<%= item.getProductID()%>&color=<%= item.getColor()%>&size=<%= item.getSize()%>">
                                                <span class="icon_close"></span>
                                            </a>
                                        </td>
                                    </tr>

                                    <% i++;
                                        }%>

                                </tbody>

                            </table>
                            <form action="UpdateCartItemQuantityController" id="cartForm">
                                <%
                                    for (int j = 1; j <= cart.size(); j++) {
                                %>
                                <input type="hidden" name="quantity<%= j%>" id="quantity#<%= j%>" value=""/>
                                <%}%>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6 col-md-6 col-sm-6">
                        <div class="cart__btn">
                            <a href="home.jsp">Continue Shopping</a>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-6">
                        <div class="cart__btn update__btn">
                            <a onclick="sendForm()" href="#"><span class="icon_cart"></span> Update cart</a>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6">

                    </div>
                    <div class="col-lg-4 offset-lg-2">
                        <div class="cart__total__procced">
                            <h6>Cart total</h6>
                            <ul>
                                <li>Subtotal <span></span></li>
                                <li>Total 
                                    <span><%= (int) (total / 1000)%>.000</span>
                                </li>
                            </ul>
                            <a href="checkout.jsp" class="primary-btn">Proceed to checkout</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Shop Cart Section End -->

        <%   } else { %>
        <div style="text-align: center;">
            <div style="margin-bottom: 20px;">
                <img src="./images/empty-cart.png" alt="Empty cart"/>
            </div>

            <div>
                <h6 style="margin-bottom: 20px;">Giỏ hàng của bạn đang trống</h6>
            </div>

            <div class="cart__btn">
                <a href="home.jsp">Continue Shopping</a>
            </div>

        </div>
        <%          }
        } else { %>
        <div style="text-align: center;">
            <div style="margin-bottom: 20px;">
                <img src="./images/empty-cart.png" alt="Empty cart"/>
            </div>

            <div>
                <h6 style="margin-bottom: 20px;">Giỏ hàng của bạn đang trống</h6>
            </div>

            <div class="cart__btn">
                <a href="home.jsp">Continue Shopping</a>
            </div>

        </div>
        <% }
        %>

        <jsp:include page="footer.jsp" flush="true" />

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script>

                                $(document).ready(function () {
                                    // Add smooth scrolling to all links
                                    $("a").on('click', function (event) {

                                        // Make sure this.hash has a value before overriding default behavior
                                        if (this.hash !== "") {
                                            // Prevent default anchor click behavior
                                            event.preventDefault();

                                            // Store hash
                                            var hash = this.hash;

                                            // Using jQuery's animate() method to add smooth page scroll
                                            // The optional number (800) specifies the number of milliseconds it takes to scroll to the specified area
                                            $('html, body').animate({
                                                scrollTop: $(hash).offset().top
                                            }, 800, function () {

                                                // Add hash (#) to URL when done scrolling (default click behavior)
                                                window.location.hash = hash;
                                            });
                                        } // End if
                                    });
                                });
                                function sendForm() {
                                    for (var i = 0; i < document.getElementsByClassName('cart__color').length; i++) {
                                        document.getElementById('quantity#' + (i + 1)).value = document.getElementById('_quantity#' + (i + 1)).value;
                                    }
                                    document.getElementById('cartForm').submit();
                                }
        </script>
        <!-- Js Plugins -->
        <jsp:include page="js-plugins.jsp" flush="true" />
        <script>
            $(".carousel-inner").children(".carousel-item:first-child").addClass("active");
        </script>
    </body>
</html>
