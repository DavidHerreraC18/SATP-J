package com.satpj.project.servicios;

import java.util.List;

import com.google.api.client.util.Preconditions;
import com.satpj.project.modelo.alerta.*;
import com.satpj.project.modelo.usuario.Usuario;

import lombok.Getter;
import lombok.Setter;

import org.springframework.beans.factory.annotation.Autowired;
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

/**
 * Servicio de la entidad Alerta Permite que se puedan acceder a todos los
 * servicios asociados a las Alertas de forma REST
 */
@Getter
@Setter
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
    public List<Alerta> findAllAlertas() {
        return repositorioAlerta.findAll();
    }

    @GetMapping(value = "/{id}", produces = "application/json")
    public Alerta findAlertaById(@PathVariable("id") Long id) {
        return repositorioAlerta.findById(id).get();
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Alerta createAlerta(@RequestBody Alerta alerta) {
        Preconditions.checkNotNull(alerta);
        return repositorioAlerta.save(alerta);
    }

    @PutMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void updateAlerta(@PathVariable("id") Long id, @RequestBody Alerta alerta) {
        Preconditions.checkNotNull(alerta);
        Alerta aActualizar = repositorioAlerta.findById(alerta.getId()).orElse(null);
        Preconditions.checkNotNull(aActualizar);
        aActualizar.setTipo(alerta.getTipo());
        repositorioAlerta.save(aActualizar);
    }

    @DeleteMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void deleteAlerta(@PathVariable("id") Long id) {
        Alerta alerta = repositorioAlerta.findById(id).orElse(null);
        Preconditions.checkNotNull(alerta);

        List<AlertaUsuario> alertasUsuario = alerta.getAlertasUsuario();
        for (AlertaUsuario alertaUsuario : alertasUsuario) {
            deleteAlertaUsuario(alerta.getId(), alertaUsuario);
        }
        repositorioAlerta.deleteById(id);
    }

    // Métodos correspondientes a la AlertaUsuario

    @GetMapping(value = "/usuario/{id}", produces = "application/json")
    public List<AlertaUsuario> findAlertaUsuarioByUsuario(@PathVariable("id") Long id) {
        Usuario usuario = servicioUsuario.findById(id);
        Preconditions.checkNotNull(usuario);
        List<AlertaUsuario> alertasUsuario = usuario.getAlertasUsuario();
        return alertasUsuario;
    }

    @GetMapping(value = "/usuario", produces = "application/json")
    public List<AlertaUsuario> findAllAlertaUsuario() {
        return repositorioAlertaUsuario.findAll();
    }

    @PostMapping(value = "/usuario")
    @ResponseStatus(HttpStatus.CREATED)
    public AlertaUsuario createAlertaUsuario(@RequestBody AlertaUsuario alertaUsuario) {
        Preconditions.checkNotNull(alertaUsuario);
        return repositorioAlertaUsuario.save(alertaUsuario);
    }

    @PutMapping(value = "/usuario/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void updateAlertaUsuario(@PathVariable("id") Long id, @RequestBody AlertaUsuario alertaUsuario) {
        Usuario usuario = servicioUsuario.findById(id);
        Alerta alerta = this.findAlertaById(alertaUsuario.getId().getAlertaId());
        Preconditions.checkNotNull(usuario);
        Preconditions.checkNotNull(alerta);
        AlertaUsuario auActualizar = repositorioAlertaUsuario.findById(alertaUsuario.getId()).orElse(null);
        Preconditions.checkNotNull(auActualizar);
        auActualizar.setFrecuencia(alertaUsuario.getFrecuencia());
        repositorioAlertaUsuario.save(auActualizar);
    }

    @DeleteMapping(value = "/usuario/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void deleteAlertaUsuario(@PathVariable("id") Long id, @RequestBody AlertaUsuario alertaUsuario) {
        repositorioAlertaUsuario.deleteById(alertaUsuario.getId());
    }
}
