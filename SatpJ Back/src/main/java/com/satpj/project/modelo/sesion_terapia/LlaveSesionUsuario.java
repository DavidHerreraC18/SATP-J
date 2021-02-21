package com.satpj.project.modelo.sesion_terapia;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;


/**
 * Clase LlaveSesionUsuario
 * Llave primaria compuesta de la tabla intermedia sesion_usuario
 */
@Embeddable
public class LlaveSesionUsuario implements Serializable{
     
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

}
