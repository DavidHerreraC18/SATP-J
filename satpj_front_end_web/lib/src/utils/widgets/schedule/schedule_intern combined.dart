import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/constants/constantes_data.dart';
import 'package:satpj_front_end_web/src/model/horario/horario.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/schedule/cell_schedule.dart';

// ignore: must_be_immutable
class ScheduleInternCombined extends StatefulWidget {
  Horario horarioPracticante = new Horario();
  Color colorSelected;
  List<Horario> horarios;

  ScheduleInternCombined(
      {this.colorSelected = kAccentColor,
      this.horarioPracticante,
      this.horarios});

  @override
  _ScheduleInternCombinedState createState() => _ScheduleInternCombinedState();
}

class _ScheduleInternCombinedState extends State<ScheduleInternCombined> {
  int horas;

  Map<String, List<int>> horarioVista1;
  Map<String, List<int>> horarioVista2;
  Map<String, List<int>> horarioVista3;

  bool dividido;

  List<Map<String, String>> horarioOpcion1 = [];
  List<Map<String, String>> horarioOpcion2 = [];
  List<Map<String, String>> horarioOpcion3 = [];

  int contDia = 0;

  @override
  void initState() {
    horas = 7;
    dividido = true;
    if (widget.horarios != null) {
      for (int i = 0; i < widget.horarios.length; i++) {
        if (widget.horarios[i].opcion == '1' || widget.horarios[i].opcion == 'seleccionado') {
          horarioVista1 = widget.horarios[i].forView();
        } else if (widget.horarios[i].opcion == '2') {
          horarioVista2 = widget.horarios[i].forView();
        } else if (widget.horarios[i].opcion == '3') {
          horarioVista3 = widget.horarios[i].forView();
        }
      }
    }
    super.initState();
  }

  bool esHoraOpcion1(String dia) {
    if (horarioVista1 != null) {
      if (horarioVista1[dia] != null &&
          horarioVista1[dia].isNotEmpty &&
          horarioVista1[dia].indexOf(horas) > -1) {
        return true;
      }
    }
    return false;
  }

  bool esHoraOpcion2(String dia) {
    if (horarioVista2 != null) {
      if (horarioVista2[dia] != null &&
          horarioVista2[dia].isNotEmpty &&
          horarioVista2[dia].indexOf(horas) > -1) {
        return true;
      }
    }

    return false;
  }

  bool esHoraOpcion3(String dia) {
    if (horarioVista3 != null) {
      if (horarioVista3[dia] != null &&
          horarioVista3[dia].isNotEmpty &&
          horarioVista3[dia].indexOf(horas) > -1) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: List.generate(13, (indexC) {
          contDia = 0;
          return Row(
              children: List.generate(7, (index) {
            contDia = 0;
            if (indexC == 0)
              return Expanded(
                child: CellSchedule(
                  label: kEncabezadoHorario[index],
                  colorDay: Color(0xffF2F2F2),
                  selected: false,
                ),
              );

            if (index != 0) {
              if (esHoraOpcion1(kEncabezadoHorario[index].toLowerCase()))
                contDia++;
              if (esHoraOpcion2(kEncabezadoHorario[index].toLowerCase()))
                contDia++;
              if (esHoraOpcion3(kEncabezadoHorario[index].toLowerCase()))
                contDia++;
              if (widget.horarios.length > 1 && contDia > 1)
                return Expanded(
                  child: Column(
                    children: [
                      if (horarioVista1 != null && contDia > 1 && esHoraOpcion1(
                                kEncabezadoHorario[index].toLowerCase()))
                        Container(
                          child: CellSchedule(
                            colorDay: Color(0xffF2F2F2),
                            diaHora: <String, String>{
                              'dia': kEncabezadoHorario[index].toLowerCase(),
                              'hora': horas.toString(),
                            },
                            selected: esHoraOpcion1(
                                kEncabezadoHorario[index].toLowerCase()),
                            colorSelected: widget.colorSelected,
                            combined: contDia,
                          ),
                        ),
                      if (horarioVista2 != null && contDia > 1 && esHoraOpcion2(
                                kEncabezadoHorario[index].toLowerCase()))
                        Container(
                          child: CellSchedule(
                            colorDay: Color(0xffF2F2F2),
                            diaHora: <String, String>{
                              'dia': kEncabezadoHorario[index].toLowerCase(),
                              'hora': horas.toString(),
                            },
                            selected: esHoraOpcion2(
                                kEncabezadoHorario[index].toLowerCase()),
                            colorSelected: Color(0xffFCF88C),
                            combined: contDia,
                          ),
                        ),
                      if (horarioVista3 != null && contDia > 1 && esHoraOpcion3(
                                kEncabezadoHorario[index].toLowerCase()))
                        Container(
                          child: CellSchedule(
                            colorDay: Color(0xffF2F2F2),
                            diaHora: <String, String>{
                              'dia': kEncabezadoHorario[index].toLowerCase(),
                              'hora': horas.toString(),
                            },
                            selected: esHoraOpcion3(
                                kEncabezadoHorario[index].toLowerCase()),
                            colorSelected: Color(0xff85ADEB),
                            combined: contDia,
                          ),
                        ),
                    ],
                  ),
                );
              else {
                if(indexC == 2 && index == 1)
                    print(kEncabezadoHorario[index].toLowerCase());
                return Expanded(
                    child: Container(
                  child: CellSchedule(
                    colorDay: Color(0xffF2F2F2),
                    diaHora: <String, String>{
                      'dia': kEncabezadoHorario[index].toLowerCase(),
                      'hora': horas.toString(),
                    },
                    selected: esHoraOpcion1(kEncabezadoHorario[index].toLowerCase())
                        ? true
                        : esHoraOpcion2(
                                kEncabezadoHorario[index].toLowerCase())
                            ? true
                            : esHoraOpcion3(
                                kEncabezadoHorario[index].toLowerCase()),
                    colorSelected: esHoraOpcion2(
                            kEncabezadoHorario[index].toLowerCase())
                        ? Color(0xffFCF88C)
                        : esHoraOpcion3(
                                    kEncabezadoHorario[index].toLowerCase())
                            ? Color(0xff85ADEB)
                            : widget.colorSelected,
                  ),
                ));
              }
            }

            horas++;
            return Expanded(
              child: Container(
                height: 39.8,
                child: Center(
                  child: Text(
                    indexC <= 4 && (horas + 1) < 12
                        ? horas.toString() +
                            ':00 a.m. - ' +
                            (horas + 1).toString() +
                            ':00 a.m.'
                        : (horas + 1) == 12
                            ? horas.toString() +
                                ':00 a.m. - ' +
                                (horas + 1).toString() +
                                ':00 p.m.'
                            : 12 < horas
                                ? (horas - 12).toString() +
                                    ':00 p.m. - ' +
                                    (horas + 1 - 12).toString() +
                                    ':00 p.m.'
                                : '12:00 p.m. - ' +
                                    (horas + 1 - 12).toString() +
                                    ':00 p.m.',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Color(0xffF2F2F2), width: 3.0),
                  ),
                ),
              ),
            );
          }));
        }),
      ),
    );
  }
}
