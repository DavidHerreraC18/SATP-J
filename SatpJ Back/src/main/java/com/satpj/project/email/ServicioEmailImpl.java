package com.satpj.project.email;

import java.nio.charset.StandardCharsets;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;
import org.thymeleaf.context.Context;
import org.thymeleaf.spring5.SpringTemplateEngine;

@Component
public class ServicioEmailImpl {

    @Autowired
    private JavaMailSender emailSender;

    @Autowired
    private SpringTemplateEngine templateEngine;

    @Value("classpath:templates/images/costos.png")
    Resource resourceFile;

    public void sendEmail(String para, String asunto, Map<String, Object> texto, boolean adjunto, String template) {
        if (!adjunto)
            enviarMensajeSimple(para, asunto, template, texto);
        else
            enviarMensajeConAdjunto(para, asunto, template, texto);

    }

    public void enviarMensajeSimple(String to, String subject, String template, Map<String, Object> text) {

        MimeMessage message = emailSender.createMimeMessage();

        try {

            MimeMessageHelper helper = new MimeMessageHelper(message, MimeMessageHelper.MULTIPART_MODE_MIXED_RELATED,
                    StandardCharsets.UTF_8.name());

            helper.setTo(to);
            helper.setSubject(subject);
            helper.setText(DefinirTemplateEmail(template, text), true);

            if(template.contains("registro")){
                helper.addInline("costos.png", resourceFile);
            }

            emailSender.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        }

    }

    public void enviarMensajeConAdjunto(String to, String subject, String template, Map<String, Object> text) {

        MimeMessage message = emailSender.createMimeMessage();

        try {

            MimeMessageHelper helper = new MimeMessageHelper(message, true, StandardCharsets.UTF_8.name());

            helper.addAttachment("costos-sesiones.png", new ClassPathResource("/templates/images/costos.png"));

            helper.setTo(to);
            helper.setSubject(subject);
            helper.setText(DefinirTemplateEmail(template, text), true);
            helper.addInline("costos.png", resourceFile);
        
            emailSender.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        } 

    }

    public String DefinirTemplateEmail(String template, Map<String, Object> text) {

        String html = "";
        Context context = new Context();
        context.setVariables(text);

        switch (template) {
            case "regitro_adulto":
                html = templateEngine.process("/registro_pacientes/registro_adulto_email", context);
                break;
            case "registro_menor":
                html = templateEngine.process("/registro_pacientes/registro_adulto_email", context);
                break;
            case "registro_pareja":
                html = templateEngine.process("/registro_pacientes/registro_adulto_email", context);
                break;
            case "cita_presencial":
                html = templateEngine.process("/citas_pacientes/cita_presencial_email", context);
                break;
            case "cita_virtual":
                html = templateEngine.process("/citas_pacientes/cita_virtual_email", context);
                break;
            default:
                html = templateEngine.process("/registro_pacientes/registro_adulto_email", context);
                break;
        }

        return html;

    }
}
