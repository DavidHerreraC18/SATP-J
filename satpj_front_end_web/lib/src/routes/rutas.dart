import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/views/documentacion/register_page_1.dart';
import 'package:satpj_front_end_web/src/views/pagos/vista_registro_pago.dart';
import 'package:satpj_front_end_web/src/views/register/pre_register_page_1.dart';
import 'package:satpj_front_end_web/src/views/register/pre_register_page_2.dart';
import 'package:satpj_front_end_web/src/views/register/pre_register_page_3.dart';
import 'package:satpj_front_end_web/src/views/gestionar_pacientes/vista_aprobacion_formularios.dart';
import 'package:satpj_front_end_web/src/views/vista_inicio.dart';

    'aprobar-paciente': (BuildContext context) => VistaAprobacionPacientes(),
Map<String, WidgetBuilder> getAppRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => VistaInicio(),
    //'login': (BuildContext context) => LoginPage(),
    PreRegisterPage1.route: (BuildContext context) => PreRegisterPage1(),
    PreRegisterPage2.route: (BuildContext context) => PreRegisterPage2(),
    PreRegisterPage3.route: (BuildContext context) => PreRegisterPage3(),
    RegisterPage1.route: (BuildContext context) => RegisterPage1(),
    VistaRegistroPago.route: (BuildContext context) => VistaRegistroPago(),
    'prepaciente': (BuildContext context) => VistaPreadmision(),
  };
}
