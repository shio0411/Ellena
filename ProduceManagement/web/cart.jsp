<%-- 
    Document   : cart
    Created on : Mar 5, 2022, 6:34:13 PM
    Author     : giama
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="sample.shopping.Product"%>
<%@page import="sample.shopping.Cart"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Cart Page</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <link href="https://fonts.googleapis.com/css?family=Poppins:200,300,400,500,600,700,800&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Lora:400,400i,700,700i&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Amatic+SC:400,700&display=swap" rel="stylesheet">

        <link rel="stylesheet" href="css/open-iconic-bootstrap.min.css">
        <link rel="stylesheet" href="css/animate.css">

        <link rel="stylesheet" href="css/owl.carousel.min.css">
        <link rel="stylesheet" href="css/owl.theme.default.min.css">
        <link rel="stylesheet" href="css/magnific-popup.css">

        <link rel="stylesheet" href="css/aos.css">

        <link rel="stylesheet" href="css/ionicons.min.css">

        <link rel="stylesheet" href="css/bootstrap-datepicker.css">
        <link rel="stylesheet" href="css/jquery.timepicker.css">


        <link rel="stylesheet" href="css/flaticon.css">
        <link rel="stylesheet" href="css/icomoon.css">
        <link rel="stylesheet" href="css/style.css">
    </head>
    <%  String message = (String) request.getAttribute("MESSAGE");
        if (message != null) {
    %>      <script>alert("${requestScope.MESSAGE}");</script>
    <%}
        Cart cart = (Cart) session.getAttribute("CART");
        String search = request.getParameter("search");
        if (search == null) {
            search = "";
        }
        int productQuantity = 0;
        if (cart != null) {
            productQuantity = cart.getCart().size();
        }
    %>
    <body class="goto-here">
        <div class="py-1 bg-primary">
            <div class="container">
                <div class="row no-gutters d-flex align-items-start align-items-center px-md-0">
                    <div class="col-lg-12 d-block">
                        <div class="row d-flex">
                            <div class="col-md pr-4 d-flex topper align-items-center">
                                <div class="icon mr-2 d-flex justify-content-center align-items-center"><span class="icon-phone2"></span></div>
                                <span class="text">+ 0123 456 789</span>
                            </div>
                            <div class="col-md pr-4 d-flex topper align-items-center">
                                <div class="icon mr-2 d-flex justify-content-center align-items-center"><span class="icon-paper-plane"></span></div>
                                <span class="text">kekekeke@email.com</span>
                            </div>
                            <div class="col-md-5 pr-4 d-flex topper align-items-center text-lg-right">
                                <span class="text">1-2 Business hours delivery &amp; Free Returns</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
            <div class="container">
                <div class="navbar-brand">HappyVege</div>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="oi oi-menu"></span> Menu
                </button>

                <div class="collapse navbar-collapse" id="ftco-nav">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item"><a href="MainController?action=Search&search=" class="nav-link">Shop</a></li>



                        <li class="nav-item"><a href="LogoutController" class="nav-link">Logout</a></li>
                        <li class="nav-item cta cta-colored"><a href="cart.jsp" class="nav-link"><span class="icon-shopping_cart"></span>[<%= productQuantity%>]</a></li>

                    </ul>
                    <form action="MainController" class="search-form">
                        <input type="text" class="nav-item" name="search" value="<%=search%>" required=""/>
                        <input type="submit" class="nav-item" name="action" value="Search"/>
                    </form>
                </div>
            </div>
        </nav>
        <!-- END nav -->

        <div class="hero-wrap hero-bread" style="background-image: url('images/bg_1.jpg');">
            <div class="container">
                <div class="row no-gutters slider-text align-items-center justify-content-center">
                    <div class="col-md-9 ftco-animate text-center">
                        <h1 class="mb-0 bread">My Cart</h1>
                    </div>
                </div>
            </div>
        </div>
        <% if (cart == null || cart.getCart().isEmpty()) {
        %>
        <script>
            if (!alert('Empty cart! Please add product first.')) {
                window.location = "MainController?action=Search&search=";
            }
        </script>    
        <%
        } else {
        %>
        
            <section class="ftco-section ftco-cart">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 ftco-animate">
                            <div class="cart-list">
                                <table class="table">
                                    <thead class="thead-primary">
                                        <tr class="text-center">
                                            <th>&nbsp;</th>
                                            <th>&nbsp;</th>
                                            <th>Product name</th>
                                            <th>Price</th>
                                            <th>Quantity</th>
                                            <th>Total</th>
                                            <th>Update</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        
                                        <c:forEach var="product" items="${sessionScope.CART.getCart().values()}">
                                            <tr class="text-center">
                                                <td class="product-remove"><a href="MainController?action=Remove&id=${product.id}"><span class="ion-ios-close"></span></a></td>

                                                <td class="image-prod"><div class="img" style="background-image:url(${product.img});"></div></td>

                                                <td class="product-name">
                                                    <h3>${product.name}</h3>
                                                    <p>Far far away, behind the word mountains, far from the countries</p>
                                                </td>
                                                <td class="price">$${product.price}</td>
                                        <form>  
                                            <td class="quantity">
                                                <div class="input-group mb-3">
                                                    <input type="number" name="quantity" step="0.5" class="quantity form-control input-number" value="${product.quantity}">
                                                </div>
                                            </td>
                                            <td class="total">$${product.quantity*product.price}</td>

                                            <input type="hidden" name="id" value="${product.id}">
                                            <td><input type="submit" name="action" value="UpdateCart"></td>
                                        </form>

                                        <c:set var="total" value="${total+product.price*product.quantity}"></c:set>
                                            </tr><!-- END TR-->
                                    </c:forEach>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="row justify-content-end">
                        <div class="col-lg-8 mt-5 cart-wrap ftco-animate"> 
                            <div class="cart-total mb-3">
                                <h3>Email</h3>
                                <p>Enter email for receiving bill</p>
                                <form action="MainController" class="info">
                                    <div class="form-group">
                                        <input type="text" name="email" required="" class="form-control text-left px-3" value="${sessionScope.LOGIN_USER.email}"/>
                                    </div>
                                    <input type="hidden" name="total" value="${pageScope.total}"/>
                                    <p><input type="submit" name="action" value="Checkout" class="btn btn-primary py-3 px-4"></p>
                                </form>
                            </div>
                        </div>
                        <div class="col-lg-4 mt-5 cart-wrap ftco-animate">
                            <div class="cart-total mb-3">
                                <h3>Cart Totals</h3>
                                <p class="d-flex">
                                    <span>Subtotal</span>
                                    <span>$${pageScope.total}</span>
                                </p>
                                <p class="d-flex">
                                    <span>Delivery</span>
                                    <span>$0.00</span>
                                </p>

                                <hr>
                                <p class="d-flex total-price">
                                    <span>Total</span>
                                    <span>$${pageScope.total}</span>
                                </p>

                            </div>
                            <div id="smart-button-container">
                                <div style="text-align: center;">
                                    <div id="paypal-button-container"></div>
                                </div>
                            </div>
                            <script src="https://www.paypal.com/sdk/js?client-id=AYvFLQu4E1zKDiNxQ0MqqUSHIdVr62ZfcpzOEWeKmnCcyocb_tpiURSGV6Fpg9SHTvGF3phZ0vhHlqKF&currency=USD" data-sdk-integration-source="button-factory"></script>
                            <script>
                                          function initPayPalButton() {
                                              paypal.Buttons({
                                                  style: {
                                                      shape: 'pill',
                                                      color: 'white',
                                                      layout: 'vertical',
                                                      label: 'paypal',

                                                  },

                                                  createOrder: function (data, actions) {
                                                      return actions.order.create({
                                                          purchase_units: [{"amount": {"currency_code": "USD", "value": 1}}]
                                                      });
                                                  },

                                                  onApprove: function (data, actions) {
                                                      return actions.order.capture().then(function (orderData) {

                                                          // Full available details
                                                          console.log('Capture result', orderData, JSON.stringify(orderData, null, 2));

                                                          // Show a success message within this page, e.g.
                                                          window.location = "MainController?action=Checkout&total=${pageScope.total}";
                                                          // Or go to another URL:  actions.redirect('thank_you.html');

                                                      });
                                                  },

                                                  onError: function (err) {
                                                      console.log(err);
                                                  }
                                              }).render('#paypal-button-container');
                                          }
                                          initPayPalButton();
                            </script>
                            
                        </div>
                    </div>
                </div>
            </section>
        
        <% }%>
        <section class="ftco-section ftco-no-pt ftco-no-pb py-5 bg-light">
            <div class="container py-4">
                <div class="row d-flex justify-content-center py-5">
                    <div class="col-md-6">
                        <h2 style="font-size: 22px;" class="mb-0">Subcribe to our Newsletter</h2>
                        <span>Get e-mail updates about our latest shops and special offers</span>
                    </div>
                    <div class="col-md-6 d-flex align-items-center">
                        <form action="MainController" class="subscribe-form">
                            <div class="form-group d-flex">
                                <input type="text" class="form-control" placeholder="Enter email address">
                                <input type="submit" name="action" value="Subscribe" class="submit px-3">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </section>
        <footer class="ftco-footer ftco-section">
            <div class="container">
                <div class="row">
                    <div class="mouse">
                        <a href="#" class="mouse-icon">
                            <div class="mouse-wheel"><span class="ion-ios-arrow-up"></span></div>
                        </a>
                    </div>
                </div>
                <div class="row mb-5">
                    <div class="col-md">
                        <div class="ftco-footer-widget mb-4">
                            <h2 class="ftco-heading-2">Vegefoods</h2>
                            <p>Far far away, behind the word mountains, far from the countries Vokalia and Consonantia.</p>
                            <ul class="ftco-footer-social list-unstyled float-md-left float-lft mt-5">
                                <li class="ftco-animate"><a href="#"><span class="icon-twitter"></span></a></li>
                                <li class="ftco-animate"><a href="#"><span class="icon-facebook"></span></a></li>
                                <li class="ftco-animate"><a href="#"><span class="icon-instagram"></span></a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-md">
                        <div class="ftco-footer-widget mb-4 ml-md-5">
                            <h2 class="ftco-heading-2">Menu</h2>
                            <ul class="list-unstyled">
                                <li><a href="#" class="py-2 d-block">Shop</a></li>
                                <li><a href="#" class="py-2 d-block">About</a></li>
                                <li><a href="#" class="py-2 d-block">Journal</a></li>
                                <li><a href="#" class="py-2 d-block">Contact Us</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="ftco-footer-widget mb-4">
                            <h2 class="ftco-heading-2">Help</h2>
                            <div class="d-flex">
                                <ul class="list-unstyled mr-l-5 pr-l-3 mr-4">
                                    <li><a href="#" class="py-2 d-block">Shipping Information</a></li>
                                    <li><a href="#" class="py-2 d-block">Returns &amp; Exchange</a></li>
                                    <li><a href="#" class="py-2 d-block">Terms &amp; Conditions</a></li>
                                    <li><a href="#" class="py-2 d-block">Privacy Policy</a></li>
                                </ul>
                                <ul class="list-unstyled">
                                    <li><a href="#" class="py-2 d-block">FAQs</a></li>
                                    <li><a href="#" class="py-2 d-block">Contact</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-md">
                        <div class="ftco-footer-widget mb-4">
                            <h2 class="ftco-heading-2">Have a Questions?</h2>
                            <div class="block-23 mb-3">
                                <ul>
                                    <li><span class="icon icon-map-marker"></span><span class="text">203 Fake St. Mountain View, San Francisco, California, USA</span></li>
                                    <li><a href="#"><span class="icon icon-phone"></span><span class="text">+0 123 456 789</span></a></li>
                                    <li><a href="#"><span class="icon icon-envelope"></span><span class="text">kekekeke@gmail.com</span></a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 text-center">

                        <p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                            Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="icon-heart color-danger" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
                            <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                        </p>
                    </div>
                </div>
            </div>
        </footer>



        <!-- loader -->
        <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>


        <script src="js/jquery.min.js"></script>
        <script src="js/jquery-migrate-3.0.1.min.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.easing.1.3.js"></script>
        <script src="js/jquery.waypoints.min.js"></script>
        <script src="js/jquery.stellar.min.js"></script>
        <script src="js/owl.carousel.min.js"></script>
        <script src="js/jquery.magnific-popup.min.js"></script>
        <script src="js/aos.js"></script>
        <script src="js/jquery.animateNumber.min.js"></script>
        <script src="js/bootstrap-datepicker.js"></script>
        <script src="js/scrollax.min.js"></script>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
        <script src="js/google-map.js"></script>
        <script src="js/main.js"></script>



    </body>
</html>
