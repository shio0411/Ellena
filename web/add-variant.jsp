<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thêm một sản phẩm mới</title>
        <link href="https://fonts.googleapis.com/css2?family=Cookie&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800;900&display=swap"
              rel="stylesheet">

        <jsp:include page="meta.jsp" flush="true"/>
        <script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    </head>
    <body>
        
        <% String[] color = request.getParameterValues("color");  %>
        <section class="vh-100 gradient-custom">
            <div class="container py-5 h-100">
                <div class="row justify-content-center align-items-center h-100">
                    <div class="col-12 col-lg-9 col-xl-7">
                        <div class="card shadow-2-strong card-registration" style="border-radius: 15px;">
                            <div class="card-body p-4 p-md-5">
                                <h3 class="mb-4 pb-2 pb-md-0 mb-md-5">Thêm một sản phẩm mới</h3>
                                <form action="MainController" class="info" method="POST" accept-charset="utf-8">
                                    <div class="csq">
                                        <div class="row" id="variant1">
                                            <div class="col-md-5 mb-4">
                                                <div class="form-outline">
                                                    <label class="form-label" for="size">Size</label>
                                                    <input class="form-control form-control-lg"  required="" type="text" name="size" placeholder="Ví dụ: XL"/>
                                                </div>
                                            </div>
                                            <div class="col-md-5 mb-4">
                                                <div class="form-outline">
                                                    <label class="form-label" for="quantity">Số lượng</label>
                                                    <input class="form-control form-control-lg" required="" type="number" min="0" name="quantity" placeholder="Ví dụ: 300"/>
                                                </div>
                                            </div>
                                            <button type="button" onclick="removeVariant('variant1')" style="border: none; background: none;"><i class="fa fa-remove fa-lg"></i></button>
                                        </div>
                                    </div>
                                    <button class="mb-4" type="button" id="addVariant" style="border: none; background: none"><i class="fa fa-plus-circle fa-lg"></i></button>
                                    <div>
                                        <button class="primary-btn" type="submit" name="action" value="Add a product" >Thêm sản phẩm</button>
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
            $(document).ready(function (e) {
                $("#addVariant").click(function (e) {
                    $(".csq").append('<div class="row" id="variant' + newId + '"><div class="col-md-5 mb-4"><div class="form-outline">' +
                            '<label class="form-label" for="size">Size</label>' +
                            '<input class="form-control form-control-lg"  required="" type="text" name="size" placeholder="Ví dụ: XL"/></div></div>' +
                            '<div class="col-md-5 mb-4"><div class="form-outline">'+
                            '<label class="form-label" for="quantity">Số lượng</label>' +
                            '<input class="form-control form-control-lg" required="" type="number" min="0" name="quantity" placeholder="Ví dụ: 300"/></div></div>'+                                          
                            '<button type="button" onclick="removeVariant(`variant' + newId + '`)" style="border: none; background: none;"><i class="fa fa-remove fa-lg"></i></button>');
                    newId++;
                });
            });
            
            function removeVariant(id) {
                const element = document.getElementById(id);
                element.remove();
            }
        </script>
    </body>
</html>
