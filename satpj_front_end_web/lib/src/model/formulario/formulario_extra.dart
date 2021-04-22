import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';

part 'formulario_extra.g.dart';

List<FormularioExtra> formularioExtraFromJson(String str) =>
    List<FormularioExtra>.from(
        json.decode(str).map((x) => FormularioExtra.fromJson(x)));

String formularioExtraToJson(List<FormularioExtra> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

FormularioExtra singleFormularioExtraFromJson(String str) {
  FormularioExtra formularioExtra = FormularioExtra.fromJson(json.decode(str));
  return formularioExtra;
}

@JsonSerializable(explicitToJson: true)
class FormularioExtra {
  int id;

  Paciente paciente;

  String escolaridad;

  String estadoCivil;

  String ocupacion;

  String lugarOcupacion;

  bool tieneEps;

  String eps;

  String estadoEps;

  String servicio;

  String nombreAcudiente1;

  String numeroAcudiente1;

  String nombreAcudiente2;

  String numeroAcudiente2;

  FormularioExtra(
      {this.id,
      this.paciente,
      this.escolaridad,
      this.estadoCivil,
      this.ocupacion,
      this.lugarOcupacion,
      this.tieneEps,
      this.eps,
      this.estadoEps,
      this.servicio,
      this.nombreAcudiente1,
      this.numeroAcudiente1,
      this.nombreAcudiente2,
      this.numeroAcudiente2});

  factory FormularioExtra.fromJson(Map<String, dynamic> json) =>
      _$FormularioExtraFromJson(json);

  Map<String, dynamic> toJson() => _$FormularioExtraToJson(this);
}
