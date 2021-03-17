import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';


const kTtipoDocumento = ['Cédula de Ciudadanía', 'Tarjeta de Identidad', 'Cédula de Extranjería', 'Pasaporte'];
const kInstituciones = [ 'Institución educativa', 'Entidades estatales (ICBF, Comisaría de Familia)', 'Especialista o institución de salud',
	'Familia',
	'Otra ¿Cuál?'
];
const kEstratoSocioeconomico = ['1','2','3','4','5','6'];



InputDecoration getInputDecoration(String hintText){
   return InputDecoration(
         hintText: hintText,
         labelStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 18.0),
         contentPadding:
             EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
         border: OutlineInputBorder(
           borderRadius: BorderRadius.all(Radius.circular(8.0)),
         ),
         enabledBorder: OutlineInputBorder(
           borderSide:
               BorderSide(color: kPrimaryColor, width: 1.5),
           borderRadius: BorderRadius.all(Radius.circular(8.0)),
         ),
         focusedBorder: OutlineInputBorder(
           borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
           borderRadius: BorderRadius.all(Radius.circular(8.0)),
         ),
       );
}
