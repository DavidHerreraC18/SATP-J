package com.satpj.project.modelo.sesion_terapia;

import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Interface RepositorioSesionUsuario Permite realizar las consultas a la BD de
 * la Entidad sesion_usuario
 */
public interface RepositorioSesionUsuario extends JpaRepository<SesionUsuario, LlaveSesionUsuario> {

}
