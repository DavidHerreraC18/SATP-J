package com.satpj.project.modelo.consultorio;

import lombok.Getter;
import lombok.Setter;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 * Clase ComprobantePago El Comprobante de Pago certifica que el Paciente
 * cancelo la Sesión de Terapia
 */
@Getter
@Setter
@Entity
@Table(name = "consultorio")
public class Consultorio {
    @Id
    @Column(name = "consultorio")
    private Long consultorio;
}
