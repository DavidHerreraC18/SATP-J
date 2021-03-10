package com.satpj.project.modelo.nota_evolucion;

import java.util.List;

import com.satpj.project.modelo.supervisor.Supervisor;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Interface RepositorioNotaEvolucion Permite realizar las consultas a la BD de
 * la Entidad nota_evolucion
 */
public interface RepositorioNotaEvolucion extends JpaRepository<NotaEvolucion, LlaveNotaEvolucion> {
    Page<NotaEvolucion> findByPracticanteId(String id, Pageable pageable);

    Page<NotaEvolucion> findBySesionTerapiaId(Long id, Pageable pageable);

    List<NotaEvolucion> findBySupervisor(Supervisor supervisor);
}
