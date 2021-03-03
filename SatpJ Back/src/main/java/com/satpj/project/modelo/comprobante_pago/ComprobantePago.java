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

import com.satpj.project.modelo.informe_pago.InformePago;
import com.satpj.project.modelo.paquete_sesion.PaqueteSesion;

/**
 * Clase ComprobantePago El Comprobante de Pago certifica que el Paciente
 * cancelo la Sesión de Terapia
 */
@Getter
@Setter
@Entity
@Table(name = "comprobante_pago")
public class ComprobantePago {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "comprobante_pago_id")
    private Long id;

    @OneToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JoinColumn(name = "paquete_sesion_id", nullable = false)
    private PaqueteSesion paqueteSesion;

    @ManyToMany(mappedBy = "comprobatesPagos")
    private List<InformePago> informesPagos;

    @NotNull(message = "El Valor Total es obligatorio")
    @Column(name = "valor_total", nullable = false)
    private double valorTotal;

    @NotNull(message = "La Referencia de Pago es obligatoria")
    @Column(name = "referencia_pago", nullable = false)
    private String referenciaPago;

    @NotNull(message = "La Fecha es obligatoria")
    @Column(name = "fecha", nullable = false)
    private LocalDate fecha;

    @Column(name = "observacion")
    private String observacion;

}
