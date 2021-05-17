package com.satpj.project.servicios;

import java.util.ArrayList;
import java.util.List;

import com.google.api.client.util.Preconditions;
import com.satpj.project.modelo.formulario.Formulario;
import com.satpj.project.modelo.formulario.RepositorioFormulario;
import com.satpj.project.seguridad.CustomPrincipal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
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

import lombok.Getter;
import lombok.Setter;

/**
 * Servicio de la entidad Formulario Permite que se puedan acceder
 * a todos los servicios asociados a los Formularios de forma
 * REST
 */
@Getter
@Setter
@EnableAutoConfiguration(exclude= SecurityAutoConfiguration.class)
@RestController
@RequestMapping("formularios")
public class ServicioFormulario {

    @Autowired
    private RepositorioFormulario repositorioFormulario;

    @GetMapping(produces = "application/json; charset=UTF-8")
    public List<Formulario> findAll(@AuthenticationPrincipal CustomPrincipal customPrincipal) {
        return repositorioFormulario.findAll();
    }
    
    @GetMapping(value = "/pendientes-aprobacion", produces = "application/json; charset=UTF-8") 
    public List<Formulario> findAllPendientesAprobacion(@AuthenticationPrincipal CustomPrincipal customPrincipal) { 
        List<Formulario> formularios = repositorioFormulario.findAll(); 
        List<Formulario> formulariosPA = new ArrayList<Formulario>(); 
        for (Formulario formulario : formularios) { 
            if(formulario.getPaciente().getEstadoAprobado().equals("PendienteAprobacion")){ 
                formulariosPA.add(formulario); 
            } 
        } 
        return formulariosPA; 
    } 
 
    @GetMapping(value = "/aprobados", produces = "application/json; charset=UTF-8") 
    public List<Formulario> findAllAprobados(@AuthenticationPrincipal CustomPrincipal customPrincipal) { 
        List<Formulario> formularios = repositorioFormulario.findAll(); 
        List<Formulario> formulariosA = new ArrayList<Formulario>(); 
        for (Formulario formulario : formularios) { 
            if(formulario.getPaciente().getEstadoAprobado().equals("Aprobado")){ 
                formulariosA.add(formulario); 
            } 
        } 
        return formulariosA; 
    } 

    @GetMapping(value = "/{id}", produces = "application/json; charset=UTF-8")
    public Formulario findById(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id) {
        return repositorioFormulario.findById(id).get();
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Formulario create(@RequestBody Formulario formulario) {
        Preconditions.checkNotNull(formulario);
        return repositorioFormulario.save(formulario);
    }

    @PutMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void update(@PathVariable("id") Long id, @RequestBody Formulario formulario) {
        Preconditions.checkNotNull(formulario);

        Formulario fActualizar = repositorioFormulario.findById(formulario.getId()).orElse(null);

        Preconditions.checkNotNull(fActualizar);

        fActualizar.setFueAtendido(formulario.isFueAtendido());
        fActualizar.setLugarAtencion(formulario.getLugarAtencion());
        fActualizar.setMotivoConsulta(formulario.getMotivoConsulta());
        fActualizar.setRemitente(formulario.getRemitente());
        fActualizar.setPaciente(formulario.getPaciente());

        repositorioFormulario.save(fActualizar);
    }

    @DeleteMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void delete(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id) {
        repositorioFormulario.deleteById(id);
    }
    
}
