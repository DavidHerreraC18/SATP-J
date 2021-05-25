package com.satpj.project.modelo.consultorio;

import lombok.Getter;
import lombok.Setter;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 * Entidad Consultorio
 * Representación de un consultorio físico presente en la universidad.
 */
@Getter
@Setter
@Entity
@Table(name = "consultorio")
public class Consultorio {
    /**
     * Corresponde al id de la Entidad Consultorio, el cual es al mismo tiempo el nombre del consultorio presencial.
     */
    @Id
    @Column(name = "consultorio")
    private String consultorio;
}
