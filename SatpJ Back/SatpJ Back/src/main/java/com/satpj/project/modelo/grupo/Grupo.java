package com.satpj.project.modelo.grupo;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.validation.constraints.NotNull;

import com.satpj.project.modelo.paciente.Paciente;

public class Grupo {
    
    @Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "grupo_id")
	private int id;

    @NotNull(message="El Tipo es obligatorio")
	@Column(name = "tipo", nullable = false)
	private String tipo;

    @OneToMany
    private List<Paciente> integrantes;
}
