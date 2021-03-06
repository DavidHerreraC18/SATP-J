package com.satpj.project.modelo.comprobante_pago;

import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Interface RepositorioComprobantePago Permite realizar las consultas a la BD
 * de la Entidad ComprobantePago
 */
public interface RepositorioComprobantePago extends JpaRepository<ComprobantePago, Long> {

}
