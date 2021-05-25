package com.satpj.project.servicios;

import java.util.ArrayList;
import java.util.List;

import com.google.api.client.util.Preconditions;
import com.satpj.project.modelo.paciente.Paciente;
import com.satpj.project.modelo.practicante.Practicante;
import com.satpj.project.modelo.supervisor.*;
import com.satpj.project.modelo.usuario.RepositorioUsuario;
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
 * Servicio de la entidad Supervisor Permite que se puedan acceder a todos los
 * servicios asociados a los Supervisores de forma REST
 */
@Getter
@Setter
@EnableAutoConfiguration(exclude= SecurityAutoConfiguration.class)
@RestController
@RequestMapping("supervisores")
public class ServicioSupervisor {

    @Autowired
    private RepositorioSupervisor repositorioSupervisor;

    @Autowired
    private ServicioPaciente servicioPaciente;
    
    @Autowired
    RepositorioUsuario repositorioUsuario;

    @GetMapping(produces = "application/json; charset=UTF-8")
    public List<Supervisor> findAll(@AuthenticationPrincipal CustomPrincipal customPrincipal) {
        return repositorioSupervisor.findAll();
    }

    @GetMapping(value = "/{id}", produces = "application/json; charset=UTF-8")
    public Supervisor findById(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") String id) {
        return repositorioSupervisor.findById(id).get();
    }

    @GetMapping(value = "/pacientes/{id}", produces = "application/json; charset=UTF-8")
    public List<Paciente> findPacientesBySupervisorId(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") String id) {
        Supervisor supervisor = repositorioSupervisor.findById(id).get();
        Preconditions.checkNotNull(supervisor);
        return supervisor.getPacientes();
    }

    @GetMapping(value = "/practicantes/{id}", produces = "application/json; charset=UTF-8")
    public List<Practicante> findPracticantesBySupervisorId(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") String id) {
        List<Paciente> pacientes = this.findPacientesBySupervisorId(customPrincipal, id);
        List<Practicante> practicantes = new  ArrayList<Practicante>(); 
        for(Paciente paciente: pacientes){
            Practicante practicante = this.servicioPaciente.findPracticanteActivoByPacienteId(customPrincipal, paciente.getId());
            if(practicante != null){
                practicantes.add(practicante);
            }
        }
        return practicantes;
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Supervisor create(@RequestBody Supervisor supervisor) {
        Preconditions.checkNotNull(supervisor);
        return repositorioSupervisor.save(supervisor);
    }

    @PutMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void update(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") String id, @RequestBody Supervisor supervisor) {
        Preconditions.checkNotNull(supervisor);
        Supervisor sActualizar = repositorioSupervisor.findById(supervisor.getId()).orElse(null);

        Preconditions.checkNotNull(sActualizar);

        sActualizar.setApellido(supervisor.getApellido());
        sActualizar.setNombre(supervisor.getNombre());
        sActualizar.setTelefono(supervisor.getTelefono());
        sActualizar.setTipoDocumento(supervisor.getTipoDocumento());
        sActualizar.setDocumento(supervisor.getDocumento());
        sActualizar.setEmail(supervisor.getEmail());
        sActualizar.setDireccion(supervisor.getDireccion());
        sActualizar.setEnfoque(supervisor.getEnfoque());

        repositorioSupervisor.save(sActualizar);
    }

    @DeleteMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void delete(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") String id) {
        repositorioSupervisor.deleteById(id);
    }

}