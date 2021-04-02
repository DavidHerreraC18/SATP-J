// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registro_practica.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistroPractica _$RegistroPracticaFromJson(Map<String, dynamic> json) {
  return RegistroPractica(
    id: json['id'] as int,
    practicante: json['practicante'] == null
        ? null
        : Practicante.fromJson(json['practicante'] as Map<String, dynamic>),
    horas: (json['horas'] as num)?.toDouble(),
    sesionesRealizadas: json['sesionesRealizadas'] as int,
    sesionesCanceladas: json['sesionesCanceladas'] as int,
    sesionesSupervisadas: json['sesionesSupervisadas'] as int,
  );
}

Map<String, dynamic> _$RegistroPracticaToJson(RegistroPractica instance) =>
    <String, dynamic>{
      'id': instance.id,
      'practicante': instance.practicante?.toJson(),
      'horas': instance.horas,
      'sesionesRealizadas': instance.sesionesRealizadas,
      'sesionesCanceladas': instance.sesionesCanceladas,
      'sesionesSupervisadas': instance.sesionesSupervisadas,
    };
