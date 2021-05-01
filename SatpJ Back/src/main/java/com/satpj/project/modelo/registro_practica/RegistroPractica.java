package com.satpj.project.modelo.registro_practica;

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
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.satpj.project.modelo.practicante.Practicante;

/**
 * Entidad registro_practica Es el Registro de la Practica respecto a las
 * Sesiones de Terapia que realizó el Practicante
 */
@Getter
@Setter
@Entity
@Table(name = "registro_practica")
public class RegistroPractica {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "registro_practica_id")
    private Long id;

    @OneToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JoinColumn(name = "practicante_id", nullable = false)
    private Practicante practicante;

    /* Horas totales de las Sesiones de Terapia realizadas */
    @Column(name = "horas")
    private double horas;

    @Column(name = "sesiones_realizadas")
    private int sesionesRealizadas;

    @Column(name = "sesiones_canceladas")
    private int sesionesCanceladas;

    /* Cantidad de Sesiones de Terapia a la que asistió un Supervisor */
    @Column(name = "sesiones_supervisadas")
    private int sesionesSupervisadas;

}
