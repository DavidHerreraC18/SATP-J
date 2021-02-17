package com.satpj.project.modelo.nota_evolucion;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.validation.constraints.NotNull;

import com.satpj.project.modelo.practicante.Practicante;
import com.satpj.project.modelo.sesion_terapia.SesionTerapia;
import com.satpj.project.modelo.supervisor.Supervisor;

@Entity
@Table(name = "nota_evolucion")
public class NotaEvolucion {
    
    @ManyToOne
    Practicante practicante;
    
    @OneToOne
    SesionTerapia sesionTerapia;

    @ManyToOne
    Supervisor supervisor;

    @Column(name = "contenido")
    String contenido;

    @NotNull(message="La Fecha y Hora de la Nota de Evolución es obligatoria")
	@Column(name = "fecha_hora", nullable = false)
    LocalDateTime fechaHora;
    
    
}
