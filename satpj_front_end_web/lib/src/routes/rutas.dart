import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/views/gestionar_pacientes/vista_gestionar_pacientes.dart';
import 'package:satpj_front_end_web/src/views/gestionar_practicantes/vista_gestionar_practicantes.dart';
import 'package:satpj_front_end_web/src/views/gestionar_supervisores.dart/vista_gestionar_supervisores.dart';
import 'package:satpj_front_end_web/src/views/documentacion/register_page_1.dart';
import 'package:satpj_front_end_web/src/views/pagos/vista_registro_pago.dart';
import 'package:satpj_front_end_web/src/views/registro/vista_pre_registro.dart';
import 'package:satpj_front_end_web/src/views/registro/vista_pre_registro_1.dart';
import 'package:satpj_front_end_web/src/views/registro/vista_pre_registro_2.dart';
import 'package:satpj_front_end_web/src/views/registro/vista_pre_registro_3.dart';
import 'package:satpj_front_end_web/src/views/vista_inicio.dart';
import 'package:satpj_front_end_web/src/views/vista_preadminision_pacientes.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => VistaInicio(),
    //'login': (BuildContext context) => LoginPage(),
    RegisterPage1.route: (BuildContext context) => RegisterPage1(),
    PreRegisterHomePage.route       : (BuildContext context) => PreRegisterHomePage(),
    PreRegisterPage1.route          : (BuildContext context) => PreRegisterPage1(),
    PreRegisterPage2.route          : (BuildContext context) => PreRegisterPage2(),
    PreRegisterPage3.route          : (BuildContext context) => PreRegisterPage3(),
    VistaRegistroPago.route         : (BuildContext context) => VistaRegistroPago(),
    VistaGestionarPacientes.route   : (BuildContext context) => VistaGestionarPacientes(),
    VistaGestionarPracticantes.route : (BuildContext context) => VistaGestionarPracticantes(),
    VistaGestionarSupervisores.route : (BuildContext context) => VistaGestionarSupervisores(),
    'prepaciente': (BuildContext context) => VistaPreadmision(),
  };
}

