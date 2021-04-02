// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'documento_paciente.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentoPaciente _$DocumentoPacienteFromJson(Map<String, dynamic> json) {
  return DocumentoPaciente(
    id: json['id'] as int,
    paciente: json['paciente'] == null
        ? null
        : Paciente.fromJson(json['paciente'] as Map<String, dynamic>),
    nombre: json['nombre'] as String,
    contenido: json['contenido'] as String,
    tipo: json['tipo'] as String,
    radicacion: json['radicacion'] == null
        ? null
        : DateTime.parse(json['radicacion'] as String),
    vencimiento: json['vencimiento'] == null
        ? null
        : DateTime.parse(json['vencimiento'] as String),
  );
}

Map<String, dynamic> _$DocumentoPacienteToJson(DocumentoPaciente instance) =>
    <String, dynamic>{
      'id': instance.id,
      'paciente': instance.paciente?.toJson(),
      'nombre': instance.nombre,
      'contenido': instance.contenido,
      'tipo': instance.tipo,
      'radicacion': instance.radicacion?.toIso8601String(),
      'vencimiento': instance.vencimiento?.toIso8601String(),
    };
