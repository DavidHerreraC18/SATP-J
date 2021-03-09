package com.satpj.project.servicios;

import java.util.List;

import com.google.api.client.util.Preconditions;
import com.satpj.project.modelo.comprobante_pago.ComprobantePago;
import com.satpj.project.modelo.informe_pago.*;
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
 * Servicio de la entidad Informe de Pago Permite que se puedan acceder a todos
 * los servicios asociados a los Informes de Pago de forma REST
 */
@Getter
@Setter
@EnableAutoConfiguration(exclude= SecurityAutoConfiguration.class)
@RestController
@RequestMapping("informepagos")
public class ServicioInformePago {

    @Autowired
    private RepositorioInformePago repositorioInformePago;

    @GetMapping(produces = "application/json")
    public List<InformePago> findAll(@AuthenticationPrincipal CustomPrincipal customPrincipal) {
        return repositorioInformePago.findAll();
    }

    @GetMapping(value = "/{id}", produces = "application/json")
    public InformePago findById(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id) {
        return repositorioInformePago.findById(id).get();
    }

    /*
     * La funcion findComprobantesByInformeId tiene el proposito de evitar la
     * recursion en JSON que genera la relacion ComprobantePago - InformePago debido
     * a que es muchos a muchos se genera una funcion en ambos servicios
     */
    @GetMapping(value = "/{id}/comprobantes", produces = "application/json")
    public List<ComprobantePago> findComprobantesByInformeId(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id) {
        InformePago informePago = repositorioInformePago.findById(id).get();
        Preconditions.checkNotNull(informePago);
        return informePago.getComprobatesPagos();
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public InformePago create(@AuthenticationPrincipal CustomPrincipal customPrincipal, @RequestBody InformePago informePago) {
        Preconditions.checkNotNull(informePago);
        return repositorioInformePago.save(informePago);
    }

    @PutMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void update(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id, @RequestBody InformePago informePago) {
        Preconditions.checkNotNull(informePago);
        InformePago ipActualizar = repositorioInformePago.findById(informePago.getId()).orElse(null);
        Preconditions.checkNotNull(ipActualizar);

        ipActualizar.setTotal(informePago.getTotal());
        ipActualizar.setFechaFin(informePago.getFechaFin());
        ipActualizar.setFechaInicio(informePago.getFechaInicio());
        repositorioInformePago.save(ipActualizar);
    }

    @DeleteMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void delete(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id) {
        InformePago informePago = repositorioInformePago.findById(id).orElse(null);
        Preconditions.checkNotNull(informePago);

        repositorioInformePago.deleteById(id);
    }

}