package com.satpj.project.modelo.horario;

import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Interface RepositorioHorario Permite realizar las consultas a la BD de la
 * Entidad horario
 */
public interface RepositorioHorario extends JpaRepository<Horario, Long> {

}
