package com.satpj.project.modelo.practicante;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.hibernate.annotations.Polymorphism;
import org.hibernate.annotations.PolymorphismType;

import com.satpj.project.modelo.usuario.Usuario;


/**
 * Entidad practicante
 * El Practicante es quién realizará las Sesiones de
 * Terapia en el Consultorio a los Pacientes
 */
@Getter
@Setter
@Entity
@Table(name = "practicante")
@Polymorphism(type = PolymorphismType.EXPLICIT)
public class Practicante extends Usuario {
 
    @NotNull(message="El Pregrado es obligatorio")
	@Column(name = "pregrado", nullable = false)
	private boolean pregrado;
    
    @NotNull(message="El Semestre es obligatorio")
	@Column(name = "semestre", nullable = false)
	private int semestre;
    
	/*El enfoque es la escuela de psicología con la que realiza 
	la Terapia */
    @NotNull(message="El Enfoque es obligatorio")
	@Column(name = "enfoque", nullable = false)
	private String enfoque;
}
