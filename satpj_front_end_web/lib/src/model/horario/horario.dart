
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'package:satpj_front_end_web/src/model/usuario/usuario.dart';

part 'horario.g.dart';

List<Horario> horarioFromJson(String str) =>
    List<Horario>.from(json.decode(str).map((x) => Horario.fromJson(x)));

String horarioToJson(List<Horario> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable(explicitToJson: true)
class Horario{

  int id;

  Usuario usuario;
  
  String opcion;

  String lunes;

  String martes;

  String miercoles;

  String jueves;

  String viernes;
  
  String sabado;

  Horario({
    this.id,
    this.usuario,
    this.lunes,
    this.martes,
    this.miercoles,
    this.jueves,
    this.viernes,
    this.sabado
  });

  factory Horario.fromJson(Map<String, dynamic> json) => _$HorarioFromJson(json);

    Map<String, dynamic> toJson() => _$HorarioToJson(this);

    Map<String, List<int>> forView(){
      
      Map <String, List<int>> horario = 
      {
        'lunes': null,
        'martes': null,
        'miercoles': null,
        'jueves': null,
        'viernes': null,
        'sabado': null
      };

      if(lunes != null && lunes.isNotEmpty){
          List<int> horas = [];
          lunes.split(';').forEach((element) {
          horas.add(int.parse(element));
          horario['lunes'] = horas;
         });
      }

       if(martes != null && martes.isNotEmpty){
          List<int> horas = [];
          martes.split(';').forEach((element) {
          horas.add(int.parse(element));
          horario['martes'] = horas;
         });
      }

       if(miercoles != null &&miercoles.isNotEmpty){
          List<int> horas = [];
          miercoles.split(';').forEach((element) {
          horas.add(int.parse(element));
          horario['miercoles'] = horas;
         });
      }

      if(jueves != null &&jueves.isNotEmpty){
          List<int> horas = [];
          jueves.split(';').forEach((element) {
          horas.add(int.parse(element));
          horario['jueves'] = horas;
         });
      }

      if(viernes != null &&viernes.isNotEmpty){
          List<int> horas = [];
          viernes.split(';').forEach((element) {
          horas.add(int.parse(element));
          horario['viernes'] = horas;
         });
      }
      
      if(sabado!= null &&sabado.isNotEmpty){
          List<int> horas = [];
          sabado.split(';').forEach((element) {
          horas.add(int.parse(element));
          horario['sabado'] = horas;
         });
      }     
      return horario;
    }
}