package com.satpj.project.modelo.sesion_terapia;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Interface RepositorioSesionUsuario Permite realizar las consultas a la BD de
 * la Entidad sesion_usuario
 */
public interface RepositorioSesionUsuario extends JpaRepository<SesionUsuario, LlaveSesionUsuario> {
    List<SesionUsuario> findByIdUsuarioId(String usuario_id);
}
