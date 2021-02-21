package com.satpj.project.modelo.paquete_sesion;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import com.satpj.project.modelo.paciente.Paciente;


/**
 * Entidad paquete_sesion
 * Esta entidad correspone a los paquetes de sesiones que
 * pueden pagar los Pacientes
 */
@Getter
@Setter
@Entity
@Table(name = "paquete_sesion")
public class PaqueteSesion {
     
    @Id
    private Long id;

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JoinColumn(name = "paciente_id", nullable = false)
    @MapsId
    private Paciente paciente;

    @NotNull(message="La Cantidad de Sesiones del Paquete es obligatoria")
	@Column(name = "cantidad_sesiones", nullable = false)
    private int cantidadSesiones;

    @NotNull(message="El Total a pagar por el Paquete es obligatorio")
	@Column(name = "total", nullable = false)
    private double total;


}
