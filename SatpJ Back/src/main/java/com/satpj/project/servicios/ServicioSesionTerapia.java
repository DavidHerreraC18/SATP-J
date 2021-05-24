package com.satpj.project.servicios;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.google.api.client.util.Preconditions;
import com.satpj.project.email.ServicioEmail;
import com.satpj.project.modelo.acudiente.Acudiente;
import com.satpj.project.modelo.auxiliar_administrativo.AuxiliarAdministrativo;
import com.satpj.project.modelo.grupo.Grupo;
import com.satpj.project.modelo.paciente.Paciente;
import com.satpj.project.modelo.practicante.Practicante;
import com.satpj.project.modelo.sesion_terapia.*;
import com.satpj.project.modelo.supervisor.Supervisor;
import com.satpj.project.modelo.usuario.Usuario;
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
 * Servicio de la entidad SesionTerapia Permite que se puedan acceder a todos
 * los servicios asociados a las Sesiones de Terapia de forma REST
 */
@Getter
@Setter
@EnableAutoConfiguration(exclude = SecurityAutoConfiguration.class)
@RestController
@RequestMapping("sesionterapias")
public class ServicioSesionTerapia {

    @Autowired
    private ServicioPaciente servicioPaciente;

    @Autowired
    private ServicioAuxiliarAdministrativo servicioAuxiliarAdministrativo;

    @Autowired
    private RepositorioSesionTerapia repositorioSesionTerapia;

    @Autowired
    private RepositorioSesionUsuario repositorioSesionUsuario;

    @Autowired
    private ServicioUsuario servicioUsuario;

    @Autowired
    private ServicioEmail servicioEmail;

    @GetMapping(produces = "application/json; charset=UTF-8")
    public List<SesionTerapia> findAllSesionesTerapia(@AuthenticationPrincipal CustomPrincipal customPrincipal) {
        return repositorioSesionTerapia.findAll();
    }

    @GetMapping(value = "/{id}/usuarios", produces = "application/json; charset=UTF-8")
    public List<Usuario> findAllUsuariosSesion(@AuthenticationPrincipal CustomPrincipal customPrincipal,
            @PathVariable("id") Long id) {
        SesionTerapia sesionTerapia = findSesionTerapiaById(customPrincipal, id);
        List<Usuario> usuarios = new ArrayList<>();
        for (SesionUsuario sesionUsuario : sesionTerapia.getSesiones()) {
            Usuario usuarioSesion = servicioUsuario.findById(customPrincipal, sesionUsuario.getId().getUsuarioId());
            usuarios.add(usuarioSesion);
        }
        return usuarios;
    }

    @GetMapping(value = "/{id}", produces = "application/json; charset=UTF-8")
    public SesionTerapia findSesionTerapiaById(@AuthenticationPrincipal CustomPrincipal customPrincipal,
            @PathVariable("id") Long id) {
        return repositorioSesionTerapia.findById(id).get();
    };

    @GetMapping(value = "/{idSesion}/{idUsuario}", produces = "application/json; charset=UTF-8")
    public SesionUsuario findSesionUsuarioById(@AuthenticationPrincipal CustomPrincipal customPrincipal,
            @PathVariable("idSesion") Long idSesion, @PathVariable("idUsuario") String idUsuario) {
        LlaveSesionUsuario llaveSesionUsuario = new LlaveSesionUsuario();
        llaveSesionUsuario.setSesion_terapia_id(idSesion);
        llaveSesionUsuario.setUsuarioId(idUsuario);
        return repositorioSesionUsuario.findById(llaveSesionUsuario).get();
    }

