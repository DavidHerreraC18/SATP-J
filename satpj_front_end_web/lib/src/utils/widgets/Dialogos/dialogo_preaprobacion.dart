import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/formulario/formulario.dart';
import 'package:satpj_front_end_web/src/providers/provider_aprobacion_formularios.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/header_dialog.dart';
import 'package:satpj_front_end_web/src/views/gestionar_pacientes/vista_aprobacion_formularios.dart';

class PreAprobDialog extends StatefulWidget {
  PreAprobDialog({
    Key key,
    this.formularioSeleccionado,
  }) : super(key: key);

  final Formulario formularioSeleccionado;

  @override
  _PreAprobDialogState createState() => _PreAprobDialogState();
}

class _PreAprobDialogState extends State<PreAprobDialog> {
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40.0, vertical: 20.0),
                        child: Container(
                          child: _contenido(widget.formularioSeleccionado),
                        )),
                  ),
                ),
                Divider(
                  color: Colors.grey[400],
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(
                          120.0,
                          35.0,
                        )),
                        padding:
                            MaterialStateProperty.all(EdgeInsets.all(10.0)),
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.error),
                        overlayColor:
                            MaterialStateProperty.all(Color(0xFFD12D2F)),
                        alignment: Alignment.center,
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.1),
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
                    SizedBox(
                      width: 8.0,
                    ),
                    TextButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(
                          120.0,
                          35.0,
                        )),
                        padding:
                            MaterialStateProperty.all(EdgeInsets.all(10.0)),
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.primary),
                        overlayColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.primaryVariant),
                        alignment: Alignment.center,
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.1),
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
                          'Pre-Aprobar Paciente',
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
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ));
  }

  Column _contenido(Formulario formularioSeleccionado) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Nombre Completo:',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 18.0),
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15.0,
            ),
            Text(
              'Motivo de Consulta:',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 18.0),
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
                  formularioSeleccionado.motivoConsulta,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15.0,
            ),
            Text(
              '¿Fue Atendido Anteriormente?',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 18.0),
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
                child: _booleano(formularioSeleccionado.fueAtendido),
              ),
            ),
          ],
        ),
        _remitente(widget.formularioSeleccionado),
      ],
    );
  }

  Text _booleano(bool respuesta) {
    if (respuesta == true) {
      return Text(
        "SI",
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 18.0),
      );
    } else {
      return Text(
        "NO",
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 18.0),
      );
    }
  }

  Future<void> _aprobarPaciente(Formulario formulario) async {
    String resuesta =
        await ProviderAprobacionFormularios.preAprobarPaciente(formulario);
    print(resuesta);
    if (resuesta == "Error") {
      mensaje = "Error procesando la solicitud, intenta de nuevo mas tarde";
      colorMensaje = Theme.of(context).colorScheme.error;
    } else {
      mensaje = "¡Paciente aprobado exitosamente!";
      colorMensaje = Theme.of(context).colorScheme.secondaryVariant;
    }
  }

  Future<void> _rechazarPaciente(Formulario formulario) async {
    String resuesta =
        await ProviderAprobacionFormularios.rechazarPaciente(formulario);
    print(resuesta);
    if (resuesta == "Error") {
      mensaje = "Error procesando la solicitud, intenta de nuevo mas tarde";
      colorMensaje = Theme.of(context).colorScheme.error;
    } else {
      mensaje = "¡Paciente aprobado exitosamente!";
      colorMensaje = Theme.of(context).colorScheme.secondaryVariant;
    }
  }

  Column _remitente(Formulario formulario) {
    if (formulario.remitente != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15.0,
          ),
          Text(
            'Remitente:',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 18.0),
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
                formulario.remitente,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [],
      );
    }
  }
}
