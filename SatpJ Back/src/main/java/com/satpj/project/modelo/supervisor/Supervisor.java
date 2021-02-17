package com.satpj.project.modelo.supervisor;

import com.satpj.project.modelo.paciente.Paciente;
import com.satpj.project.modelo.usuario.Usuario;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.validation.constraints.NotNull;

public class Supervisor {
    
    @OneToOne
    Usuario usuario;

    @NotNull(message="El Enfoque es obligatorio")
	@Column(name = "enfoque", nullable = false)
	private String enfoque;

    @OneToMany
    private List<Paciente> pacientes;
     
}
