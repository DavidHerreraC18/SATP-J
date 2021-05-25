package com.satpj.project.modelo.informe_pago;

import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Interface RepositorioInformePago Permite realizar las consultas a la BD de la
 * Entidad Informe Pago
 */
public interface RepositorioInformePago extends JpaRepository<InformePago, Long> {

}
