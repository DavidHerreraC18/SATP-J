package com.satpj.project.servicios;

import java.util.ArrayList;
import java.util.List;

import com.google.api.client.util.Preconditions;
import com.satpj.project.modelo.formulario.FormularioExtra;
import com.satpj.project.modelo.formulario.RepositorioFormularioExtra;
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
@RequestMapping("formularios-extra")
public class ServicioFormularioExtra {

    @Autowired
    private RepositorioFormularioExtra repositorioFormularioExtra;

    @GetMapping(produces = "application/json; charset=UTF-8")
    public List<FormularioExtra> findAll(@AuthenticationPrincipal CustomPrincipal customPrincipal) {
        return repositorioFormularioExtra.findAll();
    }
    
    @GetMapping(value = "/pre-aprobados", produces = "application/json; charset=UTF-8") 
    public List<FormularioExtra> findAllPreAprobados(@AuthenticationPrincipal CustomPrincipal customPrincipal) { 
        List<FormularioExtra> formularios = repositorioFormularioExtra.findAll(); 
        List<FormularioExtra> formulariosPA = new ArrayList<FormularioExtra>(); 
        for (FormularioExtra formulario : formularios) { 
            if(formulario.getPaciente().getEstadoAprobado().equals("PreAprobado")){ 
                formulariosPA.add(formulario); 
            } 
        } 
        return formulariosPA; 
    } 
 
    @GetMapping(value = "/aprobados", produces = "application/json; charset=UTF-8") 
    public List<FormularioExtra> findAllAprobados(@AuthenticationPrincipal CustomPrincipal customPrincipal) { 
        List<FormularioExtra> formularios = repositorioFormularioExtra.findAll(); 
        List<FormularioExtra> formulariosA = new ArrayList<FormularioExtra>(); 
        for (FormularioExtra formulario : formularios) { 
            if(formulario.getPaciente().getEstadoAprobado().equals("Aprobado")){ 
                formulariosA.add(formulario); 
            } 
        } 
        return formulariosA; 
    } 

    @GetMapping(value = "/{id}", produces = "application/json; charset=UTF-8")
    public FormularioExtra findById(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id) {
        return repositorioFormularioExtra.findById(id).get();
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public FormularioExtra create(@RequestBody FormularioExtra formulario) {
        Preconditions.checkNotNull(formulario);
        return repositorioFormularioExtra.save(formulario);
    }

    @PutMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void update(@PathVariable("id") Long id, @RequestBody FormularioExtra formulario) {
        Preconditions.checkNotNull(formulario);

        FormularioExtra fActualizar = repositorioFormularioExtra.findById(formulario.getId()).orElse(null);

        Preconditions.checkNotNull(fActualizar);

        fActualizar.setEps(formulario.getEps());
        fActualizar.setEscolaridad(formulario.getEscolaridad());
        fActualizar.setEstadoCivil(formulario.getEstadoCivil());
        fActualizar.setNombreAcudiente1(formulario.getNombreAcudiente1());
        fActualizar.setNombreAcudiente2(formulario.getNombreAcudiente2());
        fActualizar.setNumeroAcudiente1(formulario.getNumeroAcudiente1());
        fActualizar.setNumeroAcudiente2(formulario.getNumeroAcudiente2());
        fActualizar.setOcupacion(formulario.getOcupacion());
        fActualizar.setPaciente(formulario.getPaciente());
        fActualizar.setTieneEps(formulario.isTieneEps());
        fActualizar.setLugarOcupacion(formulario.getLugarOcupacion());
        fActualizar.setServicio(formulario.getServicio());
        repositorioFormularioExtra.save(fActualizar);
    }

    @DeleteMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void delete(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id) {
        repositorioFormularioExtra.deleteById(id);
    }
    
}
