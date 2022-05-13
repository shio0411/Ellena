
<%@page import="sample.shopping.Cart"%>
<%@page import="sample.product.ProductDTO"%>
<%-- 
    Document   : admin
    Created on : Feb 15, 2022, 3:27:42 PM
    Author     : giama
--%>

<%@page import="java.util.List"%>
<%@page import="sample.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Admin Page</title>
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


        <%  UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");

            String search = request.getParameter("search");
            if (search == null) {
                search = "";
            }
        %>
        <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
            <div class="container">
                <a class="navbar-brand" href="MainController?action=Search&search=">HappyVege</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="oi oi-menu"></span> Menu
                </button>

                <div class="collapse navbar-collapse" id="ftco-nav">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item">
                            <a href="MainController?action=ViewUser" class="nav-link">View all users</a>
                        </li>
                        <li class="nav-item">
                            <a href="insert.jsp" class="nav-link">Add new product</a>
                        </li>
                        <li class="nav-item">
                            <a href="MainController?action=Logout" class="nav-link">Logout</a>
                        </li>
                    </ul>
                    <form action="MainController" class="search-form">
                        <input type="text" name="search" value="<%=search%>" required=""/>
                        <input type="submit" name="action" value="Search"/>
                    </form>


                </div>
            </div>
        </nav>


        <div class="col-md-6 text-center">
            <h3 class="text-uppercase">Welcome: <strong><%= loginUser.getFullName()%></strong></h3>
        </div>
        <p>${requestScope.ERROR_MESSAGE}</p>
        <%  List<ProductDTO> list = (List<ProductDTO>) request.getAttribute("PRODUCT_LIST");
            if (list != null) {
                if (list.size() > 0) {


        %>
        <div class="container">
            <div class="row">
                <div class="col-md-12 ftco-animate">
                    <div class="cart-list">
                        <table class="table">
                            <thead class="thead-primary">
                                <tr class="text-center">
                                    <th>No</th>
                                    <th>Product ID</th>
                                    <th>Image</th>
                                    <th>Image Link</th>
                                    <th>Product name</th>
                                    <th>Price</th>
                                    <th>Unit in stock</th>
                                    <th>Category ID</th>
                                    <th>Import date</th>
                                    <th>Expiry date</th>
                                    <th>Update</th>
                                    <th>Hide</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%  int count = 1;
                                    for (ProductDTO product : list) {%>
                                <tr class="text-center">
                                    <td><%=count++%></td>
                            <form action="MainController" method="POST" enctype="multipart/form-data">
                                <td><input type="text" name="id" readonly="" value="<%=product.getId()%>"></td>
                                <td class="image-prod"><div class="img" style="background-image:url(<%=product.getImg()%>);"></div></td>
                                <td><input type="text" name="image" value="<%=product.getImg()%>"></td>
                                <td class="product-name"><input type="text" name="name" value="<%=product.getName()%>"></td>
                                <td class="price"><input type="number" name="price" step="0.01" value="<%=product.getCurrentPrice()%>"></td>
                                <td><input type="number" name="quantity" step="0.05" value="<%=product.getUnitInStock()%>"></td>
                                <td class="categories" ><select name="categoryID">
                                        <option value="" selected disabled hidden><%=product.getCategoryID()%></option>
                                        <option value="F">Fruit</option>
                                        <option value="V">Vegetable</option>
                                        <option value="D">Dried</option>

                                    </select></td>
                                <td class="date"><input type="date" name="importDate" value="<%=product.getImportDate()%>"></td>
                                <td class="date"><input type="date" name="expiryDate" value="<%=product.getExpiryDate()%>"></td>
                                <input type="hidden" name="search" value="<%=search%>">
                                <input type="hidden" name="imageName" value="<%=product.getImg()%>">
                                <td><input type="submit" name="action" value="Update"></td>
                            </form>
                            <td>
                                <% if (product.getStatus() == true) {%> 
                                <a href="MainController?action=Hide&id=<%=product.getId()%>&search=<%=search%>">Hide</a> 
                                <% } else {%>
                                <a href="MainController?action=Unhide&id=<%=product.getId()%>&search=<%=search%>">Unhide</a>
                                <%}%>   
                            </td>
                            </tr><!-- END TR-->
                            <% }%>

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>


            <% }  %>
            <% }%>



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
