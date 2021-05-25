import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/model/practicante/practicante.dart';
import 'package:satpj_front_end_web/src/providers/provider_agregar_pacientes-practicantes.dart';
import 'package:satpj_front_end_web/src/providers/providers_usuarios/provider_pacientes.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/validators/validadores-input.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/fotter_dialog.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/header_dialog.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/tema_formularios.dart';
import 'package:satpj_front_end_web/src/utils/widgets/inputs/rounded_text_field.dart';
import 'package:satpj_front_end_web/src/views/gestionar_practicantes/vista_administrar_practicantes.dart';

// ignore: must_be_immutable
class DialogoAgregarPacientePracticante extends StatefulWidget {
  Practicante practicante;

  DialogoAgregarPacientePracticante({this.practicante});

  @override
  _DialogoAgregarPacientePracticanteState createState() =>
      _DialogoAgregarPacientePracticanteState();
}

class _DialogoAgregarPacientePracticanteState
    extends State<DialogoAgregarPacientePracticante> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  TextEditingController textControllerEmail;
  FocusNode textFocusNodeEmail;
  bool _isEditingEmail = false;
  String estadoPaciente;

  @override
  void initState() {
    textControllerEmail = TextEditingController();

    textFocusNodeEmail = FocusNode();

    super.initState();
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
          width: 600.0,
          height: 260.0,
          child: Form(
            key: _formKey,
            child: ListView(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  HeaderDialog(
                    label: 'Asociar Paciente',
                    height: 55.0,
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ingrese el Correo Electrónico del Paciente',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          RoundedTextFieldValidators(
                              textFocusNode: textFocusNodeEmail,
                              textController: textControllerEmail,
                              textInputType: TextInputType.emailAddress,
                              isEditing: _isEditingEmail,
                              enabled: true,
                              hintText:
                                  'Ingrese el correo electrónico del paciente a asociar',
                              validate: () {
                                print('EMAIL');
                                return ValidadoresInput.validateEmail(
                                    textControllerEmail.text);
                              }),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      )),
                  estadoPaciente != null
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 20.0,
                            ),
                            child: Text(
                              estadoPaciente,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 14,
                                // letterSpacing: 3,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  FotterDialog(
                    labelCancelBtn: 'Terminar',
                    labelConfirmBtn: 'Asociar Paciente',
                    colorConfirmBtn: kPrimaryColor,
                    paginator: false,
                    width: 200.0,
                    functionConfirmBtn: () async {
                      print(textControllerEmail.text);
                      String respuesta = await _crearPracticantePaciente(
                          widget.practicante, textControllerEmail.text);
                      setState(() {
                        estadoPaciente = respuesta;
                      });
                    },
                    functionCancelBtn: (){
                       Navigator.of(context).pushNamed(
                          VistaAdministrarPracticantes.route,
                          arguments: widget.practicante);
                      Navigator.pop(context, true);
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

  Future<String> _crearPracticantePaciente(
      Practicante practicante, String correoPaciente) async {
    Paciente paciente = await ProviderPacientes.findByIdEmail(correoPaciente);
    if (paciente != null) {
      String respuesta =
          await ProviderAgregarPracticantesPacientes.crearPracticantePaciente(
              practicante.id, paciente.id);
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
      return "Exito Agregando Paciente!";
    } else {
      return "El paciente no existe en el sistema";
    }
  }
}

/*TextButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.all(5.0)),
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
                            onPressed: () async {
                              String respuesta =
                                  await _crearPracticantePaciente(
                                      widget.practicante,
                                      textControllerEmail.text);

                              setState(() {
                                estadoPaciente = respuesta;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.0,
                              ),
                              child: Text(
                                'Asociar Paciente',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),*/
