package com.satpj.project.modelo.alerta;

import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Interface RepositorioAlerta Permite realizar las consultas a la BD de la
 * Entidad Alerta
 */
public interface RepositorioAlerta extends JpaRepository<Alerta, Long> {

}
