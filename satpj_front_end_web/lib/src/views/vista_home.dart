import 'dart:async';

import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/sesion_terapia/sesion_terapia.dart';
import 'package:satpj_front_end_web/src/model/sesion_terapia/sesion_terapia_actual.dart';
import 'package:satpj_front_end_web/src/model/sesion_terapia/sesion_usuario.dart';
import 'package:satpj_front_end_web/src/model/usuario/usuario.dart';
import 'package:satpj_front_end_web/src/providers/provider_administracion_usuarios.dart';
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';
import 'package:satpj_front_end_web/src/providers/provider_sesiones_terapia.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_auxiliar_administrativo.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_paciente.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_practicante.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_supervisor.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Calendarios/CalendarioPrincipal.dart';
import 'package:satpj_front_end_web/src/utils/widgets/barras/toolbar_acudiente.dart';
import 'package:satpj_front_end_web/src/utils/widgets/loading/LoadingWanderingCube.dart';

class HomePage extends StatefulWidget {
  static const route = '/home-usuarios';
  @override
  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Usuario usuario;
  List<SesionUsuario> sesionesUsuario;
  AppBar appBar;
  SesionTerapia sesionTerapiaActual;
  bool sesionHabilitada;
  Timer timer;
  @override
  initState() {
    sesionTerapiaActual = null;
    sesionesUsuario = null;
    super.initState();
  }

  void revisarSesionTerapiaActual() async {
    bool ninguna = true;
    for (SesionUsuario sesionUsuario in sesionesUsuario) {
      SesionTerapia sT = sesionUsuario.sesionTerapia;
      DateTime ahora = DateTime.now();
      DateTime finSesion = sT.fecha.add(new Duration(hours: 1));
      if (ahora.isAfter(sT.fecha) &&
          ahora.isBefore(finSesion) &&
          !sesionHabilitada) {
        setState(() {
          sesionTerapiaActual = sT;
          sesionHabilitada = true;
        });
        ninguna = false;
      }
    }
    if (ninguna && sesionHabilitada) {
      setState(() {
        sesionTerapiaActual = null;
        sesionHabilitada = false;
      });
    }
  }

  Future<String> obtenerInformacionPrincipal() async {
    String uid = ProviderAuntenticacion.uid;
    usuario = await ProviderAdministracionUsuarios.buscarUsuario(uid);
    sesionesUsuario = await ProviderSesionesTerapia.obtenerSesionesUsuario(uid);
    switch (usuario.tipoUsuario) {
      case "Paciente":
        appBar = toolbarPaciente(context);
        break;
      case "Practicante":
        appBar = toolbarPracticante(context);
        break;
      case "Auxiliar Administrativo":
        appBar = toolbarAuxiliarAdministrativo(context);
        break;
      case "Acudiente":
        appBar = toolbarAcudiente(context);
        break;
      case "Supervisor":
        appBar = toolbarSupervisor(context);
        break;
      default:
      // code block
    }
    return Future.value("Data download successfully");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: obtenerInformacionPrincipal(), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        // AsyncSnapshot<Your object type>
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingWanderingCube();
        } else {
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else
            return Scaffold(
                //backgroundColor: Color(0xFFD4EDEB),
                appBar: appBar,
                body: CalendarioPrincipal(
                    sesionesUsuario: sesionesUsuario,
                    usuario:
                        usuario)); // snapshot.data  :- get your object which is pass from your downloadData() function
        }
      },
    );
  }
}
