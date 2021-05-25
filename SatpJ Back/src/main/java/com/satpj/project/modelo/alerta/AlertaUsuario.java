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
 * Entidad AlertaUsuario 
 * Tabla intermedia generada por la relación de muchos a muchos. 
 * Es necesario crear la clase explicitamente debido a que esta
 * cuenta con un atributo adicional
 */
@Getter
@Setter
@Entity
@Table(name = "alerta_usuario")
public class AlertaUsuario {

    /**
     * Corresponde al id de la Alerta. Es una llave compuesta generada a partir del id de la Alerta,
     * al igual que el id del Usuario.
     */
    @EmbeddedId
    private LlaveAlertaUsuario id;

    /**
     * Corresponde a la entidad Alerta, la cual representa una relación ManyToOne
     */
    @ManyToOne
    @MapsId("alerta_id")
    @JoinColumn(name = "alerta_id")
    private Alerta alerta;

    /**
     * Corresponde a la entidad de Usuario, la cual representa una relación ManyToOne
     */
    @ManyToOne
    @MapsId("usuario_id")
    @JoinColumn(name = "usuario_id")
    private Usuario usuario;
    
    /**
     * Corresponde a la frecuencia en la cual se desean emitir alertas
     */
    @NotNull(message = "La Frecuencia de la Alarma del Usuario es obligatorio")
    @Column(name = "frecuencia", nullable = false)
    private int frecuencia;
}
