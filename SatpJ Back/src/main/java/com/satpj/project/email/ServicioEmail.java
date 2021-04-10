package com.satpj.project.email;

import lombok.Getter;
import lombok.Setter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Servicio de la entidad Acudiente Permite que se puedan acceder a todos los
 * servicios asociados al Acudiente de forma REST
 */
@Getter
@Setter
@EnableAutoConfiguration(exclude= SecurityAutoConfiguration.class)
@RestController
@RequestMapping("email")
public class ServicioEmail{

    @Autowired
    private EmailServiceImpl emailSender;

    @GetMapping(produces = "application/json")
    public void findAll() {
        emailSender.sendEmail("", "", "");
    }
   
}