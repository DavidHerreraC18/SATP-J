package com.satpj.project.modelo.alerta;

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

/**
 * Clase Alerta Son los tipos de notificaciones que tiene la plataforma
 */
@Getter
@Setter
@Entity
@Table(name = "alerta")
public class Alerta {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "alerta_id")
	private Long id;

	/* Relación con la tabla intermedia generada por la relación muchos a muchos */
	@OneToMany(mappedBy = "alerta")
	@JsonIgnore
	private List<AlertaUsuario> alertasUsuario;

	@NotNull(message = "El Tipo de la Alarma es obligatorio")
	@Column(name = "tipo", nullable = false)
	private String tipo;

}
