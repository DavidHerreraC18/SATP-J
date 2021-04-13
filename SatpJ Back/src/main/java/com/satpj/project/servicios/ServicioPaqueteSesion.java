package com.satpj.project.servicios;

import java.util.List;

import com.google.api.client.util.Preconditions;
import com.satpj.project.modelo.comprobante_pago.ComprobantePago;
import com.satpj.project.modelo.paquete_sesion.*;
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
 * Servicio de la entidad Paquete Sesion Permite que se puedan acceder a todos
 * los servicios asociados a los Paquetes de Sesiones de forma REST
 */
@Getter
@Setter
@EnableAutoConfiguration(exclude= SecurityAutoConfiguration.class)
@RestController
@RequestMapping("paquetesesiones")
public class ServicioPaqueteSesion {

    @Autowired
    private RepositorioPaqueteSesion repositorioPaqueteSesion;

    @Autowired
    private ServicioComprobantePago servicioComprobantePago;

    @GetMapping(produces = "application/json; charset=UTF-8")
    public List<PaqueteSesion> findAll(@AuthenticationPrincipal CustomPrincipal customPrincipal) {
        return repositorioPaqueteSesion.findAll();
    }

    @GetMapping(value = "/{id}", produces = "application/json; charset=UTF-8")
    public PaqueteSesion findById(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id) {
        return repositorioPaqueteSesion.findById(id).get();
    }

    /*
     * La funcion findComprobanteByPaqueteId tiene el proposito de evitar la
     * recursion en JSON que genera la relacion PaqueteSesion - ComprobantePago
     */
    @GetMapping(value = "/{id}/comprobante", produces = "application/json; charset=UTF-8")
    public ComprobantePago findComprobanteByPaqueteId(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id) {
        PaqueteSesion paqueteSesion = repositorioPaqueteSesion.findById(id).get();
        Preconditions.checkNotNull(paqueteSesion);
        return paqueteSesion.getComprobantePago();
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public PaqueteSesion create(@AuthenticationPrincipal CustomPrincipal customPrincipal, @RequestBody PaqueteSesion paqueteSesion) {
        Preconditions.checkNotNull(paqueteSesion);
        return repositorioPaqueteSesion.save(paqueteSesion);
    }

    @PutMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void update(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id, @RequestBody PaqueteSesion paqueteSesion) {
        Preconditions.checkNotNull(paqueteSesion);

        PaqueteSesion psActualizar = repositorioPaqueteSesion.findById(paqueteSesion.getId()).orElse(null);

        Preconditions.checkNotNull(psActualizar);

        psActualizar.setCantidadSesiones(paqueteSesion.getCantidadSesiones());
        psActualizar.setTotal(paqueteSesion.getTotal());
        psActualizar.setPaciente(paqueteSesion.getPaciente());
        psActualizar.setFecha(paqueteSesion.getFecha());

        repositorioPaqueteSesion.save(psActualizar);
    }

    @DeleteMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void delete(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id) {
        PaqueteSesion paqueteSesion = repositorioPaqueteSesion.findById(id).orElse(null);
        Preconditions.checkNotNull(paqueteSesion);

        // Eliminar el comprobante de Pago para no dejar la relacion sola
        // ComprobantePago comprobantePago = paqueteSesion.getComprobantePago();
        // servicioComprobantePago.delete(comprobantePago.getId());

        repositorioPaqueteSesion.deleteById(id);
    }

}