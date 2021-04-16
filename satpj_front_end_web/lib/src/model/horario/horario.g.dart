// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'horario.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Horario _$HorarioFromJson(Map<String, dynamic> json) {
  return Horario(
    id: json['id'] as int,
    usuario: json['usuario'] == null
        ? null
        : Usuario.fromJson(json['usuario'] as Map<String, dynamic>),
    opcion: json['opcion'] as String,
    lunes: json['lunes'] as String,
    martes: json['martes'] as String,
    miercoles: json['miercoles'] as String,
    jueves: json['jueves'] as String,
    viernes: json['viernes'] as String,
    sabado: json['sabado'] as String,
  );
}

Map<String, dynamic> _$HorarioToJson(Horario instance) => <String, dynamic>{
      'id': instance.id,
      'usuario': instance.usuario?.toJson(),
      'opcion': instance.opcion,
      'lunes': instance.lunes,
      'martes': instance.martes,
      'miercoles': instance.miercoles,
      'jueves': instance.jueves,
      'viernes': instance.viernes,
      'sabado': instance.sabado,
    };
