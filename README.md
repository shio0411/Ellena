# Release summary Checkout warning message, fix category page and Update OrderDTO,OrderDAO
***Changes since last push from 24/6/2022 3:10 PM***

***Release date: 25/6/2022 1:04 AM***

## Add in Files:
- `OrderError`

## Change in Files:
- `CheckoutController`
	- Delete comment
	- Change `ERROR` to `INPUT_ERROR`
	- Add in check fullName, calc_shipping_district, address, phone, email
- Category.jsp
	- remove `.jpg` to display image properly
- `OrderDTO`
	- Add comments
	- Add in transactionNumber and redo all contructor and getter/setter
- Checkout.jsp
	- Add OrderError messages
- `OrderDAO`
	- Add rollback to 3 funcitons: `insertOrder(), insertOrderDetail(), updateOrderStatus()`
	- Add comment about BUG

## Discovered BUG:
- In `CheckoutController`
	```java
		odao.insertOrderDetail(orderID, cart);
        odao.updateOrderStatus(orderID, 1); // update mean insert into tblOrderStatusUpdate
	```
	The code is meant to insert orderStatusUpdate so manager and employee to manage order's status but the `getUpdateStatusHistory()` function in `OrderDAO` have problem
	```java
		List<OrderStatusDTO> list = getUpdateStatusHistory(orderID);
            int currentStatusID = list.get(list.size() - 1).getStatusID();// got ArrayIndexOutOfBoundsException for new product add in with no previous history so list = 0 and can't -1
            if (currentStatusID != statusID) {
                conn = DBUtils.getConnection();
                conn.setAutoCommit(false);
                    ptm = conn.prepareStatement(UPDATE_ORDER_STATUS);
                    ptm.setInt(1, statusID);
                    ptm.setInt(2, orderID);

                    check = ptm.executeUpdate() > 0;
                conn.commit();
	```
	The problem is the newly added product hasn't had any history so the return list is 0 and (0 - 1) will cause `ArrayIndexOutOfBoundsException`. So the insert to orderStatusUpdate does not happen but the insert to Order and OrderDetail still happen
- Suggest possible fixes:
	- Add in a if condition to avoid `ArrayIndexOutOfBoundsException`
	- Do like Mẫn: Combine all 3 queries into 1 function so the insert can rollback if a problem happens