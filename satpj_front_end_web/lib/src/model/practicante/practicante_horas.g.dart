// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'practicante_horas.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PracticanteHoras _$PracticanteHorasFromJson(Map<String, dynamic> json) {
  return PracticanteHoras(
    practicante: json['practicante'] == null
        ? null
        : Practicante.fromJson(json['practicante'] as Map<String, dynamic>),
    horas: json['horas'] as int,
  );
}

Map<String, dynamic> _$PracticanteHorasToJson(PracticanteHoras instance) =>
    <String, dynamic>{
      'practicante': instance.practicante?.toJson(),
      'horas': instance.horas,
    };
