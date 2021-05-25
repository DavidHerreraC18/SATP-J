package com.satpj.project.modelo.supervisor;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.hibernate.annotations.Polymorphism;
import org.hibernate.annotations.PolymorphismType;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.satpj.project.modelo.paciente.Paciente;
import com.satpj.project.modelo.usuario.Usuario;

/**
 * Entidad supervisor Son los Supervisores de los diferentes enfoques con los
 * que se realizán las Terapias y los encargados de monitorear a los
 * Practicantes
 */
@Getter
@Setter
@Entity
@Table(name = "supervisor")
@Polymorphism(type = PolymorphismType.EXPLICIT)
public class Supervisor extends Usuario {

    /**
     * Enfoque del Supervisor
     */
    @NotNull(message = "El Enfoque es obligatorio")
    @Column(name = "enfoque", nullable = false)
    private String enfoque;

    /**
     * Pacientes asignados al Supervisor
     */
    @OneToMany(mappedBy = "supervisor")
    @JsonIgnore
    private List<Paciente> pacientes;

}
