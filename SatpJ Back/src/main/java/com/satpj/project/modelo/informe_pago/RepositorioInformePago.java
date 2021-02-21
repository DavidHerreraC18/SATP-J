package com.satpj.project.modelo.informe_pago;

import org.springframework.data.jpa.repository.JpaRepository;


/**
 * Interface RepositorioInformePago
 * Permite realizar las consultas a la BD de la
 * Entidad informe_pago
 */
public interface RepositorioInformePago extends JpaRepository<Long, InformePago> {
    
}
