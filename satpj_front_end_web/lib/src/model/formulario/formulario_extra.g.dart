// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'formulario_extra.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormularioExtra _$FormularioExtraFromJson(Map<String, dynamic> json) {
  return FormularioExtra(
    id: json['id'] as int,
    paciente: json['paciente'] == null
        ? null
        : Paciente.fromJson(json['paciente'] as Map<String, dynamic>),
    escolaridad: json['escolaridad'] as String,
    estadoCivil: json['estadoCivil'] as String,
    ocupacion: json['ocupacion'] as String,
    lugarOcupacion: json['lugarOcupacion'] as String,
    tieneEps: json['tieneEps'] as bool,
    eps: json['eps'] as String,
    estadoEps: json['estadoEps'] as String,
    servicio: json['servicio'] as String,
    nombreAcudiente1: json['nombreAcudiente1'] as String,
    numeroAcudiente1: json['numeroAcudiente1'] as String,
    nombreAcudiente2: json['nombreAcudiente2'] as String,
    numeroAcudiente2: json['numeroAcudiente2'] as String,
  );
}

Map<String, dynamic> _$FormularioExtraToJson(FormularioExtra instance) =>
    <String, dynamic>{
      'id': instance.id,
      'paciente': instance.paciente?.toJson(),
      'escolaridad': instance.escolaridad,
      'estadoCivil': instance.estadoCivil,
      'ocupacion': instance.ocupacion,
      'lugarOcupacion': instance.lugarOcupacion,
      'tieneEps': instance.tieneEps,
      'eps': instance.eps,
      'estadoEps': instance.estadoEps,
      'servicio': instance.servicio,
      'nombreAcudiente1': instance.nombreAcudiente1,
      'numeroAcudiente1': instance.numeroAcudiente1,
      'nombreAcudiente2': instance.nombreAcudiente2,
      'numeroAcudiente2': instance.numeroAcudiente2,
    };
