package com.satpj.project.servicios;

import java.util.ArrayList;
import java.util.List;

import com.google.api.client.util.Preconditions;
import com.satpj.project.modelo.acudiente.Acudiente;
import com.satpj.project.modelo.documento_paciente.DocumentoPaciente;
import com.satpj.project.modelo.formulario.Formulario;
import com.satpj.project.modelo.formulario.FormularioExtra;
import com.satpj.project.modelo.grupo.Grupo;
import com.satpj.project.modelo.paciente.*;
import com.satpj.project.modelo.practicante.Practicante;
import com.satpj.project.modelo.practicante.PracticantePaciente;
import com.satpj.project.modelo.supervisor.Supervisor;
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
 * Servicio de la entidad Paciente Permite que se puedan acceder a todos los
 * servicios asociados a los Pacientes de forma REST
 */
@Getter
@Setter
@EnableAutoConfiguration(exclude= SecurityAutoConfiguration.class)
@RestController
@RequestMapping("pacientes")
public class ServicioPaciente {

    @Autowired
    private RepositorioPaciente repositorioPaciente;

    @Autowired
    private ServicioAcudiente servicioAcudiente;

    @Autowired
    private ServicioDocumentoPaciente servicioDocumentoPaciente;

    @Autowired
    private ServicioFormulario servicioFormulario;

    @Autowired
    private ServicioFormularioExtra servicioFormularioExtra;

    @GetMapping(produces = "application/json; charset=UTF-8")
    public List<Paciente> findAll(@AuthenticationPrincipal CustomPrincipal customPrincipal) {
        return repositorioPaciente.findAll();
    }

    /*Encuentra todos los pacientes que han sido aprobados*/
    @GetMapping(value = "/aprobados")
    public List<Paciente> findAllAprobados(@AuthenticationPrincipal CustomPrincipal customPrincipal) {
        List<Paciente> pacientes = repositorioPaciente.findAll();
        List<Paciente> pacientesNP = new ArrayList<Paciente>(); 
        for (Paciente paciente : pacientes) { 
            if((paciente.getEstadoAprobado().equals("Aprobado"))){ 
                pacientesNP.add(paciente); 
            } 
        } 
        return pacientesNP; 
    }
 
    @GetMapping(value = "/{id}", produces = "application/json; charset=UTF-8")
    public Paciente findById(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") String id) {
        return repositorioPaciente.findById(id).get();
    }

    @GetMapping(value = "email/{email}", produces = "application/json; charset=UTF-8")
    public Paciente findByEmail(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("email") String email) {
        List<Paciente> pacientes = repositorioPaciente.findByEmail(email);
        if(pacientes.isEmpty()){
            return null;
        }
        else{
            return pacientes.get(0);
        }
    }

    /*
     * La funcion findSupervisorByPacienteId tiene el proposito de evitar la
     * recursion en JSON que genera la relacion Paciente - Supervisor
     */
    @GetMapping(value = "/{id}/supervisor", produces = "application/json; charset=UTF-8")
    public Supervisor findSupervisorByPacienteId(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") String id) {
        Paciente paciente = repositorioPaciente.findById(id).get();
        Preconditions.checkNotNull(paciente);
        Preconditions.checkNotNull(paciente.getSupervisor());
        return paciente.getSupervisor();
    }

    /*
     * La funcion findSupervisorByPacienteId tiene el proposito de evitar la
     * recursion en JSON que genera la relacion Paciente - Supervisor
     */
    @GetMapping(value = "/{id}/grupo", produces = "application/json; charset=UTF-8")
    public Grupo findGrupoByPacienteId(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") String id) {
        Paciente paciente = repositorioPaciente.findById(id).get();
        Preconditions.checkNotNull(paciente);
        Preconditions.checkNotNull(paciente.getGrupo());
        return paciente.getGrupo();
    }
    
    /*
     * La funcion findAcudientesByPacienteId tiene el proposito de evitar la
     * recursion en JSON que genera la relacion Paciente - Acudiente
     */
    @GetMapping(value = "/{id}/acudientes", produces = "application/json; charset=UTF-8")
    public List<Acudiente> findAcudientesByPacienteId(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") String id) {
        Paciente paciente = repositorioPaciente.findById(id).get();
        Preconditions.checkNotNull(paciente);
        return paciente.getAcudientes();
    }

