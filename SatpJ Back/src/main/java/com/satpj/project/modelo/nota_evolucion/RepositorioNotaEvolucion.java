package com.satpj.project.modelo.nota_evolucion;

import org.springframework.data.jpa.repository.JpaRepository;


/**
 * Interface RepositorioNotaEvolucion
 * Permite realizar las consultas a la BD de la
 * Entidad nota_evolucion
 */
public interface RepositorioNotaEvolucion extends JpaRepository<Long, NotaEvolucion> {
    
}
