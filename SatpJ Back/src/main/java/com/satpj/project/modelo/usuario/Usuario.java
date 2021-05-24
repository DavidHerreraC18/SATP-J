
package com.satpj.project.modelo.usuario;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotNull;


import com.fasterxml.jackson.annotation.JsonIgnore;
import com.satpj.project.modelo.alerta.AlertaUsuario;
import com.satpj.project.modelo.horario.Horario;
import com.satpj.project.modelo.sesion_terapia.SesionUsuario;

/**
 * Entidad usuario Usuario de la plataforma
 */
@Getter
@Setter
@Entity
@Table(name = "usuario")
@Inheritance(strategy = InheritanceType.JOINED)
public class Usuario {
	
	@Id
	@Column(name = "usuario_id")
	private String id;

	/* Son las sesiones de Terapia del Usuario */
	@OneToMany(mappedBy = "usuario")
	@JsonIgnore
	private List<SesionUsuario> sesiones;

	@OneToMany(mappedBy = "usuario")
	@JsonIgnore
	private List<AlertaUsuario> alertasUsuario;

	@OneToMany(mappedBy = "usuario")
	@JsonIgnore
	private List<Horario> horarios;

	@NotNull(message = "El Documento de Identidad es obligatorio")
	@Column(name = "documento", nullable = false, length = (500))
	private String documento;

	@NotNull(message = "El Tipo de Documento de Identidad es obligatorio")
	@Column(name = "tipo_documento", nullable = false)
	private String tipoDocumento;

	@NotNull(message = "El Nombre es obligatorio")
	@Column(name = "nombre", nullable = false)
	private String nombre;

	@NotNull(message = "El Apellido es obligatorio")
	@Column(name = "apellido", nullable = false)
	private String apellido;

	@NotNull(message = "El Email es obligatorio")
	@Email(message = "El Email es invalido")
	@Column(name = "email", nullable = false)
	private String email;

	@NotNull(message = "El Telefono es obligatorio")
	@Column(name = "telefono", nullable = false)
	private String telefono;

	@NotNull(message = "El Tipo de Usuario es obligatorio")
	@Column(name = "tipo_usuario", nullable = false)
	private String tipoUsuario;

	@Column(name = "direccion", nullable = true)
	private String direccion;


	/*
	 * Es un elemento que contiene la clave y la fecha de la sesión actual del
	 * Usuario
	 */
	@Column(name = "info_sesion")
	private String infoSesion;

}