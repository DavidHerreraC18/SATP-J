
package com.satpj.project.servicios;

import java.util.List;

import com.google.api.client.util.Preconditions;
import com.satpj.project.modelo.grupo.*;
import com.satpj.project.modelo.paciente.Paciente;
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
 * Servicio de la entidad Grupo Permite que se puedan acceder a todos los
 * servicios asociados a los Grupos de Pacientes de forma REST
 */
@Getter
@Setter
@EnableAutoConfiguration(exclude= SecurityAutoConfiguration.class)
@RestController
@RequestMapping("grupos")
public class ServicioGrupo {

    @Autowired
    private RepositorioGrupo repositorioGrupo;

    @GetMapping(produces = "application/json; charset=UTF-8")
    public List<Grupo> findAll(@AuthenticationPrincipal CustomPrincipal customPrincipal) {
        return repositorioGrupo.findAll();
    }

    @GetMapping(value = "/{id}", produces = "application/json; charset=UTF-8")
    public Grupo findById(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id) {
        return repositorioGrupo.findById(id).get();
    }

    /*
     * La funcion findIntegrantesById tiene el proposito de evitar la recursion en
     * JSON que genera la relacion Paciente - Grupo
     */
    @GetMapping(value = "/{id}/integrantes", produces = "application/json; charset=UTF-8")
    public List<Paciente> findIntegrantesById(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id) {
        Grupo grupo = repositorioGrupo.findById(id).get();
        Preconditions.checkNotNull(grupo);
        return grupo.getIntegrantes();
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Grupo create(@AuthenticationPrincipal CustomPrincipal customPrincipal, @RequestBody Grupo grupo) {
        Preconditions.checkNotNull(grupo);
        return repositorioGrupo.save(grupo);
    }

    @PutMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void update(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id, @RequestBody Grupo grupo) {
        Preconditions.checkNotNull(grupo);

        Grupo gActualizar = repositorioGrupo.findById(grupo.getId()).orElse(null);

        Preconditions.checkNotNull(gActualizar);

        repositorioGrupo.save(gActualizar);
    }

    @DeleteMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void delete(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id) {
        repositorioGrupo.deleteById(id);
    }

}