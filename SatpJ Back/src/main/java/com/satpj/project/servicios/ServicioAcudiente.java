package com.satpj.project.servicios;

import java.util.List;

import com.google.api.client.util.Preconditions;
import com.satpj.project.modelo.acudiente.RepositorioAcudiente;
import com.satpj.project.seguridad.CustomPrincipal;
import com.satpj.project.modelo.acudiente.Acudiente;

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
 * Servicio de la entidad Acudiente Permite que se puedan acceder a todos los
 * servicios asociados al Acudiente de forma REST
 */
@Getter
@Setter
@EnableAutoConfiguration(exclude= SecurityAutoConfiguration.class)
@RestController
@RequestMapping("acudientes")
public class ServicioAcudiente {

    @Autowired
    private RepositorioAcudiente repositorioAcudiente;

    @GetMapping(produces = "application/json; charset=UTF-8")
    public List<Acudiente> findAll(@AuthenticationPrincipal CustomPrincipal customPrincipal) {
        return repositorioAcudiente.findAll();
    }

    @GetMapping(value = "/{id}", produces = "application/json; charset=UTF-8")
    public Acudiente findById(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") String id) {
        return repositorioAcudiente.findById(id).get();
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Acudiente create(@RequestBody Acudiente acudiente) {
        Preconditions.checkNotNull(acudiente);
        return repositorioAcudiente.save(acudiente);
    }

    @PutMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void update(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id, @RequestBody Acudiente acudiente) {
        Preconditions.checkNotNull(acudiente);

        Acudiente aActualizar = repositorioAcudiente.findById(acudiente.getId()).orElse(null);

        Preconditions.checkNotNull(aActualizar);

        aActualizar.setApellido(acudiente.getApellido());
        aActualizar.setNombre(acudiente.getNombre());
        aActualizar.setTelefono(acudiente.getTelefono());
        aActualizar.setTipoDocumento(acudiente.getTipoDocumento());
        aActualizar.setDocumento(acudiente.getDocumento());
        aActualizar.setEmail(acudiente.getEmail());
        aActualizar.setPaciente(acudiente.getPaciente());

        repositorioAcudiente.save(aActualizar);
    }

    @DeleteMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void delete(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") String id) {
        repositorioAcudiente.deleteById(id);
    }

}