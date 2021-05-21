package com.satpj.project.modelo.sesion_terapia;

import java.time.LocalDateTime;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.satpj.project.modelo.consultorio.Consultorio;
import com.satpj.project.modelo.paquete_sesion.PaqueteSesion;

import org.springframework.format.annotation.DateTimeFormat;

/**
 * Entidad sesion_terapia Son las Sesiones de Terapia que toma el Paciente y
 * realiza el Practicante
 */
@Getter
@Setter
@Entity
@Table(name = "sesion_terapia")
public class SesionTerapia {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "sesion_terapia_id")
	private Long id;

	@OneToMany(mappedBy = "sesionTerapia")
	@JsonIgnore
	private List<SesionUsuario> sesiones;

	@ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	private PaqueteSesion paqueteSesion;

	@NotNull(message = "La Fecha de la Sesión de Terapia es obligatoria")
	@Column(name = "fecha", nullable = false)
	@DateTimeFormat(iso = DateTimeFormat.ISO.TIME)
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss.SSS")	
	private LocalDateTime fecha;

	/* Indica si la Sesión de Terapia se realizará presencial o virtual */
	@NotNull(message = "Indicar si la Sesión de Terapia es Virtual o Presencial")
	@Column(name = "virtual", nullable = false)
	private boolean virtual;

	/*
	 * Puede contener el número de consultorio o el link a la sala de la
	 * videollamada
	 */
	@OneToOne(fetch = FetchType.EAGER)
	private Consultorio consultorio;

	@Column(name = "enlace_streaming", nullable = true)
	private String enlaceStreaming;



}
