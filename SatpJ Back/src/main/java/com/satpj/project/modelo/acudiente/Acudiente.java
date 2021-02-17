package com.satpj.project.modelo.acudiente;

import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;

import com.satpj.project.modelo.paciente.Paciente;
import com.satpj.project.modelo.usuario.Usuario;

public class Acudiente {
    
    @OneToOne
    Usuario usuario;

    @ManyToOne
    Paciente paciente;

}
