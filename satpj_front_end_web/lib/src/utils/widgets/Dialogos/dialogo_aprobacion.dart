import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/formulario/formulario_extra.dart';
import 'package:satpj_front_end_web/src/model/grupo/grupo.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/model/supervisor/supervisor.dart';
import 'package:satpj_front_end_web/src/providers/provider_administracion_pacientes.dart';
import 'package:satpj_front_end_web/src/providers/provider_aprobacion_pacientes.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
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
  Supervisor supervisor;

  void asignarSupervisor(Supervisor supervisor) {
    this.supervisor = supervisor;
  }

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
          height: 600,
          width: 600,
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
                    funcionAsignacionPaciente: asignarSupervisor,
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
                        Navigator.of(context)
                            .pushNamed(VistaAprobacionFormularios.route);
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
                        Navigator.of(context)
                            .pushNamed(VistaAprobacionFormularios.route);
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
          ]),
        ),
      ),
    );
  }

  Future<void> _aprobarPaciente(FormularioExtra formulario) async {
    formulario.paciente.supervisor = this.supervisor;
    String resuesta =
        await ProviderAprobacionPacientes.aprobarPaciente(formulario.paciente);
    if (resuesta == "Error") {
      mensaje = "Error procesando la solicitud, intenta de nuevo mas tarde";
      colorMensaje = Theme.of(context).colorScheme.error;
    } else {
      mensaje = "¡Paciente aprobado exitosamente!";
      colorMensaje = Theme.of(context).colorScheme.secondaryVariant;
    }
    /*Grupo grupo = await ProviderAdministracionPacientes.traerGrupoPaciente(
        formulario.paciente.id);
    if (grupo != null) {
      bool posible = false;
      int po = 0;
      for (int i = 0; i < grupo.integrantes.length; i++) {
        Paciente paciente = grupo.integrantes[i];
        if (paciente.estadoAprobado == "GrupoNoAprobado") {
          po++;
        }
      }
      if (po == grupo.integrantes.length) {
        posible = true;
      }
      if (posible) {
        for (int i = 0; i < grupo.integrantes.length; i++) {
          Paciente paciente = grupo.integrantes[i];
          paciente.supervisor = this.supervisor;
          String respuesta =
              await ProviderAprobacionPacientes.aprobarPaciente(paciente);
          if (respuesta == "Error") {
            mensaje =
                "Error procesando la solicitud, intenta de nuevo mas tarde";
            colorMensaje = Theme.of(context).colorScheme.error;
          } else {
            mensaje = "¡Paciente aprobado exitosamente!";
            colorMensaje = Theme.of(context).colorScheme.secondaryVariant;
          }
        }
      } else {
        formulario.paciente.supervisor = this.supervisor;
        String resuesta =
            await ProviderAprobacionPacientes.aprobarPacienteGrupo(
                formulario.paciente);
        if (resuesta == "Error") {
          mensaje = "Error procesando la solicitud, intenta de nuevo mas tarde";
          colorMensaje = Theme.of(context).colorScheme.error;
        } else {
          mensaje = "¡Paciente aprobado exitosamente!";
          colorMensaje = Theme.of(context).colorScheme.secondaryVariant;
        }
      }
    } else {
      formulario.paciente.supervisor = this.supervisor;
      String resuesta = await ProviderAprobacionPacientes.aprobarPaciente(
          formulario.paciente);
      if (resuesta == "Error") {
        mensaje = "Error procesando la solicitud, intenta de nuevo mas tarde";
        colorMensaje = Theme.of(context).colorScheme.error;
      } else {
        mensaje = "¡Paciente aprobado exitosamente!";
        colorMensaje = Theme.of(context).colorScheme.secondaryVariant;
      }
    }*/
  }

  Future<void> _rechazarPaciente(FormularioExtra formulario) async {
    String resuesta =
        await ProviderAprobacionPacientes.rechazarPaciente(formulario.paciente);
    if (resuesta == "Error") {
      mensaje = "Error procesando la solicitud, intenta de nuevo mas tarde";
      colorMensaje = Theme.of(context).colorScheme.error;
    } else {
      mensaje = "¡Paciente rechazado exitosamente!";
      colorMensaje = Theme.of(context).colorScheme.secondaryVariant;
    }
    /*Grupo grupo = await ProviderAdministracionPacientes.traerGrupoPaciente(
        formulario.paciente.id);
    if (grupo != null) {
      for (int i = 0; i < grupo.integrantes.length; i++) {
        Paciente paciente = grupo.integrantes[i];
        String resuesta =
            await ProviderAprobacionPacientes.rechazarPaciente(paciente);
        if (resuesta == "Error") {
          mensaje = "Error procesando la solicitud, intenta de nuevo mas tarde";
          colorMensaje = Theme.of(context).colorScheme.error;
        } else {
          mensaje = "¡Paciente rechazado exitosamente!";
          colorMensaje = Theme.of(context).colorScheme.secondaryVariant;
        }
      }
    } else {
      
    }*/
  }
}
