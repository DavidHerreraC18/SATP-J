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

  @GetMapping(value = "/{idUsuario}/{idSesion}/{tipo}", produces = "application/json; charset=UTF-8")
  public void sendEmailSesionTerapia(@AuthenticationPrincipal CustomPrincipal customPrincipal,
      @PathVariable("idUsuario") String idUsuario, @PathVariable("idSesion") Long idSesion,
      @PathVariable("tipo") String tipo) {

    Usuario usuario = repositorioUsuario.findById(idUsuario).get();

    if (usuario != null) {
      SesionTerapia sesion = repositorioSesionTerapia.findById(idSesion).get();
      if (sesion != null) {
        Map<String, Object> model = new HashMap<String, Object>();
        model.put("nombre", usuario.getNombre() + " " + usuario.getDocumento());
        model.put("fecha", sesion.getFecha());
        if (tipo.equals("cita_presencial")) {
          emailSender.sendEmail(usuario.getEmail(), "Consultores en Psicología", model, false, "cita_presencial");
        } else {
          emailSender.sendEmail(usuario.getEmail(), "Consultores en Psicología", model, false, "cita_virtual");
        }
      }
    }
  }

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

}