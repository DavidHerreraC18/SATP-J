package com.satpj.project.servicios;

import java.util.List;

import com.google.api.client.util.Preconditions;
import com.satpj.project.modelo.tarifa_sesion.*;
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

@Getter
@Setter
@EnableAutoConfiguration(exclude= SecurityAutoConfiguration.class)
@RestController
@RequestMapping("tarifas")
public class ServicioTarifaSesion {

    @Autowired
    private RepositorioTarifaSesion repositorioTarifaSesion;

    @GetMapping(produces = "application/json")
    public List<TarifaSesion> findAll(@AuthenticationPrincipal CustomPrincipal customPrincipal) {
        return repositorioTarifaSesion.findAll();
    }

    @GetMapping(value = "/{id}", produces = "application/json")
    public TarifaSesion findById(@AuthenticationPrincipal CustomPrincipal customPrincipal,@PathVariable("id") Long id) {
        return repositorioTarifaSesion.findById(id).get();
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public TarifaSesion create(@AuthenticationPrincipal CustomPrincipal customPrincipal,@RequestBody TarifaSesion tarifaSesion) {
        Preconditions.checkNotNull(tarifaSesion);
        return repositorioTarifaSesion.save(tarifaSesion);
    }

    @PutMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void update(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id, @RequestBody TarifaSesion tarifaSesion) {
        Preconditions.checkNotNull(tarifaSesion);

        TarifaSesion tfActualizar = repositorioTarifaSesion.findById(tarifaSesion.getId()).orElse(null);

        Preconditions.checkNotNull(tfActualizar);

        tfActualizar.setEstrato(tarifaSesion.getEstrato());
        tfActualizar.setTarifa(tarifaSesion.getTarifa());

        repositorioTarifaSesion.save(tfActualizar);
    }

    @DeleteMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void delete(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id) {
        repositorioTarifaSesion.deleteById(id);
    }


}
