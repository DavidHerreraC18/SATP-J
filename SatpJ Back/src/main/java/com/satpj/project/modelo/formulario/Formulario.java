package com.satpj.project.modelo.formulario;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import com.satpj.project.modelo.paciente.Paciente;

import lombok.Getter;
import lombok.Setter;

/**
 * Entidad Formulario
 * El Formulario es el registro de información de un Paciente al momento de inscribirse a la aplicación
 */
@Getter
@Setter
@Entity
@Table(name = "formulario")
public class Formulario{

    /**
     * Corresponde al número de identificación del formulario
     */
    @Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "formulario_id")
	private Long id;

    /**
     * Corresponde al paciente el cual diligencio el formulario.
     * En caso de ser un formulario grupal la información será duplicada para cada paciente.
     */
    //@OneToMany(mappedBy = "formulario")
    //@JsonIgnore
    @OneToOne
    private Paciente paciente;

    /**
     * Remitente del paciente al servicio de Consultores en Psicología
     */
    @Column(name = "remitente", nullable = true)
    private String remitente;

    /**
     * Indicador de atención previa al paciente en otra institución 
     */
    @NotNull(message = "La Estado de Atención es obligatorio")
    @Column(name = "fue_atendido", nullable = false)
    private boolean fueAtendido;

    /**
     * Lugar de atención previo en caso de que si haya sido atendido
     */
    @Column(name = "lugar_atencion", nullable = true)
    private String lugarAtencion;

    /**
     * Motivo de la consulta con el consultorio.
     */
    @Column(name = "motivo_consulta", nullable = true, length = (800))
    private String motivoConsulta;
    
}
