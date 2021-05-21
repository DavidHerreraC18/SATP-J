package com.satpj.project.email;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ServicioEmail{

    @Autowired
    private ServicioEmailImpl emailSender;
    

    @RequestMapping("/")
    @GetMapping(produces = "application/json")
    public void findAll() {
      Map<String, Object> model = new HashMap<String, Object>();
      model.put("nombre", "Julia Morales");
      model.put("fecha", "20/04/2021");
      model.put("hora", "9:00 a.m.");
      model.put("practicante", "Pepito Gómez");
      Map<String, Object> registro = new HashMap<String, Object>();
      registro.put("correo", "geralidine.gomez@javeriana.edu.co");
      registro.put("contrasena", "12345667");
      emailSender.sendEmail("geralidine.gomez@javeriana.edu.co", "Consultores en Psicología", registro, false, "registro_adulto");
      emailSender.sendEmail("geralidine.gomez@javeriana.edu.co", "Consultores en Psicología", model, false, "cita_presencial");
    }

    @Bean
    public SimpleMailMessage templateSimpleMessage() {
    SimpleMailMessage message = new SimpleMailMessage();
    message.setText(
      "This is the test email template for your email:\n%s\n");
    return message;
}
   
}