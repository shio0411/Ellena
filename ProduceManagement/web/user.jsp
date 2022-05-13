<%-- 
    Document   : user
    Created on : Feb 15, 2022, 3:17:04 PM
    Author     : giama
--%>

<%@page import="sample.shopping.Cart"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>User Page</title>
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
    <%
        Cart cart = (Cart) session.getAttribute("CART");
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
                        <li class="nav-item"><a href="MainController?action=Search&search=" class="nav-link" >Shop</a></li>
                        <li class="nav-item cta cta-colored"><a href="cart.jsp" class="nav-link"><span class="icon-shopping_cart"></span>[<%= productQuantity%>]</a></li>
                        <li class="nav-item"><a href="LogoutController" class="nav-link">Logout</a></li>
                    </ul>
                    <form action="MainController" class="search-form">
                        <input type="text" class="nav-item" name="search" value="" required=""/>
                        <input type="submit" class="nav-item" name="action" value="Search"/>
                    </form>

                </div>
            </div>
        </nav>


        <div class="text-center mb-5">
            <h3 class="text-uppercase">Welcome: <strong>${sessionScope.LOGIN_USER.fullName}</strong></h3>
        </div>
        <div class="row justify-content-end"
             <div class="col-lg-4 mt-5 cart-wrap ftco-animate">
                <div class="cart-total mb-3">
                    <h2>Your information:</h2>
                    <form action="#" class="info">
                        <div class="form-group">
                            <label for="userID">User ID</label>
                            <input type="text" class="form-control text-left px-3" value="${sessionScope.LOGIN_USER.userID}">
                            <label for="fullName">Full Name</label>
                            <input type="text" class="form-control text-left px-3" value="${sessionScope.LOGIN_USER.fullName}">
                            <label for="roleID">Role ID</label>
                            <input type="text" class="form-control text-left px-3" value="${sessionScope.LOGIN_USER.roleID}">
                            <label for="password">Password</label>
                            <input type="text" class="form-control text-left px-3" value="************">
                            <label for="address">Address</label>
                            <input type="text" class="form-control text-left px-3" value="${sessionScope.LOGIN_USER.address}">
                            <label for="birthday">Birthday</label>
                            <input type="date" class="form-control text-left px-3" value="${sessionScope.LOGIN_USER.birthday}">
                            <label for="phone">Phone</label>
                            <input type="text" class="form-control text-left px-3" value="${sessionScope.LOGIN_USER.phone}">
                            <label for="email">Email</label>
                            <input type="text" class="form-control text-left px-3" value="${sessionScope.LOGIN_USER.email}">
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
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
</html>


