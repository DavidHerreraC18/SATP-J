package com.satpj.project.modelo.alerta;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * Clase LlaveAlertaUsuario Llave primaria compuesta de la tabla intermedia
 * alerta_usuario
 */
@Embeddable
public class LlaveAlertaUsuario implements Serializable {

    @Column(name = "alerta_id")
    private Long alertaId;

    @Column(name = "usuario_id")
    private String usuarioId;

    public Long getAlertaId() {
        return alertaId;
    }

    public void setAlertaId(Long alertaId) {
        this.alertaId = alertaId;
    }

    public String getUsuarioId() {
        return usuarioId;
    }

    public void setUsuarioId(String usuarioId) {
        this.usuarioId = usuarioId;
    }

    @Override
    public boolean equals(Object o) {

        if (o == this)
            return true;
        if (!(o instanceof LlaveAlertaUsuario)) {
            return false;
        }
        LlaveAlertaUsuario llave = (LlaveAlertaUsuario) o;
        return this.alertaId == llave.alertaId && this.usuarioId.equals(llave.usuarioId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(alertaId, usuarioId);
    }

}
