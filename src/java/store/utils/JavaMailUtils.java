/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package store.utils;

import java.util.Properties;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

        
        
/**
 *
 * @author Jason 2.0
 */
public class JavaMailUtils {
//    ---------------------------Email account---------------------------------------

    public static final String EMAIL_ACCOUNT = "tongductrung2017@gmail.com"; // NOTE : THIS IS MY ACCOUNT FOR TESTING, PLEASE DO NOT MESS WITH IT!!!
    public static final String EMAIL_PASSWORD = "crwgapvouhwaovvu";
//    ------------------------------------------------------------------------------------
    private static int otpOut = 0;
    
    public static final String FORGOT_PASSWORD_OTP = "ForgotPasswordOTP";

    public static void sendMail(String recepient, String mailType) throws Exception {
        System.out.println("Preparing to send email");
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", true);
        properties.put("mail.smtp.starttls.enable", true);
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");

        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            public PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL_ACCOUNT, EMAIL_PASSWORD);
            }

        });

        switch (mailType) {
            case FORGOT_PASSWORD_OTP:
                Message message = forgotPasswordOTP(session, EMAIL_ACCOUNT, recepient);
                Transport.send(message);
                System.out.println("Message sent successfully");
                break;

            default:
                System.out.println("ERROR, no mail was sent!!");
        }

    }
    
    public static int getOtpValue(){
        return otpOut;
    }

    private static Message forgotPasswordOTP(Session session, String myAccountEmail, String recepient) {
        try {
//            Random number for OTP validation
            Random rand = new Random();
            int otpValue = rand.nextInt(1255650);
            otpOut = otpValue;
            
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(myAccountEmail));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(recepient));
            message.setSubject("Reset password OTP");
            message.setText("Dear User, \n Your OTP code for reseting your password is: "+ otpValue);
            return message;
        } catch (MessagingException ex) {
            Logger.getLogger(JavaMailUtils.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

}
