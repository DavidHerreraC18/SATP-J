package com.satpj.project.modelo.nota_evolucion;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * Clase LlaveNotaEvolucion Llave primaria compuesta de la tabla nota_evolucion
 */
@Embeddable
public class LlaveNotaEvolucion implements Serializable {

    @Column(name = "practicante_id")
    private String practicanteId;

    @Column(name = "sesion_terapia_id")
    private Long sesionTerapiaId;

    public String getPracticanteId() {
        return practicanteId;
    }

    public void setPracticanteId(String practicanteId) {
        this.practicanteId = practicanteId;
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
        if (!(o instanceof LlaveNotaEvolucion)) {
            return false;
        }
        LlaveNotaEvolucion llave = (LlaveNotaEvolucion) o;
        return this.practicanteId.equals(llave.practicanteId) && this.sesionTerapiaId == llave.sesionTerapiaId;
    }

    @Override
    public int hashCode() {
        return Objects.hash(practicanteId, sesionTerapiaId);
    }

}
