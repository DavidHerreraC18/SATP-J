package com.satpj.project.servicios;

import java.util.ArrayList;
import java.util.List;

import com.google.api.client.util.Preconditions;
import com.satpj.project.modelo.acudiente.Acudiente;
import com.satpj.project.modelo.documento_paciente.DocumentoPaciente;
import com.satpj.project.modelo.formulario.Formulario;
import com.satpj.project.modelo.paciente.*;
import com.satpj.project.modelo.practicante.Practicante;
import com.satpj.project.modelo.practicante.PracticantePaciente;
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

    @GetMapping(produces = "application/json")
    public List<Paciente> findAll(@AuthenticationPrincipal CustomPrincipal customPrincipal) {
        return repositorioPaciente.findAll();
    }

    @GetMapping(value = "/{id}", produces = "application/json")
    public Paciente findById(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id) {
        return repositorioPaciente.findById(id).get();
    }

    /*
     * La funcion findAcudientesByPacienteId tiene el proposito de evitar la
     * recursion en JSON que genera la relacion Paciente - Acudiente
     */
    @GetMapping(value = "/{id}/acudientes", produces = "application/json")
    public List<Acudiente> findAcudientesByPacienteId(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id) {
        Paciente paciente = repositorioPaciente.findById(id).get();
        Preconditions.checkNotNull(paciente);
        return paciente.getAcudientes();
    }

    /*
     * La funcion findAcudientesByPacienteId tiene el proposito de evitar la
     * recursion en JSON que genera la relacion Paciente - Documentos
     */
    @GetMapping(value = "/{id}/documentos", produces = "application/json")
    public List<DocumentoPaciente> findDocumentosByPacienteId(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id) {
        Paciente paciente = repositorioPaciente.findById(id).get();
        Preconditions.checkNotNull(paciente);
        return paciente.getDocumentosPaciente();
    }

    /*
     * La funcion findFormularioByPacienteId tiene el proposito de evitar la
     * recursion en JSON que genera la relacion Paciente - Formulario
     */
    @GetMapping(value = "/{id}/formulario", produces = "application/json")
    public Formulario findFormularioByPacienteId(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id) {
        Paciente paciente = repositorioPaciente.findById(id).get();
        Preconditions.checkNotNull(paciente);
        return paciente.getFormulario();
    }

    /*
     * La funcion findPracticantesByPacienteId tiene el proposito de encontrar al
     * Practicante que actualmente se encuentre atendiendo al Paciente Se deja como
     * valor de retorno una lista en el caso de que sea posible la doble atencion de
     * un Paciente.
     */
    @GetMapping(value = "/{id}/practicantes", produces = "application/json")
    public List<Practicante> findPracticantesByPacienteId(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id) {
        Paciente paciente = repositorioPaciente.findById(id).get();
        Preconditions.checkNotNull(paciente);
        List<PracticantePaciente> practicantePacientes = paciente.getPracticantesPaciente();
        List<Practicante> practicantes = new ArrayList<Practicante>();
        for (PracticantePaciente practicantePaciente : practicantePacientes) {
            if (practicantePaciente.isActivo()) {
                practicantes.add(practicantePaciente.getPracticante());
            }
        }
        return practicantes;
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Paciente create(@RequestBody Paciente paciente) {
        Preconditions.checkNotNull(paciente);
        return repositorioPaciente.save(paciente);
    }

    @PutMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void update(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id, @RequestBody Paciente paciente) {
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
        pActualizar.setEstadoAprobado(paciente.getEstadoAprobado());
        pActualizar.setRemitido(paciente.isRemitido());

        repositorioPaciente.save(pActualizar);
    }

    @DeleteMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void delete(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id) {

        Paciente paciente = repositorioPaciente.findById(id).orElse(null);
        Preconditions.checkNotNull(paciente);

        List<Acudiente> acudientes = paciente.getAcudientes();
        for (Acudiente acudiente : acudientes) {
            servicioAcudiente.delete(customPrincipal,acudiente.getId());
        }

        List<DocumentoPaciente> documentosPaciente = paciente.getDocumentosPaciente();
        for (DocumentoPaciente documentoPaciente : documentosPaciente) {
            servicioDocumentoPaciente.delete(customPrincipal,documentoPaciente.getId());
        }

        repositorioPaciente.deleteById(id);
    }

}