import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/practicante/practicante.dart';
import 'package:satpj_front_end_web/src/providers/provider_administracion_practicantes.dart';
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/fotter_dialog.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/header_dialog.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/formulario_practicante.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/tema_formularios.dart';

// ignore: must_be_immutable
class DialogoCrearPracticante extends StatefulWidget {
  Practicante practicante = new Practicante();

  DialogoCrearPracticante({this.practicante});

  @override
  _DialogoCrearPracticanteState createState() =>
      _DialogoCrearPracticanteState();
}

class _DialogoCrearPracticanteState extends State<DialogoCrearPracticante> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

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
          child: Form(
            key: _formKey,
            child: ListView(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  HeaderDialog(
                    label: 'Crear Practicante',
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
                    labelConfirmBtn: 'Crear',
                    colorConfirmBtn: kPrimaryColor,
                    paginator: false,
                    width: 120.0,
                    functionConfirmBtn: () {
                      print("ENTREEEEE" + widget.practicante.toString());
                      return _crearPracticante(widget.practicante);
                    },
                  )
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Future<void> _crearPracticante(Practicante practicante) async {
    String idPracticante =
        await ProviderAuntenticacion.registerWithEmailPassword(
            practicante.email, practicante.documento);
    practicante.id = idPracticante;
    practicante.tipoUsuario = "Practicante";
    String respuesta =
        await ProviderAdministracionPracticantes.crearPracticante(practicante);
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
}
