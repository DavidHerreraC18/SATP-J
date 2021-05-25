package com.satpj.project.modelo.formulario;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import com.ibm.db2.cmx.annotation.JoinColumn;
import com.satpj.project.modelo.paciente.Paciente;

import lombok.Getter;
import lombok.Setter;

/**
 * Entidad FormularioExtra
 * El FormularioExtra es el registro de información adicional de un Paciente al momento de ser preaprobado en la aplicación
 */
@Getter
@Setter
@Entity
@Table(name = "formulario_extra")
public class FormularioExtra {

    /**
     * Número de identificación del FormularioExtra
     */
    @Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "formulario_extra_id")
	private Long id;

    /**
     * Paciente preaprobado que diligencio el formulario
     */
    @OneToOne
    @JoinColumn(name = "paciente_id")
    private Paciente paciente;

    /**
     * Escolaridad del Paciente 
     */
    @NotNull(message = "La Escolaridad es obligatoria")
    @Column(name = "escolaridad", nullable = false)
    private String escolaridad;

    /**
     * Estado Civil del Paciente
     */
    @NotNull(message = "El estado civil es obligatorio")
    @Column(name = "estado_civil", nullable = false)
    private String estadoCivil;

    /**
     * Ocupación(es) del Paciente separados por un ;
     */
    @NotNull(message = "La ocupacion es obligatoria")
    @Column(name = "ocupacion", nullable = false)
    private String ocupacion;

    /**
     * Lugar de ocupación(es) del Paciente
     */
    @NotNull(message = "El lugar de ocupación es obligatorio")
    @Column(name = "lugar_ocupacion", nullable = false)
    private String lugarOcupacion;

    /**
     * Estado de afiliación a eps del Paciente
     */
    @NotNull(message = "El estado de Salud es obligatorio")
    @Column(name = "tiene_eps", nullable = false)
    private boolean tieneEps;

    /**
     * Nombre de eps del Paciente (si tiene)
     */
    @Column(name = "eps", nullable = true)
    private String eps;

    /**
     * Estado de eps del paciente (si tiene)
     */
    @Column(name = "estado_eps", nullable = true)
    private String estadoEps;

    /**
     * Como se entero del servicio el paciente
     */
    @Column(name = "servicio", nullable = true, length = 500)
    private String servicio;

    /**
     * Nombre del primer acudiente del Paciente
     */
    @NotNull(message = "El nombre del Acudiente#1 es obligatorio")
    @Column(name = "nombre_acudiente_1", nullable = false)
    private String nombreAcudiente1;

    /**
     * Número del primer acudiente del Paciente
     */
    @NotNull(message = "El numero del Acudiente#1 es obligatorio")
    @Column(name = "numero_acudiente_1", nullable = false)
    private String numeroAcudiente1;

    /**
     * Nombre del segundo acudiente del Paciente
     */
    @NotNull(message = "El nombre del Acudiente#2 es obligatorio")
    @Column(name = "nombre_acudiente_2", nullable = false)
    private String nombreAcudiente2;

    /**
     * Número del segundo acudiente del Paciente
     */
    @NotNull(message = "El numero del Acudiente#1 es obligatorio")
    @Column(name = "numero_acudiente_2", nullable = false)
    private String numeroAcudiente2;
    
}
