// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sesion_terapia_actual.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SesionTerapiaActual _$SesionTerapiaActualFromJson(Map<String, dynamic> json) {
  return SesionTerapiaActual(
    fecha:
        json['fecha'] == null ? null : DateTime.parse(json['fecha'] as String),
    posible: json['posible'] as bool,
  );
}

Map<String, dynamic> _$SesionTerapiaActualToJson(
        SesionTerapiaActual instance) =>
    <String, dynamic>{
      'fecha': instance.fecha?.toIso8601String(),
      'posible': instance.posible,
    };
