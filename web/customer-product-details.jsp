<%@page import="javafx.util.Pair"%>
<%@page import="java.util.Collection"%>
<%@page import="store.shopping.RatingDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="store.shopping.ProductDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <% ProductDTO product = (ProductDTO) request.getAttribute("PRODUCT_DETAIL");%>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="description" content="Ellena Fashion Shop">
        <meta name="keywords" content="Ellena, fashion, creative, shop">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title><%= product.getProductName()%></title>

        <!-- Google Font -->
        <link href="https://fonts.googleapis.com/css2?family=Cookie&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800;900&display=swap"
              rel="stylesheet">
        <jsp:include page="meta.jsp" flush="true"/>

    </head>
    <body>

        <jsp:include page="header.jsp" flush="true"/>

        <!-- Breadcrumb -->
        <div class="breadcrumb-option">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="breadcrumb__links">
                            <a href="./"><i class="fa fa-home"></i>Trang Chủ</a>
                            <a href="CategoryRouteController?category=<%= product.getCategoryName()%>"><%= product.getCategoryName()%></a>
                            <span><%= product.getProductName()%></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Product Details Section Begin -->
        <section class="product-details spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6">
                        <div class="product__details__pic">
                            <div class="product__details__pic__left product__thumb nice-scroll">
                                <% Collection<List<String>> values = product.getColorImage().values();
                                    int z = 1;
                                    for (List<String> v : values) {
                                        for (String image : v) {
                                %>                                       
                                <a class="pt <%if (z == 1) {%> active <%}%>" href="#product-<%= z%>">
                                    <img src="<%= image%>.jpg" alt="<%= product.getProductName()%>">
                                </a>
                                <% z++;
                                        }
                                    }%>
                            </div>
                            <div class="product__details__slider__content">
                                <div class="product__details__pic__slider owl-carousel">
                                    <%
                                        int q = 1;
                                        for (List<String> v : values) {
                                            for (String image : v) {
                                    %>   
                                    <img data-hash="product-<%= q%>" class="product__big__img" src="<%=image%>.jpg" alt="<%= product.getProductName()%>">
                                    <% q++;
                                            }
                                        }%>
                                </div>
                            </div>
                        </div>
                    </div>
                    <% int[] ratingDetails = (int[]) request.getAttribute("PRODUCT_RATING_DETAILS");%>
                    <div class="col-lg-6">
                        <div class="product__details__text">
                            <h3><%= product.getProductName()%></h3>
                            <div class="rating">
                                <% int averageStar = (int) Math.ceil(ratingDetails[0]);
                                    for (int s = 1; s <= averageStar; s++) { %>
                                <i class="fa fa-star"></i>
                                <%}
                                    if (averageStar != 5) {
                                        for (int i = 0; i < 5 - averageStar; i++) {
                                %>
                                <i class="fa fa-star-o"></i>
                                <%}
                                    }%>
                                <span>(<%= ratingDetails[1]%> đánh giá)</span>
                            </div>
                            <%

                                if (product.getDiscount() != 0) {
                            %>
                            <div class="product__details__price"><%= (int) (product.getPrice() / 1000 * (1 - product.getDiscount()))%>.000đ<span><%=product.getPrice() / 1000%>.000đ </span></div>
                            <%
                            } else {
                            %>
                            <div class="product__details__price">
                                <%=product.getPrice() / 1000%>.000đ</div>
                                <%}%>
                            <p><%= product.getDescription()%></p>
                            <div class="product__details__button">
                                <div class="quantity">
                                    <span>Số lượng</span>
                                    <div class="pro-qty">
                                        <input type="text" value="1">
                                    </div>
                                </div>
                                <a href="#" class="cart-btn"><span class="icon_bag_alt"></span>Thêm vào giỏ hàng</a>

                            </div>

                            <div class="product__details__widget">
                                <ul>

                                    <li>
                                        <span>Màu:</span>
                                        <form action="CheckSizeQuantityController" id="sizeQuantityForm" >
                                            <div id="colors">
                                                <% Iterator<String> it = product.getColorImage().keySet().iterator();
                                                    int i = 1;
                                                    List<String> colorList = new ArrayList<>();
                                                    String currentColor = request.getParameter("color");
                                                    while (it.hasNext()) {
                                                        String color = it.next();
                                                        colorList.add(color);

                                                    }
                                                    if (currentColor == null) {
                                                        currentColor = colorList.get(0);
                                                    }
                                                    for (String color : colorList) {
                                                %>   
                                                <label for="color<%=i%>" style="margin-right:1%">
                                                    <input type="radio" name="color" id="color<%=i%>" value="<%= color%>" <% if (color.equalsIgnoreCase(currentColor)) { %> checked="" <%}%>/> <%= color%>
                                                </label>     
                                                <% i++;
                                                    }%> 
                                                <input type="hidden" name="productID" value="<%= product.getProductID()%>" />
                                            </div>
                                        </form>
                                    </li>

                                    <li>
                                        <span>Size:</span>
                                        <div class="size__btn">
                                            <% ArrayList<Pair<String, Integer>> sizeQuantityList = (ArrayList<Pair<String, Integer>>) request.getAttribute("SIZE_QUANTITY");
                                                int x = 1;
                                                if (sizeQuantityList != null) {
                                                    for (Pair<String, Integer> sizeQuantity : sizeQuantityList) {
                                                        if (sizeQuantity.getValue() > 0) {
                                            %>
                                            <label for="size<%=x%>" <%if (x == 1) {%>class="active"<%}%>>
                                                <input type="radio" id="size<%=x%>" name="size">
                                                <%= sizeQuantity.getKey()%>
                                            </label>
                                            <% } else {%>
                                            <label for="size<%=x%>">
                                                <input type="radio" id="size<%=x%>" name="size" disabled="">
                                                <%= sizeQuantity.getKey()%>
                                            </label>
                                            <% }
                                                    x++;
                                                }
                                            } else {
                                             Iterator<List<String>> it1 = product.getColorSizeQuantity().keySet().iterator();
                                                int g = 1;
                                                List<String> key = new ArrayList<>();
                                                while (it1.hasNext()) {
                                                    for (String n : it1.next()) {
                                                        key.add(n);
                                                    }
                                                }
                                                for (int a = 0; a < key.size(); a += 2) {
                                                    if (colorList.get(0).equalsIgnoreCase(key.get(a))) {%>
                                            <label for="size<%=g%>" <%if (g == 1) {%> class="active" <%}%>>
                                                <input type="radio" id="size<%=g%>" name="size" >  
                                                <%= key.get(a + 1)%>
                                                
                                            </label>
                                            <%} g++;} }%>
                                        </div>
                                    </li>
                                    
                                    <li style="margin-top: 4%;">
                                        <span>Giảm giá:</span>
                                        <p><%= (int) (product.getDiscount() * 100)%>%</p>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-12">
                        <div class="product__details__tab">
                            <ul class="nav nav-tabs" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active" data-toggle="tab" href="#tabs-1" role="tab">MÔ TẢ SẢN PHẨM</a>
                                </li>                              
                                <li class="nav-item">
                                    <a class="nav-link" data-toggle="tab" href="#tabs-2" role="tab">ĐÁNH GIÁ (<%= ratingDetails[1]%>)</a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane active" id="tabs-1" role="tabpanel">
                                    <h6>MÔ TẢ SẢN PHẨM</h6>
                                    <p><%= product.getDescription() %></p>
                                </div>
                             
                                <div class="tab-pane" id="tabs-2" role="tabpanel">
                                    <h6>ĐÁNH GIÁ (<%= ratingDetails[1]%>)</h6>
                                    <% List<RatingDTO> ratingList = (List<RatingDTO>) request.getAttribute("RATING_LIST");
                                        for (RatingDTO rating : ratingList) {
                                    %>

                                    <p style="font-weight: bold"><%= rating.getFullName()%></p>
                                    <div class="rating">
                                        <% for (int t = 1; t <= rating.getStar(); t++) { %>
                                        <i class="fa fa-star"></i>
                                        <%}
                                            if (averageStar != 5) {
                                                for (int a = 0; a < 5 - averageStar; a++) {
                                        %>
                                        <i class="fa fa-star-o"></i>
                                        <%}
                                            }%>
                                    </div>
                                    <p><%= rating.getContent()%></p>
                                    <br>
                                    <%}%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </section>
        <script>
            var colors = document.getElementById('colors');
            var numElems = colors.getElementsByTagName('input');
            for (var c = 0; c < numElems.length; c++) {
                var colorButton = document.getElementById(numElems[c].id);
                colorButton.addEventListener('click', function handleClick() {
                    document.getElementById('sizeQuantityForm').submit();
                });
            }
        </script>
        <jsp:include page="footer.jsp" flush="true"/>

        <jsp:include page="js-plugins.jsp" flush="true"/>

    </body>
</html>
