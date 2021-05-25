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
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.hibernate.annotations.Polymorphism;
import org.hibernate.annotations.PolymorphismType;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.satpj.project.modelo.acudiente.Acudiente;
import com.satpj.project.modelo.documento_paciente.DocumentoPaciente;
import com.satpj.project.modelo.formulario.Formulario;
import com.satpj.project.modelo.formulario.FormularioExtra;
import com.satpj.project.modelo.grupo.Grupo;
import com.satpj.project.modelo.paquete_sesion.PaqueteSesion;
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

    /**
     * Corresponde al Supervisor que tiene asignado el Paciente
     */ 
    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name = "supervisor_id", nullable = true)
    Supervisor supervisor;

    /**
     * Corresponde al Grupo al que puede pertenecer un Paciente
     */ 
    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name = "grupo_id", nullable = true)
    Grupo grupo;

    /**
     * Corresponde a la lista de Practicantes que puede tener asignado el Paciente
     */ 
    @OneToMany(mappedBy = "paciente")
    @JsonIgnore
    private List<PracticantePaciente> practicantesPaciente;

    /**
     * Corresponde a la colección de Documentos diligenciados por el Paciente
     */ 
    @OneToMany(mappedBy = "paciente")
    @JsonIgnore
    private List<DocumentoPaciente> documentosPaciente;

    /**
     * Corresponde al Paquete de Sesiones que tiene un Paciente
     */ 
    @OneToMany(mappedBy = "paciente")
    @JsonIgnore
    private List<PaqueteSesion> paquetesSesion;

    /**
    * Corresponde al Acudiente que tiene asignado el Paciente en caso de ser menor de edad
    */ 
    @OneToMany(mappedBy = "paciente")
    @JsonIgnore
    private List<Acudiente> acudientes;

    /**
     * Corresponde al Formulario que diligencia el Paciente como proceso inicial para registrarse en el sistema
     */ 
    @OneToOne(mappedBy = "paciente")
    @JsonIgnore
    private Formulario formulario;

    /**
     * Corresponde al FormularioExtra que diligencia el Paciente como proceso para completar en el sistema
     */ 
    @OneToOne(mappedBy = "paciente")
    @JsonIgnore
    private FormularioExtra formularioExtra;
    
    /*Posibles Estados:  PendienteAprobacion, PreAprobado, Aprobado, NoAprobado */
    /**
     * Corresponde al estado de aprobación que diligencia el Paciente como proceso para completar en el sistema
     */ 
    @NotNull(message = "El estado de Aprobacion es obligatorio")
    @Column(name = "estado_aprobado")
    private String estadoAprobado;

    /* Con el estrato se realiza el cobro de las Sesiones de Terapia */
    /**
     * Corresponde al estrato que tiene el Paciente
     */ 
    @Column(name = "estrato", nullable = true)
    private int estrato;

    /**
     * Corresponde a la edad del Paciente
     */ 
    @NotNull(message = "La Edad es obligatorio")
    @Column(name = "edad", nullable = false)
    private int edad;

    /**
     * Corresponde al estado de remisión del Paciente.
     */ 
    @NotNull(message = "El Estado de Remision es obligatorio")
    @Column(name = "remitido", nullable = false)
    private boolean remitido;

}
