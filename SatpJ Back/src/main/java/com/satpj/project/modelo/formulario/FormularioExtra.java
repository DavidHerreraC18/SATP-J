package com.satpj.project.modelo.formulario;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import com.satpj.project.modelo.paciente.Paciente;

import lombok.Getter;
import lombok.Setter;

/**
 * Clase Formulario
 * El Formulario es el registro de información de un Paciente al momento de inscribirse a la aplicación
 */
@Getter
@Setter
@Entity
@Table(name = "formulario_extra")
public class FormularioExtra {

    @Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "formulario_extra_id")
	private Long id;

    @OneToOne
    private Paciente paciente;

    @NotNull(message = "La Escolaridad es obligatoria")
    @Column(name = "escolaridad", nullable = false)
    private String escolaridad;

    @NotNull(message = "El estado civil es obligatorio")
    @Column(name = "estado_civil", nullable = false)
    private String estadoCivil;

    @NotNull(message = "La ocupacion es obligatoria")
    @Column(name = "ocupacion", nullable = false)
    private String ocupacion;

    @NotNull(message = "El lugar de ocupación es obligatorio")
    @Column(name = "lugar_ocupacion", nullable = false)
    private String lugarOcupacion;

    @NotNull(message = "El estado de Salud es obligatorio")
    @Column(name = "tiene_eps", nullable = false)
    private boolean tieneEps;

    @Column(name = "eps", nullable = true)
    private String eps;

    @Column(name = "estado_eps", nullable = true)
    private String estadoEps;

    @Column(name = "servicio", nullable = true, length = 500)
    private String servicio;

    @NotNull(message = "El nombre del Acudiente#1 es obligatorio")
    @Column(name = "nombre_acudiente_1", nullable = false)
    private String nombreAcudiente1;

    @NotNull(message = "El numero del Acudiente#1 es obligatorio")
    @Column(name = "numero_acudiente_1", nullable = false)
    private String numeroAcudiente1;

    @NotNull(message = "El nombre del Acudiente#2 es obligatorio")
    @Column(name = "nombre_acudiente_2", nullable = false)
    private String nombreAcudiente2;

    @NotNull(message = "El numero del Acudiente#1 es obligatorio")
    @Column(name = "numero_acudiente_2", nullable = false)
    private String numeroAcudiente2;
    
}
