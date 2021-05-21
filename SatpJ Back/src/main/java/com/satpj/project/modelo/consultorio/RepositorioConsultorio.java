package com.satpj.project.modelo.consultorio;

import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Interface RepositorioComprobantePago Permite realizar las consultas a la BD
 * de la Entidad comprobante_pago
 */
public interface RepositorioConsultorio extends JpaRepository<Consultorio, String> {

}
