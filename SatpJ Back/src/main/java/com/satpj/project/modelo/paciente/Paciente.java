package com.satpj.project.modelo.paciente;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.validation.constraints.NotNull;

import com.satpj.project.modelo.documento_paciente.DocumentoPaciente;
import com.satpj.project.modelo.grupo.Grupo;
import com.satpj.project.modelo.supervisor.Supervisor;
import com.satpj.project.modelo.usuario.Usuario;

@Entity
@Table(name = "paciente")
public class Paciente {
    
    @OneToOne
    Usuario usuario;

    @ManyToOne
    Supervisor supervisor;

    @ManyToOne
    Grupo grupo;

    @NotNull(message="Aprobado es obligatorio")
	@Column(name = "aprobado", nullable = false)
	private boolean aprobado;
    
    @NotNull(message="El Estrato es obligatorio")
	@Column(name = "estrato", nullable = false)
	private int estrato;
    
    @NotNull(message="La Edad es obligatorio")
	@Column(name = "edad", nullable = false)
	private int edad;
   
    @OneToMany
    private List<DocumentoPaciente> documentosPaciente;

}
