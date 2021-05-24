package com.satpj.project.modelo.nota_evolucion;

import java.util.List;

import com.satpj.project.modelo.supervisor.Supervisor;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Interface RepositorioNotaEvolucion Permite realizar las consultas a la BD de
 * la Entidad NotaEvolución
 */
public interface RepositorioNotaEvolucion extends JpaRepository<NotaEvolucion, LlaveNotaEvolucion> {
    /**
     * Query la cual encuentra todas las Notas de Evolución a partir del código de identificación de un Practicante
     * @param id Corresponde al código de identificación del Practicante.
     */ 
    Page<NotaEvolucion> findByPracticanteId(String id, Pageable pageable);

    /**
     * Query la cual encuentra todas las Notas de Evolución a partir del número de identificación de la Sesion de Terapia
     * @param id Corresponde al código de identificación del practicante.
     */ 
    Page<NotaEvolucion> findBySesionTerapiaId(Long id, Pageable pageable);

    /**
     * Query la cual encuentra todas las Notas de Evolución a partir del Supervisor asignado a estas.
     * @param supervisor Corresponde al Supervisor a buscar.
     */ 
    List<NotaEvolucion> findBySupervisor(Supervisor supervisor);
}
