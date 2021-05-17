import 'package:flutter/material.dart';
import 'package:satpj_front_end_movil/src/views/home_acudientes/vista_home_practicantes.dart';
import 'package:satpj_front_end_movil/src/views/vista_inicio.dart';
//import 'package:satpj_front_end_web/src/views/home_page.dart';
//import 'package:satpj_front_end_web/src/views/login_page.dart';

Map<String, WidgetBuilder> getAppRoutes(){

  return <String,WidgetBuilder>{
    '/'                    : (BuildContext context) => VistaInicio(),
    HomePracticantes.route : (BuildContext context) => HomePracticantes(),
    //'login': (BuildContext context) => LoginPage(),
  };
}