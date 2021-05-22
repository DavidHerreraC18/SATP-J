package com.satpj.project.modelo.nota_evolucion;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.satpj.project.modelo.practicante.Practicante;
import com.satpj.project.modelo.sesion_terapia.SesionTerapia;
import com.satpj.project.modelo.supervisor.Supervisor;

import org.springframework.format.annotation.DateTimeFormat;

/**
 * Entidad nota_evolucion La Nota de Evolución contiene una breve descripción de
 * los avances y lo ocurrido en las Sesiones de Terapia del paciente
 */
@Getter
@Setter
@Entity
@Table(name = "nota_evolucion")
public class NotaEvolucion {

    /*
     * Es la llave primaria de la entidad que esta compuesta por el id del
     * Practicante y de la Sesion de la Terapia
     */
    @EmbeddedId
    private LlaveNotaEvolucion id;

    @ManyToOne
    @MapsId("practicante_id")
    @JoinColumn(name = "practicante_id")
    private Practicante practicante;

    @OneToOne
    @MapsId("sesion_terapia_id")
    @JoinColumn(name = "sesion_terapia_id")
    private SesionTerapia sesionTerapia;

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Supervisor supervisor;

    @Column(name = "contenido")
    private String contenido;

    @NotNull(message = "La Fecha y Hora de la Nota de Evolución es obligatoria")
    @Column(name = "fecha_hora", nullable = false)	
    private LocalDateTime fechaHora;

    @NotNull(message = "La definicion de envio de la Nota de Evolución es obligatoria")
    @Column(name = "enviada", nullable = false)
    private boolean enviada;

    @NotNull(message = "La definicion de registro de la Nota de Evolución es obligatoria")
    @Column(name = "registrada", nullable = false)
    private boolean registrada;

}
