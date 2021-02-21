package com.satpj.project.modelo.nota_evolucion;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * Clase LlaveNotaEvolucion
 * Llave primaria compuesta de la tabla nota_evolucion
 */
@Embeddable
public class LlaveNotaEvolucion implements Serializable {
    
    @Column(name = "practicante_id")
    private Long practicanteId;

    @Column(name = "sesion_terapia_id")
    private Long sesionTerapiaId;

    public Long getPracticanteId() {
        return practicanteId;
    }

    public void setPracticanteId(Long practicanteId) {
        this.practicanteId = practicanteId;
    }

    public Long getSesionTerapiaId() {
        return sesionTerapiaId;
    }

    public void setSesionTerapiaId(Long sesionTerapiaId) {
        this.sesionTerapiaId = sesionTerapiaId;
    }
    
}
