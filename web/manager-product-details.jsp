<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="javax.servlet.jsp.tagext.IterationTag"%>
<%@page import="store.shopping.CategoryDTO"%>
<%@page import="store.shopping.ProductDTO"%>
<%@page import="java.util.List"%>
<%@page import="store.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chi tiết sản phẩm</title>
        
        <jsp:include page="meta.jsp" flush="true" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    </head>
    <body>
        <%
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            String message = (String) request.getAttribute("MESSAGE");
            if (message != null) {
        %>
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
                        <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                    </div>
                </div>

            </div>
        </div> <%}%>

        <div class="sidenav">
            <a href="ManagerStatisticController"><i class="fa fa-bar-chart fa-lg"></i>Số liệu thống kê</a>
            <a href="ManagerShowProductController" style="color: #873e23; font-weight: bold;"><i class="fa fa-archive fa-lg"></i>Quản lí sản phẩm</a>
            <a href="ManagerShowOrderController"><i class="fa fa-cart-plus fa-lg"></i>Quản lí đơn hàng</a>
        </div>

        <div class="main">
            <div class="row">
                <form action="MainController" method="POST" class="col-12 text-right"">                
                    Xin chào, <a href="my-profile.jsp"><%= loginUser.getFullName()%></a>
                    <input type="submit" name="action" value="Logout" style="margin-left: 4%;">
                </form>

            </div>
            <h3>Chi tiết sản phẩm</h3> 
            <div class="row">

                <%
                    ProductDTO product = (ProductDTO) request.getAttribute("PRODUCT_DETAIL");
                    List<CategoryDTO> listCategory = (List<CategoryDTO>) session.getAttribute("LIST_CATEGORY");

                %>
                <form action="MainController" method="POST" style="margin-left: 1.7%;">
                    <div class="row">
                        <div class="col-md-6 mb-4">

                            <div class="form-outline">
                                <label class="form-label" for="productID">ID sản phẩm</label>
                                <input class="form-control form-control-lg" type="number" name="productID" id="productID" readonly="" value="<%= product.getProductID()%>"/>

                            </div>
                        </div>
                        <div class="col-md-6 mb-4">
                            <div class="form-outline">
                                <label class="form-label" for="status">Trạng thái</label>
                                <select class="form-control form-control-lg" name="status" id="status">
                                    <option value="true" <%if (product.isStatus() == true) {%>selected <%}%>>Active</option>
                                    <option value="false" <%if (product.isStatus() == false) {%>selected <%}%>>Inactive</option>
                                </select>
                            </div>

                        </div>

                    </div>
                    <div class="row">
                        <div class="col-md-12 mb-4">
                            <div class="form-outline">
                                <label class="form-label" for="productName">Tên sản phẩm</label>
                                <input class="form-control form-control-lg" type="text" name="productName" id="productName" value="<%= product.getProductName()%>"/>

                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-4">
                            <div class="form-outline">
                                <label class="form-label" for="categoryID">Loại sản phẩm</label>
                                <select class="form-control form-control-lg" name="categoryID" id="categoryID">
                                    <%
                                        for (CategoryDTO category : listCategory) {
                                    %>
                                    <option value="<%= category.getCategoryName()%>" <%if (product.getCategoryName().equalsIgnoreCase(category.getCategoryName())) {%>selected <%}%>><%= category.getCategoryName()%></option>
                                    <%
                                        }
                                    %>
                                </select>

                            </div>
                        </div>
                        <div class="col-md-6 mb-4">

                            <div class="form-outline">
                                <label class="form-label" for="lowStockLimit">Giới hạn số lượng thấp</label>
                                <input class="form-control form-control-lg" min="0" max="500" type="number" name="lowStockLimit" id="lowStockLimit" value="<%= product.getLowStockLimit()%>"/>

                            </div>
                        </div>

                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-4">
                            <div class="form-outline">
                                <label class="form-label" for="price">Giá tiền</label>
                                <input class="form-control form-control-lg" type="number" name="price" value="<%= product.getPrice()%>"/>
                            </div>
                        </div>
                        <div class="col-md-6 mb-4">
                            <div class="form-outline">
                                <label class="form-label" for="discount">Giảm giá</label>
                                <input class="form-control form-control-lg" type="number" min="0" max="1" step="0.1" name="discount" id="price" value="<%= product.getDiscount()%>"/>
                            </div>
                        </div>


                    </div>


                    <div class="row">
                        <div class="col-md-6 mb-4">
                            <div class="form-outline" >
                                <label class="form-label" for="description">Mô tả sản phẩm</label>
                                <textarea class="form-control form-control-lg" name="description" id="productID" style="resize: vertical; overflow: auto; width: 436.28px; height: 100px;"><%= product.getDescription()%></textarea>
                            </div> 
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 mb-4">
                            <div class="form-outline" >
                                <label class="form-label" for="colorSizeQuantity">Quản lý số lượng</label>
                                <ul class="nav nav-tabs">
                                    <% Iterator<String> it = product.getColorImage().keySet().iterator();
                                        int i = 1;
                                        List<String> colorList = new ArrayList<>();
                                        while (it.hasNext()) {
                                            String color = it.next();
                                            colorList.add(color);  %>      

                                    <li <%if (i == 1) { %> class="active" <%}%>><a data-toggle="tab" href="#<%= color%>-size"><%= color%></a></li>

                                    <% i++;
                                        }%>                             
                                </ul>


                                <div class="tab-content">
                                    <%Iterator<List<String>> it1 = product.getColorSizeQuantity().keySet().iterator();
                                        int g = 1;
                                        List<String> key = new ArrayList<>();
                                        while (it1.hasNext()) {
                                            for (String n : it1.next()) {
                                                key.add(n);
                                            }
                                        }
                                        for (String color : colorList) {
                                    %>
                                    <div id="<%=color%>-size" class="tab-pane fade <%if (g == 1) { %> in active <%}%>">

                                        <table>
                                            <tr>
                                                <th>Size</th>
                                                <th>Số lượng</th>
                                            </tr>
                                            <% for (int z = 0; z < key.size(); z += 2) {
                                                    if (color.equalsIgnoreCase(key.get(z))) {%>
                                            <tr>
                                                <td><input type="text" name="size" value="<%= key.get(z + 1)%>" maxlength="50" style="width: 60px"/></td>
                                                    <% List<String> colorSize = new ArrayList<>();
                                                        colorSize.add(key.get(z));
                                                        colorSize.add(key.get(z + 1));
                                                    %>
                                                <td><input type="number" name="quantity" value="<%= product.getColorSizeQuantity().get(colorSize)%>"></td>
                                            </tr>
                                            <% }
                                                } %>
                                        </table>
                                    <button class="mb-4" type="button" name="<%=color%>-size" onClick="addVariants(event)" style="border: none; background: none"><i class="fa fa-plus-circle fa-lg"></i></button>

                                    </div>
                                    <% g++;
                                        }%>
                                </div>          
                            </div>
                        </div> 
                    </div>    
                    <div class="row">
                        <div class="col-md-12 mb-4">
                            <div class="form-outline" >
                                <label class="form-label" for="colorImage">Hình ảnh sản phẩm</label>
                                <ul class="nav nav-tabs">
                                    <% int t = 1;

                                        for (String color : colorList) {
                                    %>
                                    <li <%if (t == 1) { %> class="active" <%}%>><a data-toggle="tab" href="#<%= color%>"><%= color%></a></li>

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
                                        <img style="height: 280px; width: 280px;" src="<%= product.getColorImage().get(color).get(k)%>.jpg"/>

                                        <%++imagesNumber;%>

                                        <%    }%>

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
                                    </script>
                                    <% j++;
                                        }%>
                                </div>
                            </div>



                        </div>
                    </div> 
            </div>

            <button class="btn btn-default" type="submit" name="action" value="ManagerUpdateProduct">Cập nhật</button>

        </div>
    </form>

</div>
</div>


<script>
        $(document).ready(function () {
            $("#myModal").modal();
        }
        );




</script>  

</body>
</html>
