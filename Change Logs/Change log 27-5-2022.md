

# Release Summary #2

***Changes since last push from 26/05/2022***
***Release date: 27/5/2022***
***Note: Using the new DB (26/5/2022)***

## Last change log milestone
- [x] Change table to `productID, productName, categoryName, status` 
    - [x] Change table name/value (manager-product.jsp)
    - [x] Change "Sắp xếp theo" name/value (manager-product.jsp)
    - [x] Change ProductDAO: 
        - [x] Join `tblProduct` with `tblCategory`
        - [x] Fix Select Query 
- [x] Update to new DB version (26/5/2022)
- [ ] Check Insert/Edit Product functions

## New files:
- 

## Changes in code:
- **manager-product.jsp**
	- Change in "Sắp xếp theo" drop-down menu:
		- From ``` <option value="categoryID">ID danh mục</option> ``` to ```<option value="categoryName">Loại sản phẩm</option>```
		- Remove the `required=""` in `<select name="orderBy">`
	- Change table naming from "ID danh mục" to "Loại sản phẩm"
	- Change the URL Rewriting in `SearchController` `pageNav` : move the page numbering to the end of the link (Previous link, numbers links, Next link)

- **ProductDTO**
	- Add `private String categoryName;`
	- Add `private int lowStockLimit`

- **ProductDAO**
	- Fix `getAllProduct` and `getListProduct` list because of the `ProductDTO` change
	- Change SQL Query from selecting `categoryID` to `categoryName`

- **ManagerSearchProductController**
	- Remove unused import

## Discovered possible issues:
 1. 

## Note for later version:
- [ ] Check Insert/Edit Product functions
- [ ] Test new way to pagination
- [ ] Test to see if possible to remove the Show....Controllers 
- [ ] Keep testing the search function to see if fixing  search function using Khánh's category DAO example is needed?






