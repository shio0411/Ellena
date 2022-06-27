# Release summary Manually merge Forgot password function
***Changes since last push from 27/6/2022 4:38 PM***

***Release date: 27/6/2022 10:14 PM***

## Add in Files:
- `ForgotPasswordController`
- `ValidateOtpController`
- `ResetPasswordController`
- `JavaMailUtils`
- reset-password.jsp
- validate-otp.jsp
- forgot-password.jsp
- activation-1.1.1.jar
- javax.mail.jar

## Change in Files:
- **login.jsp**
    - Add "Quên mật khẩu" link (form)
- **`MainController`**
    - Add `FORGOT_PASSWORD` and `FORGOT_PASSWORD_CONTROLLER`
    - Add in `VALIDATE_OTP` and `VALIDATE_OTP_CONTROLLER`
    - Add in `RESET_PASSWORD` and `RESET_PASSWORD_CONTROLLER`
- **`AuthenFilter`**
	- Add in non login user pages and controllers
	```java
		(
			(...)
			|| uri.contains("forgot-password.jsp") || uri.contains("ForgotPasswordController") || uri.contains("validate-otp.jsp") || uri.contains("ValidateOtpController")
			|| uri.contains("reset-password.jsp") || uri.contains("ResetPasswordController") || uri.contains("LogoutController")
		) (...)
	```

