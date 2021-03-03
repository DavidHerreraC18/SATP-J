
package com.satpj.project.servicios;

import java.util.List;

import com.google.api.client.util.Preconditions;
import com.satpj.project.modelo.alerta.AlertaUsuario;
import com.satpj.project.modelo.horario.Horario;
import com.satpj.project.modelo.usuario.RepositorioUsuario;
import com.satpj.project.modelo.usuario.Usuario;

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
 * Servicio de la entidad Usuario Permite que se puedan acceder a todos los
 * servicios asociados a los Usuarios de forma REST
 */
@Getter
@Setter
@RestController
@RequestMapping("usuarios")
public class ServicioUsuario {

    @Autowired
    private RepositorioUsuario repositorioUsuario;

    @Autowired
    private ServicioAlerta servicioAlerta;

    @Autowired
    private ServicioHorario servicioHorario;

    @GetMapping(produces = "application/json")
    public List<Usuario> findAll() {
        return repositorioUsuario.findAll();
    }

    @GetMapping(value = "/{id}", produces = "application/json")
    public Usuario findById(@PathVariable("id") Long id) {
        return repositorioUsuario.findById(id).get();
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Usuario create(@RequestBody Usuario usuario) {
        Preconditions.checkNotNull(usuario);
        return repositorioUsuario.save(usuario);
    }

    @PutMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void update(@PathVariable("id") Long id, @RequestBody Usuario usuario) {
        Preconditions.checkNotNull(usuario);

        Usuario uActualizar = repositorioUsuario.findById(usuario.getId()).orElse(null);

        Preconditions.checkNotNull(uActualizar);

        uActualizar.setApellido(usuario.getApellido());
        uActualizar.setNombre(usuario.getNombre());
        uActualizar.setTelefono(usuario.getTelefono());
        uActualizar.setTipoDocumento(usuario.getTipoDocumento());
        uActualizar.setDocumento(usuario.getDocumento());
        uActualizar.setEmail(usuario.getEmail());

        repositorioUsuario.save(uActualizar);
    }

    @DeleteMapping(value = "/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void delete(@PathVariable("id") Long id) {

        Usuario usuario = repositorioUsuario.findById(id).orElse(null);
        Preconditions.checkNotNull(usuario);

        List<AlertaUsuario> alertasUsuario = usuario.getAlertasUsuario();
        for (AlertaUsuario alertaUsuario : alertasUsuario) {
            servicioAlerta.deleteAlertaUsuario(alertaUsuario.getAlerta().getId(), alertaUsuario);
        }

        List<Horario> horarios = usuario.getHorarios();
        for (Horario horario : horarios) {
            servicioHorario.delete(horario.getId());
        }

        repositorioUsuario.deleteById(id);
    }

}