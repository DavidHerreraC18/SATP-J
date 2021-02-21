package com.satpj.project.modelo.grupo;

import org.springframework.data.jpa.repository.JpaRepository;


/**
 * Interface RepositorioGrupo
 * Permite realizar las consultas a la BD de la
 * Entidad grupo
 */
public interface RepositorioGrupo extends JpaRepository<Long, Grupo> {
    
}
