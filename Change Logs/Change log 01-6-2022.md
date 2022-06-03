

# Release Summary #4
***Changes since last push from 29/05/2022***

***Release date: 1/6/2022***

***Note: Using the new DB (1/6/2022)***

## Milestones
- [x] Add Rating in productDTO and productError
- [x] Update DB and add discount field
- [x] Remove importDate
- [ ] Check Insert/Edit Product functions
    - [ ] Change ProductDAO : (implement in insert/Edit function)
        - [x] Show product basic detail (productName, categoryID, lowStockLimit, price, discount, status, description)
        - [x] Edit/Update basic product infomation (productName, categoryID, lowStockLimit, price, discount, status, description)
            - [x] Add constraint (ProductError)
        - [x] Show all image for that productID
        - [ ] Show product images with color restraint (in debate)
        - [ ] Show product detail list with pagination (in debate)

## New files:
- manager-product-detail.jsp
- `ManagerShowProductDetailController`
- `ManagerUpdateProductController`
- `ProductError`


## Changes in code:
- **manager-product.jsp**
    - Delete `int id = 1;`
    - Change 
        ```
            <button type="button" data-toggle="modal" data-target="#myModal<%=id++%>">Chỉnh sửa</button>
        ```
        to
        ```
            <button type="button" onclick="document.location='ManagerShowProductDetailController?productID=<%=list.getProductID()%>'">Chỉnh sửa</button>
        ```
    - Swap table column: `Tên sản phẩm` with `ID sản phẩm`

- **ProductDAO**
    - Add `SHOW_PRODUCT` query and `getProduct` function
    - Add `UPDATE_PRODUCT` query and `updateProduct` function
    - Add `SEARCH_PRODUCT_IMAGE` query and `getListImage` function
    - Fix `getAllProduct`,`getListProduct` as 2 new fields was added to DTO

- **MainController**
    - Add `ManagerUpdateProductController` 

- **ProductDTO**
    - Change `importDate` to `rating`
    - Add `discount`



## Discovered possible issues:
 1.  

## Note for later version:
- [ ] Check Insert/Edit Product functions
    - [ ] Change ProductDAO : (implement in insert/Edit function)
        - [ ] Show product images with color restraint (in debate)
        - [ ] Show product detail list with pagination (in debate)
- [ ] Change `OrderBy` to `productPerPage` option 
- [ ] Decorate pageNav with shop.html (later)
- [ ] Select image to go to EditProductDetail  (maybe not)
    - [ ] Slideshow if lot of images

## Note considering for later version:
- Try not to add to many field in searchBar
- possible remove ShowController?
    - Split search function in DAO into 2 : Search status true/false and search status "ALL"


