// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paquete_sesion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaqueteSesion _$PaqueteSesionFromJson(Map<String, dynamic> json) {
  return PaqueteSesion(
    id: json['id'] as int,
    paciente: json['paciente'] == null
        ? null
        : Paciente.fromJson(json['paciente'] as Map<String, dynamic>),
    comprobantePago: json['comprobantePago'] == null
        ? null
        : ComprobantePago.fromJson(
            json['comprobantePago'] as Map<String, dynamic>),
    cantidadSesiones: json['cantidadSesiones'] as int,
    total: (json['total'] as num)?.toDouble(),
    fecha:
        json['fecha'] == null ? null : DateTime.parse(json['fecha'] as String),
  );
}

Map<String, dynamic> _$PaqueteSesionToJson(PaqueteSesion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'paciente': instance.paciente?.toJson(),
      'comprobantePago': instance.comprobantePago?.toJson(),
      'cantidadSesiones': instance.cantidadSesiones,
      'total': instance.total,
      'fecha': instance.fecha?.toIso8601String(),
    };
