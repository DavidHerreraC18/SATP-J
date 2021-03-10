package com.satpj.project.modelo.tarifa_sesion;

import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Interface RepositorioTarifaSesion Permite realizar las consultas a la BD de
 * la Entidad informe_pago
 */
public interface RepositorioTarifaSesion extends JpaRepository<TarifaSesion, Long> {

}
