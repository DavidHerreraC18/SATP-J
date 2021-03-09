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

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.satpj.project.modelo.acudiente.Acudiente;
import com.satpj.project.modelo.documento_paciente.DocumentoPaciente;
import com.satpj.project.modelo.grupo.Grupo;
import com.satpj.project.modelo.practicante.PracticantePaciente;
import com.satpj.project.modelo.supervisor.Supervisor;
import com.satpj.project.modelo.usuario.Usuario;

/**
 * Entidad paciente El Paciente es el Usuario que recibirá atención psicológica
 * por el Consultorio
 */
@Getter
@Setter
@Entity
@Table(name = "paciente")
@Polymorphism(type = PolymorphismType.EXPLICIT)
public class Paciente extends Usuario {

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JoinColumn(name = "supervisor_id", nullable = true)
    Supervisor supervisor;

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JoinColumn(name = "grupo_id", nullable = true)
    Grupo grupo;

    @OneToMany(mappedBy = "paciente")
    @JsonIgnore
    private List<PracticantePaciente> practicantesPaciente;

    @OneToMany(mappedBy = "paciente")
    @JsonIgnore
    private List<DocumentoPaciente> documentosPaciente;

    @OneToMany(mappedBy = "paciente")
    @JsonIgnore
    private List<Acudiente> acudientes;

    @NotNull(message = "El estado de Aprobacion es obligatorio")
    @Column(name = "estado-aprobado")
    private String estadoAprobado;

    /* Con el estrato se realiza el cobro de las Sesiones de Terapia */
    @Column(name = "estrato", nullable = true)
    private int estrato;

    @NotNull(message = "La Edad es obligatorio")
    @Column(name = "edad", nullable = false)
    private int edad;

}
