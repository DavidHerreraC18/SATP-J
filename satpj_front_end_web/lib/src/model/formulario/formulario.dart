
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';

part 'formulario.g.dart';

List<Formulario> formularioFromJson(String str) =>
    List<Formulario>.from(json.decode(str).map((x) => Formulario.fromJson(x)));

String formularioToJson(List<Formulario> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

/*Formulario singleFormularioFromJson(String str){
  Formulario formulario = Formulario.fromJson(json.decode(str));
  return formulario;
}*/

@JsonSerializable(explicitToJson: true)
class Formulario{

    int id;

    Paciente paciente;

    String remitente;

    bool fueAtendido;

    String lugarAtencion;

    String motivoConsulta;

    Formulario({
      this.id,
      this.paciente,
      this.remitente,
      this.fueAtendido,
      this.lugarAtencion,
      this.motivoConsulta
    });

    factory Formulario.fromJson(Map<String, dynamic> json) => _$FormularioFromJson(json);

    Map<String, dynamic> toJson() => _$FormularioToJson(this);

}