// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tarifa_sesion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TarifaSesion _$TarifaSesionFromJson(Map<String, dynamic> json) {
  return TarifaSesion(
    id: json['id'] as int,
    estrato: json['estrato'] as int,
    tarifa: json['tarifa'] as int,
  );
}

Map<String, dynamic> _$TarifaSesionToJson(TarifaSesion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'estrato': instance.estrato,
      'tarifa': instance.tarifa,
    };
