package com.satpj.project.modelo.paquete_sesion;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.satpj.project.modelo.comprobante_pago.ComprobantePago;
import com.satpj.project.modelo.paciente.Paciente;

/**
 * Entidad PaqueteSesion Esta entidad correspone a los paquetes de sesiones que
 * pueden pagar los Pacientes
 */
@Getter
@Setter
@Entity
@Table(name = "paquete_sesion")
public class PaqueteSesion {

    /**
     * Corresponde al número de identificación del PaqueteSesion
     */ 
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "paquete_sesion_id")
    private Long id;

    /**
     * Corresponde al Paciente el cual puede hacer pago del PaqueteSesion
     */ 
    @ManyToOne(cascade = CascadeType.MERGE, fetch = FetchType.EAGER)
    @JoinColumn(name = "paciente_id", nullable = false)
    private Paciente paciente;

    /**
     * Corresponde al Comprobante de Pago el cual permite el pago de los Paquetes de Sesión
     */ 
    @OneToOne(cascade = CascadeType.MERGE, fetch = FetchType.EAGER, mappedBy = "paqueteSesion")
    @JsonIgnore
    private ComprobantePago comprobantePago;

    /**
     * Corresponde a las cantidad de sesiones que tiene el paquete.
     */ 
    @NotNull(message = "La Cantidad de Sesiones del Paquete es obligatoria")
    @Column(name = "cantidad_sesiones", nullable = false)
    private int cantidadSesiones;

    /**
     * Corresponde el total a pagar por el paquete.
     */ 
    @NotNull(message = "El Total a pagar por el Paquete es obligatorio")
    @Column(name = "total", nullable = false)
    private double total;

    /**
     * Corresponde a la fecha de creación de la fecha.
     */ 
    @NotNull(message = "La fecha debe ser obligatoria")
    @Column(name = "fecha", nullable = false)
    private LocalDate fecha;

}
