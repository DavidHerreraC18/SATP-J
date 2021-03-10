package com.satpj.project.modelo.formulario;

import org.springframework.data.jpa.repository.JpaRepository;
/**
 * Interface RepositorioFormulario Permite realizar las consultas a
 * la BD de la Entidad formulario
 */
public interface RepositorioFormulario extends JpaRepository<Formulario, Long> {
    
}
