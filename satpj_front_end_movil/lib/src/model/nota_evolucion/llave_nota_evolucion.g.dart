// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'llave_nota_evolucion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LlaveNotaEvolucion _$LlaveNotaEvolucionFromJson(Map<String, dynamic> json) {
  return LlaveNotaEvolucion(
    practicanteId: json['practicanteId'] as String,
    sesionTerapiaId: json['sesionTerapiaId'] as int,
  );
}

Map<String, dynamic> _$LlaveNotaEvolucionToJson(LlaveNotaEvolucion instance) =>
    <String, dynamic>{
      'practicanteId': instance.practicanteId,
      'sesionTerapiaId': instance.sesionTerapiaId,
    };
