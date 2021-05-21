package com.satpj.project.servicios;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.google.api.client.util.Preconditions;
import com.satpj.project.modelo.grupo.Grupo;
import com.satpj.project.modelo.paciente.Paciente;
import com.satpj.project.modelo.practicante.*;
import com.satpj.project.modelo.sesion_terapia.SesionTerapia;
import com.satpj.project.modelo.sesion_terapia.SesionUsuario;
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
@EnableAutoConfiguration(exclude = SecurityAutoConfiguration.class)
@RestController
@RequestMapping("practicantes")
public class ServicioPracticante {

    @Autowired
    private RepositorioPracticante repositorioPracticante;

    @Autowired
    private ServicioPaciente servicioPaciente;

    @Autowired
    private ServicioSesionTerapia servicioSesionTerapia;

    @Autowired
    private RepositorioPracticantePaciente RepositorioPracticantePaciente;

    @GetMapping(produces = "application/json; charset=UTF-8")
    public List<Practicante> findAllPracticantes(@AuthenticationPrincipal CustomPrincipal customPrincipal) {
        return repositorioPracticante.findAll();
    }

    @GetMapping(value = "/{id}", produces = "application/json; charset=UTF-8")
    public Practicante findPracticanteById(@AuthenticationPrincipal CustomPrincipal customPrincipal,
            @PathVariable("id") String id) {
        return repositorioPracticante.findById(id).get();
    }

