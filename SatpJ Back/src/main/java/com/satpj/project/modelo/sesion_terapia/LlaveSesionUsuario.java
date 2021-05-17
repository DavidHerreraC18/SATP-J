package com.satpj.project.modelo.sesion_terapia;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;

import lombok.Getter;
import lombok.Setter;

/**
 * Clase LlaveSesionUsuario Llave primaria compuesta de la tabla intermedia
 * sesion_usuario
 */
@Getter
@Setter
@Embeddable
public class LlaveSesionUsuario implements Serializable {

    @Column(name = "usuario_id")
    private String usuarioId;

    @Column(name = "sesion_terapia_id")
    private Long sesion_terapia_id;

    @Override
    public boolean equals(Object o) {
        if (o == this)
            return true;
        if (!(o instanceof LlaveSesionUsuario)) {
            return false;
        }
        LlaveSesionUsuario llave = (LlaveSesionUsuario) o;
        return this.sesion_terapia_id == llave.sesion_terapia_id && this.usuarioId.equals(llave.usuarioId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(sesion_terapia_id, usuarioId);
    }

}
