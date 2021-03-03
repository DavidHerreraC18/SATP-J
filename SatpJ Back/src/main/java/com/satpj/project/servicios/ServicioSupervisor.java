package com.satpj.project.servicios;

import java.util.List;

import com.google.api.client.util.Preconditions;
import com.satpj.project.modelo.paciente.Paciente;
import com.satpj.project.modelo.supervisor.*;

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
 * Servicio de la entidad Supervisor Permite que se puedan acceder a todos los
 * servicios asociados a los Supervisores de forma REST
 */
@Getter
@Setter
@RestController
@RequestMapping("supervisores")
public class ServicioSupervisor {

    @Autowired
    private RepositorioSupervisor repositorioSupervisor;

    @GetMapping(produces = "application/json")
    public List<Supervisor> findAll() {
        return repositorioSupervisor.findAll();
    }

    @GetMapping(value = "/{id}", produces = "application/json")
    public Supervisor findById(@PathVariable("id") Long id) {
        return repositorioSupervisor.findById(id).get();
    }

    @GetMapping(value = "/pacientes/{id}", produces = "application/json")
    public List<Paciente> findPacientesBySupervisorId(@PathVariable("id") Long id) {
        Supervisor supervisor = repositorioSupervisor.findById(id).get();
        Preconditions.checkNotNull(supervisor);
        return supervisor.getPacientes();
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Supervisor create(@RequestBody Supervisor supervisor) {
        Preconditions.checkNotNull(supervisor);
        return repositorioSupervisor.save(supervisor);
    }

    @PutMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void update(@PathVariable("id") Long id, @RequestBody Supervisor supervisor) {
        Preconditions.checkNotNull(supervisor);

        Supervisor sActualizar = repositorioSupervisor.findById(supervisor.getId()).orElse(null);

        Preconditions.checkNotNull(sActualizar);

        sActualizar.setApellido(supervisor.getApellido());
        sActualizar.setNombre(supervisor.getNombre());
        sActualizar.setTelefono(supervisor.getTelefono());
        sActualizar.setTipoDocumento(supervisor.getTipoDocumento());
        sActualizar.setDocumento(supervisor.getDocumento());
        sActualizar.setEmail(supervisor.getEmail());
        sActualizar.setEnfoque(supervisor.getEnfoque());

        repositorioSupervisor.save(sActualizar);
    }

    @DeleteMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void delete(@PathVariable("id") Long id) {
        repositorioSupervisor.deleteById(id);
    }

}