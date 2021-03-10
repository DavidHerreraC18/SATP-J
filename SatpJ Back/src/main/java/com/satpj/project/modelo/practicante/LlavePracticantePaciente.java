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
    private String pPracticanteId;

    @Column(name = "paciente_id")
    private String pPacienteId;

    public String getPPracticanteId() {
        return pPracticanteId;
    }

    public void setPPracticanteId(String pPracticanteId) {
        this.pPracticanteId = pPracticanteId;
    }

    public String getPPacienteId() {
        return pPacienteId;
    }

    public void setPPacienteId(String pPacienteId) {
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
        return this.pPracticanteId.equals(llave.pPracticanteId) && this.pPacienteId.equals(llave.pPacienteId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(pPracticanteId, pPacienteId);
    }
}
