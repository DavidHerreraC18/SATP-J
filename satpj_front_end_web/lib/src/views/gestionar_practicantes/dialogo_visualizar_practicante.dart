import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/practicante/practicante.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/header_dialog.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/formulario_practicante.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/tema_formularios.dart';

class DialogoVisualizarPracticante extends StatefulWidget {
  
  Practicante practicante = new Practicante();
  
  DialogoVisualizarPracticante({this.practicante});

  @override
  _DialogoVisualizarPracticanteState createState() => _DialogoVisualizarPracticanteState();
}

class _DialogoVisualizarPracticanteState extends State<DialogoVisualizarPracticante> {
  
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: temaFormularios(),  
        child: 
        Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Container(
          width: 800.0,
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: 
                [
                HeaderDialog(
                    label: 'Practicante',
                    height: 55.0,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal:40.0),
                  child: FormInternInformation(
                    practicante: widget.practicante,
                    enabled: false,
                    ),
                ),
               ],
              ),
           ]
          ),
        ),
      ),
    );
  }
}
