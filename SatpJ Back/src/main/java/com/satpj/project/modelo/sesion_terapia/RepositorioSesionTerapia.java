package com.satpj.project.modelo.sesion_terapia;

import org.springframework.data.jpa.repository.JpaRepository;


/**
 * Interface RepositorioSesionTerapia
 * Permite realizar las consultas a la BD de la
 * Entidad sesion_terapia
 */
public interface RepositorioSesionTerapia extends JpaRepository<Long, SesionTerapia> {
    
}
