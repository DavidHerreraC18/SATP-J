package com.satpj.project.modelo.horario;

import java.util.List;

import com.satpj.project.modelo.usuario.Usuario;

import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Interface RepositorioHorario Permite realizar las consultas a la BD de la
 * Entidad horario
 */
public interface RepositorioHorario extends JpaRepository<Horario, Long> {
    
    List<Horario> findByUsuario(Usuario usuario);

}
