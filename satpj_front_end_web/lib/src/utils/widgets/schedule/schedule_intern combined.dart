import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/constants/constantes_data.dart';
import 'package:satpj_front_end_web/src/model/horario/horario.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/schedule/cell_schedule.dart';

class ScheduleInternCombined extends StatefulWidget {
  
  Horario horarioPracticante = new Horario();
  Color colorSelected;

  ScheduleInternCombined({ 
    this.colorSelected = kAccentColor,
    this.horarioPracticante
    });

  @override
  _ScheduleInternCombinedState createState() => _ScheduleInternCombinedState();
}

List<Map<String, String>> horario = [];

class _ScheduleInternCombinedState extends State<ScheduleInternCombined> {

  int horas;
  Map<String, List<int>> horarioVista;
  bool dividido;

  @override
  void initState() {
    widget.horarioPracticante.lunes='8;9;13';
    horas = 7;
    horarioVista = {};
    dividido = true;
    if(widget.horarioPracticante != null){
       horarioVista = widget.horarioPracticante.forView();
    }
    super.initState();
  }
  
  bool esHora(String dia){
    if(horarioVista[dia] != null &&
       horarioVista[dia].isNotEmpty && horarioVista[dia].indexOf(horas) > -1 ){
       return true;
    }
    return false;
  }


  @override
  Widget build(BuildContext context) {
    return Expanded(
                  child: Column(
                    children: List.generate(13, (indexC) {
                      return Row(
                          children: List.generate(7, (index) {
                        if (indexC == 0)
                          return Expanded(
                            child: CellSchedule(
                              label: kEncabezadoHorario[index],
                              colorDay: Color(0xffF2F2F2),
                              selected: false,
                            ),
                          );

                        if (index != 0)
                          
                          if(index == 1 && indexC == 1)
                          return Expanded(
                            child: Column(
                                children: [
                                  Container(
                                    child: CellSchedule(
                                      colorDay: Color(0xffF2F2F2),
                                      diaHora: <String, String>{
                                        'dia': kEncabezadoHorario[index].toLowerCase(),
                                        'hora': horas.toString(),
                                      },
                                      horario: horario,
                                      selected: esHora(kEncabezadoHorario[index].toLowerCase()),
                                      colorSelected: widget.colorSelected,
                                      combined: true,
                                    ),
                                  ),
                                  Container(
                                    child: CellSchedule(
                                      colorDay: Color(0xffF2F2F2),
                                      diaHora: <String, String>{
                                        'dia': kEncabezadoHorario[index].toLowerCase(),
                                        'hora': horas.toString(),
                                      },
                                      horario: horario,
                                      selected: esHora(kEncabezadoHorario[index].toLowerCase()),
                                      colorSelected: Color(0xffFCF88C),
                                      combined: true,
                                    ),
                                  ),
                                  Container(  
                                    child: CellSchedule(
                                      colorDay: Color(0xffF2F2F2),
                                      diaHora: <String, String>{
                                        'dia': kEncabezadoHorario[index].toLowerCase(),
                                        'hora': horas.toString(),
                                      },
                                      horario: horario,
                                      selected: esHora(kEncabezadoHorario[index].toLowerCase()),
                                      colorSelected: Color(0xff85ADEB),
                                      combined: true,
                                    ),
                                  ),                  
                                ],
                              ),
                            );
                            else 
                            return Expanded(
                            child: Container(
                                    child: CellSchedule(
                                      colorDay: Color(0xffF2F2F2),
                                      diaHora: <String, String>{
                                        'dia': kEncabezadoHorario[index].toLowerCase(),
                                        'hora': horas.toString(),
                                      },
                                      horario: horario,
                                      selected: esHora(kEncabezadoHorario[index].toLowerCase()),
                                      colorSelected: widget.colorSelected,
                                    ),
                                  )
                            );
               
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
                                bottom: BorderSide(
                                    color: Color(0xffF2F2F2), width: 3.0),
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