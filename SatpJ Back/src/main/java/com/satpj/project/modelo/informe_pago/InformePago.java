package com.satpj.project.modelo.informe_pago;

import java.time.LocalDate;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinTable;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.satpj.project.modelo.comprobante_pago.ComprobantePago;

/**
 * Entidad InformePago 
 * Es el Informe de los Pagos de las Sesiones de Terapia
 * que realizan los Pacientes al Consultorio
 */
@Getter
@Setter
@Entity
@Table(name = "informe_pago")
public class InformePago {

    /**
     * Número de identificación del Informe de Pago
     */ 
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "informe_pago_id")
    private Long id;

    /**
     * Comprobantes de Pago utilizados para el informe de pago
     */ 
    @ManyToMany
    @JoinTable(name = "informe_comprobante_pago", joinColumns = @JoinColumn(name = "informe_pago_id"), inverseJoinColumns = @JoinColumn(name = "comprobante_pago_id"))
    @JsonIgnore
    private List<ComprobantePago> comprobantesPagos;

    /**
     * Fecha de Inicio para la generación del informe
     */ 
    @NotNull(message = "La Fecha de Inicio es obligatoria")
    @Column(name = "fecha_inicio", nullable = false)
    private LocalDate fechaInicio;

    /**
     * Fecha de Fin para la generación del informe
     */ 
    @NotNull(message = "La Fecha de Finalización es obligatoria")
    @Column(name = "fecha_fin", nullable = false)
    private LocalDate fechaFin;

    /**
     * Total generado por los comprobantes
     */ 
    @NotNull(message = "El Total es obligatorio")
    @Column(name = "total", nullable = false)
    private double total;

}
