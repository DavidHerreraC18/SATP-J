package com.satpj.project.modelo.practicante;

import javax.persistence.Column;
import javax.persistence.OneToOne;
import javax.validation.constraints.NotNull;

import com.satpj.project.modelo.usuario.Usuario;

public class Practicante {
    
    @OneToOne
    Usuario usuario;

    @NotNull(message="El Pregrado es obligatorio")
	@Column(name = "pregrado", nullable = false)
	private boolean pregrado;
    
    @NotNull(message="El Semestre es obligatorio")
	@Column(name = "semestre", nullable = false)
	private int semestre;
    
    @NotNull(message="El Enfoque es obligatorio")
	@Column(name = "enfoque", nullable = false)
	private String enfoque;
}
