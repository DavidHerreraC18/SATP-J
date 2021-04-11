// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nota_evolucion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotaEvolucion _$NotaEvolucionFromJson(Map<String, dynamic> json) {
  return NotaEvolucion(
    id: json['id'] == null
        ? null
        : LlaveNotaEvolucion.fromJson(json['id'] as Map<String, dynamic>),
    practicante: json['practicante'] == null
        ? null
        : Practicante.fromJson(json['practicante'] as Map<String, dynamic>),
    sesionTerapia: json['sesionTerapia'] == null
        ? null
        : SesionTerapia.fromJson(json['sesionTerapia'] as Map<String, dynamic>),
    supervisor: json['supervisor'] == null
        ? null
        : Supervisor.fromJson(json['supervisor'] as Map<String, dynamic>),
    contenido: json['contenido'] as String,
    fechaHora: json['fechaHora'] == null
        ? null
        : DateTime.parse(json['fechaHora'] as String),
    enviada: json['enviada'] as bool,
    registrada: json['registrada'] as bool,
  );
}

Map<String, dynamic> _$NotaEvolucionToJson(NotaEvolucion instance) =>
    <String, dynamic>{
      'id': instance.id?.toJson(),
      'practicante': instance.practicante?.toJson(),
      'sesionTerapia': instance.sesionTerapia?.toJson(),
      'supervisor': instance.supervisor?.toJson(),
      'contenido': instance.contenido,
      'fechaHora': instance.fechaHora?.toIso8601String(),
      'enviada': instance.enviada,
      'registrada': instance.registrada,
    };
