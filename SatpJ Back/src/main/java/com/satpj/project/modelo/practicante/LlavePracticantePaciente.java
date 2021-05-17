package com.satpj.project.modelo.practicante;

import java.io.Serializable;
import java.util.Objects;

import com.ibm.db2.cmx.annotation.Column;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
/**
 * Clase LlaveAlertaUsuario Llave primaria compuesta de la tabla intermedia
 * practicante_paciente
 */
public class LlavePracticantePaciente implements Serializable {

    @Column(name = "practicante_id")
    private String practicante_id;

    @Column(name = "paciente_id")
    private String paciente_id;

    @Override
    public boolean equals(Object o) {

        if (o == this)
            return true;
        if (!(o instanceof LlavePracticantePaciente)) {
            return false;
        }
        LlavePracticantePaciente llave = (LlavePracticantePaciente) o;
        return this.practicante_id.equals(llave.practicante_id) && this.paciente_id.equals(llave.paciente_id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(practicante_id, paciente_id);
    }
}
