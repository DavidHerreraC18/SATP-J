package com.satpj.project.modelo.alerta;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * Llave de AlertaUsuario 
 * Corresponde a una llave primaria compuesta del Id de Usuario y Alerta.
 */
@Embeddable
public class LlaveAlertaUsuario implements Serializable {

    /**
     * Corresponde al Id de la Alerta.
     */
    @Column(name = "alerta_id")
    private Long alertaId;

    /**
     * Corresponde al Id del Usuario.
     */
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
