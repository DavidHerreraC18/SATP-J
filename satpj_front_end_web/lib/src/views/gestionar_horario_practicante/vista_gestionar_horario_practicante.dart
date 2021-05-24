import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/constants/constantes_data.dart';
import 'package:satpj_front_end_web/src/model/horario/horario.dart';
import 'package:satpj_front_end_web/src/model/practicante/practicante.dart';
import 'package:satpj_front_end_web/src/model/usuario/usuario.dart';
import 'package:satpj_front_end_web/src/providers/provider_administracion_usuarios.dart';
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_auxiliar_administrativo.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_practicante.dart';
import 'package:satpj_front_end_web/src/utils/widgets/loading/LoadingWanderingCube.dart';
import 'package:satpj_front_end_web/src/utils/widgets/schedule/schedule_intern%20combined.dart';
import 'package:satpj_front_end_web/src/views/gestionar_horario_practicante/vista_horario_practicante_opcion_1.dart';
import 'package:satpj_front_end_web/src/views/gestionar_horario_practicante/vista_horario_practicante_opcion_2.dart';
import 'package:satpj_front_end_web/src/views/gestionar_horario_practicante/vista_horario_practicante_opcion_3.dart';
import 'package:satpj_front_end_web/src/views/gestionar_practicantes/vista_administrar_practicantes.dart';

import '../vista_home.dart';

class VistaGestionarHorarioPracticante extends StatefulWidget {
  static const route = '/horario-practicante';

  VistaGestionarHorarioPracticante();

  @override
  _VistaGestionarHorarioPracticanteState createState() =>
      _VistaGestionarHorarioPracticanteState();
}

