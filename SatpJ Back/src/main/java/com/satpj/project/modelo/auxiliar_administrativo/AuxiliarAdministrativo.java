package com.satpj.project.modelo.auxiliar_administrativo;

import javax.persistence.ManyToOne;

import com.satpj.project.modelo.usuario.Usuario;

public class AuxiliarAdministrativo {
    
    @ManyToOne
    Usuario usuario;
    
}
