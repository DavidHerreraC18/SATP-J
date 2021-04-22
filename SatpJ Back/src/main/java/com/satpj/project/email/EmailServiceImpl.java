package com.satpj.project.email;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

@Component
public class EmailServiceImpl{

    @Autowired
    private JavaMailSender emailSender;

    public void sendEmail(String to, String subject, String text) {
         sendEmailTool("Hola","avocadoenterprise@gmail.com", "pruebita de la murision");
        
    }

    private boolean sendEmailTool(String textMessage, String email,String subject) {
		
        SimpleMailMessage message = new SimpleMailMessage(); 	
		boolean send = false;
     
			message.setTo(email); 
			message.setSubject(subject); 
			message.setText(textMessage);
			emailSender.send(message);
			send = true;
		
		
        return send;
	}
    
    public void sendMessageWithAttachment(String to, String subject, String text, String pathToAttachment) {
            
        MimeMessage message = emailSender.createMimeMessage();
         
        MimeMessageHelper helper;
        try {
            helper = new MimeMessageHelper(message, true);
            helper.setTo(to);
            helper.setSubject(subject);
            helper.setText(text);
            
        FileSystemResource file 
          = new FileSystemResource(new File(pathToAttachment));
        helper.addAttachment("Invoice", file);
    
        emailSender.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        }

    }

    public String leerTemplateEmail(){
        
        File file = new File("./templates/email_preaprobacion.docx");
        String line = "";
        try {
            Scanner scanner = new Scanner(file);
            while (scanner.hasNextLine()) {
                line += scanner.nextLine();
                System.out.println(line);
            }
            scanner.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
       
        return line;
      
    }
}


