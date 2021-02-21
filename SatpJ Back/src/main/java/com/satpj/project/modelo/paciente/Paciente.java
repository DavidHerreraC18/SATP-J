package com.satpj.project.modelo.paciente;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.hibernate.annotations.Polymorphism;
import org.hibernate.annotations.PolymorphismType;

import com.satpj.project.modelo.documento_paciente.DocumentoPaciente;
import com.satpj.project.modelo.grupo.Grupo;
import com.satpj.project.modelo.supervisor.Supervisor;
import com.satpj.project.modelo.usuario.Usuario;


/**
 * Entidad paciente
 * El Paciente es el Usuario que recibirá atención 
 * psicológica por el Consultorio
 */
@Getter
@Setter
@Entity
@Table(name = "paciente")
@Polymorphism(type = PolymorphismType.EXPLICIT)
public class Paciente extends Usuario {

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JoinColumn(name ="supervisor_id", nullable = false)
    Supervisor supervisor;

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JoinColumn(name ="grupo_id", nullable = false)
    Grupo grupo;
    
	@Column(name = "aprobado")
	private boolean aprobado;
    
    /* Con el estrato se realiza el cobro de las Sesiones de Terapia */
    @NotNull(message="El Estrato es obligatorio")
	@Column(name = "estrato", nullable = false)
	private int estrato;
    
    @NotNull(message="La Edad es obligatorio")
	@Column(name = "edad", nullable = false)
	private int edad;
   
    @OneToMany
    private List<DocumentoPaciente> documentosPaciente;

}
