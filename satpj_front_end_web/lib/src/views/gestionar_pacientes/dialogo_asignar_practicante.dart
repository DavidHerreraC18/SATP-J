import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/validators/validadores-input.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/fotter_dialog.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/header_dialog.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/tema_formularios.dart';
import 'package:satpj_front_end_web/src/utils/widgets/inputs/dropdown.dart';
import 'package:satpj_front_end_web/src/utils/widgets/inputs/rounded_text_field.dart';

import '../../constants.dart';

class DialogoAsignarPracticante extends StatefulWidget {
  DialogoAsignarPracticante({Paciente pacienteP}) {
    if (paciente != null) paciente = pacienteP;
  }

  @override
  _DialogoAsignarPracticanteState createState() =>
      _DialogoAsignarPracticanteState();
}

Paciente paciente = new Paciente();

class _DialogoAsignarPracticanteState extends State<DialogoAsignarPracticante> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  TextEditingController textControllerPracticante;
  FocusNode textFocusNodePracticante;

  TextEditingController textControllerPaciente;
  FocusNode textFocusNodePaciente;
  bool _isEditingPaciente = false;

  @override
  void initState() {
    textControllerPracticante = new TextEditingController(text: null);
    textControllerPaciente = new TextEditingController(
        text: paciente.nombre + ' ' + paciente.apellido);

    textFocusNodePracticante = new FocusNode();
    textFocusNodePaciente = new FocusNode();

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
          width: 500.0,
          height: 370.0,
          child: Form(
            key: _formKey,
            child: ListView(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  HeaderDialog(
                    label: 'Asignar Practicante',
                    height: 55.0,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text(
                        'Paciente',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      RoundedTextFieldValidators(
                          textFocusNode: textFocusNodePaciente,
                          textController: textControllerPaciente,
                          textInputType: TextInputType.text,
                          isEditing: _isEditingPaciente,
                          enabled: false,
                          validate: () {
                            return null;
                          }),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'Practicantes',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Dropdown(
                        textController: textControllerPracticante,
                        focusNode: textFocusNodePracticante,
                        hintText: 'Practicantes',
                        values: kTtipoDocumento,
                        onChanged: () {
                          if (textControllerPracticante.text.isNotEmpty)
                            print('HOLA');
                          //widget.paciente.tipoDocumento = textControllerPracticante.text;
                        },
                        validate: () {
                          return ValidadoresInput.validateEmpty(
                              textControllerPracticante.text,
                              'Seleccione un practicante',
                              '');
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ]),
                  )
                ],
              ),
              FotterDialog(
                labelCancelBtn: 'Cancelar',
                labelConfirmBtn: 'Asignar',
                colorConfirmBtn: kPrimaryColor,
                width: 120.0,
              )
            ]),
          ),
        ),
      ),
    );
  }
}
