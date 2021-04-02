// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alerta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Alerta _$AlertaFromJson(Map<String, dynamic> json) {
  return Alerta(
    id: json['id'] as int,
    alertaUsuario: (json['alertaUsuario'] as List)
        ?.map((e) => e == null
            ? null
            : AlertaUsuario.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    tipo: json['tipo'] as String,
  );
}

Map<String, dynamic> _$AlertaToJson(Alerta instance) => <String, dynamic>{
      'id': instance.id,
      'alertaUsuario':
          instance.alertaUsuario?.map((e) => e?.toJson())?.toList(),
      'tipo': instance.tipo,
    };
