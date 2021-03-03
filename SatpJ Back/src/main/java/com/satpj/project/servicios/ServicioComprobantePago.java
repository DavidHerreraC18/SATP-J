package com.satpj.project.servicios;

import java.util.List;

import com.google.api.client.util.Preconditions;
import com.satpj.project.modelo.comprobante_pago.*;
import com.satpj.project.modelo.informe_pago.InformePago;

import lombok.Getter;
import lombok.Setter;

import org.springframework.beans.factory.annotation.Autowired;
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

/**
 * Servicio de la entidad Comprobante de Pago Permite que se puedan acceder a
 * todos los servicios asociados a los Comprobantes de Pago de forma REST
 */
@Getter
@Setter
@RestController
@RequestMapping("comprobantespago")
public class ServicioComprobantePago {

    @Autowired
    private RepositorioComprobantePago repositorioComprobantePago;

    @Autowired
    private ServicioPaqueteSesion ServicioPaqueteSesion;

    @GetMapping(produces = "application/json")
    public List<ComprobantePago> findAll() {
        return repositorioComprobantePago.findAll();
    }

    @GetMapping(value = "/{id}", produces = "application/json")
    public ComprobantePago findById(@PathVariable("id") Long id) {
        return repositorioComprobantePago.findById(id).get();
    }

    /*
     * La funcion findInformesByComprobanteId tiene el proposito de evitar la
     * recursion en JSON que genera la relacion ComprobantePago - InformePago
     */
    @GetMapping(value = "/{id}/informes", produces = "application/json")
    public List<InformePago> findInformesByComprobanteId(@PathVariable("id") Long id) {
        ComprobantePago comprobantePago = repositorioComprobantePago.findById(id).get();
        Preconditions.checkNotNull(comprobantePago);
        return comprobantePago.getInformesPagos();
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public ComprobantePago create(@RequestBody ComprobantePago comprobantePago) {
        Preconditions.checkNotNull(comprobantePago);
        return repositorioComprobantePago.save(comprobantePago);
    }

    @PutMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void update(@PathVariable("id") Long id, @RequestBody ComprobantePago comprobantePago) {
        Preconditions.checkNotNull(comprobantePago);

        ComprobantePago cPagoActualizar = repositorioComprobantePago.findById(comprobantePago.getId()).orElse(null);

        Preconditions.checkNotNull(cPagoActualizar);

        cPagoActualizar.setFecha(comprobantePago.getFecha());
        cPagoActualizar.setValorTotal(comprobantePago.getValorTotal());
        cPagoActualizar.setObservacion(comprobantePago.getObservacion());
        cPagoActualizar.setPaqueteSesion(comprobantePago.getPaqueteSesion());
        cPagoActualizar.setReferenciaPago(comprobantePago.getReferenciaPago());

        repositorioComprobantePago.save(cPagoActualizar);
    }

    @DeleteMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void delete(@PathVariable("id") Long id) {

        repositorioComprobantePago.deleteById(id);
    }

}