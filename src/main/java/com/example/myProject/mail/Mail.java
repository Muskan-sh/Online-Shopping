package com.example.myProject.mail;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

/**
 * <b>I don't know whether a single session can send multiple mails if it cannot instead of creating static blocks use constructor and instead of static function use methods</b>
 */
public class Mail {
    static Session session;
    static String sender = "";//your mail address
    static String password = "";//password

    static {
        Properties props = System.getProperties();
        props.put("mail.smtp.host", "smtp.gmail.com"); //SMTP Host
        props.put("mail.smtp.port", "587"); //TLS Port
        props.put("mail.smtp.auth", "true"); //enable authentication
        props.put("mail.smtp.starttls.enable", "true"); //enable STARTTLS
        Authenticator auth = new Authenticator() {
            //override the getPasswordAuthentication method
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(sender, password);
            }
        };
        session = Session.getInstance(props, auth);

    }

    /**
     * It don't uses multithreading currently you can use it for fast performance <br/>
     * <b> @return <i>true</i> when mail is sent successfully else returns false </b>
     */
    public static boolean sendMail(String recipient, String otp) {
        MimeMessage message = new MimeMessage(session);
        try {
            message.setFrom(new InternetAddress(sender));

            // Set To Field: adding recipient's email to from field.
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(recipient));

            // Set Subject: subject of the email
            message.setSubject("OTP validation");

            //set your content here
            message.setContent("", "text/html");
            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }
}
