

# Release Summary #5.0.1
***Changes since last push from 6/6/2022***

***Release date: 7/6/2022 7:55AM***

***Note: Using the new DB (3/6/2022)***

## Milestones
- [x] Continue debug from `Message message = new MimeMessage(session);` as home PC fail to sent mail

## New files:
- activation-1.1.1.jar


## Changes in code:
- 


## Discovered possible issues:
 1.  

## Note for later version:
- [ ] Change `OrderBy` to `productPerPage` option 
- [ ] Decorate pageNav with shop.html (later)
- [ ] Continue `ForgotPassword` function:
    - [ ] Check/confirmation for ways to push `OTP_CHECK` and `USER_ID` to request 
    - [ ] Create validate-otp.jsp page
    - [ ] Add to UserDAO a query for update password
    - [ ] Create a change-password.jsp with some secure feature (check if user enter correct OTP)


## Note considering for later version:
- Try not to add to many field in searchBar
- possible remove ShowController?
    - Split search function in DAO into 2 : Search status true/false and search status "ALL"
- Don't show dashboard
- [Ternary conditional operators into if-else statements](https://converter.website-dev.eu/)

