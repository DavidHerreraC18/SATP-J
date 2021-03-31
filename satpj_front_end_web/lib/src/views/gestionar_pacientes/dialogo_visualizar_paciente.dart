import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/paciente.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/tema-formularios.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/formulario_paciente.dart';

class DialogoVisualizarPaciente extends StatefulWidget {
  Paciente paciente = new Paciente();

  DialogoVisualizarPaciente({this.paciente});

  @override
  _DialogoVisualizarPacienteState createState() => _DialogoVisualizarPacienteState();
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
                Container(
                    height: 55.0,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(4.1)),
                      color: kPrimaryColor,
                    ),
                    margin: EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            'Paciente',
                            textAlign: TextAlign.left,
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context, widget.paciente);
                          },
                        ),
                      ],
                    )),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40.0),
                  child: 
                  FormPatientInformation(
                    paciente: widget.paciente,
                    prefix: 'el',
                    label: 'del paciente',
                    fechaNacimiento: true,
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
