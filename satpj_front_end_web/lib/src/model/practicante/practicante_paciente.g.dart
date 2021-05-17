// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'practicante_paciente.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PracticantePaciente _$PracticantePacienteFromJson(Map<String, dynamic> json) {
  return PracticantePaciente(
    id: json['id'] == null
        ? null
        : LlavePracticantePaciente.fromJson(json['id'] as Map<String, dynamic>),
    practicante: json['practicante'] == null
        ? null
        : Practicante.fromJson(json['practicante'] as Map<String, dynamic>),
    paciente: json['paciente'] == null
        ? null
        : Paciente.fromJson(json['paciente'] as Map<String, dynamic>),
    activo: json['activo'] as bool,
  );
}

Map<String, dynamic> _$PracticantePacienteToJson(
        PracticantePaciente instance) =>
    <String, dynamic>{
      'id': instance.id?.toJson(),
      'practicante': instance.practicante?.toJson(),
      'paciente': instance.paciente?.toJson(),
      'activo': instance.activo,
    };
