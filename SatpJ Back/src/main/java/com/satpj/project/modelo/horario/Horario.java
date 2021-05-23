package com.satpj.project.modelo.horario;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

import com.satpj.project.modelo.usuario.Usuario;

/**
 * Entidad horario El Horario corresponde a la disponibildidad horaria del
 * Paciente, Practicante y Supervisor
 */
@Getter
@Setter
@Entity
@Table(name = "horario")
public class Horario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "horario_id")
    private Long id;

    @ManyToOne(cascade = CascadeType.MERGE, fetch = FetchType.EAGER)
    @MapsId("usuario_id")
    @JoinColumn(name = "usuario_id", insertable = false)
    private Usuario usuario;

    @Column(name = "opcion")
    private String opcion;

    /* Contiene las horas disponibles del día */
    @Column(name = "lunes")
    private String lunes;

    @Column(name = "martes")
    private String martes;

    @Column(name = "miercoles")
    private String miercoles;

    @Column(name = "jueves")
    private String jueves;

    @Column(name = "viernes")
    private String viernes;

    @Column(name = "sabado")
    private String sabado;

}
