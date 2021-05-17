package com.satpj.project.servicios;

import java.util.List;

import com.google.api.client.util.Preconditions;
import com.satpj.project.modelo.auxiliar_administrativo.*;
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
 * Servicio de la entidad Auxiliar Administrativo Permite que se puedan acceder
 * a todos los servicios asociados a los Auxiliares Administrativos de forma
 * REST
 */
@Getter
@Setter
@EnableAutoConfiguration(exclude= SecurityAutoConfiguration.class)
@RestController
@RequestMapping("auxiliares")
public class ServicioAuxiliarAdministrativo {

    @Autowired
    private RepositorioAuxiliarAdministrativo repositorioAuxiliarAdministrativo;

    @GetMapping(produces = "application/json")
    public List<AuxiliarAdministrativo> findAll(@AuthenticationPrincipal CustomPrincipal customPrincipal) {
        return repositorioAuxiliarAdministrativo.findAll();
    }

    @GetMapping(value = "/{id}",  produces = "application/json; charset=UTF-8")
    public AuxiliarAdministrativo findById(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") String id) {
        return repositorioAuxiliarAdministrativo.findById(id).get();
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public AuxiliarAdministrativo create(@AuthenticationPrincipal CustomPrincipal customPrincipal,@RequestBody AuxiliarAdministrativo auxiliar) {
        Preconditions.checkNotNull(auxiliar);
        return repositorioAuxiliarAdministrativo.save(auxiliar);
    }

    @PutMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void update(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id, @RequestBody AuxiliarAdministrativo acudiente) {
        Preconditions.checkNotNull(acudiente);

        AuxiliarAdministrativo aActualizar = repositorioAuxiliarAdministrativo.findById(acudiente.getId()).orElse(null);

        Preconditions.checkNotNull(aActualizar);

        aActualizar.setApellido(acudiente.getApellido());
        aActualizar.setNombre(acudiente.getNombre());
        aActualizar.setTelefono(acudiente.getTelefono());
        aActualizar.setTipoDocumento(acudiente.getTipoDocumento());
        aActualizar.setDocumento(acudiente.getDocumento());
        aActualizar.setEmail(acudiente.getEmail());

        repositorioAuxiliarAdministrativo.save(aActualizar);
    }

    @DeleteMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void delete(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") String id) {
        repositorioAuxiliarAdministrativo.deleteById(id);
    }

}