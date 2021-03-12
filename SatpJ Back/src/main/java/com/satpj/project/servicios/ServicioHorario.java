package com.satpj.project.servicios;

import java.util.List;

import com.google.api.client.util.Preconditions;
import com.satpj.project.modelo.horario.*;
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
 * Servicio de la entidad Horario Permite que se puedan acceder a todos los
 * servicios asociados a los Horarios de forma REST
 */
@Getter
@Setter
@EnableAutoConfiguration(exclude= SecurityAutoConfiguration.class)
@RestController
@RequestMapping("horarios")
public class ServicioHorario {

    @Autowired
    private RepositorioHorario repositorioHorario;

    @GetMapping(produces = "application/json")
    public List<Horario> findAll(@AuthenticationPrincipal CustomPrincipal customPrincipal) {
        return repositorioHorario.findAll();
    }

    @GetMapping(value = "/{id}", produces = "application/json")
    public Horario findById(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id) {
        return repositorioHorario.findById(id).get();
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Horario create(@AuthenticationPrincipal CustomPrincipal customPrincipal, @RequestBody Horario horario) {
        Preconditions.checkNotNull(horario);
        return repositorioHorario.save(horario);
    }

    @PutMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void update(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id, @RequestBody Horario horario) {
        Preconditions.checkNotNull(horario);

        Horario hActualizar = repositorioHorario.findById(horario.getId()).orElse(null);

        Preconditions.checkNotNull(hActualizar);
        hActualizar.setLunes(horario.getLunes());
        hActualizar.setMartes(horario.getMartes());
        hActualizar.setMiercoles(horario.getMiercoles());
        hActualizar.setJueves(horario.getJueves());
        hActualizar.setViernes(horario.getViernes());
        hActualizar.setSabado(horario.getSabado());

        repositorioHorario.save(hActualizar);
    }

    @DeleteMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void delete(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id) {
        repositorioHorario.deleteById(id);
    }

}