<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="store.shopping.ProductDTO"%>
<%@page import="java.util.List"%>
<%@page import="store.shopping.CategoryDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Home Page</title>

        <!-- Google Font -->
        <link href="https://fonts.googleapis.com/css2?family=Cookie&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800;900&display=swap"
              rel="stylesheet">

        <!-- Css Styles -->
        <jsp:include page="meta.jsp" flush="true"/>
    </head>

    <body>
        <jsp:include page="header.jsp" flush="true" />                          

        <!-- Breadcrumb Begin -->
        <div class="breadcrumb-option">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="breadcrumb__links">
                            <a href="./"><i class="fa fa-home"></i> Trang chủ</a>
                            <% String category = request.getParameter("category"); %>
                            <span><%= category %></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Shop Section Begin -->
        <section class="shop spad">
            <div class="container">
                <form action="MainController" method="POST">
                    <div class="row">
                        <div class="col-lg-3 col-md-3">
                            <div class="shop__sidebar">

                                <div class="sidebar__filter">
                                    <div class="section-title">
                                        <h4>Giá</h4>
                                    </div>
                                    <form action="MainController">
                                        <div class="filter-range-wrap">
                                            
                                            <div class="price-range ui-slider ui-corner-all ui-slider-horizontal ui-widget ui-widget-content"
                                                 data-min="100000" data-max="1000000"></div>

                                            <div class="range-slider">
                                                <div class="price-input">
                                                    <p>Price:</p>
                                                    <input type="text" readonly="" id="minamount" name="minAmount">
                                                    <input type="text" readonly="" id="maxamount" name="maxAmount">
                                                </div>
                                            </div>
                                        </div>
                                        <input type="hidden" name="search" value="">
                                        <a><button style="border: none; background: none;" type="submit" name="action" value="filter-price">Filter</button></a>
                                    </form>
                                </div>
                                <div class="sidebar__sizes">
                                    <div class="section-title">
                                        <h4>Kích cỡ</h4>
                                    </div>
                                    <div class="size__list filter__controls">
                                        <ul>
                                            <li style="float: left;" data-filter="*" class="active">Tất cả</li><br>
                                            <li style="float: left;" data-filter=".XS">XS</li><br>
                                            <li style="float: left" data-filter=".S">S</li><br>
                                            <li style="float: left" data-filter=".M">M</li><br>
                                            <li style="float: left" data-filter=".L">L</li><br>
                                            <li style="float: left" data-filter=".XL">XL</li><br>
                                        </ul>
                                    </div>
                                </div>

                                <div class="sidebar__color">
                                    <div class="section-title">
                                        <h4>Màu sắc</h4>
                                    </div>
                                    <div class="size__list color__list filter__controls">
                                        <ul>
                                            <li style="float: left;" data-filter="*" class="active">Tất cả</li><br>
                                            <li style="float: left;" data-filter=".Đen">Đen</li><br>
                                            <li style="float: left" data-filter=".Đỏ">Đỏ</li><br>
                                            <li style="float: left" data-filter=".Xanh">Xanh</li><br>
                                            <li style="float: left" data-filter=".Xanh nhạt">Xanh nhạt</li><br>
                                            <li style="float: left" data-filter=".Trắng">Trắng</li><br>
                                            <li style="float: left" data-filter=".Be">Be</li><br>
                                        </ul>
                                    </div>
                                </div>

                            </div>
                            </form>
                        </div>
                        <%
                            List<ProductDTO> searchCatalog = (List<ProductDTO>) session.getAttribute("SEARCH_CATALOG");
                            if (searchCatalog.size() > 0) {

                        %>
                        <div class="col-lg-9 col-md-9">
                            <div class="row property__gallery" id="itemsToFilter">
                                <% for (int i = 0; i < searchCatalog.size(); i++) {
                                        ProductDTO product = searchCatalog.get(i);
                                        Iterator<List<String>> key = product.getColorSizeQuantity().keySet().iterator();
                                        List<String> colorSize = new ArrayList<>();
                                        while (key.hasNext()) {
                                            colorSize = key.next();
                                        }
                                %>
                                <div class="col-lg-4 col-md-6 mix <%for (String s : colorSize) {%><%=s%> <%}%>">
                                    <div class="product__item">
                                        <div class="product__item__pic set-bg">
                                            <%
                                                if (product.getColorImage().get("key").size() > 1) {
                                            %>
                                            <div id="product-<%=product.getProductID()%>" class="carousel slide" data-ride="carousel" data-interval="false">
                                                <div class="carousel-inner">
                                                    <%
                                                        for (String img : product.getColorImage().get("key")) {
                                                    %>
                                                    <div class="carousel-item">
                                                        <img class="d-block" src="<%=img%>">
                                                    </div>
                                                    <%
                                                        }
                                                    %>
                                                </div>
                                                <a class="carousel-control-prev" data-target="#product-<%=product.getProductID()%>" role="button" data-slide="prev">
                                                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                                    <span class="sr-only">Previous</span>
                                                </a>
                                                <a class="carousel-control-next" data-target="#product-<%=product.getProductID()%>" role="button" data-slide="next">
                                                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                                    <span class="sr-only">Next</span>
                                                </a>
                                            </div>
                                            <%} else {
                                            %>
                                            <img src="<%=product.getColorImage().get("key").get(0)%>">
                                            <%
                                                }
                                            %>
                                            <%
                                                if (product.getDiscount() != 0) {
                                            %>
                                            <div class="label sale">Sale</div>
                                            <%}%>
                                            <ul class="product__hover">
                                                <li><a href="<%=product.getColorImage().get("key").get(0)%>.jpg" class="image-popup"><span class="arrow_expand"></span></a></li>
                                                <li><a href="#"><span class="icon_bag_alt"></span></a></li>
                                            </ul>
                                        </div>
                                        <div class="product__item__text">
                                            <h6><a href="ProductRouteController?productID=<%=product.getProductID()%>">
                                                    <%=product.getProductName()%></a></h6>
                                                    <%
                                                        if (product.getDiscount() != 0) {
                                                    %>
                                            <div class="">
                                                <span class="product__price text-danger">
                                                    <%= (int) (product.getPrice() - product.getDiscount()) / 1000%>.000đ <span class="original-price"><s>
                                                            <%=product.getPrice() / 1000%>.000đ </s></span></span>
                                                <span class="product__price text-danger"> -
                                                    <%=(int) (product.getDiscount() * 100.0 / product.getPrice())%>%</span>
                                            </div>
                                            <%
                                            } else {
                                            %>
                                            <div class="product__price">
                                                <%=product.getPrice() / 1000%>.000đ</div>
                                                <%}%>
                                        </div>
                                    </div>
                                </div>
                                <%}
                                } else {%>
                                <div>Không có kết quả tìm kiếm.</div>
                                <%}%>
                            </div>
                        </div>
                    </div>
            </div>
        </section>

        <!-- Shop Section End -->
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
        </script>
        <jsp:include page="js-plugins.jsp" flush="true" />
        <script>
            $(".carousel-inner").children(".carousel-item:first-child").addClass("active");
        </script>
    </body>
</html>
