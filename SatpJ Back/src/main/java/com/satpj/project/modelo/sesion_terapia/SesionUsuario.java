package com.satpj.project.modelo.sesion_terapia;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

import com.satpj.project.modelo.usuario.Usuario;

import lombok.Getter;
import lombok.Setter;

/**
 * Entidad sesion_usuario Tabla intermedia sesion_usuario generada por la
 * relación de muchos a muchos. Es necesario crear la clase explicitamente
 * debido a que esta cuenta con un atributo adicional
 */
@Getter
@Setter
@Entity
@Table(name = "sesion_usuario")
public class SesionUsuario {

    @EmbeddedId
    private LlaveSesionUsuario id;

    @ManyToOne
    @MapsId("usuario_id")
    @JoinColumn(name = "usuario_id")
    private Usuario usuario;

    @ManyToOne
    @MapsId("sesion_terapia_id")
    @JoinColumn(name = "sesion_terapia__id")
    private SesionTerapia sesionTerapia;

    @Column(name = "observador")
    private boolean observador;

}
