package com.satpj.project.modelo.practicante;

import java.io.Serializable;

import com.ibm.db2.cmx.annotation.Column;

/**
 * Clase LlaveAlertaUsuario Llave primaria compuesta de la tabla intermedia
 * practicante_paciente
 */
public class LlavePracticantePaciente implements Serializable {

    @Column(name = "practicante_id")
    private String practicante_id;

    @Column(name = "paciente_id")
    private String paciente_id;

    public String getPracticante_id() {
        return practicante_id;
    }

    public void setPracticante_id(String practicante_id) {
        this.practicante_id = practicante_id;
    }

    public String getPaciente_id() {
        return paciente_id;
    }

    public void setPaciente_id(String paciente_id) {
        this.paciente_id = paciente_id;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((paciente_id == null) ? 0 : paciente_id.hashCode());
        result = prime * result + ((practicante_id == null) ? 0 : practicante_id.hashCode());
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        LlavePracticantePaciente other = (LlavePracticantePaciente) obj;
        if (paciente_id == null) {
            if (other.paciente_id != null)
                return false;
        } else if (!paciente_id.equals(other.paciente_id))
            return false;
        if (practicante_id == null) {
            if (other.practicante_id != null)
                return false;
        } else if (!practicante_id.equals(other.practicante_id))
            return false;
        return true;
    }

    
}
