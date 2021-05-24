package com.satpj.project.modelo.grupo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.satpj.project.modelo.paciente.Paciente;

/**
 * Entidad grupo Es un Grupo de Pacientes que reciben atención conjuntamente y
 * asisten a las Sesiones de Terapia juntos
 */
@Getter
@Setter
@Entity
@Table(name = "grupo")
public class Grupo {

	/**
     * Número de identificación del Grupo
     */
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "grupo_id")
	private Long id;

	/**
     * Tipo de Grupo
     */
	@NotNull(message = "El Tipo es obligatorio")
	@Column(name = "tipo", nullable = false)
	private String tipo;

	/**
     * Integrantes del Grupo
     */
	@OneToMany(mappedBy = "grupo")
	@JsonIgnore
	private List<Paciente> integrantes;
}
