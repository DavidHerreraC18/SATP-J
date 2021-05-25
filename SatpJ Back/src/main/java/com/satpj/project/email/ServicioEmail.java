package com.satpj.project.email;

import java.util.HashMap;
import java.util.Map;

import com.satpj.project.modelo.sesion_terapia.RepositorioSesionTerapia;
import com.satpj.project.modelo.sesion_terapia.SesionTerapia;
import com.satpj.project.modelo.usuario.RepositorioUsuario;
import com.satpj.project.modelo.usuario.Usuario;
import com.satpj.project.seguridad.CustomPrincipal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.Getter;
import lombok.Setter;
/**
 * Servicio
 * Permite el envio de correos electrónicos por medio de llamadas internas o a servicios REST 
 */
@Getter
@Setter
@EnableAutoConfiguration(exclude = SecurityAutoConfiguration.class)
@RestController
@RequestMapping("envios")
public class ServicioEmail {

  @Autowired
  private ServicioEmailImpl emailSender;

  @Autowired
  private RepositorioUsuario repositorioUsuario;

  @Autowired
  private RepositorioSesionTerapia repositorioSesionTerapia;

  /**
   * Get Request
   * Hace envio del correo con la información de una nueva sesión de terapia creada. 
   */
  @GetMapping(value = "/{idUsuario}/{idSesion}", produces = "application/json; charset=UTF-8")
  public void sendEmailSesionTerapia(@AuthenticationPrincipal CustomPrincipal customPrincipal,
      @PathVariable("idUsuario") String idUsuario, @PathVariable("idSesion") Long idSesion) {

    Usuario usuario = repositorioUsuario.findById(idUsuario).get();

    if (usuario != null) {
      SesionTerapia sesion = repositorioSesionTerapia.findById(idSesion).get();
      if (sesion != null) {
        Map<String, Object> model = new HashMap<String, Object>();
        model.put("nombre", usuario.getNombre() + " " + usuario.getDocumento());
        String aa = sesion.getFecha().getDayOfMonth() +"/"+sesion.getFecha().getMonthValue() +"/"+sesion.getFecha().getYear();
        String hh = sesion.getFecha().getHour() +":"+ sesion.getFecha().getMinute();
        model.put("fecha", aa);
        model.put("hora", hh);

        if(sesion.isVirtual()){
          model.put("modalidad", "Virtual");
          emailSender.sendEmail(usuario.getEmail(), "Consultores en Psicología", model, false, "cita_virtual");
        }
        else{
          model.put("modalidad", "Presencial");
          model.put("consultorio", sesion.getConsultorio());
          emailSender.sendEmail(usuario.getEmail(), "Consultores en Psicología", model, false, "cita_presencial");
        }
       
      }
    }
  }

  /**
   * Get Request
   * Hace envio del correo con la información de registro de un paciente, practicante o supervisor nuevo. 
   */
  @GetMapping(value = "/{id}/{tipo}", produces = "application/json; charset=UTF-8")
  public void sendEmailRegistro(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") String id,
      @PathVariable("tipo") String tipo) {

    Usuario usuario = repositorioUsuario.findById(id).orElse(null);
    if (usuario != null) {
      Map<String, Object> registro = new HashMap<String, Object>();
      registro.put("correo", usuario.getEmail());
      registro.put("contrasena", usuario.getDocumento());
      emailSender.sendEmail(usuario.getEmail(), "Consultores en Psicología", registro, false, tipo);
    }

  }

  /**
   * Get Request
   * Hace envio del correo con la información de la videollamada para compartirla con los supervisores y acudientes.
   */
  @GetMapping(value = "compartir/{supervisorId}/{practicanteId}/{tipo}/{link}", produces = "application/json; charset=UTF-8")
  public void sendEmailCompartirSesion(@AuthenticationPrincipal CustomPrincipal customPrincipal,
      @PathVariable("supervisorId") String supervisorId, @PathVariable("practicanteId") String practicanteId,
      @PathVariable("link") String link,
      @PathVariable("tipo") String tipo) {

    Usuario supervisor = repositorioUsuario.findById(supervisorId).get();
    Usuario practicante = repositorioUsuario.findById(practicanteId).get();

    if (supervisor != null && practicante != null) {
      Map<String, Object> acceso = new HashMap<String, Object>();
      acceso.put("nombre", supervisor.getNombre());
      acceso.put("practicante", practicante.getNombre() + " " + practicante.getApellido());
      acceso.put("link", link);
      emailSender.sendEmail(supervisor.getEmail(), "Consultores en Psicología", acceso, false, tipo);
    }

  }

}