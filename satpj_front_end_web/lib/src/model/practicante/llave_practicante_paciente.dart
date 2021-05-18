import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'llave_practicante_paciente.g.dart';

List<LlavePracticantePaciente> llavePracticantePacienteFromJson(String str) =>
    List<LlavePracticantePaciente>.from(
        json.decode(str).map((x) => LlavePracticantePaciente.fromJson(x)));

String llavePracticantePacienteToJson(List<LlavePracticantePaciente> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable(explicitToJson: true)
class LlavePracticantePaciente {
  // ignore: non_constant_identifier_names
  String practicante_id;
  // ignore: non_constant_identifier_names
  String paciente_id;

  LlavePracticantePaciente(
      {
      // ignore: non_constant_identifier_names
      this.practicante_id,
      // ignore: non_constant_identifier_names
      this.paciente_id});

  factory LlavePracticantePaciente.fromJson(Map<String, dynamic> json) =>
      _$LlavePracticantePacienteFromJson(json);

  Map<String, dynamic> toJson() => _$LlavePracticantePacienteToJson(this);
}
