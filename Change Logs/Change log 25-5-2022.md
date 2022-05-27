
# Release Summary #1

***Changes since last pull from 23/05/2022***
***Release date: 25/5/2022***
***Note: Still using the old DB since 23/05/2022***

## New files:
- manager-order.jsp
- `ManagerShowProductController`
- `ActivateProductController`
- `DeactivateProductController`
- `ManagerSearchProductController`

## Changes in code:

 - **manager-product.jsp (main focus in this release)**
   	- Add role fillter
   	- Add display product list with pagination `(ManagerShowProductController)`
   	- Add display search product list with pagination `(ManagerSearchProductController)`
   	- Add `pageNav`
   	- Add pop up for successful status update

 - **manager-statistic.jsp**
	- Change `sideNav` 

 - **LoginController**
	- Change `MANAGER_PAGE="manager.jsp"` to `MANAGER_PAGE="ManagerShowProductController"`

 - **ProductDAO (main focus in this release)**
	 - Add Query Strings.
	 - Add functions :
	     - `getAllProduct` (for ManagerShowProductController)
	     - `getListProduct` (for ManagerSearchProductController)
	     - `activateProduct` (for ActivateProductController)
	     - `deactivateProduct` (for DeactivateProductController)

 - **ProductDTO**
	- `productID` change from `String` to `int`

 - **MainController**
     - Add in `ActivateProductController` and `DeactivateProductController`
     - Add in `ManagerSearchProductController`

## Discovered possible issues:

 1. `ActivateAccountController` and `DeactivateAccountController` both
    return to `ShowAccountController` (show all Account) even if the admin
    currently in `SearchAccountController` (admin.jsp page)
    
 2. `ActivateProductController` and `DeactivateProductController` both
    return to `ManagerShowProductController` (show all Product) even if the
    manager currently in `ManagerSearchProductController` (manager-product.jsp
    page).


## Note for later version:
- Change table to `productID, productName, categoryName, status` 
    - Change table name/value (manager-product.jsp)
    - Change "Sắp xếp theo" name/value (manager-product.jsp)
    - Change ProductDAO: 
        - Join `tblProduct` with `tblCategory`
        - Fix Select Query 
- Update to new DB version
- Check Insert/Edit Product functions






