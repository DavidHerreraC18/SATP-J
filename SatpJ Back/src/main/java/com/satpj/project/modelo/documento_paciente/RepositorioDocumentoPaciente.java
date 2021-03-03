package com.satpj.project.modelo.documento_paciente;

import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Interface RepositorioDocumentoPaciente Permite realizar las consultas a la BD
 * de la Entidad documento_paciente
 */
public interface RepositorioDocumentoPaciente extends JpaRepository<DocumentoPaciente, Long> {

}
