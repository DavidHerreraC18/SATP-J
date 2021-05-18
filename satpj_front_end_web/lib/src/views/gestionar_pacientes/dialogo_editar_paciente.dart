import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/providers/provider_administracion_pacientes.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/fotter_dialog.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/tema_formularios.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/formulario_paciente.dart';
import 'package:satpj_front_end_web/src/views/gestionar_pacientes/vista_administrar_pacientes.dart';

// ignore: must_be_immutable
class DialogoEditarPaciente extends StatefulWidget {
  Paciente paciente = new Paciente();

  DialogoEditarPaciente({this.paciente});

  @override
  _DialogoEditarPacienteState createState() => _DialogoEditarPacienteState();
}

class _DialogoEditarPacienteState extends State<DialogoEditarPaciente> {
  GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _formKey = new GlobalKey<FormState>();
    super.initState();
  }

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
          child: Form(
            key: _formKey,
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
                              'Editar Paciente',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white),
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
                    child: FormPatientInformation(
                      paciente: widget.paciente,
                      prefix: 'el',
                      label: 'del paciente',
                      fechaNacimiento: true,
                      stack: false,
                    ),
                  ),
                ],
              ),
              FotterDialog(
                labelCancelBtn: 'Cancelar',
                labelConfirmBtn: 'Editar',
                colorConfirmBtn: kPrimaryColor,
                width: 120.0,
                functionConfirmBtn: () {
                  _editarPaciente(widget.paciente);
                  Future.delayed(Duration(milliseconds: 1000), () {
                    Navigator.of(context)
                        .pushNamed(VistaAdministrarPacientes.route);
                  });
                },
              )
            ]),
          ),
        ),
      ),
    );
  }
}

Future<void> _editarPaciente(Paciente paciente) async {
  String respuesta =
      await ProviderAdministracionPacientes.editarPaciente(paciente);
  print(respuesta);
  if (respuesta == "Error") {
    /*mensaje = "Error procesando la solicitud, intenta de nuevo mas tarde";
      colorMensaje = Theme.of(context).colorScheme.error;*/
    print("Error procesando la solicitud, intenta de nuevo mas tarde");
  } else {
    /*mensaje = "¡Paciente creado exitosamente!";
      colorMensaje = Theme.of(context).colorScheme.secondaryVariant;*/
    print(respuesta);
    print("¡Paciente creado exitosamente!");
  }
}
