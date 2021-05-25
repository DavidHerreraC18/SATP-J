package com.satpj.project.modelo.documento_paciente;

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
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import com.satpj.project.modelo.paciente.Paciente;


/**
 * Entidad Documento Paciente 
 * Representa los documentos que el Consultorio le solicita
 * al Paciente para que este pueda recibir atención
 */
@Getter
@Setter
@Entity
@Table(name = "documento_paciente")
public class DocumentoPaciente {

	/**
     * Corresponde al número de identificación del documento.
     */
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "documento_paciente_id")
	private Long id;

	/**
     * Corresponde al Paciente el cual diligencio el documento.
     */
	@ManyToOne(cascade = CascadeType.MERGE, fetch = FetchType.EAGER)
	@JoinColumn(name = "paciente_id", nullable = false)
	private Paciente paciente;

	/**
     * Corresponde al nombre del documento diligenciado
     */
	@NotNull(message = "El Nombre del Documento es obligatorio")
	@Column(name = "nombre", nullable = false)
	private String nombre;

	/**
     * Corresponde al contenido del documento
     */
	@Lob
	@NotNull(message = "El Contenido del Documento es obligatorio")
	@Column(name = "contenido", nullable = false, length = 2000000)
	private String contenido;

	/**
     * Corresponde al tipo de documento diligenciado
     */
	@NotNull(message = "El Tipo del Documento es obligatorio")
	@Column(name = "tipo", nullable = true)
	private String tipo;

	/**
     * Corresponde a la fecha de radicación del documento
     */
	@NotNull(message = "La Fecha de Radicacion del Documento es obligatorio")
	@Column(name = "radicacion", nullable = true)
	private LocalDateTime radicacion;

	/**
     * Corresponde a la fecha de vencimiento del documento (si tiene, de no ser así será la misma fecha de radicación)
     */
	@NotNull(message = "La Fecha de Vencimiento del Documento es obligatorio")
	@Column(name = "vencimiento", nullable = true)	
	private LocalDateTime vencimiento;

}
