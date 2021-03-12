package com.satpj.project.modelo.tarifa_sesion;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

/**
 * Entidad informe_pago Es la Tarifa de los Pagos de las Sesiones de Terapia que
 * controlan los Administradores del Consultorio
 */
@Getter
@Setter
@Entity
@Table(name = "tarifa_sesion")
public class TarifaSesion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "tarifa_sesion_id")
    private Long id;

    @NotNull(message = "El Estrato es obligatorio")
    @Column(name = "estrato", nullable = false)
    private int estrato;

    @NotNull(message = "La Tarifa es obligatoria")
    @Column(name = "tarifa", nullable = false)
    private int tarifa;

}
