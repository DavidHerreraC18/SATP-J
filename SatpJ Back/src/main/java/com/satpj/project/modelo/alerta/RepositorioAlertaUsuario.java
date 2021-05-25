package com.satpj.project.modelo.alerta;

import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Interface RepositorioAlertaUsuario Permite realizar las consultas a la BD de
 * la Entidad AlertaUsuario
 */
public interface RepositorioAlertaUsuario extends JpaRepository<AlertaUsuario, LlaveAlertaUsuario> {

}
