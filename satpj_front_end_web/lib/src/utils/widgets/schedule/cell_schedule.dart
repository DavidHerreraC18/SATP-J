import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';

class CellSchedule extends StatefulWidget {
  Color colorDay = Color(0xffF2F2F2);
  Color colorSelected;
  String label;
  Map<String, String> diaHora;
  List<Map<String, String>> horario = [];
  bool selected;
  bool combined;
  //double height;
  CellSchedule(
      {this.label = '',
      this.colorDay,
      this.colorSelected: kAccentColor,
      this.diaHora,
      this.horario,
      this.selected = false,
      this.combined = false});

  @override
  _CellScheduleState createState() => _CellScheduleState();
}

class _CellScheduleState extends State<CellSchedule> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (widget.label.isEmpty && !widget.selected) {
            widget.colorDay = widget.colorSelected;
            widget.selected = true;
            widget.horario.add(widget.diaHora);
            print(widget.diaHora);
            print(widget.horario.length);
            return;
          }

          if (widget.label.isEmpty && widget.selected) {
            widget.colorDay = Color(0xffF2F2F2);
            widget.selected = false;
            widget.horario.remove(widget.diaHora);
            print(widget.horario);
            print(widget.horario.length);
            return;
          }
        });
      },
      child: Container(
          height: widget.combined ? (39.8/3) - 2 : 39.8,
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
