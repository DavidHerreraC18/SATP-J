
package com.satpj.project.servicios;

import java.util.List;

import com.google.api.client.util.Preconditions;
import com.satpj.project.modelo.grupo.*;

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
 * Servicio de la entidad Grupo Permite que se puedan acceder a todos los
 * servicios asociados a los Grupos de Pacientes de forma REST
 */
@Getter
@Setter
@RestController
@RequestMapping("grupos")
public class ServicioGrupo {

    @Autowired
    private RepositorioGrupo repositorioGrupo;

    @GetMapping(produces = "application/json")
    public List<Grupo> findAll() {
        return repositorioGrupo.findAll();
    }

    @GetMapping(value = "/{id}", produces = "application/json")
    public Grupo findById(@PathVariable("id") Long id) {
        return repositorioGrupo.findById(id).get();
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Grupo create(@RequestBody Grupo grupo) {
        Preconditions.checkNotNull(grupo);
        return repositorioGrupo.save(grupo);
    }

    @PutMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void update(@PathVariable("id") Long id, @RequestBody Grupo grupo) {
        Preconditions.checkNotNull(grupo);

        Grupo gActualizar = repositorioGrupo.findById(grupo.getId()).orElse(null);

        Preconditions.checkNotNull(gActualizar);

        repositorioGrupo.save(gActualizar);
    }

    @DeleteMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void delete(@PathVariable("id") Long id) {
        repositorioGrupo.deleteById(id);
    }

}