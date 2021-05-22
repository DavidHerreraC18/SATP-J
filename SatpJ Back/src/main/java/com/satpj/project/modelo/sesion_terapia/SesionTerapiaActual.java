package com.satpj.project.modelo.sesion_terapia;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.Column;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonFormat;

import org.springframework.format.annotation.DateTimeFormat;

/**
 * Entidad sesion_terapia Son las Sesiones de Terapia que toma el Paciente y
 * realiza el Practicante
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class SesionTerapiaActual {


	@NotNull(message = "La Fecha de la Sesión de Terapia es obligatoria")
	@Column(name = "fecha", nullable = false)	
	private LocalDateTime fecha;

	boolean posible;

}
