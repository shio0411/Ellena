

# Release Summary #6
***Changes since last push from 7/6/2022***

***Release date: 9/6/2022 10:542PM***

***Note: Using the new DB (3/6/2022)***

## Milestones
- [x] Decorate pageNav with shop.html (later)
- [x] Continue `ForgotPassword` function:
    - [x] Check/confirmation for ways to push `OTP_CHECK` and `USER_ID` to session 
    - [x] Create validate-otp.jsp page
    - [x] Use the change password function in UserDAO
    - [x] Create a reset-password.jsp with some secure feature 
        - [x] limited attemps (prevent brute-force)
        - [x] can't change password if session is null

## New files:
- validate-otp.jsp
- `ValidateOtpController`
- reset-password.jsp
- `ResetPasswordController`


## Changes in code:
- **forgot-password.jsp**
    - Change page title

- **ForgotPasswordController**
    - Change from request scope to session
        ```
            session.setAttribute("USER_ID", userID);
            session.setAttribute("OTP_EXPECTED", JavaMailUtils.getOtpValue());
        ```
    - Delete excess line `url = ERROR;`
    - Add 
        ```
            session.setAttribute("OTP_CHECK", false);
            session.setAttribute("INPUT_ATTEMPS", 3);
        ```
    - Change from public to private 
        ```
            private static final String ERROR = "forgot-password.jsp";
            private static final String SUCCESS = "validate-otp.jsp";
        ```

- **MainController**
    - Add in `VALIDATE_OTP` and `VALIDATE_OTP_CONTROLLER`
    - Add in `RESET_PASSWORD` and `RESET_PASSWORD_CONTROLLER`

- **SQLforEllenaShop.sql**
    - Update to new DB (3/6/2022)

## Discovered possible issues:
 1. `my-profile.jsp` gave the admin pageNav even when user is not admin role.

## Note for later version:
- [ ] Change `OrderBy` to `productPerPage` option 



## Note considering for later version:
- Try not to add to many field in searchBar
- possible remove ShowController?
    - Split search function in DAO into 2 : Search status true/false and search status "ALL"
- Don't show dashboard
- [Ternary conditional operators into if-else statements](https://converter.website-dev.eu/)

