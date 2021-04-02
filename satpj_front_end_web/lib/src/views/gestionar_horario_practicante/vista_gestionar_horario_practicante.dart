import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/constants/constantes_data.dart';
import 'package:satpj_front_end_web/src/model/horario/horario.dart';
import 'package:satpj_front_end_web/src/model/practicante/practicante.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_practicante.dart';
import 'package:satpj_front_end_web/src/utils/widgets/schedule/cell_schedule.dart';
import 'package:satpj_front_end_web/src/utils/widgets/schedule/schedule_intern%20combined.dart';

Practicante practicante = new Practicante();

Horario opcion1 = new Horario();
Horario opcion2 = new Horario();
Horario opcion3 = new Horario();

Map<String, List<int>> horario1 = {};
Map<String, List<int>> horario2 = {};
Map<String, List<int>> horario3 = {};

class VistaGestionarHorarioPracticante extends StatefulWidget {
  static const route = '/horario-practicante';

  VistaGestionarHorarioPracticante({Practicante practicanteH}) {
    
    if(practicanteH != null){
        practicante = practicanteH;
        practicante.horarios = [];
    }
    practicante.horarios = [];
    
  }

  @override
  _VistaGestionarHorarioPracticanteState createState() =>
      _VistaGestionarHorarioPracticanteState();
}

class _VistaGestionarHorarioPracticanteState
    extends State<VistaGestionarHorarioPracticante> {
  int horas = 0;
  int horarios;
  Map<String, List<int>> horarioVista;

  @override
  void initState() {
    
    if (practicante.horarios == null) {
      practicante.horarios = [];
    }

    horarios = practicante.horarios.length;
    
    if(practicante.horarios.isNotEmpty){
       
   
    if (horarios == 1) {
      opcion1 = practicante.horarios[0];
      horario1 = opcion1.forView();
    } else if (horarios == 2) {
      opcion1 = practicante.horarios[0];
      horario1 = opcion1.forView();

      opcion2 = practicante.horarios[1];
      horario2 = opcion2.forView();
    } else if (horarios == 3) {
      opcion1 = practicante.horarios[0];
      horario1 = opcion1.forView();

      opcion2 = practicante.horarios[1];
      horario2 = opcion2.forView();

      opcion3 = practicante.horarios[2];
      horario3 = opcion3.forView();
     }
    
    }

    opcion1.lunes='8;9;13';
    horas = 7;
    horarioVista = {};

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
      return practicante.horarios.map((value) {
        return PopupMenuItem<String>(
          value: value.opcion,
          child: Text('Opción ' + value.opcion),
        );
      }).toList();
    }
    
    if (estado == 'nuevos' && horarios == 2){
      int value = int.parse(opcion1.opcion) + int.parse(opcion2.opcion) - 3;
       items.add(new PopupMenuItem<String>(
          value: value.toString(),
          child: Text('Opción ' + value.toString()),
        )
      );
      return items;
    }

    if (estado == 'nuevos' && horarios == 1){
      int value = (3 - int.parse(opcion1.opcion)) + 1;
      int suma = value;
      while(suma <= 3){
       items.add(new PopupMenuItem<String>(
          value: value.toString(),
          child: Text('Opción ' + value.toString()),
        )
       );
       suma += value;
       value++;
      }
      return items;
    }
    
    if(estado == 'nuevos' && horarios == 0){
       return KOpciones.map((value) {
            return PopupMenuItem<String>(
              value: value,
              child: Text('Opción ' + value),
            );
        }).toList();
    }

    return items;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: toolbarPracticante(context),
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
                        child: Text(
                            '                                          Horario',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                            )),
                      ),
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: Icon(
                      Icons.local_hospital,
                      color: Colors.white,
                    ),
                    onSelected: (String result) {
                      setState(() {
                        print(result);
                      });
                    },
                    itemBuilder: (BuildContext context) =>
                        getPopupMenuItem('nuevos')
                  ),
                  PopupMenuButton<String>(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    onSelected: (String result) {
                      setState(() {
                        print(result);
                      });
                    },
                    itemBuilder: (BuildContext context) =>
                       getPopupMenuItem('existentes')
                  ),
                  PopupMenuButton<String>(
                    icon: Icon(
                      Icons.delete_rounded,
                      color: Colors.white,
                    ),
                    onSelected: (String result) {
                      setState(() {
                        print(result);
                      });
                    },
                    itemBuilder: (BuildContext context) =>
                       getPopupMenuItem('existentes')
                  ),
                ],
              ),
            ),
            ScheduleInternCombined(
                horarioPracticante: opcion1,
            ),
          ],
        )
      ),
    );
  }
}
