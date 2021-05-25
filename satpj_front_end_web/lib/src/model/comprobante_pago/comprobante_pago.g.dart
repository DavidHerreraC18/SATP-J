// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comprobante_pago.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComprobantePago _$ComprobantePagoFromJson(Map<String, dynamic> json) {
  return ComprobantePago(
    id: json['id'] as int,
    paqueteSesion: json['paqueteSesion'] == null
        ? null
        : PaqueteSesion.fromJson(json['paqueteSesion'] as Map<String, dynamic>),
    informesPagos: (json['informesPagos'] as List)
        ?.map((e) =>
            e == null ? null : InformePago.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    valorTotal: (json['valorTotal'] as num)?.toDouble(),
    referenciaPago: json['referenciaPago'] as String,
    fecha:
        json['fecha'] == null ? null : DateTime.parse(json['fecha'] as String),
    observacion: json['observacion'] as String,
  );
}

Map<String, dynamic> _$ComprobantePagoToJson(ComprobantePago instance) =>
    <String, dynamic>{
      'id': instance.id,
      'paqueteSesion': instance.paqueteSesion?.toJson(),
      'informesPagos':
          instance.informesPagos?.map((e) => e?.toJson())?.toList(),
      'valorTotal': instance.valorTotal,
      'referenciaPago': instance.referenciaPago,
      'fecha': instance.fecha?.toIso8601String(),
      'observacion': instance.observacion,
    };
