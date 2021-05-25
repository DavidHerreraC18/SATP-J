import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/constants/constantes_data.dart';
import 'package:satpj_front_end_web/src/model/horario/horario.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/schedule/cell_schedule.dart';

// ignore: must_be_immutable
class ScheduleIntern extends StatefulWidget {
  String opcion;
  Horario horarioPracticante = new Horario();
  Map<String, List<int>> horarioVista = {};
  Color colorSelected;

  ScheduleIntern(
      {this.opcion = '1',
      this.colorSelected = kAccentColor,
      this.horarioPracticante,
      this.horarioVista
      });

  @override
  _ScheduleInternState createState() => _ScheduleInternState();
}

class _ScheduleInternState extends State<ScheduleIntern> {
  int horas;

  @override
  void initState() {
    horas = 7;
    super.initState();
  }

  bool esHora(String dia) {
    if (widget.horarioVista[dia] != null &&
        widget.horarioVista[dia].isNotEmpty &&
        widget.horarioVista[dia].indexOf(horas) > -1) {
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
              return Expanded(
                child: CellSchedule(
                  colorDay: Color(0xffF2F2F2),
                  diaHora: <String, String>{
                    'dia': kEncabezadoHorario[index].toLowerCase(),
                    'hora': horas.toString(),
                  },
                  selected: esHora(kEncabezadoHorario[index].toLowerCase()),
                  colorSelected: widget.colorSelected,
                  horario: widget.horarioVista,
                ),
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
