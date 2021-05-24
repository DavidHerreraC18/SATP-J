import 'package:flutter/material.dart';
import 'package:satpj_front_end_movil/src/views/home/vista_home.dart';
import 'package:satpj_front_end_movil/src/views/sesion_videollamadas/vista_llamada.dart';
import 'package:satpj_front_end_movil/src/views/vista_inicio.dart';
//import 'package:satpj_front_end_web/src/views/home_page.dart';
//import 'package:satpj_front_end_web/src/views/login_page.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => VistaInicio(),
    VistaLlamada.route: (BuildContext context) => VistaLlamada(),
    HomePage.route: (BuildContext context) => HomePage(),
    //'login': (BuildContext context) => LoginPage(),
  };
}
