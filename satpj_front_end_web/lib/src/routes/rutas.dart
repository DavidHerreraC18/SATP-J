import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/views/vista_inicio.dart';
import 'package:satpj_front_end_web/src/views/vista_preadminision_pacientes.dart';

Map<String, WidgetBuilder> getAppRoutes(){

  return <String,WidgetBuilder>{
    '/' : (BuildContext context) => VistaInicio(),
    'prepaciente': (BuildContext context) => VistaPreadmision(),
  };
}