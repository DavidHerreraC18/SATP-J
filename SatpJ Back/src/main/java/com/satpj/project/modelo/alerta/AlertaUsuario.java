package com.satpj.project.modelo.alerta;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import com.satpj.project.modelo.usuario.Usuario;

/**
 * Entidad alerta_usuario Tabla intermedia alerta_usuario generada por la
 * relación de muchos a muchos. Es necesario crear la clase explicitamente
 * debido a que esta cuenta con un atributo adicional
 */
@Getter
@Setter
@Entity
@Table(name = "alerta_usuario")
public class AlertaUsuario {

    @EmbeddedId
    private LlaveAlertaUsuario id;

    @ManyToOne
    @MapsId("alerta_id")
    @JoinColumn(name = "alerta_id")
    private Alerta alerta;

    @ManyToOne
    @MapsId("usuario_id")
    @JoinColumn(name = "usuario_id")
    private Usuario usuario;

    @NotNull(message = "La Frecuencia de la Alarma del Usuario es obligatorio")
    @Column(name = "frecuencia", nullable = false)
    private int frecuencia;
}
