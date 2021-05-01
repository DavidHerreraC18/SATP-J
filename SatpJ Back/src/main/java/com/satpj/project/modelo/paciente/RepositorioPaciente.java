package com.satpj.project.modelo.paciente;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Interface RepositorioPaciente Permite realizar las consultas a la BD de la
 * Entidad paciente
 */
public interface RepositorioPaciente extends JpaRepository<Paciente, String> {
    List<Paciente> findByEmail(String email);
}
