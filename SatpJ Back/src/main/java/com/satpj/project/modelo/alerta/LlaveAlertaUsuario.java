package com.satpj.project.modelo.alerta;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;


/**
 * Clase LlaveAlertaUsuario
 * Llave primaria compuesta de la tabla intermedia alerta_usuario
 */
@Embeddable
public class LlaveAlertaUsuario implements Serializable {

    @Column(name = "alerta_id")
    private Long alertaId;

    @Column(name = "usuario_id")
    private Long usuarioId;

    public Long getAlertaId() {
        return alertaId;
    }

    public void setAlertaId(Long alertaId) {
        this.alertaId = alertaId;
    }

    public Long getUsuarioId() {
        return usuarioId;
    }

    public void setUsuarioId(Long usuarioId) {
        this.usuarioId = usuarioId;
    }

    
}
