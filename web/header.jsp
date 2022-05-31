<%-- 
    Document   : header
    Created on : May 31, 2022, 3:20:12 PM
    Author     : giama
--%>

<%@page import="java.util.Collections"%>
<%@page import="java.util.ArrayList"%>
<%@page import="store.user.UserDTO"%>
<%@page import="store.shopping.CategoryDTO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Header Page</title>
        <jsp:include page="meta.jsp" flush="true"/>
    </head>
    <body>
        <% List<CategoryDTO> listCategory = (List<CategoryDTO>) session.getAttribute("LIST_CATEGORY");
            UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
            ArrayList<Integer> categoryOrder = new ArrayList();
            for (CategoryDTO cat : listCategory) {
                categoryOrder.add(cat.getOrder());
            }
            Collections.sort(categoryOrder);
        %>

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
                <a href="./"><img src="img/ellena-logo.png" alt=""></a>
            </div>
            <div id="mobile-menu-wrap"></div>
            <div class="offcanvas__auth">
                <a href="./login.jsp">Login</a>
                <a href="./register.jsp">Register</a>
            </div>
        </div>
        <!-- Offcanvas Menu End -->

        <!-- Header Section Begin -->
        <header class="header">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-xl-3 col-lg-2">
                        <div class="header__logo">
                            <a href="./"><img class="img-fluid" style="height: 38px;" src="img/ellena-logo.png" alt=""></a>
                        </div>
                    </div>
                    <div class="col-xl-6 col-lg-7" >
                        <nav class="header__menu">
                            <ul id="menu">
                                <li <%if(request.getRequestURL().toString().contains("/home.jsp")) { %>class="active"<%}%>><a href="./">Home</a></li>
                                <li <%if(request.getRequestURL().toString().contains("/category")) { %>class="active"<%}%>><a>Thời trang</a>
                                    <ul class="dropdown">
                                        <%
                                            for (int i : categoryOrder) {
                                                for (CategoryDTO cat : listCategory) {
                                                    if (cat.getOrder() == i) {
                                        %>
                                        <li><a href="CategoryRouteController?category=<%=cat.getCategoryName()%>"><%=cat.getCategoryName()%></a></li>
                                            <%
                                                        }
                                                    }
                                                }%>
                                    </ul>
                                </li>
                                <li><a href="./blog.html">Khám phá</a></li>
                                <li <%if(request.getRequestURL().toString().contains("/contact")) { %>class="active"<%}%>><a href="./contact.jsp">Liên hệ</a></li>
                            </ul>
                        </nav>
                    </div>
                    <div class="col-lg-3">
                        <div class="header__right">
                            <%if (user != null) {%>
                            <div class="header__right__auth">
                                <a style="font-weight: 500; color: #721c24" href="my-profile.jsp"><%= user.getFullName().toUpperCase()%></a>
                            </div>
                            <% } else {%>
                            <div class="header__right__auth">
                                <a href="login.jsp">Login</a>
                                <a href="register.jsp">Register</a>
                            </div>
                            <%}%>
                            <ul class="header__right__widget">
                                <li><span class="icon_search search-switch"></span></li>
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
        <!-- Search Begin -->
        <div class="search-model">
            <div class="h-100 d-flex align-items-center justify-content-center">
                <div class="search-close-switch">+</div>
                <form action="MainController" class="search-model-form">
                    <input type="text" name="search" id="search-input" placeholder="Tìm kiếm sản phẩm.....">
                    <input type="hidden" name="action" value="search-catalog" />
                </form>
            </div>
        </div>
        <!-- Search End -->
        <script>
            // Add active class to the current button (highlight it)
            var header = document.getElementById("menu");
            var btns = header.getElementsByTagName("li");
            for (var i = 0; i < btns.length; i++) {
                btns[i].addEventListener("click", function () {
                    var current = document.getElementsByClassName("active");
                    current[0].className = current[0].className.replace(" active", "");
                    this.className += " active";
                });
            }
        </script>
        <jsp:include page="js-plugins.jsp" flush="true"/>
    </body>
</html>
