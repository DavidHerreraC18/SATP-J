package com.satpj.project.modelo.sesion_terapia;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Interface RepositorioSesionTerapia Permite realizar las consultas a la BD de
 * la Entidad sesion_terapia
 */
public interface RepositorioSesionTerapia extends JpaRepository<SesionTerapia, Long> {
    List<SesionTerapia> findByFecha(LocalDateTime fecha); 
}
