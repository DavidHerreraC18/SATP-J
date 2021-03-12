package com.satpj.project.servicios;

import java.util.List;

import com.google.api.client.util.Preconditions;
import com.satpj.project.modelo.alerta.*;
import com.satpj.project.modelo.usuario.Usuario;
import com.satpj.project.seguridad.CustomPrincipal;

import lombok.Getter;
import lombok.Setter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.annotation.AuthenticationPrincipal;

/**
 * Servicio de la entidad Alerta Permite que se puedan acceder a todos los
 * servicios asociados a las Alertas de forma REST
 */
@Getter
@Setter
@EnableAutoConfiguration(exclude= SecurityAutoConfiguration.class)
@RestController
@RequestMapping("alertas")
public class ServicioAlerta {

    @Autowired
    private RepositorioAlerta repositorioAlerta;

    @Autowired
    private RepositorioAlertaUsuario repositorioAlertaUsuario;

    @Autowired
    private ServicioUsuario servicioUsuario;

    // Métodos correspondientes a la Alerta

    @GetMapping(produces = "application/json")
    public List<Alerta> findAllAlertas(@AuthenticationPrincipal CustomPrincipal customPrincipal) {
        return repositorioAlerta.findAll();
    }

    @GetMapping(value = "/{id}", produces = "application/json")
    public Alerta findAlertaById(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id) {
        return repositorioAlerta.findById(id).get();
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Alerta createAlerta(@AuthenticationPrincipal CustomPrincipal customPrincipal, @RequestBody Alerta alerta) {
        Preconditions.checkNotNull(alerta);
        return repositorioAlerta.save(alerta);
    }

    @PutMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void updateAlerta(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id, @RequestBody Alerta alerta) {
        Preconditions.checkNotNull(alerta);
        Alerta aActualizar = repositorioAlerta.findById(alerta.getId()).orElse(null);
        Preconditions.checkNotNull(aActualizar);
        aActualizar.setTipo(alerta.getTipo());
        repositorioAlerta.save(aActualizar);
    }

    @DeleteMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void deleteAlerta(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id) {
        Alerta alerta = repositorioAlerta.findById(id).orElse(null);
        Preconditions.checkNotNull(alerta);

        List<AlertaUsuario> alertasUsuario = alerta.getAlertasUsuario();
        for (AlertaUsuario alertaUsuario : alertasUsuario) {
            deleteAlertaUsuario(customPrincipal, alerta.getId(), alertaUsuario);
        }
        repositorioAlerta.deleteById(id);
    }

    // Métodos correspondientes a la AlertaUsuario

    @GetMapping(value = "/usuario/{id}", produces = "application/json")
    public List<AlertaUsuario> findAlertaUsuarioByUsuario(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") String id) {
        Usuario usuario = servicioUsuario.findById(customPrincipal, id);
        Preconditions.checkNotNull(usuario);
        List<AlertaUsuario> alertasUsuario = usuario.getAlertasUsuario();
        return alertasUsuario;
    }

    @GetMapping(value = "/usuario", produces = "application/json")
    public List<AlertaUsuario> findAllAlertaUsuario(@AuthenticationPrincipal CustomPrincipal customPrincipal) {
        return repositorioAlertaUsuario.findAll();
    }

    @PostMapping(value = "/usuario")
    @ResponseStatus(HttpStatus.CREATED)
    public AlertaUsuario createAlertaUsuario(@AuthenticationPrincipal CustomPrincipal customPrincipal, @RequestBody AlertaUsuario alertaUsuario) {
        Preconditions.checkNotNull(alertaUsuario);
        return repositorioAlertaUsuario.save(alertaUsuario);
    }

    @PutMapping(value = "/usuario/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void updateAlertaUsuario(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") String id, @RequestBody AlertaUsuario alertaUsuario) {
        Usuario usuario = servicioUsuario.findById(customPrincipal, id);
        Alerta alerta = this.findAlertaById(customPrincipal, alertaUsuario.getId().getAlertaId());
        Preconditions.checkNotNull(usuario);
        Preconditions.checkNotNull(alerta);
        AlertaUsuario auActualizar = repositorioAlertaUsuario.findById(alertaUsuario.getId()).orElse(null);
        Preconditions.checkNotNull(auActualizar);
        auActualizar.setFrecuencia(alertaUsuario.getFrecuencia());
        repositorioAlertaUsuario.save(auActualizar);
    }

    @DeleteMapping(value = "/usuario/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void deleteAlertaUsuario(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id, @RequestBody AlertaUsuario alertaUsuario) {
        repositorioAlertaUsuario.deleteById(alertaUsuario.getId());
    }
}
