

# Release Summary #5
***Changes since last push from 3/6/2022***

***Release date: 6/6/2022 1:33AM***

***Note: Using the new DB (3/6/2022)***

## Milestones
- [x] Update pageNav

## New files:
- javax.mail.jar
- forgot-password.jsp
- `ForgotPasswordController`
- `JavaMailUtils`


## Changes in code:
- **`ManagerShowProductController`**
    - Temporarily change `int productPerPage = 3;` for testing pageNav

- **manager-product.jsp**
    - Add 
    ```
        int noOfPageLinks = 5; // amount of page links to be displayed
        int minLinkRange = noOfPageLinks/2; // minimum link range ahead/behind
    ```
    for calculating the begin and end of pageNav for loop
    - Add "Calculating the begin and end of pageNav for loop"
    - Fix pageNav display

- **login.jsp**
    - Add "Quên mật khẩu" link (form)

- **`MainController`**
    - Add `FORGOT_PASSWORD` and `FORGOT_PASSWORD_CONTROLLER`


## Discovered possible issues:
 1.  

## Note for later version:
- [ ] Change `OrderBy` to `productPerPage` option 
- [ ] Decorate pageNav with shop.html (later)
- [ ] Continue `ForgotPassword` function
    - [ ] Continue debug from `Message message = new MimeMessage(session);` as home PC fail to sent mail
    - [ ] Create validate-otp.jsp page
    - [ ] Add to UserDAO a query for update password
    - [ ] Create a change-password.jsp with some secure feature (check if user enter correct OTP)


## Note considering for later version:
- Try not to add to many field in searchBar
- possible remove ShowController?
    - Split search function in DAO into 2 : Search status true/false and search status "ALL"
- Don't show dashboard
- [Ternary conditional operators into if-else statements](https://converter.website-dev.eu/)

