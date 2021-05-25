package com.satpj.project.modelo.practicante;

import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Interface RepositorioPracticante Permite realizar las consultas a la BD de la
 * Entidad practicante
 */
public interface RepositorioPracticante extends JpaRepository<Practicante, String> {

}
