package com.satpj.project.servicios;

import java.util.List;

import com.google.api.client.util.Preconditions;
import com.satpj.project.modelo.practicante.*;

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
 * Servicio de la entidad Practicante Permite que se puedan acceder a todos los
 * servicios asociados a los Practicantes de forma REST
 */
@Getter
@Setter
@RestController
@RequestMapping("practicantes")
public class ServicioPracticante {

    @Autowired
    private RepositorioPracticante repositorioPracticante;

    @GetMapping(produces = "application/json")
    public List<Practicante> findAll() {
        return repositorioPracticante.findAll();
    }

    @GetMapping(value = "/{id}", produces = "application/json")
    public Practicante findById(@PathVariable("id") Long id) {
        return repositorioPracticante.findById(id).get();
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Practicante create(@RequestBody Practicante practicante) {
        Preconditions.checkNotNull(practicante);
        return repositorioPracticante.save(practicante);
    }

    @PutMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void update(@PathVariable("id") Long id, @RequestBody Practicante practicante) {
        Preconditions.checkNotNull(practicante);

        Practicante pActualizar = repositorioPracticante.findById(practicante.getId()).orElse(null);

        Preconditions.checkNotNull(pActualizar);

        pActualizar.setApellido(practicante.getApellido());
        pActualizar.setNombre(practicante.getNombre());
        pActualizar.setTelefono(practicante.getTelefono());
        pActualizar.setTipoDocumento(practicante.getTipoDocumento());
        pActualizar.setDocumento(practicante.getDocumento());
        pActualizar.setEmail(practicante.getEmail());
        pActualizar.setEnfoque(practicante.getEnfoque());
        pActualizar.setPregrado(practicante.isPregrado());
        pActualizar.setSemestre(practicante.getSemestre());

        repositorioPracticante.save(pActualizar);
    }

    @DeleteMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void delete(@PathVariable("id") Long id) {
        repositorioPracticante.deleteById(id);
    }

}