package com.satpj.project.modelo.practicante;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import com.satpj.project.modelo.paciente.Paciente;

/**
 * Entidad practicante_paciente Tabla intermedia generada por la relación de
 * muchos a muchos. Es necesario crear la clase explicitamente debido a que esta
 * cuenta con un atributo adicional
 */
@Getter
@Setter
@Entity
@Table(name = "practicante_paciente")
public class PracticantePaciente {

    /**
     * Llave compuesta entre El Practicante es quién realizará las Sesiones de Terapia
     * en el Consultorio a los Pacientes
     */
    @EmbeddedId
    private LlavePracticantePaciente id;

    @ManyToOne
    @MapsId("practicante_id")
    @JoinColumn(name = "practicante_id")
    private Practicante practicante;

    @ManyToOne
    @MapsId("paciente_id")
    @JoinColumn(name = "paciente_id")
    private Paciente paciente;

    /**
     * Sera verdadero si el practicante es actualmente el terapeuta del Paciente
     */
    @NotNull(message = "El Estado Activo del Practicante Paciente es obligatorio ")
    @Column(name = "activo", nullable = false)
    private boolean activo;
}
