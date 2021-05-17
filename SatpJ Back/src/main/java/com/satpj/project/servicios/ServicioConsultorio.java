package com.satpj.project.servicios;

import java.util.ArrayList;
import java.util.List;

import com.google.api.client.util.Preconditions;
import com.satpj.project.modelo.consultorio.Consultorio;
import com.satpj.project.modelo.consultorio.RepositorioConsultorio;
import com.satpj.project.modelo.sesion_terapia.SesionTerapia;
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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.annotation.AuthenticationPrincipal;

/**
 * Servicio de la entidad Auxiliar Administrativo Permite que se puedan acceder
 * a todos los servicios asociados a los Auxiliares Administrativos de forma
 * REST
 */
@Getter
@Setter
@EnableAutoConfiguration(exclude= SecurityAutoConfiguration.class)
@RestController
@RequestMapping("consultorios")
public class ServicioConsultorio {

    @Autowired
    private RepositorioConsultorio repositorioConsultorio;

    @Autowired
    private ServicioSesionTerapia servicioSesionTerapia;    

    @Autowired
    private ServicioPaciente servicioPaciente;

    @GetMapping(produces = "application/json")
    public List<Consultorio> findAll(@AuthenticationPrincipal CustomPrincipal customPrincipal) {
        return repositorioConsultorio.findAll();
    }

    @GetMapping(value = "/{id}", produces = "application/json")
    public Consultorio findById(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id) {
        return repositorioConsultorio.findById(id).get();
    }

    @GetMapping(value = "/consultorios-disponible", produces = "application/json")
    public List<Consultorio> findConsultorioBySesion(@AuthenticationPrincipal CustomPrincipal customPrincipal, @RequestBody SesionTerapia sesionTerapia) {
        Preconditions.checkNotNull(sesionTerapia);
        List<Consultorio> consultorios = this.findAll(customPrincipal);  
        List<Consultorio> respuesta = new ArrayList<Consultorio>();
        List<SesionTerapia> sesiones = servicioSesionTerapia.findSesionTerapiaByFecha(customPrincipal, sesionTerapia.getFecha());
        for(SesionTerapia sesion: sesiones)
        {
            if(!sesion.isVirtual()){
                for(Consultorio consultorio: consultorios){
                    if(sesion.getConsultorio().getConsultorio() != consultorio.getConsultorio()){
                        respuesta.add(consultorio);
                    }
                }
            }
        }
        return respuesta;
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Consultorio create(@AuthenticationPrincipal CustomPrincipal customPrincipal,@RequestBody Consultorio consultorio) {
        Preconditions.checkNotNull(consultorio);
        return repositorioConsultorio.save(consultorio);
    }

    @DeleteMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void delete(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id) {
        repositorioConsultorio.deleteById(id);
    }
}
