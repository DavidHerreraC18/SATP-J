import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/views/agendar_citas/gestionar_agendamiento.dart';
import 'package:satpj_front_end_web/src/views/documentacion/vista_registro_documentos.dart';
import 'package:satpj_front_end_web/src/views/gestionar_horario_practicante/vista_horario_practicante_opcion_1.dart';
import 'package:satpj_front_end_web/src/views/gestionar_horario_practicante/vista_gestionar_horario_practicante.dart';
import 'package:satpj_front_end_web/src/views/gestionar_horario_practicante/vista_horario_practicante_opcion_2.dart';
import 'package:satpj_front_end_web/src/views/gestionar_horario_practicante/vista_horario_practicante_opcion_3.dart';
import 'package:satpj_front_end_web/src/views/gestionar_pacientes/vista_aprobacion_formularios.dart';
import 'package:satpj_front_end_web/src/views/gestionar_pacientes/vista_administrar_pacientes.dart';
import 'package:satpj_front_end_web/src/views/gestionar_perfil/vista_editar_auxiliar.dart';
import 'package:satpj_front_end_web/src/views/gestionar_practicantes/vista_administrar_practicantes.dart';
import 'package:satpj_front_end_web/src/views/gestionar_practicantes/vista_agregar_pacientes-practicantes.dart';
import 'package:satpj_front_end_web/src/views/gestionar_supervisores/vista_administracion_supervisores.dart';
import 'package:satpj_front_end_web/src/views/pagos/vista_registro_pago.dart';
import 'package:satpj_front_end_web/src/views/pagos/vista_registro_paquete_sesion.dart';
import 'package:satpj_front_end_web/src/views/pagos/vista_visualizar_pagos.dart';
import 'package:satpj_front_end_web/src/views/registro/vista_pre_registro.dart';
import 'package:satpj_front_end_web/src/views/registro/vista_pre_registro_1.dart';
import 'package:satpj_front_end_web/src/views/registro/vista_pre_registro_2.dart';
import 'package:satpj_front_end_web/src/views/registro/vista_pre_registro_3.dart';
import 'package:satpj_front_end_web/src/views/registro/vista_pre_registro_4.dart';
import 'package:satpj_front_end_web/src/views/registro/vista_registro.dart';
import 'package:satpj_front_end_web/src/views/vista_inicio.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => VistaInicio(),
    PreRegisterHomePage.route: (BuildContext context) => PreRegisterHomePage(),
    PreRegisterPage1.route: (BuildContext context) => PreRegisterPage1(),
    PreRegisterPage2.route: (BuildContext context) => PreRegisterPage2(),
    PreRegisterPage3.route: (BuildContext context) => PreRegisterPage3(),
    PreRegisterPage4.route              :  (BuildContext context) => PreRegisterPage4(),
    VistaRegistroPaquetesSesiones.route : (BuildContext context) => VistaRegistroPaquetesSesiones(),
    VistaRegistroPago.route             : (BuildContext context) => VistaRegistroPago(),
    VistaVisualizarPagos.route          : (BuildContext context) => VistaVisualizarPagos(),
    VistaAdministrarPacientes.route: (BuildContext context) =>
        VistaAdministrarPacientes(),
    VistaAdministrarPracticantes.route: (BuildContext context) =>
        VistaAdministrarPracticantes(),
    VistaAdministrarSupervisores.route: (BuildContext context) =>
        VistaAdministrarSupervisores(),
    VistaGestionarHorarioPracticante.route: (BuildContext context) =>
        VistaGestionarHorarioPracticante(),
    VistaHorarioPracticanteOpcion1.route: (BuildContext context) =>
        VistaHorarioPracticanteOpcion1(),
    VistaHorarioPracticanteOpcion3.route: (BuildContext context) =>
        VistaHorarioPracticanteOpcion3(),
    VistaHorarioPracticanteOpcion2.route: (BuildContext context) =>
        VistaHorarioPracticanteOpcion2(),
    VistaAprobacionFormularios.route: (BuildContext context) =>
        VistaAprobacionFormularios(),
    VistaGestionarAgendamiento.route: (BuildContext context) =>
        VistaGestionarAgendamiento(),
    VistaAgregarPacientesPracticantes.route: (BuildContext context) =>
        VistaAgregarPacientesPracticantes(),
    RegisterHomePage.route: (BuildContext context) => RegisterHomePage(),
    VistaRegistroDocumentos.route: (BuildContext contex) =>
        VistaRegistroDocumentos(),
    VistaEditarAuxiliar.route: (BuildContext contex) => VistaEditarAuxiliar(),
  };
}
