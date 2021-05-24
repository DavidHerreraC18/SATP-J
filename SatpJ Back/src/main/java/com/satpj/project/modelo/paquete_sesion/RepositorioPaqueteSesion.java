package com.satpj.project.modelo.paquete_sesion;

import java.util.List;

import com.satpj.project.modelo.paciente.Paciente;

import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Interface RepositorioPaqueteSesion Permite realizar las consultas a la BD de
 * la Entidad PaqueteSesion
 */
public interface RepositorioPaqueteSesion extends JpaRepository<PaqueteSesion, Long> {

    List<PaqueteSesion> findByPaciente(Paciente paciente);

}
