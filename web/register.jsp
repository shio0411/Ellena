<%-- 
    Document   : register
    Created on : May 18, 2022, 6:01:30 PM
    Author     : giama
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Register Page</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <link href="https://fonts.googleapis.com/css2?family=Cookie&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800;900&display=swap"
              rel="stylesheet">

        <!-- Css Styles -->
        <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
        <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css">
        <link rel="stylesheet" href="css/elegant-icons.css" type="text/css">
        <link rel="stylesheet" href="css/jquery-ui.min.css" type="text/css">
        <link rel="stylesheet" href="css/magnific-popup.css" type="text/css">
        <link rel="stylesheet" href="css/owl.carousel.min.css" type="text/css">
        <link rel="stylesheet" href="css/slicknav.min.css" type="text/css">
        <link rel="stylesheet" href="css/style.css" type="text/css">
    </head>

    <body class="goto-here">

        <section class="vh-100 gradient-custom">
            <div class="container py-5 h-100">
                <div class="row justify-content-center align-items-center h-100">
                    <div class="col-12 col-lg-9 col-xl-7">
                        <div class="card shadow-2-strong card-registration" style="border-radius: 15px;">
                            <div class="card-body p-4 p-md-5">
                                <h3 class="mb-4 pb-2 pb-md-0 mb-md-5">Đăng ký tài khoản</h3>
                                <form action="MainController" class="info" method="POST">

                                    <div class="row">
                                        <div class="col-md-12 mb-4">

                                            <div class="form-outline">
                                                <label class="form-label" for="email">Email</label>
                                                <input type="email" name="userID" id="firstName" class="form-control form-control-lg" />
                                                
                                            </div>

                                        </div>

                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 mb-4">

                                            <div class="form-outline">
                                                <label class="form-label" for="password">Mật khẩu</label>
                                                <input type="password" name="password" id="password" class="form-control form-control-lg" />
                                                
                                            </div>
                                        </div>
                                        <div class="col-md-6 mb-4">

                                            <div class="form-outline">
                                                <label class="form-label" for="confirm">Xác nhận mật khẩu</label>
                                                <input type="password" name="confirm" id="confirm" class="form-control form-control-lg" />
                                                
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 mb-4 d-flex align-items-center">

                                            <div class="form-outline datepicker w-100">
                                                <label for="birthdayDate" class="form-label">Sinh nhật</label>
                                                <input type="text" class="form-control form-control-lg" id="birthdayDate" />
                                                
                                            </div>

                                        </div>
                                        <div class="col-md-6 mb-4">

                                            <h6 class="mb-2 pb-1">Giới tính: </h6>

                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="sex" id="femaleGender"
                                                       value="False" />
                                                <label class="form-check-label" for="femaleGender">Nữ</label>
                                            </div>

                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="sex" id="maleGender"
                                                       value="Ture" />
                                                <label class="form-check-label" for="maleGender">Nam</label>
                                            </div>



                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6 mb-4 pb-2">

                                            <div class="form-outline">
                                                <label class="form-label" for="address">Địa chỉ</label>
                                                <input type="text" name="address" id="address" class="form-control form-control-lg" />
                                                
                                            </div>

                                        </div>
                                        <div class="col-md-6 mb-4 pb-2">

                                            <div class="form-outline">
                                                <label class="form-label" for="phoneNumber">Phone Number</label>
                                                <input type="tel" id="phoneNumber" class="form-control form-control-lg" />
                                                
                                            </div>

                                        </div>
                                    </div>


                                    <div class="mt-4 pt-2">
                                        <input class="primary-btn"  name="action" type="submit" value="Register" />
                                    </div>

                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>


        <div class="text-center mb-5">
            <h3 class="text-uppercase">Welcome to <strong>HAPPYVEGE</strong></h3>
        </div>
        <div>
            <div class="col-lg-4 mt-5 cart-wrap ftco-animate">
                <div class="cart-total mb-3">
                    <h2>Thông tin của bạn</h2>
                    <form action="MainController" class="info" method="POST">
                        <div class="form-group">
                            <p><label for="userID">Email*</label>
                                <input type="text" name="userID" required="" class="form-control text-left px-3"></p>
                                ${requestScope.USER_ERROR.userID}
                            <p><label for="fullName">Full Name*</label>
                                <input type="text" name="fullName" required="" class="form-control text-left px-3"></p>
                                ${requestScope.USER_ERROR.fullName}
                            <p><label for="password">Password*</label>
                                <input type="password" name="password" required="" class="form-control text-left px-3"></p>
                            <p><label for="confirm">Confirm*</label>
                                <input type="password" name="confirm" required="" class="form-control text-left px-3"></p>
                                ${requestScope.USER_ERROR.confirm}
                            <p>
                                <label for="sex">Giới tính*</label>
                                </br>
                                <input type="radio" name="sex" value="True">
                                <label for="Male">Nam</label>
                                <input type="radio" name="sex" value="False">
                                <label for="Female">Nữ</label>
                            </p>
                            <p><label for="address">Address</label>
                                <input type="text" name="address" class="form-control text-left px-3"></p>
                            <p><label for="birthday">Birthday*</label>
                                <input type="date" name="birthday" required="" class="form-control text-left px-3"></p>
                            <p><label for="phone">Phone*</label>
                                <input type="text" name="phone" required="" class="form-control text-left px-3"></p>

                            <input type="submit" name="action" value="Register">
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>

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
</html>
