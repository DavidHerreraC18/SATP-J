import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/views/vista_aprobacion_formularios.dart';
import 'package:satpj_front_end_web/src/views/vista_inicio.dart';

Map<String, WidgetBuilder> getAppRoutes(){

  return <String,WidgetBuilder>{
    '/' : (BuildContext context) => VistaInicio(),
    'aprobar-paciente': (BuildContext context) => VistaAprobacionPacientes(),
  };
}