import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/practicante/practicante.dart';
import 'package:satpj_front_end_web/src/providers/provider_administracion_practicantes.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/fotter_dialog.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/header_dialog.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/formulario_practicante.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/tema_formularios.dart';
import 'package:satpj_front_end_web/src/views/gestionar_practicantes/vista_administrar_practicantes.dart';

// ignore: must_be_immutable
class DialogoEditarPracticante extends StatefulWidget {
  Practicante practicante = new Practicante();

  DialogoEditarPracticante({this.practicante});

  @override
  _DialogoEditarPracticanteState createState() =>
      _DialogoEditarPracticanteState();
}

class _DialogoEditarPracticanteState extends State<DialogoEditarPracticante> {
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
                  label: 'Editar Practicante',
                  height: 55.0,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40.0),
                  child: FormInternInformation(
                    practicante: widget.practicante,
                  ),
                ),
                FotterDialog(
                  labelCancelBtn: 'Cancelar',
                  labelConfirmBtn: 'Editar',
                  colorConfirmBtn: kPrimaryColor,
                  width: 120.0,
                  //formKey: _formKey,
                  functionConfirmBtn: () {
                    _editarPracticante(widget.practicante);
                    Future.delayed(Duration(milliseconds: 1000), () {
                      Navigator.of(context)
                          .pushNamed(VistaAdministrarPracticantes.route);
                    });
                  },
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Future<void> _editarPracticante(Practicante practicante) async {
    String respuesta =
        await ProviderAdministracionPracticantes.editarPracticante(practicante);
    print(respuesta);
    if (respuesta == "Error") {
      /*mensaje = "Error procesando la solicitud, intenta de nuevo mas tarde";
      colorMensaje = Theme.of(context).colorScheme.error;*/
      print("Error procesando la solicitud, intenta de nuevo mas tarde");
    } else {
      /*mensaje = "¡Paciente creado exitosamente!";
      colorMensaje = Theme.of(context).colorScheme.secondaryVariant;*/
      print(respuesta);
      print("¡Practicante editado exitosamente!");
    }
  }
}
