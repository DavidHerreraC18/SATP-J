// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grupo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Grupo _$GrupoFromJson(Map<String, dynamic> json) {
  return Grupo(
    id: json['id'] as int,
    tipo: json['tipo'] as String,
    integrantes: (json['integrantes'] as List)
        ?.map((e) =>
            e == null ? null : Paciente.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GrupoToJson(Grupo instance) => <String, dynamic>{
      'id': instance.id,
      'tipo': instance.tipo,
      'integrantes': instance.integrantes?.map((e) => e?.toJson())?.toList(),
    };
