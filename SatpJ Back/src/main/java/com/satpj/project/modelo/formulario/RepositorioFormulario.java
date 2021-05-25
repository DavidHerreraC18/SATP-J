package com.satpj.project.modelo.formulario;

import org.springframework.data.jpa.repository.JpaRepository;
/**
 * Interface RepositorioFormulario Permite realizar las consultas a
 * la BD de la Entidad Formulario
 */
public interface RepositorioFormulario extends JpaRepository<Formulario, Long> {
    
}
