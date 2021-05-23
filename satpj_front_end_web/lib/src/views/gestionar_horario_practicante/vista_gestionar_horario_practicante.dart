import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/constants/constantes_data.dart';
import 'package:satpj_front_end_web/src/model/horario/horario.dart';
import 'package:satpj_front_end_web/src/model/practicante/practicante.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_auxiliar_administrativo.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_practicante.dart';
import 'package:satpj_front_end_web/src/utils/widgets/schedule/schedule_intern%20combined.dart';
import 'package:satpj_front_end_web/src/views/gestionar_horario_practicante/vista_horario_practicante_opcion_1.dart';
import 'package:satpj_front_end_web/src/views/gestionar_horario_practicante/vista_horario_practicante_opcion_2.dart';
import 'package:satpj_front_end_web/src/views/gestionar_horario_practicante/vista_horario_practicante_opcion_3.dart';

Practicante practicante = new Practicante();

Horario opcion1;
Horario opcion2;
Horario opcion3;

Map<String, List<int>> horario1 = {};
Map<String, List<int>> horario2 = {};
Map<String, List<int>> horario3 = {};

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
  int horarios;
  Map<String, List<int>> horarioVista;
  bool auxiliar = false;

  initDataHorarios() {
    if (practicante.horarios == null) {
      practicante.horarios = [];
    }

    print('HOLA');
    print(practicante.horarios.length);
    horarios = practicante.horarios.length;

    if (practicante.horarios.isNotEmpty) {
      for (Horario h in practicante.horarios) {
        if (h.opcion == '1') {
          opcion1 = h;
          horario1 = opcion1.forView();
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
      Navigator.pushNamed(context, VistaHorarioPracticanteOpcion1.route, arguments: {"arguments" : opcion1});
    else if (opcion == '2')
      Navigator.pushNamed(context, VistaHorarioPracticanteOpcion2.route, arguments: {"arguments" : opcion2});
    else
      Navigator.pushNamed(context, VistaHorarioPracticanteOpcion3.route, arguments: {"arguments" : opcion3});
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    if (arguments != null) {
      if (arguments['arguments'] is List<Horario>) {
        practicante.horarios = arguments['arguments'] as List<Horario>;
      }
      if(arguments['auxiliar'] is bool){
          auxiliar = arguments['auxiliar'] as bool;
      }
    } else {
      practicante.horarios = [];
    }

    initDataHorarios();

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: !auxiliar ? toolbarPracticante(context) : toolbarAuxiliarAdministrativo(context),
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
                    Expanded(
                      child: Container(
                        color: kPrimaryColor,
                        child: Center(
                          child: Text('                    Horario',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                              )),
                        ),
                      ),
                    ),
                    if(!auxiliar)
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
                    if(!auxiliar)
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
                    if(!auxiliar)
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
                    if(auxiliar)        
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
                horarioPracticante: opcion1,
                horarios: practicante.horarios,
              ),
            ],
          )),
    );
  }
}
