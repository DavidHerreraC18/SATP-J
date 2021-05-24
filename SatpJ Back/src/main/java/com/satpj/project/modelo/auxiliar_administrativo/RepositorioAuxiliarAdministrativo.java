package com.satpj.project.modelo.auxiliar_administrativo;

import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Interface RepositorioAuxiliarAdministrativo Permite realizar las consultas a
 * la BD de la Entidad AuxiliarAdministrativo
 */
public interface RepositorioAuxiliarAdministrativo extends JpaRepository<AuxiliarAdministrativo, String> {

}
