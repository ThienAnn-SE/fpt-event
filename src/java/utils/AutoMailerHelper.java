/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import dtos.EventDTO;
import dtos.EventRegisterDTO;
import java.util.ArrayList;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;

/**
 *
 * @author thien
 */
public class AutoMailerHelper {

    //sending email and password
    private final String FROM_MAIL = "automailer.fptevent@gmail.com";
    private final String PASSWORD = "Lethienan952001";
    //templates path
    private final String ACCOUNT_REGISTRATION_TEMPLATE = "D:\\NetBeans 8.2\\Project\\fpt-event\\web\\templates\\newAccRegistation.html";
    private final String EVENT_NOTIFICATION_TEMPLATE = "D:\\NetBeans 8.2\\Project\\fpt-event\\web\\templates\\eventNotification.html";
    private final String EVENT_REGISTRATION_TEMPLATE = "D:\\NetBeans 8.2\\Project\\fpt-event\\web\\templates\\regisEvent.html";

    private void sendMail(String subject, String content, String toEmail) throws AddressException, MessagingException {
        Properties props = new Properties();
        props.setProperty("mail.smtp.host", "smtp.gmail.com");
        props.setProperty("mail.smtp.port", "587");
        props.setProperty("mail.smtp.auth", "true");
        props.setProperty("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.socketFactory.port", "587");
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_MAIL, PASSWORD);
            }
        });
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_MAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail, false));
            message.setSubject(subject);
            String htmlContent = content;
            message.setContent(htmlContent, "text/html");
            Transport.send(message);
        } catch (MessagingException | RuntimeException ex) {
            System.out.println(ex.getMessage());
        }
    }

    public void sendAccountRegistrationMail(String userEmail) throws MessagingException {
        String content = FileHelper.readHTMLFile(ACCOUNT_REGISTRATION_TEMPLATE);
        content = java.text.MessageFormat.format(content, userEmail);
        sendMail("Welcome to FPT Event", content, userEmail);
    }

    public void sendEventRegistrationMail(String userEmail, String eventName) throws MessagingException {
        String content = FileHelper.readHTMLFile(EVENT_REGISTRATION_TEMPLATE);
        content = java.text.MessageFormat.format(content, userEmail, eventName);
        sendMail("Event registration confirmation", content, userEmail);

    }

    public void sendEventNotification(ArrayList<EventRegisterDTO> registerList, EventDTO event, String locationName) throws MessagingException {
        String content = FileHelper.readHTMLFile(EVENT_NOTIFICATION_TEMPLATE);
        for (int i = 0; i < registerList.size(); i++) {
            content = java.text.MessageFormat.format(content, registerList.get(i).getEmail(), event.getEventName(), event.getStartDate(), locationName);
            sendMail("FPTU Event notification", content, registerList.get(i).getEmail());
        }
    }
}
