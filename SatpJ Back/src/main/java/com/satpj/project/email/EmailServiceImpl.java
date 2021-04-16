package com.satpj.project.email;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
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
}


