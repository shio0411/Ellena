# Release summary Manager product/order pagination and Employee order pagination
***Changes since last push from 17/7/2022 1:13 PM***

***Release date: 15/7/2022 5:42 PM***

## Add in Files:
- 

## Change in Files:
- Admin account pagination
	- admin.jsp
		- Fix pageNav calculating
- Manager product pagination
	- manager-product.jsp
		- Add back in pop-up modal
		- Reconfig for pagination pageNav
	- `ManagerShowProductController`
		- Reconfig for pagination
	- `ManagerSearchProductController`
		- Reconfig for pagination
	- `ProductDAO`
		- Reconfig for pagination
- Manager/Employee order paginaiton
	- manager-order.jsp
		- Reconfig for pagination pageNav
	- employee-order.jsp
		- Reconfig for pagination pageNav
	- `ShowOrderController`
		- Reconfig for pagination
	- `SearchOrderController`
		- Reconfig for pagination
	- `OrderDAO`
		- Reconfig for pagination


- `AuthenFilter`
	- Allow Manager to access ManagerSearchProductController directly

