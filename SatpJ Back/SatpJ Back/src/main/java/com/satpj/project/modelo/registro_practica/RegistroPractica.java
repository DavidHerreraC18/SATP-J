package com.satpj.project.modelo.registro_practica;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;

import com.satpj.project.modelo.practicante.Practicante;

public class RegistroPractica {

    @Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "usuario_id")
	private int id;

    @OneToOne
    private Practicante practicante;

	@Column(name = "horas")
	private double horas;
    
    @Column(name = "sesiones_realizadas")
	private int sesionesRealizadas;

    @Column(name = "sesiones_canceladas")
	private int sesionesCanceladas;
   
    @Column(name = "sesiones_supervisadas")
	private int sesionesSupervisadas;


    
}
