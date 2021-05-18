import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/supervisor/supervisor.dart';
import 'package:satpj_front_end_web/src/providers/provider_administracion_supervisores.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/fotter_dialog.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/header_dialog.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/formulario_supervisor.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/tema_formularios.dart';
import 'package:satpj_front_end_web/src/views/gestionar_supervisores/vista_administracion_supervisores.dart';

// ignore: must_be_immutable
class DialogoEditarSupervisor extends StatefulWidget {
  Supervisor supervisor = new Supervisor();

  DialogoEditarSupervisor({this.supervisor});

  @override
  _DialogoEditarSupervisorState createState() =>
      _DialogoEditarSupervisorState();
}

class _DialogoEditarSupervisorState extends State<DialogoEditarSupervisor> {
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
                HeaderDialog(
                  label: 'Editar Supervisor',
                  height: 55.0,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40.0),
                  child: FormSupervisorInformation(
                    supervisor: widget.supervisor,
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
                _editarSupervisor(widget.supervisor);
                Future.delayed(Duration(milliseconds: 1000), () {
                  Navigator.of(context)
                      .pushNamed(VistaAdministrarSupervisores.route);
                });
              },
            )
          ]),
        ),
      ),
    );
  }

  Future<void> _editarSupervisor(Supervisor supervisor) async {
    String respuesta =
        await ProviderAdministracionSupervisores.editarSupervisor(supervisor);
    print(respuesta);
    if (respuesta == "Error") {
      /*mensaje = "Error procesando la solicitud, intenta de nuevo mas tarde";
      colorMensaje = Theme.of(context).colorScheme.error;*/
      print("Error procesando la solicitud, intenta de nuevo mas tarde");
    } else {
      /*mensaje = "¡Paciente creado exitosamente!";
      colorMensaje = Theme.of(context).colorScheme.secondaryVariant;*/
      print(respuesta);
      print("Supervisor editado exitosamente!");
    }
  }
}
