package com.satpj.project.modelo.supervisor;

import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Interface RepositorioSupervisor Permite realizar las consultas a la BD de la
 * Entidad supervisor
 */
public interface RepositorioSupervisor extends JpaRepository<Supervisor, String> {

}
