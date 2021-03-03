package com.satpj.project.servicios;

import java.util.List;

import com.google.api.client.util.Preconditions;
import com.satpj.project.modelo.acudiente.Acudiente;
import com.satpj.project.modelo.documento_paciente.DocumentoPaciente;
import com.satpj.project.modelo.paciente.*;

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
 * Servicio de la entidad Paciente Permite que se puedan acceder a todos los
 * servicios asociados a los Pacientes de forma REST
 */
@Getter
@Setter
@RestController
@RequestMapping("pacientes")
public class ServicioPaciente {

    @Autowired
    private RepositorioPaciente repositorioPaciente;

    @Autowired
    private ServicioAcudiente servicioAcudiente;

    @Autowired
    private ServicioDocumentoPaciente servicioDocumentoPaciente;

    @GetMapping(produces = "application/json")
    public List<Paciente> findAll() {
        return repositorioPaciente.findAll();
    }

    @GetMapping(value = "/{id}", produces = "application/json")
    public Paciente findById(@PathVariable("id") Long id) {
        return repositorioPaciente.findById(id).get();
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Paciente create(@RequestBody Paciente paciente) {
        Preconditions.checkNotNull(paciente);
        return repositorioPaciente.save(paciente);
    }

    @PutMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void update(@PathVariable("id") Long id, @RequestBody Paciente paciente) {
        Preconditions.checkNotNull(paciente);

        Paciente pActualizar = repositorioPaciente.findById(paciente.getId()).orElse(null);

        Preconditions.checkNotNull(pActualizar);

        pActualizar.setApellido(paciente.getApellido());
        pActualizar.setNombre(paciente.getNombre());
        pActualizar.setTelefono(paciente.getTelefono());
        pActualizar.setTipoDocumento(paciente.getTipoDocumento());
        pActualizar.setDocumento(paciente.getDocumento());
        pActualizar.setEmail(paciente.getEmail());
        pActualizar.setGrupo(paciente.getGrupo());
        pActualizar.setEdad(paciente.getEdad());
        pActualizar.setEstrato(paciente.getEstrato());
        pActualizar.setAprobado(paciente.isAprobado());

        repositorioPaciente.save(pActualizar);
    }

    @DeleteMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void delete(@PathVariable("id") Long id) {

        Paciente paciente = repositorioPaciente.findById(id).orElse(null);
        Preconditions.checkNotNull(paciente);

        List<Acudiente> acudientes = paciente.getAcudientes();
        for (Acudiente acudiente : acudientes) {
            servicioAcudiente.delete(acudiente.getId());
        }

        List<DocumentoPaciente> documentosPaciente = paciente.getDocumentosPaciente();
        for (DocumentoPaciente documentoPaciente : documentosPaciente) {
            servicioDocumentoPaciente.delete(documentoPaciente.getId());
        }

        repositorioPaciente.deleteById(id);
    }

}