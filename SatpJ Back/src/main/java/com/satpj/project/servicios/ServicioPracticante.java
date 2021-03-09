package com.satpj.project.servicios;

import java.util.ArrayList;
import java.util.List;

import com.google.api.client.util.Preconditions;
import com.satpj.project.modelo.paciente.Paciente;
import com.satpj.project.modelo.practicante.*;
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
 * Servicio de la entidad Practicante Permite que se puedan acceder a todos los
 * servicios asociados a los Practicantes de forma REST
 */
@Getter
@Setter
@EnableAutoConfiguration(exclude= SecurityAutoConfiguration.class)
@RestController
@RequestMapping("practicantes")
public class ServicioPracticante {

    @Autowired
    private RepositorioPracticante repositorioPracticante;

    @Autowired
    private RepositorioPracticantePaciente RepositorioPracticantePaciente;

    @GetMapping(produces = "application/json")
    public List<Practicante> findAllPracticantes(@AuthenticationPrincipal CustomPrincipal customPrincipal) {
        return repositorioPracticante.findAll();
    }

    @GetMapping(value = "/{id}", produces = "application/json")
    public Practicante findPracticanteById(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id) {
        return repositorioPracticante.findById(id).get();
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Practicante createPracticante(@RequestBody Practicante practicante) {
        Preconditions.checkNotNull(practicante);
        return repositorioPracticante.save(practicante);
    }

    @PutMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void updatePracticante(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id, @RequestBody Practicante practicante) {
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
    public void deletePracticante(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id) {
        repositorioPracticante.deleteById(id);
    }

    @GetMapping(value = "/pacientes", produces = "application/json")
    public List<Practicante> findAllPracticantesPaciente(@AuthenticationPrincipal CustomPrincipal customPrincipal) {
        return repositorioPracticante.findAll();
    }

    @GetMapping(value = "/{idPracticante}/{idPaciente}", produces = "application/json")
    public PracticantePaciente findPracticantePacienteById(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("idPracticante") Long idPracticante,
            @PathVariable("idPaciente") Long idPaciente) {
        LlavePracticantePaciente llave = new LlavePracticantePaciente();
        llave.setPPacienteId(idPaciente);
        llave.setPPacienteId(idPracticante);
        PracticantePaciente practicantePaciente = RepositorioPracticantePaciente.findById(llave).get();
        Preconditions.checkNotNull(practicantePaciente);
        return practicantePaciente;
    }

    @GetMapping(value = "/pacientes/{idPracticante}", produces = "application/json")
    public List<PracticantePaciente> findPacientesByPracticanteId(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("idPracticante") Long idPracticante) {

        Practicante practicante = repositorioPracticante.findById(idPracticante).get();
        Preconditions.checkNotNull(practicante);

        return practicante.getPracticantesPaciente();
    }

    @PostMapping(value = "/pacientes")
    @ResponseStatus(HttpStatus.CREATED)
    public PracticantePaciente createPracticantePaciente(@AuthenticationPrincipal CustomPrincipal customPrincipal, @RequestBody PracticantePaciente practicantePaciente) {
        Preconditions.checkNotNull(practicantePaciente);
        return RepositorioPracticantePaciente.save(practicantePaciente);
    }

    @PutMapping(value = "/{idPracticante}/{idPaciente}")
    @ResponseStatus(HttpStatus.OK)
    public void updatePracticante(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("idPracticante") Long idPracticante,
            @PathVariable("idPaciente") Long idPaciente, @RequestBody PracticantePaciente practicantePaciente) {
        Preconditions.checkNotNull(practicantePaciente);

        LlavePracticantePaciente llave = new LlavePracticantePaciente();
        llave.setPPacienteId(idPaciente);
        llave.setPPacienteId(idPracticante);
        PracticantePaciente ppActualizar = RepositorioPracticantePaciente.findById(llave).get();
        Preconditions.checkNotNull(ppActualizar);
        ppActualizar.setActivo(practicantePaciente.isActivo());

        RepositorioPracticantePaciente.save(ppActualizar);
    }

    @DeleteMapping(value = "/{idPracticante}/{idPaciente}")
    @ResponseStatus(HttpStatus.OK)
    public void deletePracticante(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("idPracticante") Long idPracticante,
            @PathVariable("idPaciente") Long idPaciente) {
        LlavePracticantePaciente llave = new LlavePracticantePaciente();
        llave.setPPacienteId(idPaciente);
        llave.setPPacienteId(idPracticante);
        RepositorioPracticantePaciente.deleteById(llave);
    }

    /*
     * La funcion findPacientesActivosByPacienteId tiene el proposito de encontrar a
     * los Pacientes que actualmente se encuentren siendo atendidos por el
     * Practicante
     */
    @GetMapping(value = "/pacientes/activos/{id}", produces = "application/json")
    public List<Paciente> findPacientesActivosByPacienteId(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id) {
        Practicante practicante = repositorioPracticante.findById(id).get();
        Preconditions.checkNotNull(practicante);
        List<PracticantePaciente> practicantePacientes = practicante.getPracticantesPaciente();
        List<Paciente> pacientes = new ArrayList<Paciente>();
        for (PracticantePaciente practicantePaciente : practicantePacientes) {
            if (practicantePaciente.isActivo()) {
                pacientes.add(practicantePaciente.getPaciente());
            }
        }
        return pacientes;
    }

    /*
     * La funcion findPacientesNoActivosByPacienteId tiene el proposito de encontrar
     * a los Pacientes que hayan sido atendidos por el Practicante
     */
    @GetMapping(value = "/pacientes/noactivos/{id}", produces = "application/json")
    public List<Paciente> findPacientesNoActivosByPacienteId(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id) {
        Practicante practicante = repositorioPracticante.findById(id).get();
        Preconditions.checkNotNull(practicante);
        List<PracticantePaciente> practicantePacientes = practicante.getPracticantesPaciente();
        List<Paciente> pacientes = new ArrayList<Paciente>();
        for (PracticantePaciente practicantePaciente : practicantePacientes) {
            if (!practicantePaciente.isActivo()) {
                pacientes.add(practicantePaciente.getPaciente());
            }
        }
        return pacientes;
    }

}