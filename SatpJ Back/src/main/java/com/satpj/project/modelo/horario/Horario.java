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
import javax.persistence.Table;

import com.satpj.project.modelo.usuario.Usuario;

/**
 * Entidad horario 
 * El Horario corresponde a la disponibildidad horaria del
 * Paciente, Practicante y Supervisor
 */
@Getter
@Setter
@Entity
@Table(name = "horario")
public class Horario {

    /**
     * Número de identificación del Horario
    */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "horario_id")
    private Long id;

    /**
     * Usuario propietario del Horario
     */
    @ManyToOne(cascade = CascadeType.MERGE, fetch = FetchType.EAGER)
    @JoinColumn(name = "usuario_id")
    private Usuario usuario;

    /**
     * Opción del Horario, puede ser (1,2,3 o seleccionado)
     */
    @Column(name = "opcion")
    private String opcion;

    /* Contiene las horas disponibles del día */
    /**
     * Horas de disponibilidad del día lunes, estas se almacenan de la siguiente forma:
     *  H;H;H
     * <p>
     *  Ej. 9;10;16 
     * <p>
     *  Indicaria que el paciente el día lunes tiene libre las siguientes horas:
     * <p>
     *  9:00 AM a 10:00 AM
     * <p>
     *  10:00 AM a 11:00 AM
     * <p>
     *  4:00 PM a 5:00 PM
     * <p>
     */
    @Column(name = "lunes")
    private String lunes;

    /**
     * Horas de disponibilidad del día martes, estas se almacenan de la siguiente forma:
     *  H;H;H
     * <p>
     *  Ej. 9;10;16 
     * <p>
     *  Indicaria que el paciente el día martes tiene libre las siguientes horas:
     * <p>
     *  9:00 AM a 10:00 AM
     * <p>
     *  10:00 AM a 11:00 AM
     * <p>
     *  4:00 PM a 5:00 PM
     * <p>
     */
    @Column(name = "martes")
    private String martes;

    /**
     * Horas de disponibilidad del día miércoles, estas se almacenan de la siguiente forma:
     *  H;H;H
     * <p>
     *  Ej. 9;10;16 
     * <p>
     *  Indicaria que el paciente el día miércoles tiene libre las siguientes horas:
     * <p>
     *  9:00 AM a 10:00 AM
     * <p>
     *  10:00 AM a 11:00 AM
     * <p>
     *  4:00 PM a 5:00 PM
     * <p>
     */
    @Column(name = "miercoles")
    private String miercoles;

    /**
     * Horas de disponibilidad del día jueves, estas se almacenan de la siguiente forma:
     *  H;H;H
     * <p>
     *  Ej. 9;10;16 
     * <p>
     *  Indicaria que el paciente el día jueves tiene libre las siguientes horas:
     * <p>
     *  9:00 AM a 10:00 AM
     * <p>
     *  10:00 AM a 11:00 AM
     * <p>
     *  4:00 PM a 5:00 PM
     * <p>
     */
    @Column(name = "jueves")
    private String jueves;

    /**
     * Horas de disponibilidad del día viernes, estas se almacenan de la siguiente forma:
     *  H;H;H
     * <p>
     *  Ej. 9;10;16 
     * <p>
     *  Indicaria que el paciente el día viernes tiene libre las siguientes horas:
     * <p>
     *  9:00 AM a 10:00 AM
     * <p>
     *  10:00 AM a 11:00 AM
     * <p>
     *  4:00 PM a 5:00 PM
     * <p>
     */
    @Column(name = "viernes")
    private String viernes;
    
    /**
     * Horas de disponibilidad del día sabado, estas se almacenan de la siguiente forma:
     *  H;H;H
     * <p>
     *  Ej. 9;10;16 
     * <p>
     *  Indicaria que el paciente el día sabado tiene libre las siguientes horas:
     * <p>
     *  9:00 AM a 10:00 AM
     * <p>
     *  10:00 AM a 11:00 AM
     * <p>
     *  4:00 PM a 5:00 PM
     * <p>
     */
    @Column(name = "sabado")
    private String sabado;

}
