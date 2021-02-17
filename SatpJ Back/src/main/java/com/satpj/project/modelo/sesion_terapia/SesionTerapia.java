package com.satpj.project.modelo.sesion_terapia;

import java.time.LocalDate;
import java.time.LocalTime;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.validation.constraints.NotNull;

@Entity
@Table(name = "sesion_terapia")
public class SesionTerapia {

    @Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "usuario_id")
	private int id;

    @NotNull(message="La Fecha de la Sesión de Terapia es obligatoria")
	@Column(name = "fecha", nullable = false)
	private LocalDate fecha;

    @NotNull(message="La Hora de la Sesión de Terapia es obligatoria")
	@Column(name = "hora", nullable = false)
	private LocalTime hora;

    @NotNull(message="Indicar si la Sesión de Terapia es Virtual o Presencial")
	@Column(name = "virtual", nullable = false)
	private LocalTime virtual;

    @NotNull(message="El Consultorio de la Sesión de Terapia es obligatorio")
	@Column(name = "consultorio", nullable = false)
	private String consultorio;
    
}
