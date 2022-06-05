<%-- 
    Document   : forgot-password
    Created on : Jun 5, 2022, 12:22:19 AM
    Author     : Jason 2.0
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <jsp:include page="meta.jsp" flush="true"/>
    </head>
    <body>
        <!-- Page Preloder -->
        <div id="preloder">
            <div class="loader"></div>
        </div>

        <!-- Offcanvas Menu Begin -->
        <div class="offcanvas-menu-overlay"></div>
        <div class="offcanvas-menu-wrapper">
            <div class="offcanvas__close">+</div>
            <ul class="offcanvas__widget">
                <li><span class="icon_search search-switch"></span></li>
                <li><a href="#"><span class="icon_heart_alt"></span>
                        <div class="tip">2</div>
                    </a></li>
                <li><a href="#"><span class="icon_bag_alt"></span>
                        <div class="tip">2</div>
                    </a></li>
            </ul>
            <div class="offcanvas__logo">
                <a href="./home.jsp"><img src="img/logo.png" alt=""></a>
            </div>
            <div id="mobile-menu-wrap"></div>
            <div class="offcanvas__auth">
                <a href="MainController?action=Login">Login</a>
                <a href="#">Register</a>
            </div>
        </div>
        <!-- Offcanvas Menu End -->

        <!-- Header Section Begin -->
        <header class="header">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-xl-3 col-lg-2">
                        <div class="header__logo">
                            <a href="./index.html"><img src="img/logo.png" alt=""></a>
                        </div>
                    </div>
                    <div class="col-xl-6 col-lg-7" >
                        <nav class="header__menu">
                            <ul>
                                <li class="active"><a href="./index.html">Home</a></li>
                                <li><a href="./shop.html">Shop</a></li>
                                <li><a href="#">Pages</a>
                                    <ul class="dropdown">
                                        <li><a href="./product-details.html">Product Details</a></li>
                                        <li><a href="./shop-cart.html">Shop Cart</a></li>
                                        <li><a href="./checkout.html">Checkout</a></li>
                                        <li><a href="./blog-details.html">Blog Details</a></li>
                                    </ul>
                                </li>
                                <li><a href="./blog.html">Blog</a></li>
                                <li><a href="./contact.html">Contact</a></li>
                            </ul>
                        </nav>
                    </div>
                    <div class="col-lg-3">
                        <div class="header__right">
                            <div class="header__right__auth">
                                <a href="login.jsp">Login</a>
                                <a href="register.jsp">Register</a>
                            </div>
                            <ul class="header__right__widget">
                                <li><span class="icon_search search-switch"></span></li>
                                <li><a href="#"><span class="icon_heart_alt"></span>
                                        <div class="tip">2</div>
                                    </a></li>
                                <li><a href="#"><span class="icon_bag_alt"></span>
                                        <div class="tip">2</div>
                                    </a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="canvas__open">
                    <i class="fa fa-bars"></i>
                </div>
            </div>
        </header>
        <!-- Header Section End -->
        
        
        
        <section class="vh-100 gradient-custom">
            <div class="container py-5 h-100">
                <div class="row justify-content-center align-items-center h-100">
                    <div class="col-12 col-lg-9 col-xl-7">
                        <div class="card shadow-2-strong card-registration" style="border-radius: 15px;">
                            <div class="card-body p-4 p-md-5">
                                <h3 class="mb-4 pb-2 pb-md-0 mb-md-5" style="text-align: center;">Đặt lại mật khẩu</h3>
                                <form action="MainController" method="post">
                                    <div class="row">
                                        <div class="col-md-12 mb-4">

                                            <div class="form-outline">
                                                <label class="form-label" for="userID">Tên đăng nhập</label>
                                                <input type="text" name="userID" class="form-control" placeholder="example@email.com" id="username">                                                

                                            </div>

                                        </div>

                                    </div>
                                    <!--ERROR message-->
                                    <p style="color: red">${requestScope.ERROR}</p>
                                    
                                    <div>
                                        <button class="primary-btn" type="submit" name="action" value="ForgotPassword" >Gửi mail xác nhận mã OTP</button>
                                    </div>

                                </form>
                                    
                                    
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
                                    
                                    
        <script src="js/jquery-3.3.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.magnific-popup.min.js"></script>
        <script src="js/jquery-ui.min.js"></script>
        <script src="js/mixitup.min.js"></script>
        <script src="js/jquery.countdown.min.js"></script>
        <script src="js/jquery.slicknav.js"></script>
        <script src="js/owl.carousel.min.js"></script>
        <script src="js/jquery.nicescroll.min.js"></script>
        <script src="js/main.js"></script>
    </body>
</html>
