
package com.satpj.project.servicios;

import java.util.List;

import com.google.api.client.util.Preconditions;
import com.satpj.project.modelo.alerta.AlertaUsuario;
import com.satpj.project.modelo.horario.Horario;
import com.satpj.project.modelo.sesion_terapia.SesionUsuario;
import com.satpj.project.modelo.usuario.RepositorioUsuario;
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
 * Servicio de la entidad Usuario Permite que se puedan acceder a todos los
 * servicios asociados a los Usuarios de forma REST
 */
@Getter
@Setter
@EnableAutoConfiguration(exclude= SecurityAutoConfiguration.class)
@RestController
@RequestMapping("usuarios")
public class ServicioUsuario {

    @Autowired
    private RepositorioUsuario repositorioUsuario;

    @Autowired
    private ServicioAlerta servicioAlerta;

    @Autowired
    private ServicioHorario servicioHorario;

    @GetMapping(produces = "application/json; charset=UTF-8")
    public List<Usuario> findAll(@AuthenticationPrincipal CustomPrincipal customPrincipal) {
        return repositorioUsuario.findAll();
    }

    @GetMapping(value = "/{id}", produces = "application/json; charset=UTF-8")
    public Usuario findById(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") String id) {
        return repositorioUsuario.findById(id).get();
    }

    /*
     * La funcion findSesionesByUsuarioId tiene el proposito de evitar la recursion
     * en JSON que genera la relacion Usuario - SesionUsuario
     */
    @GetMapping(value = "/sesiones/{id}", produces = "application/json; charset=UTF-8")
    public List<SesionUsuario> findSesionesByUsuarioId(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") String id) {
        Usuario usuario = repositorioUsuario.findById(id).get();
        Preconditions.checkNotNull(usuario);
        return usuario.getSesiones();
    }

    /*
     * La funcion findHorariosByUsuarioId tiene el proposito de evitar la recursion
     * en JSON que genera la relacion Usuario - Horario
     */
    @GetMapping(value = "/horarios/{id}", produces = "application/json; charset=UTF-8")
    public List<Horario> findHorariosByUsuarioId(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") String id) {
        Usuario usuario = repositorioUsuario.findById(id).get();
        Preconditions.checkNotNull(usuario);
        return usuario.getHorarios();
    }

    /*
     * La funcion findHorariosByUsuarioId tiene el proposito de evitar la recursion
     * en JSON que genera la relacion Usuario - Horario
     */
    @GetMapping(value = "/horarios/seleccionado/{id}", produces = "application/json; charset=UTF-8")
    public Horario findHorarioSeleccionadoByUsuarioId(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") String id) {
        Usuario usuario = repositorioUsuario.findById(id).get();
        Preconditions.checkNotNull(usuario);
        Horario seleccionado = null;
        for(Horario horario: usuario.getHorarios()){
            if(horario.getOpcion().equals("Seleccionado"))
            {
                seleccionado = horario;
            }
        }
        Preconditions.checkNotNull(seleccionado);
        return seleccionado;
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Usuario create(@RequestBody Usuario usuario) {
        Preconditions.checkNotNull(usuario);
        return repositorioUsuario.save(usuario);
    }

    @PutMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void update(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") String id, @RequestBody Usuario usuario) {
        Preconditions.checkNotNull(usuario);

        Usuario uActualizar = repositorioUsuario.findById(usuario.getId()).orElse(null);

        Preconditions.checkNotNull(uActualizar);

        uActualizar.setApellido(usuario.getApellido());
        uActualizar.setNombre(usuario.getNombre());
        uActualizar.setTelefono(usuario.getTelefono());
        uActualizar.setTipoDocumento(usuario.getTipoDocumento());
        uActualizar.setDocumento(usuario.getDocumento());
        uActualizar.setEmail(usuario.getEmail());
        uActualizar.setDireccion(usuario.getDireccion());

        repositorioUsuario.save(uActualizar);
    }

    @DeleteMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void delete(@AuthenticationPrincipal CustomPrincipal customPrincipal, @PathVariable("id") String id) {
        Usuario usuario = repositorioUsuario.findById(id).orElse(null);
        Preconditions.checkNotNull(usuario);
        List<AlertaUsuario> alertasUsuario = usuario.getAlertasUsuario();
        for (AlertaUsuario alertaUsuario : alertasUsuario) {
            servicioAlerta.deleteAlertaUsuario(customPrincipal, alertaUsuario.getAlerta().getId(), alertaUsuario);
        }
        List<Horario> horarios = usuario.getHorarios();
        for (Horario horario : horarios) {
            servicioHorario.delete(customPrincipal, horario.getId());
        }
        repositorioUsuario.deleteById(id);
    }

}