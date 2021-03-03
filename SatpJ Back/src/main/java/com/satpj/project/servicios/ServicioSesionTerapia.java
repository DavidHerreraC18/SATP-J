package com.satpj.project.servicios;

import java.util.ArrayList;
import java.util.List;

import com.google.api.client.util.Preconditions;
import com.satpj.project.modelo.sesion_terapia.*;
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
 * Servicio de la entidad SesionTerapia Permite que se puedan acceder a todos
 * los servicios asociados a las Sesiones de Terapia de forma REST
 */
@Getter
@Setter
@RestController
@RequestMapping("sesionterapias")
public class ServicioSesionTerapia {

    @Autowired
    private RepositorioSesionTerapia repositorioSesionTerapia;

    @Autowired
    private RepositorioSesionUsuario repositorioSesionUsuario;

    @Autowired
    private ServicioUsuario servicioUsuario;

    @GetMapping(produces = "application/json")
    public List<SesionTerapia> findAllSesionesTerapia() {
        return repositorioSesionTerapia.findAll();
    }

    @GetMapping(value = "/{id}/usuarios", produces = "application/json")
    public List<Usuario> findAllUsuariosSesion(@PathVariable("id") Long id) {
        SesionTerapia sesionTerapia = findSesionTerapiaById(id);
        List<Usuario> usuarios = new ArrayList<>();
        for (SesionUsuario sesionUsuario : sesionTerapia.getSesiones()) {
            Usuario usuarioSesion = servicioUsuario.findById(sesionUsuario.getId().getUsuarioId());
            usuarios.add(usuarioSesion);
        }
        return usuarios;
    }

    @GetMapping(value = "/{id}", produces = "application/json")
    public SesionTerapia findSesionTerapiaById(@PathVariable("id") Long id) {
        return repositorioSesionTerapia.findById(id).get();
    };

    @GetMapping(value = "/{idSesion}/{idUsuario}", produces = "application/json")
    public SesionUsuario findSesionUsuarioById(@PathVariable("idSesion") Long idSesion,
            @PathVariable("idUsuario") Long idUsuario) {
        LlaveSesionUsuario llaveSesionUsuario = new LlaveSesionUsuario();
        llaveSesionUsuario.setSesionTerapiaId(idSesion);
        llaveSesionUsuario.setUsuarioId(idUsuario);
        return repositorioSesionUsuario.findById(llaveSesionUsuario).get();
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public SesionTerapia createSesionTerapia(@RequestBody SesionTerapia sesionTerapia) {
        Preconditions.checkNotNull(sesionTerapia);
        return repositorioSesionTerapia.save(sesionTerapia);
    }

    @PostMapping(value = "/usuarios")
    @ResponseStatus(HttpStatus.CREATED)
    public SesionUsuario createSesionUsuario(@RequestBody SesionUsuario sesionUsuario) {
        Preconditions.checkNotNull(sesionUsuario);
        return repositorioSesionUsuario.save(sesionUsuario);
    }

    @PutMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void updateSesionTerapia(@PathVariable("id") Long id, @RequestBody SesionTerapia sesionTerapia) {
        Preconditions.checkNotNull(sesionTerapia);

        SesionTerapia stActualizar = repositorioSesionTerapia.findById(sesionTerapia.getId()).get();

        Preconditions.checkNotNull(stActualizar);
        stActualizar.setConsultorio(sesionTerapia.getConsultorio());
        stActualizar.setFecha(sesionTerapia.getFecha());
        stActualizar.setHora(sesionTerapia.getHora());
        stActualizar.setPaqueteSesion(sesionTerapia.getPaqueteSesion());
        stActualizar.setVirtual(sesionTerapia.isVirtual());

        repositorioSesionTerapia.save(stActualizar);
    }

    @DeleteMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void deleteSesionTerapia(@PathVariable("id") Long id) {
        SesionTerapia sesionTerapia = repositorioSesionTerapia.findById(id).get();
        Preconditions.checkNotNull(sesionTerapia);

        List<SesionUsuario> sesionesUsuario = sesionTerapia.getSesiones();
        for (SesionUsuario sesionUsuario : sesionesUsuario) {
            deleteSesionUsuario(sesionUsuario.getId().getSesionTerapiaId(), sesionUsuario.getId().getUsuarioId());
        }

        repositorioSesionTerapia.deleteById(id);
    }

    @DeleteMapping(value = "{idSesion}/{idUsuario}")
    @ResponseStatus(HttpStatus.OK)
    public void deleteSesionUsuario(@PathVariable("idSesion") Long idSesion,
            @PathVariable("idUsuario") Long idUsuario) {
        SesionUsuario sesionUsuario = this.findSesionUsuarioById(idSesion, idUsuario);
        Preconditions.checkNotNull(sesionUsuario);

        repositorioSesionUsuario.deleteById(sesionUsuario.getId());
    }

}