    @GetMapping(value = "/horas", produces = "application/json; charset=UTF-8")
    public List<PracticanteHoras> findHorasPracticantes(@AuthenticationPrincipal CustomPrincipal customPrincipal) {
        List<Practicante> practicantes = this.findAllPracticantes(customPrincipal);
        List<PracticanteHoras> practicantesHoras = new ArrayList<PracticanteHoras>();
        for (Practicante practicante : practicantes) {
            int contadorHoras = 0;
            List<SesionUsuario> sesiones = this.servicioSesionTerapia.findSesionUsuarioByUsuarioId(customPrincipal,
                    practicante.getId());
            for (SesionUsuario sesionUsuario : sesiones) {
                SesionTerapia sesionTerapia = sesionUsuario.getSesionTerapia();
                if (sesionTerapia.getFecha().isBefore(LocalDateTime.now())) {
                    contadorHoras++;
                }
            }
            practicantesHoras.add(new PracticanteHoras(practicante, contadorHoras));
        }
        return practicantesHoras;
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Practicante createPracticante(@RequestBody Practicante practicante) {
        Preconditions.checkNotNull(practicante);
        return repositorioPracticante.save(practicante);
    }

    @PutMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void updatePracticante(@AuthenticationPrincipal CustomPrincipal customPrincipal,
            @PathVariable("id") String id, @RequestBody Practicante practicante) {
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
        pActualizar.setAforo(practicante.getAforo());
        repositorioPracticante.save(pActualizar);
    }

    @DeleteMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void deletePracticante(@AuthenticationPrincipal CustomPrincipal customPrincipal,
            @PathVariable("id") String id) {
        repositorioPracticante.deleteById(id);
    }

    @GetMapping(value = "/pacientes", produces = "application/json; charset=UTF-8")
    public List<Practicante> findAllPracticantesPaciente(@AuthenticationPrincipal CustomPrincipal customPrincipal) {
        return repositorioPracticante.findAll();
    }

    @GetMapping(value = "/{idPracticante}/{idPaciente}", produces = "application/json; charset=UTF-8")
    public PracticantePaciente findPracticantePacienteById(@AuthenticationPrincipal CustomPrincipal customPrincipal,
            @PathVariable("idPracticante") String idPracticante, @PathVariable("idPaciente") String idPaciente) {
        LlavePracticantePaciente llave = new LlavePracticantePaciente();
        llave.setPaciente_id(idPaciente);
        llave.setPracticante_id(idPracticante);
        PracticantePaciente practicantePaciente = RepositorioPracticantePaciente.findById(llave).get();
        Preconditions.checkNotNull(practicantePaciente);
        return practicantePaciente;
    }

    @GetMapping(value = "/pacientes/{idPracticante}", produces = "application/json; charset=UTF-8")
    public List<PracticantePaciente> findPacientesByPracticanteId(
            @AuthenticationPrincipal CustomPrincipal customPrincipal,
            @PathVariable("idPracticante") String idPracticante) {

        Practicante practicante = repositorioPracticante.findById(idPracticante).get();
        Preconditions.checkNotNull(practicante);

        return practicante.getPracticantesPaciente();
    }

    @PostMapping(value = "/pacientes")
    @ResponseStatus(HttpStatus.CREATED)
    public PracticantePaciente createPracticantePaciente(@AuthenticationPrincipal CustomPrincipal customPrincipal,
            @RequestBody PracticantePaciente practicantePaciente) {
        Preconditions.checkNotNull(practicantePaciente);
        return RepositorioPracticantePaciente.save(practicantePaciente);
    }

    @PostMapping(value = "/pacientes/{idPracticante}/{idPaciente}")
    @ResponseStatus(HttpStatus.CREATED)
    public PracticantePaciente createPracticantePaciente(@AuthenticationPrincipal CustomPrincipal customPrincipal,
            @PathVariable("idPracticante") String idPracticante, @PathVariable("idPaciente") String idPaciente) {
        
        Practicante practicante = this.findPracticanteById(customPrincipal, idPracticante);
        Paciente paciente = servicioPaciente.findById(customPrincipal, idPaciente);
        if (practicante != null && paciente != null) {
            LlavePracticantePaciente llave = new LlavePracticantePaciente();
            llave.setPaciente_id(paciente.getId());
            llave.setPracticante_id(practicante.getId());
            PracticantePaciente practicantePaciente = new PracticantePaciente();
            practicantePaciente.setId(llave);
            practicantePaciente.setPaciente(paciente);
            practicantePaciente.setPracticante(practicante);
            practicantePaciente.setActivo(true);
            List<PracticantePaciente> practicantesPaciente = paciente.getPracticantesPaciente();
            for (PracticantePaciente ppDesactivar : practicantesPaciente) {
                ppDesactivar.setActivo(false);
                RepositorioPracticantePaciente.save(ppDesactivar);
            }
            Grupo grupo = paciente.getGrupo();
            if (grupo != null) {
                for (Paciente pacienteGrupo : grupo.getIntegrantes()) {
                    LlavePracticantePaciente llaveGrupo = new LlavePracticantePaciente();
                    llaveGrupo.setPaciente_id(pacienteGrupo.getId());
                    llaveGrupo.setPracticante_id(practicante.getId());
                    PracticantePaciente practicantePacienteGrupo = new PracticantePaciente();
                    practicantePacienteGrupo.setId(llaveGrupo);
                    practicantePacienteGrupo.setPaciente(pacienteGrupo);
                    practicantePacienteGrupo.setPracticante(practicante);
                    practicantePacienteGrupo.setActivo(true);
                    List<PracticantePaciente> practicantesPacienteGrupo = pacienteGrupo.getPracticantesPaciente();
                    for (PracticantePaciente ppDesactivar : practicantesPacienteGrupo) {
                        ppDesactivar.setActivo(false);
                        RepositorioPracticantePaciente.save(ppDesactivar);
                    }
                    RepositorioPracticantePaciente.save(practicantePacienteGrupo);
                }
            }
                return RepositorioPracticantePaciente.save(practicantePaciente);
        }
        return null;

    }

    @PutMapping(value = "/{idPracticante}/{idPaciente}")
    @ResponseStatus(HttpStatus.OK)
    public void updatePracticante(@AuthenticationPrincipal CustomPrincipal customPrincipal,
            @PathVariable("idPracticante") String idPracticante, @PathVariable("idPaciente") String idPaciente,
            @RequestBody PracticantePaciente practicantePaciente) {
        Preconditions.checkNotNull(practicantePaciente);

        LlavePracticantePaciente llave = new LlavePracticantePaciente();
        llave.setPaciente_id(idPaciente);
        llave.setPracticante_id(idPracticante);
        PracticantePaciente ppActualizar = RepositorioPracticantePaciente.findById(llave).get();
        Preconditions.checkNotNull(ppActualizar);
        ppActualizar.setActivo(practicantePaciente.isActivo());

        RepositorioPracticantePaciente.save(ppActualizar);
    }

    @DeleteMapping(value = "/{idPracticante}/{idPaciente}")
    @ResponseStatus(HttpStatus.OK)
    public void deletePracticante(@AuthenticationPrincipal CustomPrincipal customPrincipal,
            @PathVariable("idPracticante") String idPracticante, @PathVariable("idPaciente") String idPaciente) {
        LlavePracticantePaciente llave = new LlavePracticantePaciente();
        llave.setPaciente_id(idPaciente);
        llave.setPracticante_id(idPracticante);
        RepositorioPracticantePaciente.deleteById(llave);
    }

    /*
     * La funcion findPacientesActivosByPacienteId tiene el proposito de encontrar a
     * los Pacientes que actualmente se encuentren siendo atendidos por el
     * Practicante
     */
    @GetMapping(value = "/pacientes/activos/{id}", produces = "application/json; charset=UTF-8")
    public List<Paciente> findPacientesActivosByPracticanteId(@AuthenticationPrincipal CustomPrincipal customPrincipal,
            @PathVariable("id") String id) {
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
    @GetMapping(value = "/pacientes/noactivos/{id}", produces = "application/json; charset=UTF-8")
    public List<Paciente> findPacientesNoActivosByPracticanteId(
            @AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") String id) {
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

    /*
     * La funcion findPracticanteActivoByPacienteId tiene el proposito de encontrar
     * al Practicante que actualmente se encuentren atendiendo al Practicante
     */
    @GetMapping(value = "/practicante/activo/{id}", produces = "application/json; charset=UTF-8")
    public Practicante findPracticanteActivoByPacienteId(@AuthenticationPrincipal CustomPrincipal customPrincipal,
            @PathVariable("id") String id) {
        Paciente paciente = servicioPaciente.findById(customPrincipal, id);
        Preconditions.checkNotNull(paciente);
        List<PracticantePaciente> practicantePacientes = paciente.getPracticantesPaciente();
        Practicante practicante = null;
        for (PracticantePaciente practicantePaciente : practicantePacientes) {
            if (practicantePaciente.isActivo()) {
                practicante = practicantePaciente.getPracticante();
            }
        }
        return practicante;
    }

}