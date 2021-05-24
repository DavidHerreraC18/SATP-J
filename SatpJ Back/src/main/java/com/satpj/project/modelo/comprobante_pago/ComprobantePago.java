package com.satpj.project.modelo.comprobante_pago;

import java.time.LocalDate;
import java.util.List;

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
import javax.persistence.ManyToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.satpj.project.modelo.informe_pago.InformePago;
import com.satpj.project.modelo.paquete_sesion.PaqueteSesion;

/**
 * Entidad ComprobantePago 
 * Certifica que el Paciente hizo pago de la Sesión de Terapia
 */
@Getter
@Setter
@Entity
@Table(name = "comprobante_pago")
public class ComprobantePago {

    /**
     * Corresponde al Id del Comprobante.
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "comprobante_pago_id")
    private Long id;

    /**
     * Corresponde al paquete de sesiones, el cual permite asociar sesiones de terapia a los pacientes,
     * una vez se hayan pagado.
     */
    @OneToOne(cascade = CascadeType.MERGE, fetch = FetchType.EAGER)
    @JoinColumn(name = "paquete_sesion_id", nullable = false)
    private PaqueteSesion paqueteSesion;

    /**
     * Corresponde a  los informes de pago que pueden ser generados a partir del Comporbante.
     */
    @ManyToMany(mappedBy = "comprobatesPagos")
    @JsonIgnore
    private List<InformePago> informesPagos;

    /**
     * Corresponde al valor total del comprobante.
     */
    @NotNull(message = "El Valor Total es obligatorio")
    @Column(name = "valor_total", nullable = false)
    private double valorTotal;

    /**
     * Corresponde a la referencia del pago realizado
     */
    @NotNull(message = "La Referencia de Pago es obligatoria")
    @Column(name = "referencia_pago", nullable = false)
    private String referenciaPago;

    /**
     * Fecha del pago
     */
    @NotNull(message = "La Fecha es obligatoria")
    @Column(name = "fecha", nullable = false)
    private LocalDate fecha;

    /**
     * Corresponde a la observaciones encontradas al momento de realizar el pago.
     */
    @Column(name = "observacion", nullable = true)
    private String observacion;

}
