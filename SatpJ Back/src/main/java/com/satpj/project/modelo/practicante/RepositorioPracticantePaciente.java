package com.satpj.project.modelo.practicante;

import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Interface RepositorioPracticantePaciente Permite realizar las consultas a la
 * BD de la Entidad intermedia PracticantePaciente
 */
public interface RepositorioPracticantePaciente extends JpaRepository<PracticantePaciente, LlavePracticantePaciente> {

}
