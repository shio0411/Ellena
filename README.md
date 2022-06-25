# Release summary Fix check out BUG and update OrderDTO
***Changes since last push from 25/6/2022 1:04 AM***

***Release date: 26/6/2022 3:10 AM***

## Add in Files:
- 

## Change in Files:
- `OrderDTO`
	- Change `transactionNumber` from `int` to `String`
- home.jsp
	- Fix "hàng mới về" section. Product display link properly
- `CheckoutController`
	- **FIX BUG** Remove old insert order and replace with new insert order code along with new function in ProductDAO
	```java
		// new insert order
        OrderDAO odao = new OrderDAO();
        // update product quantity
        for (CartProduct item : cart) {
            int productColorID = pdao.getProductColorID(item.getProductID(), item.getColor());
            List<String> colorSize = new ArrayList<>();
            colorSize.add(item.getColor());
            colorSize.add(item.getSize());
            int maxQuantity = pdao.getProductDetail(item.getProductID()).getColorSizeQuantity().get(colorSize);
            if (productColorID > 0) {
                pdao.updateProductQuantity(maxQuantity - item.getQuantity(), productColorID, item.getSize());
            }
        }
        boolean checkAddOrder = odao.addOrder(order, user.getUserID(), cart);
        if (checkAddOrder) {
            int orderID = odao.getOrderID(user.getUserID());
            if (orderID > 0) {
                request.setAttribute("CART_MESSAGE", "Đặt hàng thành công! Mã đơn hàng của bạn là " + orderID);
                session.removeAttribute("CART");
                url = SUCCESS;
            }
        } else {
            request.setAttribute("CART_MESSAGE", "Đặt hàng không thành công!");
            url = CART_ERROR;
        }
	```
- `OrderDAO`
	- Update `UPDATE_ORDER_STATUS` query
		```java
			private static final String UPDATE_ORDER_STATUS = "INSERT INTO tblOrderStatusUpdate(statusID, orderID, updateDate, modifiedBy, roleID) VALUES (?, ?, GETDATE(), ?, ?)";
		```
	- Remove old/bug/unuse functions (as all had combine in to `addOrder()` funciton):
		- `insertOrderDetail()`
		- `insertOrder()`
	- Add new `addOrder()` function to replace the old 2 bug functions
		```java
			public boolean addOrder(OrderDTO order, String userID, List<CartProduct> cart) throws SQLException {
	        boolean check = false;
	        Connection conn = null;
	        PreparedStatement ptm = null;
	        ResultSet rs = null;

	        try {
	            conn = DBUtils.getConnection();
	            conn.setAutoCommit(false);
	            // insert Order
	            ptm = conn.prepareStatement(INSERT_ORDER);
	            ptm.setDate(1, Date.valueOf(LocalDate.now()));
	            ptm.setInt(2, order.getTotal());
	            ptm.setString(3, userID);
	            ptm.setString(4, order.getPayType());
	            ptm.setString(5, order.getFullName());
	            ptm.setString(6, order.getAddress());
	            ptm.setString(7, order.getPhone());
	            ptm.setString(8, order.getEmail());
	            ptm.setString(9, order.getNote());
	            check = ptm.executeUpdate() > 0;
	            if (check) {
	                // get new orderID
	                ptm = conn.prepareStatement(GET_ORDER_ID);
	                ptm.setString(1, userID);
	                rs = ptm.executeQuery();
	                if (rs.next()) {
	                    int orderID = rs.getInt("orderID");
	                    boolean orderDetailCheck = true;
	                    // insert orderDetail
	                    for (CartProduct item : cart) {
	                        ptm = conn.prepareStatement(INSERT_ORDER_DETAIL);
	                        ptm.setInt(1, item.getPrice());
	                        ptm.setInt(2, item.getQuantity());
	                        ptm.setString(3, item.getSize());
	                        ptm.setString(4, item.getColor());
	                        ptm.setInt(5, orderID);
	                        ptm.setInt(6, item.getProductID());
	                        orderDetailCheck = orderDetailCheck && ptm.executeUpdate() > 0;
	                        if (!orderDetailCheck) {
	                            throw new SQLException("Fail to insert orderDetail");// use throw exception cause i don't know if break; can catch exception to do rollback();
	                        }
	                    }
	                    // update orderStatus
	                    if (orderDetailCheck) {
	                        ptm = conn.prepareStatement(UPDATE_ORDER_STATUS);
	                        ptm.setInt(1, 1); // set statusID = 1 as new order always come with status = 1
	                        ptm.setInt(2, orderID);
	                        ptm.setString(3, "System");
	                        ptm.setString(4, "");
	                        check = ptm.executeUpdate() > 0;
	                    }

	                }

	            }
	            // check if insert successfully
	            if (check) {
	                conn.commit();
	            } else {
	                throw new SQLException("Fail to insert order");
	            }

	        } catch (ClassNotFoundException | SQLException e) {
	            e.printStackTrace();
	            try {
	                if (conn != null) {
	                    conn.rollback();
	                }
	            } catch (Exception e2) {
	                e2.printStackTrace();
	            }

	        } finally {
	            if (rs != null) {
	                rs.close();
	            }
	            if (ptm != null) {
	                ptm.close();
	            }
	            if (conn != null) {
	                conn.close();
	            }
	        }

	        return check;
	    }
		```
	- Update `updateOrderStatus()` function
		- Add in more param to take
			```java
				public boolean updateOrderStatus(int orderID, int statusID, String modifiedBy, String role) throws SQLException {
					(...)
					ptm.setString(3, modifiedBy);
                	ptm.setString(4, role);
					(...)
				}
			```
- `UpdateOrderController`
	- Add session and userDTO to adapt to the new `updateOrderStatus()` function
		```java
			HttpSession session = request.getSession();
			UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
		```
	- Update `updateOrderStatus()` function
		```java
			boolean check = dao.updateOrderStatus(orderID, statusID, user.getUserID(), user.getRoleID()) && dao.updateOrderTrackingID(orderID, trackingID);   
		```

## Discovered BUG
- `OrderDAO`
	- Even if there is a rollback for addProduct, the identity won't get reset even when a rollback happens
	- Possible fix: I don't know, going to google it later
- `CheckoutController`
	- When there's a rollback, the product quantity does not get revert and still got decreases from DB
	- Possible fix: change the Decrease product function into 1 function in DAO?

