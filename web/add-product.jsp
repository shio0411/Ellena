<%-- 
    Document   : add-product
    Created on : Jun 4, 2022, 8:07:23 PM
    Author     : vankh
--%>

<%@page import="store.shopping.CategoryDTO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Thêm một sản phẩm mới</title>
        <link href="https://fonts.googleapis.com/css2?family=Cookie&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800;900&display=swap"
              rel="stylesheet">

        <jsp:include page="meta.jsp" flush="true"/>
        <script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    </head>
    <body class="goto-here">
        <%
            List<CategoryDTO> listCategory = (List<CategoryDTO>) session.getAttribute("LIST_CATEGORY");

        %>
        <style>
            .img-wrap {
                display: inline-block; 
                width: 200px;
                position: relative;

            }
            .img-wrap .close {
                position: absolute;
                top: 2px;
                right: 2px;
                z-index: 100;

            }
        </style>
        <section class="vh-100 gradient-custom">
            <div class="container py-5 h-100">
                <div class="row justify-content-center align-items-center h-100">
                    <div class="col-12 col-lg-9 col-xl-7">
                        <div class="card shadow-2-strong card-registration" style="border-radius: 15px;">
                            <div class="card-body p-4 p-md-5">
                                <h3 class="mb-4 pb-2 pb-md-0 mb-md-5">Thêm một sản phẩm mới</h3>
                                <form action="MainController" class="info" method="POST" accept-charset="utf-8" enctype="multipart/form-data" id="myForm">

                                    <div class="row">
                                        <div class="col-md-12 mb-4">

                                            <div class="form-outline">
                                                <label class="form-label" for="productName">Tên sản phẩm</label>
                                                <input type="text" name="productName" id="productName" required="" class="form-control form-control-lg" placeholder="Ví dụ: ÁO THUN TRẮNG CƠ BẢN"/>

                                            </div>

                                        </div>

                                    </div>

                                    <div class="row">
                                        <div class="col-md-6 mb-4">
                                            <div class="form-outline">
                                                <label class="form-label" for="categoryID">Loại sản phẩm</label>
                                                <select class="form-control form-control-lg" name="categoryID" id="categoryID">
                                                    <%  for (CategoryDTO category : listCategory) {
                                                    %>
                                                    <option value="<%= category.getCategoryID()%>"><%= category.getCategoryName()%></option>
                                                    <%
                                                        }
                                                    %>
                                                </select>

                                            </div>
                                        </div>
                                        <div class="col-md-6 mb-4">

                                            <div class="form-outline">
                                                <label class="form-label" for="lowStockLimit">Giới hạn số lượng thấp</label>
                                                <input class="form-control form-control-lg" min="0" max="500" type="number" name="lowStockLimit" id="lowStockLimit" placeholder="Thông báo khi số lượng thấp"/>

                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 mb-4">
                                            <div class="form-outline">
                                                <label class="form-label" for="price">Giá tiền</label>
                                                <input class="form-control form-control-lg" type="number" name="price" min="0" id="price" required="" placeholder="Ví dụ: 300000"/>
                                            </div>
                                        </div>
                                        <div class="col-md-6 mb-4">
                                            <div class="form-outline">
                                                <label class="form-label" for="discount">Giảm giá</label>
                                                <input class="form-control form-control-lg" type="number" min="0" max="1" step="0.1" value="0" name="discount" id="discount"/>
                                            </div>
                                        </div>


                                    </div>

                                    <div class="row">
                                        <div class="col-md-6 mb-4">
                                            <div class="form-outline" >
                                                <label class="form-label" for="description">Mô tả sản phẩm</label>
                                                <textarea class="form-control form-control-lg" name="description" id="productID" style="resize: vertical; overflow: auto; width: 436.28px; height: 100px;" placeholder="Giới thiệu sản phẩm, tối đa 500 kí tự..."></textarea>
                                            </div> 
                                        </div>
                                    </div>

                                    <div class="color-container">
                                        <div class="row" id="color1">
                                            <div class="col-md-4 mb-4">
                                                <div class="form-outline">
                                                    <label class="form-label" for="color">Màu</label>

                                                    <input class="form-control form-control-lg" required="" type="text" name="color" placeholder="Ví dụ: Trắng"/>
                                                    <input id="variantsCount1" type="hidden" name="variantsCount" value="1"/>
                                                </div>
                                            </div> 
                                            <div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                                <div class="modal-dialog" id="1" >
                                                    <div class="modal-content" >
                                                        <div class="modal-header">
                                                            <h4 class="modal-title" id="myModalLabel">Chi tiết màu</h4>
                                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                                                        </div>
                                                        <div class="modal-body">
                                                            <div id="sq1">
                                                                <div class="row" id="variant1">
                                                                    <div class="col-md-5 mb-4 pb-2">
                                                                        <div class="form-outline">
                                                                            <label class="form-label" for="size">Size</label>
                                                                            <input class="form-control form-control-lg"  required="" type="text" name="size" placeholder="Ví dụ: XL"/>
                                                                        </div>

                                                                    </div>
                                                                    <div class="col-md-5 mb-4 pb-2">

                                                                        <div class="form-outline">
                                                                            <label class="form-label" for="quantity">Số lượng</label>
                                                                            <input class="form-control form-control-lg" required="" type="number" min="0" name="quantity" placeholder="Ví dụ: 300"/>
                                                                        </div>
                                                                    </div>
                                                                    <button type="button" onclick="removeVariant('variant1')" style="border: none; background: none;"><i class="fa fa-remove fa-lg"></i></button>
                                                                </div>
                                                            </div>
                                                            <!-- Add a variant inside pop-up -->
                                                            <button class="mb-4" type="button" id="addVariant1" style="margin-left: 2.6%; border: none; background: none"><i class="fa fa-plus-circle fa-lg"></i></button>
                                                            <!-- Upload image -->
                                                            <div class="row">
                                                                <div id="upload-image1" class="col-md-5 mb-4">
                                                                    <div>
                                                                        <input accept="image/*" type="file" name="files0" onChange="previewImages(event)"/>          
                                                                        <div id="preview" class="img-wrap"></div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <!-- Add an image browse button -->
                                                            <button type="button" id="addImage1" style="width: 25px; margin-left: 2.6%;" onClick="myFunction(event)">+</button>
                                                            <script>

                                                                var maxInputs = 3;

                                                                function myFunction(e) {

                                                                    var id = e.target.id.charAt(e.target.id.length - 1);
                                                                    var uploadDiv = e.target.previousElementSibling.firstElementChild;

                                                                    var container = document.createElement("div");


                                                                    var input = document.createElement("input");
                                                                    input.setAttribute("accept", "image/*");
                                                                    input.setAttribute("type", "file");
                                                                    input.setAttribute("name", "files" + (id-1));
                                                                    input.setAttribute("onChange", "previewImages(event)");

                                                                    console.log(input);
                                                                    var preview = document.createElement("div");
                                                                    preview.setAttribute("id", "preview");
                                                                    preview.setAttribute("class", "img-wrap");

                                                                    container.appendChild(input);
                                                                    container.appendChild(preview);
                                                                    uploadDiv.appendChild(container);

                                                                    var inputCount = uploadDiv.children.length;
                                                                    if (inputCount === maxInputs) {

                                                                        if (inputCount === maxInputs) {
                                                                            document.querySelector("#addImage" + id).style.display = "none";
                                                                            document.querySelector("#addImage" + id).setAttribute("onClick", "");
                                                                        }

                                                                    }
                                                                }
                                                                function previewImages(e) {

                                                                    var preview = e.target.nextElementSibling;

                                                                    if (e.target.files) {
                                                                        [].forEach.call(e.target.files, readAndPreview);
                                                                    }


                                                                    function readAndPreview(file) {

                                                                        // Make sure `file.name` matches our extensions criteria
                                                                        if (!/\.(jpe?g|png|gif)$/i.test(file.name)) {
                                                                            return alert(file.name + " is not an image");
                                                                        } // else...


                                                                        var reader = new FileReader();

                                                                        reader.addEventListener("load", function () {

                                                                            var image = new Image(200, 100);
                                                                            image.title = file.name;
                                                                            image.src = this.result;

                                                                            var button = document.createElement("button");
                                                                            button.innerHTML = `&times;`;
                                                                            button.setAttribute("class", "close");
                                                                            button.setAttribute("type", "button");
                                                                            button.addEventListener("click", deleteImage);

                                                                            while (preview.hasChildNodes()) {
                                                                                preview.removeChild(preview.firstChild);
                                                                            }

                                                                            preview.appendChild(image);
                                                                            preview.appendChild(button);
                                                                        });

                                                                        reader.readAsDataURL(file);

                                                                    }

                                                                }
                                                                function deleteImage() {
                                                                    var image = this.parentElement;

                                                                    var input = image.previousElementSibling;

                                                                    input.value = "";
                                                                    while (image.hasChildNodes()) {
                                                                        image.removeChild(image.firstChild);
                                                                    }
                                                                }
                                                            
                                                            </script>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--Edit a color's variant -->
                                            <button type="button" data-toggle="modal" data-target="#myModal1" style="border: none; background: none;"><i class="fa fa-edit fa-lg"></i></button>
                                            <!--Remove a color -->
                                            <button type="button" onclick="removeColor('color1')" style="border: none; background: none;"><i class="fa fa-remove fa-lg"></i></button>
                                        </div>
                                    </div>
                                    <button class="mb-4" type="button" id="addColor" style="border: none; background: none"><i class="fa fa-plus-circle fa-lg"></i></button>
                                    <div>
                                        <button class="primary-btn" onClick="checkForm(event)" type="submit" name="action" value="Add a product" >Tạo</button>
                                    </div>
                                </form>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </section>

        <script>
            var newId = 2;

            $(document).ready(function () {
                $("#addColor").click(function () {

                    $(".color-container").append('<div class="row" id="color' + newId + '"><div class="col-md-4 mb-4"><div class="form-outline">' +
                            '<label class="form-label" for="color">Màu</label>' +
                            '<input class="form-control form-control-lg" type="text" name="color" placeholder="Ví dụ: Trắng"/></div></div>' +
                            '<input id="variantsCount' + newId + '" type="hidden" name="variantsCount" value="1"/>' +
                            '<div class="modal fade" id="myModal' + newId + '" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">' +
                            '<div class="modal-dialog" id="' + newId + '" >' +
                            '<div class="modal-content" >' +
                            '<div class="modal-header">' +
                            '<h4 class="modal-title" id="myModalLabel">Chi tiết màu</h4>' +
                            '<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button></div>' +
                            '<div class="modal-body">' +
                            '<div id="sq' + newId + '">' +
                            '<div class="row" id="variant' + newId + '">' +
                            '<div class="col-md-5 mb-4 pb-2">' +
                            '<div class="form-outline">' +
                            '<label class="form-label" for="size">Size</label>' +
                            '<input class="form-control form-control-lg"  required="" type="text" name="size" placeholder="Ví dụ: XL"/>' +
                            '</div></div>' +
                            '<div class="col-md-5 mb-4 pb-2">' +
                            '<div class="form-outline">' +
                            '<label class="form-label" for="quantity">Số lượng</label>' +
                            '<input class="form-control form-control-lg" required="" type="number" min="0" name="quantity" placeholder="Ví dụ: 300"/>' +
                            '</div></div>' +
                            '<button type="button" onclick="removeVariant(`variant' + newId + '`)" style="border: none; background: none;"><i class="fa fa-remove fa-lg"></i></button></div></div>' +
                            '<button class="mb-4" type="button" id="addVariant' + newId + '" style="border: none; background: none"><i class="fa fa-plus-circle fa-lg"></i></button>' +
                            '<div class="row"><div id="upload-image' + newId + '" class="col-md-5 mb-4">' +
                            '<div><input accept="image/*" type="file" name="files'+(newId-1)+'" onChange="previewImages(event)"/>' +
                            '<div id="preview" class="img-wrap"></div></div></div></div>' +
                            '<button type="button" id="addImage' + newId + '" style="width: 25px; margin-left: 2.6%;" onClick="myFunction(event)">+</button></div>' +
                            '<div class="modal-footer">' +
                            '<button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button></div></div></div></div>' +
                            '<button type="button" data-toggle="modal" data-target="#myModal' + newId + '" style="border: none; background: none;"><i class="fa fa-edit fa-lg"></i></button>' +
                            '<button type="button" onclick="removeColor(`color' + newId + '`)" style="border: none; background: none;"><i class="fa fa-remove fa-lg"></i></button></div>');

                    $("#addVariant" + newId).click(function () {

                        var modalId = findAncestor(this, ".fade").id;
                        modalId = modalId.charAt(modalId.length - 1);
                        var variantsCount = parseInt(document.getElementById("variantsCount" + modalId).value);
                        variantsCount += 1;
                        document.getElementById("variantsCount" + modalId).setAttribute("value", variantsCount);

                        console.log(document.getElementById("variantsCount" + modalId).value);
                        $("#sq" + modalId).append('<div class="row" id="' + modalId + 'variant' + newVariantId + '"><div class="col-md-5 mb-4"><div class="form-outline">' +
                                '<label class="form-label" for="size">Size</label>' +
                                '<input class="form-control form-control-lg"  required="" type="text" name="size" placeholder="Ví dụ: XL"/></div></div>' +
                                '<div class="col-md-5 mb-4"><div class="form-outline">' +
                                '<label class="form-label" for="quantity">Số lượng</label>' +
                                '<input class="form-control form-control-lg" required="" type="number" min="0" name="quantity" placeholder="Ví dụ: 300"/></div></div>' +
                                '<button type="button" onclick="removeVariant(`' + modalId + 'variant' + newVariantId + '`)" style="border: none; background: none;"><i class="fa fa-remove fa-lg"></i></button>');
                        newVariantId++;

                    });
                    newId++;

                });

            });
            function findAncestor(el, sel) {
                while ((el = el.parentElement) && !((el.matches || el.matchesSelector).call(el, sel)))
                    ;
                return el;
            }

            var newVariantId = 2;
            var addVariantId = 1;
            $(document).ready(function () {
                $("#addVariant1").click(function () {
                    var modalId = findAncestor(this, ".fade").id;
                    modalId = modalId.charAt(modalId.length - 1);
                    var variantsCount = parseInt(document.getElementById("variantsCount1").value);
                    variantsCount += 1;
                    document.getElementById("variantsCount1").setAttribute("value", variantsCount);
                    console.log(document.getElementById("variantsCount1").value);
                    $("#sq1").append('<div class="row" id="' + modalId + 'variant' + newVariantId + '"><div class="col-md-5 mb-4"><div class="form-outline">' +
                            '<label class="form-label" for="size">Size</label>' +
                            '<input class="form-control form-control-lg"  required="" type="text" name="size" placeholder="Ví dụ: XL"/></div></div>' +
                            '<div class="col-md-5 mb-4"><div class="form-outline">' +
                            '<label class="form-label" for="quantity">Số lượng</label>' +
                            '<input class="form-control form-control-lg" required="" type="number" min="0" name="quantity" placeholder="Ví dụ: 300"/></div></div>' +
                            '<button type="button" onclick="removeVariant(`' + modalId + 'variant' + newVariantId + '`)" style="border: none; background: none;"><i class="fa fa-remove fa-lg"></i></button>');
                    newVariantId++;

                });
            });

            function removeColor(id) {
                const element = document.getElementById(id);
                element.remove();
            }
            function removeVariant(id) {
                const element = document.getElementById(id);
                var modalId = element.id.charAt(0);
                var variantsCount = parseInt(document.getElementById("variantsCount" + modalId).value);
                variantsCount -= 1;
                document.getElementById("variantsCount" + modalId).setAttribute("value", variantsCount);
                element.remove();

            }
            console.log(newId);
            function checkForm(e) {
                var form = document.getElementById("myForm");
                
                
                var stored = [];
                
                for (var i = 1; i < newId; i++) {
                    var variant = document.getElementById("sq"+i);
                    var sizes = variant.querySelectorAll("input[name='size']");
                    for (var size of sizes) {
                        if (stored.includes(size.value))  {
                            e.preventDefault();
                            return alert("Không thể nhập size trùng nhau!");
                        }
                        stored.push(size.value);
                        
                    }
                    stored = [];
                }
                
                for (var inputColor of form.color) {
                    if (stored.includes(inputColor.value)) {
                        e.preventDefault();
                        return alert("Không thể nhập màu trùng nhau!");
                        
                    }
                    
                    stored.push(inputColor.value);
                }
                
                
                
            }
        </script>

    </body>
</html>
