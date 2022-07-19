# Release summary discover,search-catalog pagination and update PageNav code
***Changes since last push from 19/7/2022 4:14 PM***

***Release date: 20/7/2022 1:00 AM***

## Add in Files:
- 

## Change in Files:
- Admin account pagination
	- admin.jsp
		- Fix pageNav calculating
- Manager product pagination
	- manager-product.jsp
		- Fix pageNav calculating
- Manager/Employee order paginaiton
	- manager-order.jsp
		- Fix pageNav calculating
	- employee-order.jsp
		- Fix pageNav calculating
- Guest/Customer product paginaiton
	- discover.jsp
		- Reconfig for pagination pageNav
	- search-catalog.jsp
		- Reconfig for pagination pageNav
	- `DiscoverController`
		- Reconfig for pagination
	- `FilterAllProductsController`
		- Reconfig for pagination
	- `SearchCatalogController`
		- Reconfig for pagination
	- `FilterSearchedProductsController`
		- Reconfig for pagination
	- `ProductDAO`
		- Reconfig for pagination
- `AuthenFilter`
	- Allow Guest/Customer direct access to :
		- `FilterAllProductsController`
		- `SearchCatalogController`
		- `FilterSearchedProductsController`

