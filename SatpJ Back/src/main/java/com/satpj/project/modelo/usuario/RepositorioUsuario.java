package com.satpj.project.modelo.usuario;

import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Interface RepositorioUsuario Permite realizar las consultas a la BD de la
 * Entidad usuario
 */
public interface RepositorioUsuario extends JpaRepository<Usuario, String> {
}
