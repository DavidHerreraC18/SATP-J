package com.satpj.project.servicios;

import java.util.ArrayList;
import java.util.List;

import com.google.api.client.util.Preconditions;
import com.google.gson.Gson;
import com.satpj.project.modelo.acudiente.Acudiente;
import com.satpj.project.modelo.acudiente.RepositorioAcudiente;
import com.satpj.project.modelo.formulario.Formulario;
import com.satpj.project.modelo.formulario.RepositorioFormulario;
import com.satpj.project.modelo.grupo.Grupo;
import com.satpj.project.modelo.grupo.RepositorioGrupo;
import com.satpj.project.modelo.paciente.Paciente;
import com.satpj.project.modelo.paciente.RepositorioPaciente;
import com.satpj.project.modelo.usuario.RepositorioUsuario;
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
 * Servicio de la entidad Formulario Permite que se puedan acceder a todos los
 * servicios asociados a los Formularios de forma REST
 */
@Getter
@Setter
@EnableAutoConfiguration(exclude = SecurityAutoConfiguration.class)
@RestController
@RequestMapping("formularios")
public class ServicioFormulario {

    @Autowired
    private RepositorioFormulario repositorioFormulario;

    @Autowired
    private RepositorioGrupo repositorioGrupo;

    @Autowired
    private RepositorioPaciente repositorioPaciente;

    @Autowired
    private RepositorioUsuario repositorioUsuario;

    @Autowired
    private RepositorioAcudiente repositorioAcudiente;

    @GetMapping(produces = "application/json; charset=UTF-8")
    public List<Formulario> findAll(@AuthenticationPrincipal CustomPrincipal customPrincipal) {
        return repositorioFormulario.findAll();
    }

    @GetMapping(value = "/pendientes-aprobacion", produces = "application/json; charset=UTF-8")
    public List<Formulario> findAllPendientesAprobacion(@AuthenticationPrincipal CustomPrincipal customPrincipal) {
        List<Formulario> formularios = repositorioFormulario.findAll();
        List<Formulario> formulariosPA = new ArrayList<Formulario>();
        for (Formulario formulario : formularios) {
            if (formulario.getPaciente().getEstadoAprobado().equals("PendienteAprobacion")) {
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
            if (formulario.getPaciente().getEstadoAprobado().equals("Aprobado")) {
                formulariosA.add(formulario);
            }
        }
        return formulariosA;
    }

    @GetMapping(value = "/{id}", produces = "application/json; charset=UTF-8")
    public Formulario findById(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id) {
        return repositorioFormulario.findById(id).get();
    }

    @PostMapping()
    @ResponseStatus(HttpStatus.CREATED)
    public Formulario create(@RequestBody String json) {

        Formulario formulario = new Gson().fromJson(json, Formulario.class);

        if (formulario.getPaciente() != null) {

            List<Acudiente> acudientes = formulario.getPaciente().getAcudientes();
            formulario.getPaciente().setAcudientes(null);
            repositorioUsuario.save(formulario.getPaciente());
            Paciente paciente = repositorioPaciente.save(formulario.getPaciente());

            if (acudientes != null) {
                if (acudientes.size() > 0) {
                    for (Acudiente a : acudientes) {
                        a = repositorioUsuario.save(a);
                        a.setPaciente(paciente);
                        repositorioAcudiente.save(a);
                    }

                }
            }

        }

        return repositorioFormulario.save(formulario);
    }

    @PostMapping(path = "/grupal")
    @ResponseStatus(HttpStatus.CREATED)
    public Grupo createGrupal(@RequestBody String json) {
        
        Grupo grupo = new Gson().fromJson(json, Grupo.class);
        if (grupo != null) {
            List<Paciente> integrantes = grupo.getIntegrantes();
            grupo.setIntegrantes(null);
            grupo = repositorioGrupo.save(grupo);
            for (Paciente p : integrantes) {
                if (p != null) {
                    
                    Formulario formulario = p.getFormulario();
                    p.setFormulario(null);
                    
                    repositorioUsuario.save(p);
                    
                    p = repositorioPaciente.save(p);
                    p.setGrupo(grupo);
                    repositorioPaciente.save(p);
                    
                    formulario.setPaciente(p);
                    repositorioFormulario.save(formulario);
                }
            }
        }
        return grupo;
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
