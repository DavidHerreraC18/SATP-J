package com.satpj.project.servicios;

import java.util.List;

import com.google.api.client.util.Preconditions;
import com.satpj.project.modelo.documento_paciente.*;

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
 * Servicio de la entidad DocumentoPaciente Permite que se puedan acceder a
 * todos los servicios asociados a los Documentos del Paciente de forma REST
 */
@Getter
@Setter
@RestController
@RequestMapping("documentos")
public class ServicioDocumentoPaciente {

    @Autowired
    private RepositorioDocumentoPaciente repositorioDocumentoPaciente;

    @GetMapping(produces = "application/json")
    public List<DocumentoPaciente> findAll() {
        return repositorioDocumentoPaciente.findAll();
    }

    @GetMapping(value = "/{id}", produces = "application/json")
    public DocumentoPaciente findById(@PathVariable("id") Long id) {
        return repositorioDocumentoPaciente.findById(id).get();
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public DocumentoPaciente create(@RequestBody DocumentoPaciente documentoPaciente) {
        Preconditions.checkNotNull(documentoPaciente);
        return repositorioDocumentoPaciente.save(documentoPaciente);
    }

    @PutMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void update(@PathVariable("id") Long id, @RequestBody DocumentoPaciente documentoPaciente) {
        Preconditions.checkNotNull(documentoPaciente);

        DocumentoPaciente dpActualizar = repositorioDocumentoPaciente.findById(documentoPaciente.getId()).orElse(null);

        Preconditions.checkNotNull(dpActualizar);

        dpActualizar.setTipo(documentoPaciente.getTipo());
        dpActualizar.setNombre(documentoPaciente.getNombre());
        dpActualizar.setPaciente(documentoPaciente.getPaciente());
        dpActualizar.setContenido(documentoPaciente.getContenido());
        dpActualizar.setRadicacion(documentoPaciente.getRadicacion());
        dpActualizar.setVencimiento(documentoPaciente.getVencimiento());

        repositorioDocumentoPaciente.save(dpActualizar);
    }

    @DeleteMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void delete(@PathVariable("id") Long id) {
        repositorioDocumentoPaciente.deleteById(id);
    }

}