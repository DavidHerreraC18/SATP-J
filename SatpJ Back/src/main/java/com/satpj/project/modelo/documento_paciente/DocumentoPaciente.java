package com.satpj.project.modelo.documento_paciente;

import java.sql.Blob;
import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import com.satpj.project.modelo.paciente.Paciente;

/**
 * Entidad documento_paciente Son los documentos que el Consultorio le solicita
 * al Paciente para que este pueda recibir atención
 */
@Getter
@Setter
@Entity
@Table(name = "documento_paciente")
public class DocumentoPaciente {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "documento_paciente_id")
	private Long id;

	@ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	@JoinColumn(name = "paciente_id", nullable = false)
	private Paciente paciente;

	@NotNull(message = "El Nombre del Documento es obligatorio")
	@Column(name = "nombre", nullable = false)
	private String nombre;

	@Lob
	@NotNull(message = "El Contenido del Documento es obligatorio")
	@Column(name = "contenido", nullable = false)
	private Blob contenido;

	@NotNull(message = "El Tipo del Documento es obligatorio")
	@Column(name = "tipo", nullable = false)
	private String tipo;

	@NotNull(message = "La Fecha de Radicacion del Documento es obligatorio")
	@Column(name = "radicacion", nullable = false)
	private LocalDateTime radicacion;

	@NotNull(message = "La Fecha de Vencimiento del Documento es obligatorio")
	@Column(name = "vencimiento", nullable = false)
	private LocalDateTime vencimiento;

}
