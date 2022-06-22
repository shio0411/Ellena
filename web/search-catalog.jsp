<%-- 
    Document   : search-catalog
    Created on : Jun 12, 2022, 7:48:23 PM
    Author     : vankh
--%>

<%@page import="java.util.List"%>
<%@page import="store.shopping.ProductDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="description" content="Ashion Template">
        <meta name="keywords" content="Ashion, unica, creative, html">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Tìm kiếm sản phẩm</title>

        <!-- Google Font -->
        <link href="https://fonts.googleapis.com/css2?family=Cookie&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800;900&display=swap"
              rel="stylesheet">

        <jsp:include page="meta.jsp" flush="true" />
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
                            <span>Tìm kiếm</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Shop Section Begin -->
        <section class="shop spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3 col-md-3">
                        <div class="shop__sidebar">
                            <div class="sidebar__categories">
                                <div class="section-title">
                                    <h4>Categories</h4>
                                </div>
                                <div class="categories__accordion">
                                    <div class="accordion" id="accordionExample">
                                        <div class="card">
                                            <div class="card-heading active">
                                                <a data-toggle="collapse" data-target="#collapseOne">Women</a>
                                            </div>
                                            <div id="collapseOne" class="collapse show" data-parent="#accordionExample">
                                                <div class="card-body">
                                                    <ul>
                                                        <li><a href="#">Coats</a></li>
                                                        <li><a href="#">Jackets</a></li>
                                                        <li><a href="#">Dresses</a></li>
                                                        <li><a href="#">Shirts</a></li>
                                                        <li><a href="#">T-shirts</a></li>
                                                        <li><a href="#">Jeans</a></li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card">
                                            <div class="card-heading">
                                                <a data-toggle="collapse" data-target="#collapseTwo">Men</a>
                                            </div>
                                            <div id="collapseTwo" class="collapse" data-parent="#accordionExample">
                                                <div class="card-body">
                                                    <ul>
                                                        <li><a href="#">Coats</a></li>
                                                        <li><a href="#">Jackets</a></li>
                                                        <li><a href="#">Dresses</a></li>
                                                        <li><a href="#">Shirts</a></li>
                                                        <li><a href="#">T-shirts</a></li>
                                                        <li><a href="#">Jeans</a></li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card">
                                            <div class="card-heading">
                                                <a data-toggle="collapse" data-target="#collapseThree">Kids</a>
                                            </div>
                                            <div id="collapseThree" class="collapse" data-parent="#accordionExample">
                                                <div class="card-body">
                                                    <ul>
                                                        <li><a href="#">Coats</a></li>
                                                        <li><a href="#">Jackets</a></li>
                                                        <li><a href="#">Dresses</a></li>
                                                        <li><a href="#">Shirts</a></li>
                                                        <li><a href="#">T-shirts</a></li>
                                                        <li><a href="#">Jeans</a></li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>


                                    </div>
                                </div>
                            </div>
                            <div class="sidebar__filter">
                                <div class="section-title">
                                    <h4>Shop by price</h4>
                                </div>
                                <div class="filter-range-wrap">
                                    <div class="price-range ui-slider ui-corner-all ui-slider-horizontal ui-widget ui-widget-content"
                                         data-min="33" data-max="99"></div>
                                    <div class="range-slider">
                                        <div class="price-input">
                                            <p>Price:</p>
                                            <input type="text" id="minamount">
                                            <input type="text" id="maxamount">
                                        </div>
                                    </div>
                                </div>
                                <a href="#">Filter</a>
                            </div>
                            <div class="sidebar__sizes">
                                <div class="section-title">
                                    <h4>Shop by size</h4>
                                </div>
                                <div class="size__list">
                                    <label for="xxs">
                                        xxs
                                        <input type="checkbox" id="xxs">
                                        <span class="checkmark"></span>
                                    </label>
                                    <label for="xs">
                                        xs
                                        <input type="checkbox" id="xs">
                                        <span class="checkmark"></span>
                                    </label>
                                    <label for="xss">
                                        xs-s
                                        <input type="checkbox" id="xss">
                                        <span class="checkmark"></span>
                                    </label>
                                    <label for="s">
                                        s
                                        <input type="checkbox" id="s">
                                        <span class="checkmark"></span>
                                    </label>
                                    <label for="m">
                                        m
                                        <input type="checkbox" id="m">
                                        <span class="checkmark"></span>
                                    </label>
                                    <label for="ml">
                                        m-l
                                        <input type="checkbox" id="ml">
                                        <span class="checkmark"></span>
                                    </label>
                                    <label for="l">
                                        l
                                        <input type="checkbox" id="l">
                                        <span class="checkmark"></span>
                                    </label>
                                    <label for="xl">
                                        xl
                                        <input type="checkbox" id="xl">
                                        <span class="checkmark"></span>
                                    </label>
                                </div>
                            </div>
                            <div class="sidebar__color">
                                <div class="section-title">
                                    <h4>Shop by size</h4>
                                </div>
                                <div class="size__list color__list">
                                    <label for="black">
                                        Blacks
                                        <input type="checkbox" id="black">
                                        <span class="checkmark"></span>
                                    </label>
                                    <label for="whites">
                                        Whites
                                        <input type="checkbox" id="whites">
                                        <span class="checkmark"></span>
                                    </label>
                                    <label for="reds">
                                        Reds
                                        <input type="checkbox" id="reds">
                                        <span class="checkmark"></span>
                                    </label>
                                    <label for="greys">
                                        Greys
                                        <input type="checkbox" id="greys">
                                        <span class="checkmark"></span>
                                    </label>
                                    <label for="blues">
                                        Blues
                                        <input type="checkbox" id="blues">
                                        <span class="checkmark"></span>
                                    </label>
                                    <label for="beige">
                                        Beige Tones
                                        <input type="checkbox" id="beige">
                                        <span class="checkmark"></span>
                                    </label>
                                    <label for="greens">
                                        Greens
                                        <input type="checkbox" id="greens">
                                        <span class="checkmark"></span>
                                    </label>
                                    <label for="yellows">
                                        Yellows
                                        <input type="checkbox" id="yellows">
                                        <span class="checkmark"></span>
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%
                        List<ProductDTO> searchCatalog = (List<ProductDTO>) request.getAttribute("SEARCH_CATALOG");
                    %>
                    <div class="col-lg-9 col-md-9">
                    <div class="row property__gallery">
                        <% for (int i = 0; i < searchCatalog.size(); i++) {
                                ProductDTO product = searchCatalog.get(i);
                        %>
                        <div class="col-lg-4 col-md-6 mix">
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
                                                <img class="d-block" src="<%=img%>.jpg">
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
                                    <img src="<%=product.getColorImage().get("key").get(0)%>.jpg">
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
                                        <li><a href="#"><span class="icon_heart_alt"></span></a></li>
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
                                            <%= (int) (product.getPrice() / 1000 * (1 - product.getDiscount()))%>.000đ <span class="original-price"><s>
                                                    <%=product.getPrice() / 1000%>.000đ </s></span></span>
                                        <span class="product__price text-danger"> -
                                            <%=(int) (product.getDiscount() * 100)%>%</span>
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
                        <%}%>
                    </div>
                    </div>
                <!--                    <div class="col-lg-9 col-md-9">
                                        <div class="row">
                                            <div class="col-lg-4 col-md-6">
                                                <div class="product__item">
                                                    <div class="product__item__pic set-bg" data-setbg="img/shop/shop-2.jpg">
                                                        <ul class="product__hover">
                                                            <li><a href="img/shop/shop-2.jpg" class="image-popup"><span class="arrow_expand"></span></a></li>
                                                            <li><a href="#"><span class="icon_heart_alt"></span></a></li>
                                                            <li><a href="#"><span class="icon_bag_alt"></span></a></li>
                                                        </ul>
                                                    </div>
                                                    <div class="product__item__text">
                                                        <h6><a href="#">Flowy striped skirt</a></h6>
                                                        <div class="rating">
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                            <i class="fa fa-star"></i>
                                                        </div>
                                                        <div class="product__price">$ 49.0</div>
                                                    </div>
                                                </div>
                                            </div>
                
                
                                            <div class="col-lg-12 text-center">
                                                <div class="pagination__option">
                                                    <a href="#">1</a>
                                                    <a href="#">2</a>
                                                    <a href="#">3</a>
                                                    <a href="#"><i class="fa fa-angle-right"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>-->
            </div>
        </div>
    </section>
                    
    <!-- Shop Section End -->
    <jsp:include page="footer.jsp" flush="true" />

  
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script>
    $(document).ready(function() {
        // Add smooth scrolling to all links
        $("a").on('click', function(event) {

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
                }, 800, function() {

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
