
package com.satpj.project.modelo.usuario;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.satpj.project.modelo.alerta.AlertaUsuario;
import com.satpj.project.modelo.horario.Horario;
import com.satpj.project.modelo.sesion_terapia.SesionUsuario;


/**
 * Entidad usuario
 * Usuario de la plataforma
 */
@Getter
@Setter
@Entity
@Table(name = "usuario")
@Inheritance(strategy = InheritanceType.JOINED)
public class Usuario {
   
    @Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "usuario_id")
	private Long id;
    
	/* Son las sesiones de Terapia del Usuario */
	@OneToMany(mappedBy = "usuario")
	private List<SesionUsuario> sesiones;

	@OneToMany(mappedBy = "usuario")
	private List<AlertaUsuario> alertasUsuario;

	@OneToMany
	private List<Horario> horarios;

    @NotNull(message="El Documento de Identidad es obligatorio")
	@Column(name = "documento", nullable = false, length = (500))
	private String documento;

    @NotNull(message="El Tipo de Documento de Identidad es obligatorio")
	@Column(name = "tipo_documento", nullable = false)
	private String tipoDocumento;

	@NotNull(message="El Nombre es obligatorio")
	@Column(name = "nombre", nullable = false)
	private String nombre;

	@NotNull(message="El Apellido es obligatorio")
	@Column(name = "apellido", nullable = false)
	private String apellido;

	@NotNull(message="El Email es obligatorio")
	@Email(message = "El Email es invalido")
	@Column(name = "email", nullable = false)
	private String email;

    @NotNull(message="El Telefono es obligatorio")
	@Column(name = "telefono", nullable = false)
	private String telefono;

	@NotNull(message="La Contraseña es obligatoria")
	@Length(min=8, message="La Contraseña debe tener al menos 8 caracteres")
	@Column(name = "hash_contrasena", nullable = false)
	private String hashContrasena;
    
	/* Es un elemento que contiene la clave y la fecha de la sesión actual del
	Usuario */
	@Column(name = "info_sesion")
	private String infoSesion;

	

}