// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sesion_terapia.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SesionTerapia _$SesionTerapiaFromJson(Map<String, dynamic> json) {
  return SesionTerapia(
    id: json['id'] as int,
    sesiones: (json['sesiones'] as List)
        ?.map((e) => e == null
            ? null
            : SesionUsuario.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    paqueteSesion: json['paqueteSesion'] == null
        ? null
        : PaqueteSesion.fromJson(json['paqueteSesion'] as Map<String, dynamic>),
    fecha:
        json['fecha'] == null ? null : DateTime.parse(json['fecha'] as String),
    virtual: json['virtual'] as bool,
    consultorio: json['consultorio'] == null
        ? null
        : Consultorio.fromJson(json['consultorio'] as Map<String, dynamic>),
    enlaceStreaming: json['enlaceStreaming'] as String,
  );
}

Map<String, dynamic> _$SesionTerapiaToJson(SesionTerapia instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sesiones': instance.sesiones?.map((e) => e?.toJson())?.toList(),
      'paqueteSesion': instance.paqueteSesion?.toJson(),
      'fecha': instance.fecha?.toIso8601String(),
      'virtual': instance.virtual,
      'consultorio': instance.consultorio?.toJson(),
      'enlaceStreaming': instance.enlaceStreaming,
    };
