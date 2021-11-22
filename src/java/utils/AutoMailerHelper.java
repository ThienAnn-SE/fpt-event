/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import dtos.EventDTO;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author thien
 */
public class AutoMailerHelper {

    //sending email and password
    private final String FROM_MAIL = "automailer.fptevent@gmail.com";
    private final String PASSWORD = "Lethienan952001";
    //templates path
    private final String ACCOUNT_REGISTRATION_TEMPLATE = "D:\\NetBeans 8.2\\Project\\fpt-event\\web\\templates\\newAccountRegistation.html";
    private final String EVENT_REGISTRATION_TEMPLATE = "./web/templates/NewAccountRegistration.hmtl";
    private final String EVENT_CANCEL_TEMPLATE = "./web/templates/NewAccountRegistration.hmtl";

    private void sendMail(String subject, String content, String toEmail) throws AddressException, MessagingException {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com"); //SMTP Host
        props.put("mail.smtp.port", "587"); //TLS Port
        props.put("mail.smtp.auth", "true"); //enable authentication
        props.put("mail.smtp.starttls.enable", "true"); //enable STARTTLS
        Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_MAIL, PASSWORD);
            }
        });
        MimeMessage message = new MimeMessage(session);
        message.setFrom(new InternetAddress(FROM_MAIL));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail, false));
        message.setSubject(subject);
        String htmlContent = content;
        message.setContent(htmlContent, "text/html");
        Transport.send(message);
    }

    public void sendAccountRegistrationMail(String userEmail) throws MessagingException {
        String content = FileHelper.readHTMLFile(ACCOUNT_REGISTRATION_TEMPLATE);
        content = java.text.MessageFormat.format(content, userEmail);
        sendMail("Welcome to FPT Event", content, userEmail);
    }

    public void sendEventRegistrationMail(String userEmail, EventDTO event) {
        
    }
    
    public void sendEventCancelMail(String userEmail){
        
    }

}
