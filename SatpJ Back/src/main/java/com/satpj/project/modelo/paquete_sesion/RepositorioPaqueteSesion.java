package com.satpj.project.modelo.paquete_sesion;

import org.springframework.data.jpa.repository.JpaRepository;


/**
 * Interface RepositorioPaqueteSesion
 * Permite realizar las consultas a la BD de la
 * Entidad paquete_sesion
 */
public interface RepositorioPaqueteSesion extends JpaRepository<Long, PaqueteSesion> {
    
}
