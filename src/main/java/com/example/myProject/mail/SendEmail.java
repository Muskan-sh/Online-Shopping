package com.example.myProject.mail;


import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import java.util.Properties;
import java.util.Random;

/**
 * <b>I don't know whether a single session can send multiple mails if it cannot instead of creating static blocks use
 * constructor and instead of static function use methods</b>
 */
public class SendEmail {
    static Session session;
    static String sender = "shopherewebsite@gmail.com";//your mail address
    static String password = "shophere123";//password

    public SendEmail() {
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

    //generate vrification code
    public String getOTP() {
        Random rnd = new Random();
        int number = rnd.nextInt(999999);
        return String.format("%06d", number);
    }

    /**
     * It don't uses multithreading currently you can use it for fast performance <br/>
     * <b> @return <i>true</i> when mail is sent successfully else returns false </b>
     */
    public boolean sendEmail(String name,String email,String otp,String msgContent,String subject) {

        // Create a default MimeMessage object.
        MimeMessage message = new MimeMessage(session);

        // This mail has 2 part, the BODY and the embedded image
        MimeMultipart multipart = new MimeMultipart("related");
        try {
            // Set From: header field of the header.
            message.setFrom(new InternetAddress(sender));

            // Set To Field: adding recipient's email to from field.
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));

            // Set Subject: subject of the email
            message.setSubject(subject);

            // first part (the html)
            BodyPart messageBodyPart = new MimeBodyPart();
            messageBodyPart.setContent(msgContent, "text/html");

            // add it
            multipart.addBodyPart(messageBodyPart);

            // second part (the image)
            messageBodyPart = new MimeBodyPart();

            DataSource fds = new FileDataSource("C:\\Users\\reach\\Desktop\\Online-Shopping\\src\\main\\webapp\\img\\myLogo.png");

            messageBodyPart.setDataHandler(new DataHandler(fds));
            messageBodyPart.setHeader("Content-ID", "<image>");

            // add image to the multipart
            multipart.addBodyPart(messageBodyPart);

            // put everything together
            message.setContent(multipart);

            // Send message
            Transport.send(message);

            return true;

        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }
}




