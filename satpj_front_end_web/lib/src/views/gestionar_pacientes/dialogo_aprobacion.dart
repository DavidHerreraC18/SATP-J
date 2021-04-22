import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:satpj_front_end_web/src/model/formulario/formulario.dart';
import 'package:satpj_front_end_web/src/model/formulario/formulario_extra.dart';
import 'package:satpj_front_end_web/src/providers/provider_aprobacion_pacientes.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/header_dialog.dart';
import 'package:satpj_front_end_web/src/views/gestionar_pacientes/vista_aprobacion_formularios.dart';

class AprobDialog extends StatefulWidget {
  AprobDialog({
    Key key,
    this.formularioSeleccionado,
  }) : super(key: key);

  final FormularioExtra formularioSeleccionado;

  @override
  _AprobDialogState createState() => _AprobDialogState();
}

class _AprobDialogState extends State<AprobDialog> {
  String mensaje;
  Color colorMensaje;

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: SafeArea(
          child: Container(
            height: 600,
            width: 600,
            child: Column(
              children: [
                HeaderDialog(
                  label: "Respuestas Formulario",
                ),
                Expanded(
                  child: RawScrollbar(
                    radius: Radius.circular(8.0),
                    isAlwaysShown: true,
                    thumbColor: Theme.of(context).colorScheme.primary,
                    child: SingleChildScrollView(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          child: _contenido(widget.formularioSeleccionado),
                        )),
                  ),
                ),
                Divider(
                  color: Colors.grey[400],
                  height: 20,
                ),
                mensaje != null
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 20.0,
                          ),
                          child: Text(
                            mensaje,
                            style: TextStyle(
                              color: colorMensaje,
                              fontSize: 14,
                              // letterSpacing: 3,
                            ),
                          ),
                        ),
                      )
                    : Container(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        padding:
                            MaterialStateProperty.all(EdgeInsets.all(10.0)),
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.error),
                        overlayColor:
                            MaterialStateProperty.all(Color(0xFFD12D2F)),
                        alignment: Alignment.center,
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      onPressed: () {
                        _rechazarPaciente(widget.formularioSeleccionado);
                        //Navigator.of(context).pop();
                        Future.delayed(Duration(milliseconds: 1000), () {
                          Navigator.of(context)
                              .pushNamed(VistaAprobacionFormularios.route);
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ),
                        child: Text(
                          'Rechazar Paciente',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.all(5.0)),
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.primary),
                        overlayColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.primaryVariant),
                        alignment: Alignment.center,
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      onPressed: () {
                        _aprobarPaciente(widget.formularioSeleccionado);
                        Future.delayed(Duration(milliseconds: 1000), () {
                          /*Navigator.of(context).popAndPushNamed(
                              VistaAprobacionFormularios.route);*/
                          Navigator.of(context)
                              .pushNamed(VistaAprobacionFormularios.route);
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ),
                        child: Text(
                          'Aprobar Paciente',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Column _contenido(FormularioExtra formularioSeleccionado) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Nombre Completo',
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: 2.0,
          ),
          Container(
            width: 600,
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: EdgeInsets.all(4.0),
              child: Text(
                formularioSeleccionado.paciente.nombre +
                    " " +
                    formularioSeleccionado.paciente.apellido,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
        ]),
      ],
    );
  }

  Future<void> _aprobarPaciente(FormularioExtra formulario) async {
    String resuesta =
        await ProviderAprobacionPacientes.aprobarPaciente(formulario);
    print(resuesta);
    if (resuesta == "Error") {
      mensaje = "Error procesando la solicitud, intenta de nuevo mas tarde";
      colorMensaje = Theme.of(context).colorScheme.error;
    } else {
      mensaje = "¡Paciente aprobado exitosamente!";
      colorMensaje = Theme.of(context).colorScheme.secondaryVariant;
    }
  }

  Future<void> _rechazarPaciente(FormularioExtra formulario) async {
    String resuesta =
        await ProviderAprobacionPacientes.rechazarPaciente(formulario);
    print(resuesta);
    if (resuesta == "Error") {
      mensaje = "Error procesando la solicitud, intenta de nuevo mas tarde";
      colorMensaje = Theme.of(context).colorScheme.error;
    } else {
      mensaje = "¡Paciente aprobado exitosamente!";
      colorMensaje = Theme.of(context).colorScheme.secondaryVariant;
    }
  }
}
