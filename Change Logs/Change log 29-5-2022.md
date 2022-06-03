

# Release Summary #3
***Changes since last push from 27/05/2022***

***Release date: 29/5/2022***

***Note: Using the new DB (28/5/2022)***

## Milestones
- [x] Test new way to pagination
- [x] Test to see if possible to remove the Show....Controllers 
	- [x] No
- [x] Keep testing the search function to see if fixing search function using Khánh's category DAO example is needed?
	- [x] Yes we need it!!
	- [x] Use `removeAccent` in `VNCharacterUtils` from khanh's

## New files:
- 

## Changes in code(Ellena_Main):
- **`ManagerSearchProductController`**
	1. Move 
		```
			//give manager-product.jsp know that we are in SearchProduct
            boolean searchPage = false;
            request.setAttribute("SWITCH_SEARCH", searchPage);
		```
		outside the if statement to prevent null exception when no product was found
	2. Add 
		```
			request.setAttribute("noOfPages", 1);
            request.setAttribute("currentPage", 1);
		```
		outside the if statement to prevent null exception when no product was found
	3. Add and change `int noOfPage = 1;` outside the try/catch to prevent no product was found and can't set the attribute
	4. Add `import store.utils.VNCharacterUtils;` for using `removeAccent` in searching "name"


- **manager-product.jsp**
	- Add
		```
			if (listProduct!=null) { //if no product in list, page nav won't display
				//...pageNav code
            }//end of the "No product" if statement
		```
		to prevent pageNav from displaying if there is no product in the list

- **`ProductDAO`**
	- Change `SEARCH_PRODUCT_PAGINATION` Query
		```
			WHERE productName LIKE ? AND A.status=? 
		```
		to
		```
			WHERE dbo.fuChuyenCoDauThanhKhongDau(productName) LIKE ? AND A.status=? 
		```
		to implement Khanh's function


## Discovered possible issues:
 1. The "Sắp xếp theo" option is not working. As the `Order by` cannot use with bind variable (`ptm.setString(1, orderBy);`) as it will result in
 	```
 		... (ORDER BY 'categoryName' ASC) ...
 	```
 	and the Query will return an error (even though it still displays as search all).
 	[Discover Error](https://stackoverflow.com/questions/19029859/sorted-result-set-from-db-not-apprearring-in-order-while-printed-in-java)
 	Possible solution: insert straight in the Query String before execute
 	[Solution referance](https://www.geeksforgeeks.org/insert-a-string-into-another-string-in-java/)
***NOTE: The "Sắp xếp theo" option no longer will be in the final release as it will be changed to an option to choose a number of products per page. But the issue will be noted for others' functions if the same issue happens again.***
 

## Note for later version:
- [ ] Check Insert/Edit Product functions
	- [ ] Change ProductDAO : (implement in insert/Edit function)
		- [ ] Join tables : `tblProduct, tblProductDetail, tblProductImage, tblCategory`
		[join multiple tables](https://www.w3schools.com/sql/sql_join_inner.asp)
		- [ ] SELECT all fields in `tblProduct, tblProductDetail, tblProductImage, tblCategory`
		- [ ]  Fix `getAllProduct` and `getListProduct` to make list store all the fields
- [ ] OrderBy is fucking different!!! 
- [ ] Change `OrderBy` to `productPerPage` option 
- [ ] Decorate pageNav with shop.html (later)





