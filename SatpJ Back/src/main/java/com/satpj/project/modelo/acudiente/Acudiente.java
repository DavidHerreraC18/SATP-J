package com.satpj.project.modelo.acudiente;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Polymorphism;
import org.hibernate.annotations.PolymorphismType;

import com.satpj.project.modelo.paciente.Paciente;
import com.satpj.project.modelo.usuario.Usuario;


/**
 * Entidad Acudiente
 * El Acudiente representa al tutor legal que tiene un Paciente
 * menor de edad como el padre o la madre
 */
@Getter
@Setter
@Entity
@Table(name = "acudiente")
@Polymorphism(type = PolymorphismType.EXPLICIT)
public class Acudiente extends Usuario{
    
    /**
     * Corresponde al paciente que tiene a su cuidado. 
     */
    @ManyToOne(cascade = CascadeType.MERGE, fetch = FetchType.EAGER)
    @JoinColumn(name = "paciente_id", nullable = true,  insertable = false)
    private Paciente paciente;

}

/*@OneToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
  @JoinColumn(name = "usuario_id", nullable = false)
  @MapsId
  Usuario usuario;*/
