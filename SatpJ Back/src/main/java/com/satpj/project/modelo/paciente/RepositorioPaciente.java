package com.satpj.project.modelo.paciente;

import org.springframework.data.jpa.repository.JpaRepository;


/**
 * Interface RepositorioPaciente
 * Permite realizar las consultas a la BD de la
 * Entidad paciente
 */
public interface RepositorioPaciente extends JpaRepository<Long, Paciente> {
    
}
