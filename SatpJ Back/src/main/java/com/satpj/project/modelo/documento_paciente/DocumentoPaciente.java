package com.satpj.project.modelo.documento_paciente;

import java.sql.Blob;
import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.validation.constraints.NotNull;

import com.satpj.project.modelo.paciente.Paciente;

public class DocumentoPaciente {
    
    @ManyToOne
    Paciente paciente;
    
    @NotNull(message="El Nombre del Documento es obligatorio")
	@Column(name = "nombre", nullable = false)
	private String nombre;

    @Lob
    @NotNull(message="El Contenido del Documento es obligatorio")
	@Column(name = "contenido", nullable = false)
	private Blob contenido;

    @NotNull(message="El Tipo del Documento es obligatorio")
	@Column(name = "tipo", nullable = false)
	private String tipo;

    @NotNull(message="La Fecha de Radicacion del Documento es obligatorio")
	@Column(name = "radicacion", nullable = false)
	private LocalDateTime radicacion;

    @NotNull(message="La Fecha de Vencimiento del Documento es obligatorio")
	@Column(name = "vencimiento", nullable = false)
	private LocalDateTime vencimiento;


}
