import 'package:json_annotation/json_annotation.dart';
import 'package:satpj_front_end_movil/src/model/paciente/paciente.dart';
import 'dart:convert';

import 'package:satpj_front_end_movil/src/model/practicante/llave_practicante_paciente.dart';
import 'package:satpj_front_end_movil/src/model/practicante/practicante.dart';

part 'practicante_paciente.g.dart';

List<PracticantePaciente> practicantePacienteFromJson(String str) =>
    List<PracticantePaciente>.from(
        json.decode(str).map((x) => PracticantePaciente.fromJson(x)));

String practicantePacienteToJson(List<PracticantePaciente> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable(explicitToJson: true)
class PracticantePaciente {
  LlavePracticantePaciente id;

  Practicante practicante;

  Paciente paciente;

  bool activo;

  PracticantePaciente({this.id, this.practicante, this.paciente, this.activo});

  factory PracticantePaciente.fromJson(Map<String, dynamic> json) =>
      _$PracticantePacienteFromJson(json);

  Map<String, dynamic> toJson() => _$PracticantePacienteToJson(this);
}
