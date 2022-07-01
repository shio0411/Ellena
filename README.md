# Update search-order:
- modified:   README.md
- modified:   src/java/store/controllers/SearchOrderController.java
- modified:   src/java/store/controllers/UpdateOrderController.java
- modified:   src/java/store/filter/AuthenFilter.java
- modified:   web/login.jsp
- modified:   web/manager-order.jsp
- modified:   web/manager-product.jsp
- modified:   web/manager-statistic.jsp

	












# Release summary Update Checkout
***Changes since last push from 23/6/2022 6:54 AM***

***Release date: 23/6/2022 4:23 PM***

## Change in Files:
- shop-cart.jsp
	- Add get CART_MESSAGE
		```java
			// get cart message
			String message = (String) request.getAttribute("CART_MESSAGE");
            if (message == null) {
                message = "";
            }
		```
	- Add message row
		```jsp
			<!--Message row-->
                <div class="row">
                    <div class="col-12" style="text-align: center;">
                        <%= message%>
                    </div>
                </div>
		```
- `ProductDAO`
	- Update UPDATE_PRODUCT_QUANTITY Query
		```java
			private static final String UPDATE_PRODUCT_QUANTITY = "UPDATE tblColorSizes SET quantity = ? WHERE productColorID = ? AND size LIKE ?";
		```
	- Update updateProductQuantity() function to get size
- `CheckoutController`
	- Add check cart
	- Add check email pattern
	- Add check quantity return message
	- Add check status return message
