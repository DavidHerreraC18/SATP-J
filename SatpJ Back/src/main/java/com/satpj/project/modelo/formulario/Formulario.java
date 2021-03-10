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
 * Clase Formulario
 * El Formulario es el registro de información de un Paciente al momento de inscribirse a la aplicación
 */
@Getter
@Setter
@Entity
@Table(name = "formulario")
public class Formulario{

    @Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "formulario_id")
	private Long id;

    @OneToOne
    private Paciente paciente;

    @Column(name = "remitente", nullable = true)
    private String remitente;

    @NotNull(message = "La Estado de Atención es obligatorio")
    @Column(name = "fue_atendido", nullable = false)
    private boolean fueAtendido;

    @Column(name = "lugar_atencion", nullable = true)
    private String lugarAtencion;

    @Column(name = "motivo_consulta", nullable = true, length = (800))
    private String motivoConsulta;
    
}
