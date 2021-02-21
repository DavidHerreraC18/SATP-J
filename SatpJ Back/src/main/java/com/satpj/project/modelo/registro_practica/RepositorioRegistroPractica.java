package com.satpj.project.modelo.registro_practica;

import org.springframework.data.jpa.repository.JpaRepository;


/**
 * Interface RepositorioRegistroPractica
 * Permite realizar las consultas a la BD de la
 * Entidad registro_practica
 */
public interface RepositorioRegistroPractica extends JpaRepository<Long, RegistroPractica> {
    
}