class _VistaGestionarHorarioPracticanteState
    extends State<VistaGestionarHorarioPracticante> {
  int horas = 0;
  int horarios = 0;
  Map<String, List<int>> horarioVista;
  bool auxiliar = false;
  Practicante practicante = new Practicante();
  AppBar appBar = AppBar();
  Usuario usuario = new Usuario();
  bool aprobado = false;

  Horario opcion1;
  Horario opcion2;
  Horario opcion3;

  Map<String, List<int>> horario1;
  Map<String, List<int>> horario2;
  Map<String, List<int>> horario3;

  initDataHorarios() {
    horario1 = {};
    horario2 = {};
    horario3 = {};
    if (practicante.horarios == null) {
      practicante.horarios = [];
      horarioVista = {};
    }

    horarios = practicante.horarios.length;

    if (practicante.horarios.isNotEmpty) {
      for (Horario h in practicante.horarios) {
        if (h.opcion == '1') {
          opcion1 = h;
          horario1 = opcion1.forView();
        }
        if (h.opcion == 'seleccionado') {
          aprobado = true;
        } else if (h.opcion == '2') {
          opcion2 = h;
          horario2 = opcion2.forView();
        } else {
          opcion3 = h;
          horario3 = opcion3.forView();
        }
      }
    }

    horas = 7;
  }

  Future<String> obtenerInformacionPrincipal() async {
    String uid = ProviderAuntenticacion.uid;
    usuario = await ProviderAdministracionUsuarios.buscarUsuario(uid);
    switch (usuario.tipoUsuario) {
      case "Practicante":
        appBar = toolbarPracticante(context);
        break;
      case "Auxiliar Administrativo":
        appBar = toolbarAuxiliarAdministrativo(context);
        auxiliar = true;
        break;
      default:
      // code block
    }
    return Future.value("Data download successfully");
  }

  @override
  void initState() {
    if (practicante != null) {
      if (practicante.horarios == null) {
        practicante.horarios = [];
      }
    }
    super.initState();
  }

  bool esHora(String dia) {
    if (horarioVista[dia] != null &&
        horarioVista[dia].isNotEmpty &&
        horarioVista[dia].indexOf(horas) > -1) {
      return true;
    }
    return false;
  }

  List<PopupMenuItem<String>> getPopupMenuItem(String estado) {
    List<PopupMenuItem<String>> items = [];

    if (estado == 'existentes' && horarios > 0) {
      for (Horario opcion in practicante.horarios) {
        items.add(new PopupMenuItem<String>(
          value: opcion.opcion,
          child: Text('Opción ' + opcion.opcion),
        ));
      }
      return items;
    }

    if (estado == 'nuevos' && horarios == 2) {
      int sumO = 0;
      for (Horario opcion in practicante.horarios) {
        sumO += int.parse(opcion.opcion);
      }
      String value = (sumO == 5
          ? '1'
          : sumO == 4
              ? '2'
              : sumO == 3
                  ? '3'
                  : '');
      items.add(new PopupMenuItem<String>(
        value: value,
        child: Text('Opción ' + value),
      ));
      return items;
    }

    if (estado == 'nuevos' && horarios == 1) {
      Horario opcion = practicante.horarios.first;

      String value = opcion.opcion == '1' ? '2' : '1';

      items.add(new PopupMenuItem<String>(
        value: value,
        child: Text('Opción ' + value),
      ));

      value = opcion.opcion == '3' ? '2' : '3';
      items.add(new PopupMenuItem<String>(
        value: value,
        child: Text('Opción ' + value),
      ));
      return items;
    }

    if (estado == 'nuevos' && horarios == 0) {
      return KOpciones.map((value) {
        return PopupMenuItem<String>(
          value: value,
          child: Text('Opción ' + value),
        );
      }).toList();
    }
    return items;
  }

  void redirect(String opcion) {
    if (opcion == '1')
      Navigator.pushNamed(context, VistaHorarioPracticanteOpcion1.route,
          arguments: {"arguments": opcion1, "practicante": practicante});
    else if (opcion == '2')
      Navigator.pushNamed(context, VistaHorarioPracticanteOpcion2.route,
          arguments: {"arguments": opcion2, "practicante": practicante});
    else
      Navigator.pushNamed(context, VistaHorarioPracticanteOpcion3.route,
          arguments: {"arguments": opcion3, "practicante": practicante});
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    if (arguments != null) {
      if (arguments['arguments'] is List<Horario>) {
        if ((arguments['arguments'] as List<Horario>).isNotEmpty) {
          practicante.horarios = arguments['arguments'] as List<Horario>;
          practicante.id = practicante.horarios.first.usuario.id;
        }
      }
    } else {
      practicante.horarios = [];
    }

    initDataHorarios();
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
              backgroundColor: Colors.white,
              resizeToAvoidBottomInset: false,
              appBar: appBar,
              body: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: kPrimaryColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                if (auxiliar)
                                  Navigator.pushNamed(context,
                                      VistaAdministrarPracticantes.route);
                                else
                                  Navigator.pushNamed(context, HomePage.route);
                              },
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(right: 20.0),
                                color: kPrimaryColor,
                                child: Center(
                                  child: Text(
                                      !aprobado && !auxiliar
                                          ? '                    Horario'
                                          : !aprobado && auxiliar
                                              ? '      Horario'
                                              : 'Horario',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25.0,
                                      )),
                                ),
                              ),
                            ),
                            if (!aprobado && !auxiliar)
                              PopupMenuButton<String>(
                                  icon: Icon(
                                    Icons.local_hospital,
                                    color: Colors.white,
                                  ),
                                  onSelected: (String result) {
                                    setState(() {
                                      print(result);
                                      redirect(result);
                                    });
                                  },
                                  itemBuilder: (BuildContext context) =>
                                      getPopupMenuItem('nuevos')),
                            if (!aprobado && !auxiliar)
                              PopupMenuButton<String>(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                  onSelected: (String result) {
                                    setState(() {
                                      print(result);
                                      redirect(result);
                                    });
                                  },
                                  itemBuilder: (BuildContext context) =>
                                      getPopupMenuItem('existentes')),
                            if (!aprobado && !auxiliar)
                              PopupMenuButton<String>(
                                  icon: Icon(
                                    Icons.delete_rounded,
                                    color: Colors.white,
                                  ),
                                  onSelected: (String result) {
                                    setState(() {
                                      print(result);
                                      redirect(result);
                                    });
                                  },
                                  itemBuilder: (BuildContext context) =>
                                      getPopupMenuItem('existentes')),
                            if (!aprobado && auxiliar)
                              PopupMenuButton<String>(
                                  icon: Icon(
                                    Icons.remove_red_eye_rounded,
                                    color: Colors.white,
                                  ),
                                  onSelected: (String result) {
                                    setState(() {
                                      print(result);
                                      redirect(result);
                                    });
                                  },
                                  itemBuilder: (BuildContext context) =>
                                      getPopupMenuItem('existentes')),
                          ],
                        ),
                      ),
                      ScheduleInternCombined(
                        horarios: practicante.horarios,
                        colorSelected:
                            !aprobado ? Color(0xFFFF637D) : kAccentColor,
                      ),
                    ],
                  )),
            );
        }
      },
    );
  }
}
