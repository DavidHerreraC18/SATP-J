// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'formulario.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Formulario _$FormularioFromJson(Map<String, dynamic> json) {
  return Formulario(
    id: json['id'] as int,
    paciente: json['paciente'] == null
        ? null
        : Paciente.fromJson(json['paciente'] as Map<String, dynamic>),
    remitente: json['remitente'] as String,
    fueAtendido: json['fueAtendido'] as bool,
    lugarAtencion: json['lugarAtencion'] as String,
    motivoConsulta: json['motivoConsulta'] as String,
  );
}

Map<String, dynamic> _$FormularioToJson(Formulario instance) =>
    <String, dynamic>{
      'id': instance.id,
      'paciente': instance.paciente?.toJson(),
      'remitente': instance.remitente,
      'fueAtendido': instance.fueAtendido,
      'lugarAtencion': instance.lugarAtencion,
      'motivoConsulta': instance.motivoConsulta,
    };