    @PostMapping(value = "/sesiones-posibles/{id}", produces = "application/json; charset=UTF-8")
    public SesionTerapiaActual findSesionTerapiaActualById(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") String id, @RequestBody SesionTerapiaActual sesionTerapiaActual) {
        List<SesionUsuario> sesionesUsuario = servicioUsuario.findSesionesByUsuarioId(customPrincipal, id);
        for (SesionUsuario sUsuario : sesionesUsuario) {
            SesionTerapia sT = sUsuario.getSesionTerapia();
            LocalDateTime fechaIni = sT.getFecha();
            LocalDateTime fechaFin = fechaIni.plusHours(1);
            if(sesionTerapiaActual.getFecha().isAfter(fechaIni) && sesionTerapiaActual.getFecha().isBefore(fechaFin)){
                sesionTerapiaActual.setPosible(true);
            }
        }
        return sesionTerapiaActual;
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public SesionTerapia createSesionTerapia(@AuthenticationPrincipal CustomPrincipal customPrincipal,
            @RequestBody SesionTerapia sesionTerapia) {
        Preconditions.checkNotNull(sesionTerapia);
        return repositorioSesionTerapia.save(sesionTerapia);
    }

    @PutMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void updateSesionTerapia(@AuthenticationPrincipal CustomPrincipal customPrincipal,
            @PathVariable("id") Long id, @RequestBody SesionTerapia sesionTerapia) {
        Preconditions.checkNotNull(sesionTerapia);

        SesionTerapia stActualizar = repositorioSesionTerapia.findById(sesionTerapia.getId()).get();

        Preconditions.checkNotNull(stActualizar);
        stActualizar.setConsultorio(sesionTerapia.getConsultorio());
        stActualizar.setFecha(sesionTerapia.getFecha());
        stActualizar.setPaqueteSesion(sesionTerapia.getPaqueteSesion());
        stActualizar.setVirtual(sesionTerapia.isVirtual());

        repositorioSesionTerapia.save(stActualizar);
    }

    @DeleteMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void deleteSesionTerapia(@AuthenticationPrincipal CustomPrincipal customPrincipal,
            @PathVariable("id") Long id) {
        SesionTerapia sesionTerapia = repositorioSesionTerapia.findById(id).get();
        Preconditions.checkNotNull(sesionTerapia);

        List<SesionUsuario> sesionesUsuario = sesionTerapia.getSesiones();
        for (SesionUsuario sesionUsuario : sesionesUsuario) {
            deleteSesionUsuario(customPrincipal, sesionUsuario.getId().getSesion_terapia_id(),
                    sesionUsuario.getId().getUsuarioId());
        }

        repositorioSesionTerapia.deleteById(id);
    }

    @DeleteMapping(value = "{idSesion}/{idUsuario}")
    @ResponseStatus(HttpStatus.OK)
    public void deleteSesionUsuario(@AuthenticationPrincipal CustomPrincipal customPrincipal,
            @PathVariable("idSesion") Long idSesion, @PathVariable("idUsuario") String idUsuario) {
        SesionUsuario sesionUsuario = this.findSesionUsuarioById(customPrincipal, idSesion, idUsuario);
        Preconditions.checkNotNull(sesionUsuario);

        repositorioSesionUsuario.deleteById(sesionUsuario.getId());
    }

    @GetMapping(value = "/fechas", produces = "application/json; charset=UTF-8")
    public List<SesionTerapia> findSesionTerapiaByFecha(@AuthenticationPrincipal CustomPrincipal customPrincipal,
            @RequestBody LocalDateTime dateTime) {
        return repositorioSesionTerapia.findByFecha(dateTime);
    }

    @GetMapping(value = "/usuario/{idUsuario}", produces = "application/json; charset=UTF-8")
    public List<SesionUsuario> findSesionUsuarioByUsuarioId(@AuthenticationPrincipal CustomPrincipal customPrincipal,
            @PathVariable("idUsuario") String idUsuario) {
        List<SesionUsuario> sesionesUsuario = repositorioSesionUsuario.findByIdUsuarioId(idUsuario);
        return sesionesUsuario;
    }

    @PostMapping(value = "/usuarios")
    @ResponseStatus(HttpStatus.CREATED)
    public SesionUsuario createSesionUsuario(@AuthenticationPrincipal CustomPrincipal customPrincipal,
            @RequestBody SesionUsuario sesionUsuario) {
        Preconditions.checkNotNull(sesionUsuario);
        Usuario usuarioSesion = servicioUsuario.findById(customPrincipal, sesionUsuario.getId().getUsuarioId());
        SesionTerapia sesionTerapia = this.findSesionTerapiaById(customPrincipal,
                sesionUsuario.getId().getSesion_terapia_id());
        if (usuarioSesion != null && sesionTerapia != null) {
            sesionUsuario.setSesionTerapia(sesionTerapia);
            sesionUsuario.setUsuario(usuarioSesion);
            if (usuarioSesion.getTipoUsuario().equals("Paciente")) {
                Paciente paciente = servicioPaciente.findById(customPrincipal, usuarioSesion.getId());
                Grupo grupo = paciente.getGrupo();
                if (grupo != null) {
                    for (Paciente pacienteGrupo : grupo.getIntegrantes()) {
                        SesionUsuario nuevaSesionUsuario = new SesionUsuario();
                        LlaveSesionUsuario llaveSesionUsuario = new LlaveSesionUsuario();
                        llaveSesionUsuario.setSesion_terapia_id(sesionTerapia.getId());
                        llaveSesionUsuario.setUsuarioId(pacienteGrupo.getId());
                        nuevaSesionUsuario.setId(llaveSesionUsuario);
                        Usuario usuarioSesionGrupo = servicioUsuario.findById(customPrincipal, pacienteGrupo.getId());
                        nuevaSesionUsuario.setUsuario(usuarioSesionGrupo);
                        nuevaSesionUsuario.setSesionTerapia(sesionTerapia);
                        nuevaSesionUsuario.setObservador(false);
                        repositorioSesionUsuario.save(nuevaSesionUsuario);
                    }
                }
                for (Acudiente acudiente : paciente.getAcudientes()) {
                    SesionUsuario nuevaSesionUsuario = new SesionUsuario();
                    LlaveSesionUsuario llaveSesionUsuario = new LlaveSesionUsuario();
                    llaveSesionUsuario.setSesion_terapia_id(sesionTerapia.getId());
                    llaveSesionUsuario.setUsuarioId(acudiente.getId());
                    nuevaSesionUsuario.setId(llaveSesionUsuario);
                    Usuario usuarioSesionGrupo = servicioUsuario.findById(customPrincipal, acudiente.getId());
                    nuevaSesionUsuario.setUsuario(usuarioSesionGrupo);
                    nuevaSesionUsuario.setSesionTerapia(sesionTerapia);
                    nuevaSesionUsuario.setObservador(true);
                    repositorioSesionUsuario.save(nuevaSesionUsuario);
                }
                Supervisor supervisor = paciente.getSupervisor();
                if (supervisor != null) {
                    SesionUsuario nuevaSesionUsuario = new SesionUsuario();
                    LlaveSesionUsuario llaveSesionUsuario = new LlaveSesionUsuario();
                    llaveSesionUsuario.setSesion_terapia_id(sesionTerapia.getId());
                    llaveSesionUsuario.setUsuarioId(supervisor.getId());
                    nuevaSesionUsuario.setId(llaveSesionUsuario);
                    Usuario usuarioSesionGrupo = servicioUsuario.findById(customPrincipal, supervisor.getId());
                    nuevaSesionUsuario.setUsuario(usuarioSesionGrupo);
                    nuevaSesionUsuario.setSesionTerapia(sesionTerapia);
                    nuevaSesionUsuario.setObservador(true);
                    repositorioSesionUsuario.save(nuevaSesionUsuario);
                }
                Practicante practicante = servicioPaciente.findPracticanteActivoByPacienteId(customPrincipal,
                        paciente.getId());
                if (practicante != null) {
                    SesionUsuario nuevaSesionUsuario = new SesionUsuario();
                    LlaveSesionUsuario llaveSesionUsuario = new LlaveSesionUsuario();
                    llaveSesionUsuario.setSesion_terapia_id(sesionTerapia.getId());
                    llaveSesionUsuario.setUsuarioId(practicante.getId());
                    nuevaSesionUsuario.setId(llaveSesionUsuario);
                    Usuario usuarioSesionGrupo = servicioUsuario.findById(customPrincipal, practicante.getId());
                    nuevaSesionUsuario.setUsuario(usuarioSesionGrupo);
                    nuevaSesionUsuario.setSesionTerapia(sesionTerapia);
                    nuevaSesionUsuario.setObservador(false);
                    repositorioSesionUsuario.save(nuevaSesionUsuario);
                }

            }
            List<AuxiliarAdministrativo> auxiliares = servicioAuxiliarAdministrativo.findAll(customPrincipal);
            for (AuxiliarAdministrativo auxiliar : auxiliares) {
                SesionUsuario nuevaSesionUsuario = new SesionUsuario();
                LlaveSesionUsuario llaveSesionUsuario = new LlaveSesionUsuario();
                llaveSesionUsuario.setSesion_terapia_id(sesionTerapia.getId());
                llaveSesionUsuario.setUsuarioId(auxiliar.getId());
                nuevaSesionUsuario.setId(llaveSesionUsuario);
                Usuario usuarioSesionGrupo = servicioUsuario.findById(customPrincipal, auxiliar.getId());
                nuevaSesionUsuario.setUsuario(usuarioSesionGrupo);
                nuevaSesionUsuario.setSesionTerapia(sesionTerapia);
                nuevaSesionUsuario.setObservador(true);
                repositorioSesionUsuario.save(nuevaSesionUsuario);
            }
            return repositorioSesionUsuario.save(sesionUsuario);
        }
        return null;

    }

    @PostMapping(value = "/compartir")
    @ResponseStatus(HttpStatus.CREATED)
    public void compartirEnlaceSesionTerapia(@AuthenticationPrincipal CustomPrincipal customPrincipal,
            @RequestBody SesionTerapia sesionTerapia) {
        SesionTerapia sesion = repositorioSesionTerapia.findById(sesionTerapia.getId()).get();

        Usuario supervisor = null;
        Usuario practicante = null;
        List<Usuario> acudientes = new ArrayList<Usuario>();

        for (SesionUsuario sesionUsuario : sesion.getSesiones()) {
            Usuario usuario = sesionUsuario.getUsuario();
            if (usuario.getTipoUsuario().equals("Supervisor")) {
                supervisor = usuario;
            }
            if (usuario.getTipoUsuario().equals("Acudiente")) {
                acudientes.add(usuario);
            }
            if (usuario.getTipoUsuario().equals("Practicante")) {
                practicante = usuario;
            }

        }

        if (practicante != null) {
            if (supervisor != null) {
                servicioEmail.sendEmailCompartirSesion(customPrincipal, supervisor.getId(), practicante.getId(),
                        sesion.getEnlaceStreaming(), "compartir_sesion");
            }
            if (!acudientes.isEmpty()) {
                for (Usuario a : acudientes) {
                    servicioEmail.sendEmailCompartirSesion(customPrincipal, a.getId(), practicante.getId(),
                            sesion.getEnlaceStreaming(), "compartir_sesion");
                }
            }
        }

    }

}