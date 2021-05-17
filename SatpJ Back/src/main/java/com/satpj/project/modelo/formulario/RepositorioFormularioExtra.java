package com.satpj.project.modelo.formulario;

import org.springframework.data.jpa.repository.JpaRepository;
/**
 * Interface RepositorioFormularioExtra Permite realizar las consultas a
 * la BD de la Entidad formulario extra
 */
public interface RepositorioFormularioExtra extends JpaRepository<FormularioExtra, Long>{
    
}
