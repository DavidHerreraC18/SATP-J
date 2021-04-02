import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'llave_practicante_paciente.g.dart';

List<LlavePracticantePaciente> llavePracticantePacienteFromJson(String str) =>
    List<LlavePracticantePaciente>.from(json.decode(str).map((x) => LlavePracticantePaciente.fromJson(x)));

String llavePracticantePacienteToJson(List<LlavePracticantePaciente> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable(explicitToJson: true)
class LlavePracticantePaciente{
  String pPracticanteId;
  String pPacienteId;

  LlavePracticantePaciente({
    this.pPracticanteId,
    this.pPacienteId
  });

  factory LlavePracticantePaciente.fromJson(Map<String, dynamic> json) => _$LlavePracticantePacienteFromJson(json);

  Map<String, dynamic> toJson() => _$LlavePracticantePacienteToJson(this);

}