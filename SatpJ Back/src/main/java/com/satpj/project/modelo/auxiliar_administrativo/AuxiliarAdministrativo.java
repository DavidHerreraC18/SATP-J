package com.satpj.project.modelo.auxiliar_administrativo;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Polymorphism;
import org.hibernate.annotations.PolymorphismType;

import com.satpj.project.modelo.usuario.Usuario;

/**
 * Entidad AuxiliarAdministravo 
 * El Auxiliar Administrativo es el Usuario que puede gestionar
 * la mayoria de los componentes del sistema, como los pacientes,
 * agendar citas, entre otros
 */
@Getter
@Setter
@Entity
@Table(name = "auxiliar_administrativo")
@Polymorphism(type = PolymorphismType.EXPLICIT)
public class AuxiliarAdministrativo extends Usuario{
    

}
