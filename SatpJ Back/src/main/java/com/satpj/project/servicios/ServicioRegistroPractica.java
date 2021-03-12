package com.satpj.project.servicios;

import java.util.List;

import com.google.api.client.util.Preconditions;
import com.satpj.project.modelo.registro_practica.*;
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
 * Servicio de la entidad Registro de Practica Permite que se puedan acceder a
 * todos los servicios asociados al Registro de Practicas de forma REST
 */
@Getter
@Setter
@EnableAutoConfiguration(exclude= SecurityAutoConfiguration.class)
@RestController
@RequestMapping("registropracticas")
public class ServicioRegistroPractica {

    @Autowired
    private RepositorioRegistroPractica repositorioRegistroPractica;

    @GetMapping(produces = "application/json")
    public List<RegistroPractica> findAll(@AuthenticationPrincipal CustomPrincipal customPrincipal) {
        return repositorioRegistroPractica.findAll();
    }

    @GetMapping(value = "/{id}", produces = "application/json")
    public RegistroPractica findById(@PathVariable("id") Long id) {
        return repositorioRegistroPractica.findById(id).get();
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public RegistroPractica create(@AuthenticationPrincipal CustomPrincipal customPrincipal, @RequestBody RegistroPractica registroPractica) {
        Preconditions.checkNotNull(registroPractica);
        return repositorioRegistroPractica.save(registroPractica);
    }

    @PutMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void update(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id, @RequestBody RegistroPractica registroPractica) {
        Preconditions.checkNotNull(registroPractica);

        RegistroPractica rpActualizar = repositorioRegistroPractica.findById(registroPractica.getId()).orElse(null);

        Preconditions.checkNotNull(rpActualizar);
        rpActualizar.setHoras(registroPractica.getHoras());
        rpActualizar.setSesionesCanceladas(registroPractica.getSesionesCanceladas());
        rpActualizar.setSesionesRealizadas(registroPractica.getSesionesRealizadas());
        rpActualizar.setSesionesSupervisadas(registroPractica.getSesionesSupervisadas());

        repositorioRegistroPractica.save(rpActualizar);
    }

    @DeleteMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void delete(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id) {
        repositorioRegistroPractica.deleteById(id);
    }

}