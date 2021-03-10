package com.satpj.project.servicios;

import java.util.ArrayList;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import com.google.api.client.util.Preconditions;
import com.satpj.project.modelo.nota_evolucion.*;
import com.satpj.project.modelo.practicante.Practicante;
import com.satpj.project.modelo.supervisor.Supervisor;
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
 * Servicio de la entidad Nota de Evolución Permite que se puedan acceder a
 * todos los servicios asociados a las Notas de Evolución de forma REST
 */
@Getter
@Setter
@EnableAutoConfiguration(exclude= SecurityAutoConfiguration.class)
@RestController
@RequestMapping("notasevolucion")
public class ServicioNotaEvolucion {

    @Autowired
    private RepositorioNotaEvolucion repositorioNotaEvolucion;

    @Autowired
    private ServicioPracticante servicioPracticante;

    @Autowired
    private ServicioSupervisor servicioSupervisor;

    @GetMapping(produces = "application/json")
    public List<NotaEvolucion> findAll(@AuthenticationPrincipal CustomPrincipal customPrincipal) {
        return repositorioNotaEvolucion.findAll();
    }

    @GetMapping(value = "/{idSesion}/{idPracticante}", produces = "application/json")
    public NotaEvolucion findByLlaveNotaEvolucionId(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("idSesion") Long idSesion,
            @PathVariable("idPracticante") Long idPracticante) {
        LlaveNotaEvolucion llaveNotaEvolucion = new LlaveNotaEvolucion();
        llaveNotaEvolucion.setPracticanteId(idPracticante);
        llaveNotaEvolucion.setSesionTerapiaId(idSesion);
        return repositorioNotaEvolucion.findById(llaveNotaEvolucion).get();
    }

    @GetMapping(value = "/practicante/{idPracticante}", produces = "application/json")
    public List<NotaEvolucion> findAllNotasByPracticante(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("idPracticante") Long idPracticante) {
        Practicante practicante = servicioPracticante.findPracticanteById(customPrincipal, idPracticante);
        Preconditions.checkNotNull(practicante);
        Page<NotaEvolucion> notasEvolucion = repositorioNotaEvolucion.findByPracticanteId(practicante.getId(),
                Pageable.unpaged());
        return notasEvolucion.getContent();
    }

    @GetMapping(value = "/practicante/{idPracticante}/enviadas", produces = "application/json")
    public List<NotaEvolucion> findAllNotasByPracticanteEnviadas(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("idPracticante") Long idPracticante) {
        Practicante practicante = servicioPracticante.findPracticanteById(customPrincipal, idPracticante);
        Preconditions.checkNotNull(practicante);
        Page<NotaEvolucion> notasEvolucion = repositorioNotaEvolucion.findByPracticanteId(practicante.getId(),
                Pageable.unpaged());
        List<NotaEvolucion> notasEnviadas = new ArrayList<>();
        for (NotaEvolucion notaEvolucion : notasEvolucion.getContent()) {
            if (notaEvolucion.isEnviada()) {
                notasEnviadas.add(notaEvolucion);
            }
        }
        return notasEvolucion.getContent();
    }

    @GetMapping(value = "/practicante/{idPracticante}/noenviadas", produces = "application/json")
    public List<NotaEvolucion> findAllNotasByPracticanteNoEnviadas(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("idPracticante") Long idPracticante) {
        Practicante practicante = servicioPracticante.findPracticanteById(customPrincipal, idPracticante);
        Preconditions.checkNotNull(practicante);
        Page<NotaEvolucion> notasEvolucion = repositorioNotaEvolucion.findByPracticanteId(practicante.getId(),
                Pageable.unpaged());
        List<NotaEvolucion> notasEnviadas = new ArrayList<>();
        for (NotaEvolucion notaEvolucion : notasEvolucion.getContent()) {
            if (!notaEvolucion.isEnviada()) {
                notasEnviadas.add(notaEvolucion);
            }
        }
        return notasEvolucion.getContent();
    }

    @GetMapping(value = "/supervisor/{idSupervisor}", produces = "application/json")
    public List<NotaEvolucion> findAllNotasBySupervisor(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("idSupervisor") Long idSupervisor) {
        Supervisor supervisor = servicioSupervisor.findById(customPrincipal, idSupervisor);
        Preconditions.checkNotNull(supervisor);
        List<NotaEvolucion> notasEvolucion = repositorioNotaEvolucion.findBySupervisor(supervisor);
        return notasEvolucion;
    }

    @GetMapping(value = "/supervisor/{idSupervisor}/registradas", produces = "application/json")
    public List<NotaEvolucion> findAllNotasBySupervisorRegistradas(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("idSupervisor") Long idSupervisor) {
        Supervisor supervisor = servicioSupervisor.findById(customPrincipal, idSupervisor);
        Preconditions.checkNotNull(supervisor);
        List<NotaEvolucion> notasEvolucion = repositorioNotaEvolucion.findBySupervisor(supervisor);
        List<NotaEvolucion> notasRegistradas = new ArrayList<>();
        for (NotaEvolucion notaEvolucion : notasEvolucion) {
            if (notaEvolucion.isEnviada()) {
                notasRegistradas.add(notaEvolucion);
            }
        }
        return notasRegistradas;
    }

    @GetMapping(value = "/supervisor/{idSupervisor}/noregistradas", produces = "application/json")
    public List<NotaEvolucion> findAllNotasBySupervisorNoRegistradas(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("idSupervisor") Long idSupervisor) {
        Supervisor supervisor = servicioSupervisor.findById(customPrincipal, idSupervisor);
        Preconditions.checkNotNull(supervisor);
        List<NotaEvolucion> notasEvolucion = repositorioNotaEvolucion.findBySupervisor(supervisor);
        List<NotaEvolucion> notasRegistradas = new ArrayList<>();
        for (NotaEvolucion notaEvolucion : notasEvolucion) {
            if (notaEvolucion.isEnviada()) {
                notasRegistradas.add(notaEvolucion);
            }
        }
        return notasRegistradas;
    }

    @GetMapping(value = "/sesiones/{id}", produces = "application/json")
    public NotaEvolucion findBySesionTerapiaId(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id) {
        return repositorioNotaEvolucion.findByPracticanteId(id, Pageable.unpaged()).get().findFirst().get();
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public NotaEvolucion create(@AuthenticationPrincipal CustomPrincipal customPrincipal, @RequestBody NotaEvolucion notaEvolucion) {
        Preconditions.checkNotNull(notaEvolucion);
        return repositorioNotaEvolucion.save(notaEvolucion);
    }

    @PutMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void update(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id, @RequestBody NotaEvolucion notaEvolucion) {
        Preconditions.checkNotNull(notaEvolucion);
        NotaEvolucion neActualizar = repositorioNotaEvolucion.findById(notaEvolucion.getId()).orElse(null);
        Preconditions.checkNotNull(neActualizar);

        neActualizar.setContenido(notaEvolucion.getContenido());
        repositorioNotaEvolucion.save(neActualizar);
    }

    @DeleteMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void delete(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") Long id, @RequestBody NotaEvolucion notaEvolucion) {
        repositorioNotaEvolucion.deleteById(notaEvolucion.getId());
    }

}