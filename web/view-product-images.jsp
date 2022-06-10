<%-- 
    Document   : view-product-images
    Created on : Jun 6, 2022, 2:17:27 PM
    Author     : giama
--%>

<%@page import="java.util.Set"%>
<%@page import="javafx.util.Pair"%>
<%@page import="java.util.List"%>
<%@page import="store.shopping.ProductDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Hình ảnh sản phẩm</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <jsp:include page="meta.jsp" flush="true" />




    </head>
    <body>
        <style>

            .img-wrap {
                display: inline-block; 
                width: 280px;
                position: relative;

            }
            .img-wrap .close {
                position: absolute;
                top: 2px;
                right: 2px;
                z-index: 100;

            }

            .nav-pills>li.active>a, .nav-pills>li.active>a:focus, .nav-pills>li.active>a:hover {
                color: #fff;
                background-color: #fbe2d6;
            }
        </style>
        <%ProductDTO product = (ProductDTO) request.getAttribute("PRODUCT_DETAIL");
            Set<String> colorList = product.getColorImage().keySet();
            String message = (String) request.getAttribute("MESSAGE");
            if (message != null) {
        %>

        <!-- Pop-up thông báo cập nhật thành công -->
        <div class="modal fade" id="myModal" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Thông báo</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>

                    </div>
                    <div class="modal-body">
                        <p><%=message%></p>
                    </div>
                    <div class="modal-footer">
                        <a href="MainController?action=ViewImages&productID=<%=product.getProductID()%>"><button type="button" class="btn btn-default">Đóng</button></a>
                    </div>
                </div>

            </div>
        </div> <%}%>
        <div class="sidenav">
            <a href="ManagerStatisticController"><i class="fa fa-bar-chart fa-lg"></i>Số liệu thống kê</a>
            <a href="ManagerShowProductController" style="color: #873e23; font-weight: bold;"><i class="fa fa-archive fa-lg"></i>Quản lí sản phẩm</a>
            <a href="manager-order.jsp"><i class="fa fa-cart-plus fa-lg"></i>Quản lí đơn hàng</a>
        </div>

        <div class='main'>
            <div class="row">
                <div class="col-md-12 mb-4">
                    <div class="form-outline" >
                        <label class="form-label" for="colorImage">Hình ảnh sản phẩm</label>
                        <ul class="nav nav-pills mb-4">
                            <% int t = 1;

                                for (String color : colorList) {
                            %>
                            <li class='nav-item <%if (t == 1) { %> active <%}%>'><a data-toggle="tab" href="#<%= color%>"><%= color%></a></li>
                                <% t++;
                                    } %>                             
                        </ul>


                        <div class="tab-content">
                            <% int j = 1;

                                for (String color : colorList) {
                                    int imagesNumber = 0;
                            %>
                            <div id="<%= color%>" class="tab-pane fade <%if (j == 1) { %> in active <%}%>">
                                <%  for (int k = 0; k < product.getColorImage().get(color).size(); k++) {%>
                                <div class='img-wrap'>

                                    <button class="close" type="button" data-toggle="modal" data-target="#<%=color%>Modal<%=k%>">&times;</button>
                                    <img style="height: 280px; width: 280px;" src="<%= product.getColorImage().get(color).get(k)%>.jpg"/>
                                    <div class="modal fade" id="<%=color%>Modal<%=k%>" role="dialog">
                                        <div class="modal-dialog">

                                            <!-- Modal content-->
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h4 class="modal-title">Xoá ảnh</h4>
                                                    <button type="button" class="close" data-dismiss="modal">&times;</button>

                                                </div>
                                                <div class="modal-body">
                                                    <p>Bạn có chắc muốn xoá ảnh này?</p>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type='button' class='btn btn-default' data-dismiss="modal">Huỷ</button>
                                                    <a href="MainController?action=DeleteImage&productID=<%=product.getProductID()%>&imageName=<%= product.getColorImage().get(color).get(k)%>"><button type="button" class="btn btn-danger">Xoá</button></a>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>


                                <%++imagesNumber;%>

                                <%}%>

                                <a href="MainController?action=ViewImages&productID=<%=product.getProductID()%>"<button id="add" type="button" onClick="checkImages()">Add more images</button></a>


                            </div>
                            <script>
                                function checkImages() {
                                    if (<%=imagesNumber%> >= 3) {
                                        return alert("Du roi nha!");
                                    } else {
                                        var container = document.createElement("div");
                                        var input = document.createElement("input");
                                        input.setAttribute("accept", "image/*");
                                        input.setAttribute("type", "file");
                                        input.setAttribute("name", "files");
                                        input.setAttribute("id", "file-input" + inputID.toString());
                                        input.setAttribute("class", "file-input");

                                        var preview = document.createElement("div");
                                        preview.setAttribute("id", "preview" + inputID.toString());

                                        container.appendChild(input);
                                        container.appendChild(preview);
                                        document.getElementById(<%=color%>).appendChild(container);

                                        document.querySelector('#file-input' + inputID).addEventListener("change", previewImages);
                                    }
                                }
                            </script>
                            <% j++;
                                }%>
                        </div>
                    </div> 
                </div>
            </div>
        </div>
        <script>
            $(document).ready(function () {
                $("#myModal").modal();
            });
        </script>
    </body>
</html>
