package com.satpj.project.modelo.practicante;

import java.io.Serializable;
import java.util.Objects;

import com.ibm.db2.cmx.annotation.Column;

/**
 * Clase LlaveAlertaUsuario Llave primaria compuesta de la tabla intermedia
 * practicante_paciente
 */
public class LlavePracticantePaciente implements Serializable {

    @Column(name = "practicante_id")
    private Long pPracticanteId;

    @Column(name = "paciente_id")
    private Long pPacienteId;

    public Long getPPracticanteId() {
        return pPracticanteId;
    }

    public void setPPracticanteId(Long pPracticanteId) {
        this.pPracticanteId = pPracticanteId;
    }

    public Long getPPacienteId() {
        return pPacienteId;
    }

    public void setPPacienteId(Long pPacienteId) {
        this.pPacienteId = pPacienteId;
    }

    @Override
    public boolean equals(Object o) {

        if (o == this)
            return true;
        if (!(o instanceof LlavePracticantePaciente)) {
            return false;
        }
        LlavePracticantePaciente llave = (LlavePracticantePaciente) o;
        return this.pPracticanteId == llave.pPracticanteId && this.pPacienteId == llave.pPacienteId;
    }

    @Override
    public int hashCode() {
        return Objects.hash(pPracticanteId, pPacienteId);
    }
}
