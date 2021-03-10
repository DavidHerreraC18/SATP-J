package com.satpj.project.modelo.acudiente;

import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Interface RepositorioAcudiente Permite realizar las consultas a la BD de la
 * Entidad acudiente
 */
public interface RepositorioAcudiente extends JpaRepository<Acudiente, String> {

}
