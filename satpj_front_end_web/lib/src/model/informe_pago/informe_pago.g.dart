// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'informe_pago.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InformePago _$InformePagoFromJson(Map<String, dynamic> json) {
  return InformePago(
    id: json['id'] as int,
    comprobante: (json['comprobante'] as List)
        ?.map((e) => e == null
            ? null
            : ComprobantePago.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    fechaInicio: json['fechaInicio'] == null
        ? null
        : DateTime.parse(json['fechaInicio'] as String),
    fechaFin: json['fechaFin'] == null
        ? null
        : DateTime.parse(json['fechaFin'] as String),
    total: (json['total'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$InformePagoToJson(InformePago instance) =>
    <String, dynamic>{
      'id': instance.id,
      'comprobante': instance.comprobante?.map((e) => e?.toJson())?.toList(),
      'fechaInicio': instance.fechaInicio?.toIso8601String(),
      'fechaFin': instance.fechaFin?.toIso8601String(),
      'total': instance.total,
    };
