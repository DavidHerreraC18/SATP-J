import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/views/gestionar_horario_practicante/vista_horario_practicante_opcion_1.dart';
import 'package:satpj_front_end_web/src/views/gestionar_horario_practicante/vista_gestionar_horario_practicante.dart';
import 'package:satpj_front_end_web/src/views/gestionar_horario_practicante/vista_horario_practicante_opcion_2.dart';
import 'package:satpj_front_end_web/src/views/gestionar_horario_practicante/vista_horario_practicante_opcion_3.dart';
import 'package:satpj_front_end_web/src/views/gestionar_pacientes/vista_gestionar_pacientes.dart';
import 'package:satpj_front_end_web/src/views/gestionar_practicantes/vista_gestionar_practicantes.dart';
import 'package:satpj_front_end_web/src/views/gestionar_supervisores.dart/vista_gestionar_supervisores.dart';
import 'package:satpj_front_end_web/src/views/documentacion/vista_registro_documentos.dart';
import 'package:satpj_front_end_web/src/views/pagos/vista_registro_pago.dart';
import 'package:satpj_front_end_web/src/views/registro/vista_pre_registro.dart';
import 'package:satpj_front_end_web/src/views/registro/vista_pre_registro_1.dart';
import 'package:satpj_front_end_web/src/views/registro/vista_pre_registro_2.dart';
import 'package:satpj_front_end_web/src/views/registro/vista_pre_registro_3.dart';
import 'package:satpj_front_end_web/src/views/vista_inicio.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => VistaInicio(),
    //'login': (BuildContext context) => LoginPage(),
    PreRegisterHomePage.route: (BuildContext context) => PreRegisterHomePage(),
    PreRegisterPage1.route: (BuildContext context) => PreRegisterPage1(),
    PreRegisterPage2.route: (BuildContext context) => PreRegisterPage2(),
    PreRegisterPage3.route: (BuildContext context) => PreRegisterPage3(),
    VistaRegistroPago.route: (BuildContext context) => VistaRegistroPago(),
    VistaGestionarPacientes.route: (BuildContext context) =>
        VistaGestionarPacientes(),
    VistaGestionarPracticantes.route: (BuildContext context) =>
        VistaGestionarPracticantes(),
    VistaGestionarSupervisores.route: (BuildContext context) =>
        VistaGestionarSupervisores(),
    VistaGestionarHorarioPracticante.route: (BuildContext context) =>
        VistaGestionarHorarioPracticante(),
    VistaHorarioPracticanteOpcion1.route: (BuildContext context) =>
        VistaHorarioPracticanteOpcion1(),
    VistaHorarioPracticanteOpcion2.route: (BuildContext context) =>
        VistaHorarioPracticanteOpcion2(),
    VistaHorarioPracticanteOpcion3.route: (BuildContext context) =>
        VistaHorarioPracticanteOpcion3(),
  };
}
