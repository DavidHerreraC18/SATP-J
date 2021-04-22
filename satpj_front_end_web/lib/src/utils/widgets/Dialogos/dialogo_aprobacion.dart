import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:satpj_front_end_web/src/model/Notificadores/data_notifier.dart';
import 'package:satpj_front_end_web/src/model/formulario/formulario.dart';
import 'package:satpj_front_end_web/src/model/formulario/formulario_extra.dart';
import 'package:satpj_front_end_web/src/providers/provider_aprobacion_pacientes.dart';
import 'package:satpj_front_end_web/src/providers/provider_preaprobacion_pacientes.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/header_dialog.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/formulario_formulario_extra.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/tema_formularios.dart';
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
                            'Formulario',
                            textAlign: TextAlign.left,
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(
                                context, widget.formularioSeleccionado);
                          },
                        ),
                      ],
                    )),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40.0),
                  child: FormFormularioExtraInformation(
                    formularioExtra: widget.formularioSeleccionado,
                    stack: false,
                    enabled: false,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        padding:
                            MaterialStateProperty.all(EdgeInsets.all(10.0)),
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.secondary),
                        overlayColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.secondaryVariant),
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
                        padding: EdgeInsets.only(
                          top: 15.0,
                          bottom: 15.0,
                        ),
                        child: Text(
                          'Pre-Aprobar Paciente',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
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
                        padding: EdgeInsets.only(
                          top: 15.0,
                          bottom: 15.0,
                        ),
                        child: Text(
                          'Rechazar Paciente',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ]),
        ),
      ),
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
