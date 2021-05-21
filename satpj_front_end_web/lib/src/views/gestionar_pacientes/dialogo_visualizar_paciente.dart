import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/header_dialog.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/tema_formularios.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/formulario_paciente.dart';

// ignore: must_be_immutable
class DialogoVisualizarPaciente extends StatefulWidget {
  Paciente paciente = new Paciente();

  DialogoVisualizarPaciente({this.paciente});

  @override
  _DialogoVisualizarPacienteState createState() =>
      _DialogoVisualizarPacienteState();
}

class _DialogoVisualizarPacienteState extends State<DialogoVisualizarPaciente> {
  @override
  Widget build(BuildContext context) {
    print(widget.paciente.nombre);
    return Theme(
      data: temaFormularios(),
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Container(
          width: 800.0,
          child: ListView(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                 HeaderDialog(
                  label: 'Paciente',
                  height: 55.0,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40.0),
                  child: FormPatientInformation(
                    paciente: widget.paciente,
                    prefix: 'el',
                    label: 'del paciente',
                    fechaNacimiento: false,
                    stack: false,
                    enabled: false,
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
