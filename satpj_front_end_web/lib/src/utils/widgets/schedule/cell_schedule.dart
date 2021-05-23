import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';

// ignore: must_be_immutable
class CellSchedule extends StatefulWidget {
  Color colorDay = Color(0xffF2F2F2);
  Color colorSelected;
  String label;
  Map<String, String> diaHora;
  Map<String, List<int>> horario = {};
  bool selected;
  int combined;
  //double height;
  CellSchedule(
      {this.label = '',
      this.colorDay,
      this.colorSelected: kAccentColor,
      this.diaHora,
      this.horario,
      this.selected = false,
      this.combined = 1});

  @override
  _CellScheduleState createState() => _CellScheduleState();
}

class _CellScheduleState extends State<CellSchedule> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (widget.label.isEmpty && !widget.selected) {
            widget.colorDay = widget.colorSelected;
            widget.selected = true;
            if (widget.horario[widget.diaHora['dia']] == null) {
              List<int> horas = [];
              widget.horario[widget.diaHora['dia']] = horas;
            }
            widget.horario[widget.diaHora['dia']]
                .add(int.parse(widget.diaHora['hora']));
            print(widget.horario);
            return;
          }

          if (widget.label.isEmpty && widget.selected) {
            widget.colorDay = Color(0xffF2F2F2);
            widget.selected = false;
            if (widget.horario[widget.diaHora['dia']] != null) {
              widget.horario[widget.diaHora['dia']]
                  .remove(int.parse(widget.diaHora['hora']));
            }
            print(widget.horario);
            return;
          }
        });
      },
      child: Container(
          height: widget.combined > 1 ? (39.8 / widget.combined) - 2 : 39.8,
          margin: EdgeInsets.only(right: 3.0, bottom: 3.0),
          color: !widget.selected ? widget.colorDay : widget.colorSelected,
          child: Center(
            child: Text(
              widget.label,
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.normal),
            ),
          )),
    );
  }
}