    /*
     * La funcion findAcudientesByPacienteId tiene el proposito de evitar la
     * recursion en JSON que genera la relacion Paciente - Documentos
     */
    @GetMapping(value = "/{id}/documentos", produces = "application/json; charset=UTF-8")
    public List<DocumentoPaciente> findDocumentosByPacienteId(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") String id) {
        Paciente paciente = repositorioPaciente.findById(id).get();
        Preconditions.checkNotNull(paciente);
        return paciente.getDocumentosPaciente();
    }

    /*
     * La funcion findFormularioByPacienteId tiene el proposito de evitar la
     * recursion en JSON que genera la relacion Paciente - Formulario
     */
    @GetMapping(value = "/{id}/formulario", produces = "application/json; charset=UTF-8")
    public Formulario findFormularioByPacienteId(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") String id) {
        Paciente paciente = repositorioPaciente.findById(id).get();
        Preconditions.checkNotNull(paciente);
        Preconditions.checkNotNull(paciente.getFormulario());
        return paciente.getFormulario();
    }

    @GetMapping(value = "/{id}/formulario-extra", produces = "application/json; charset=UTF-8")
    public FormularioExtra findFormularioExtraByPacienteId(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") String id) {
        Paciente paciente = repositorioPaciente.findById(id).get();
        Preconditions.checkNotNull(paciente);
        Preconditions.checkNotNull(paciente.getFormularioExtra());
        return paciente.getFormularioExtra();
    }

    /*
     * La funcion findPracticantesByPacienteId tiene el proposito de encontrar al
     * Practicante que actualmente se encuentre atendiendo al Paciente Se deja como
     * valor de retorno una lista en el caso de que sea posible la doble atencion de
     * un Paciente.
     */
    @GetMapping(value = "/{id}/practicantes", produces = "application/json; charset=UTF-8")
    public List<Practicante> findPracticantesByPacienteId(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") String id) {
        Paciente paciente = repositorioPaciente.findById(id).get();
        Preconditions.checkNotNull(paciente);
        List<PracticantePaciente> practicantePacientes = paciente.getPracticantesPaciente();
        List<Practicante> practicantes = new ArrayList<Practicante>();
        for (PracticantePaciente practicantePaciente : practicantePacientes) {
            if (practicantePaciente.isActivo()) {
                //practicantes.add(practicantePaciente.getPracticante());
            }
        }
        return practicantes;
    }

    /*
     * La funcion findPracticanteActivoByPacienteId tiene el proposito de encontrar al
     * Practicante que actualmente se encuentre atendiendo al Paciente.
     */
    @GetMapping(value = "/practicante/{id}", produces = "application/json; charset=UTF-8")
    public Practicante findPracticanteActivoByPacienteId(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") String id) {
        Paciente paciente = repositorioPaciente.findById(id).get();
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


    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Paciente create(@RequestBody Paciente paciente) {
        Preconditions.checkNotNull(paciente);
        return repositorioPaciente.save(paciente);
    }

    @PutMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void update(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") String id, @RequestBody Paciente paciente) {
        Preconditions.checkNotNull(paciente);
        //System.out.println("PACIENTE RECIBIDOL:" + paciente.toString());
        Paciente pActualizar = repositorioPaciente.findById(id).orElse(null);
        //System.out.println("PACIENTE ACTUAL:" + pActualizar.toString());
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
        pActualizar.setEstadoAprobado(paciente.getEstadoAprobado());
        pActualizar.setRemitido(paciente.isRemitido());
        pActualizar.setSupervisor(paciente.getSupervisor());
        repositorioPaciente.save(pActualizar);
    }

    @DeleteMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void delete(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") String id) {

        Paciente paciente = repositorioPaciente.findById(id).orElse(null);
        Preconditions.checkNotNull(paciente);

        if(paciente.getAcudientes() != null){
            List<Acudiente> acudientes = paciente.getAcudientes();
            for (Acudiente acudiente : acudientes) {
                servicioAcudiente.delete(customPrincipal,acudiente.getId());
            }
        }   

        if(paciente.getFormulario() != null){
        servicioFormulario.delete(customPrincipal, paciente.getFormulario().getId());
        }
        
        if(paciente.getFormularioExtra() != null){
        servicioFormularioExtra.delete(customPrincipal, paciente.getFormularioExtra().getId());
        }

        if(paciente.getDocumentosPaciente() != null){
            List<DocumentoPaciente> documentosPaciente = paciente.getDocumentosPaciente();
            for (DocumentoPaciente documentoPaciente : documentosPaciente) {
                servicioDocumentoPaciente.delete(customPrincipal,documentoPaciente.getId());
            }
        }

        repositorioPaciente.deleteById(id);
    }

}