package com.satpj.project.modelo.sesion_terapia;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * Clase LlaveSesionUsuario Llave primaria compuesta de la tabla intermedia
 * sesion_usuario
 */
@Embeddable
public class LlaveSesionUsuario implements Serializable {

    @Column(name = "usuario_id")
    private Long usuarioId;

    @Column(name = "sesion_terapia_id")
    private Long sesionTerapiaId;

    public Long getUsuarioId() {
        return usuarioId;
    }

    public void setUsuarioId(Long usuarioId) {
        this.usuarioId = usuarioId;
    }

    public Long getSesionTerapiaId() {
        return sesionTerapiaId;
    }

    public void setSesionTerapiaId(Long sesionTerapiaId) {
        this.sesionTerapiaId = sesionTerapiaId;
    }

    @Override
    public boolean equals(Object o) {

        if (o == this)
            return true;
        if (!(o instanceof LlaveSesionUsuario)) {
            return false;
        }
        LlaveSesionUsuario llave = (LlaveSesionUsuario) o;
        return this.sesionTerapiaId == llave.sesionTerapiaId && this.usuarioId == llave.usuarioId;
    }

    @Override
    public int hashCode() {
        return Objects.hash(sesionTerapiaId, usuarioId);
    }

}
