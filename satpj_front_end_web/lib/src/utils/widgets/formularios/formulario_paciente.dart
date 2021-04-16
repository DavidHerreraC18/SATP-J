import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/validators/validadores-input.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/container_stack.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/formulario_usuario.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/tema_formularios.dart';

import '../../../constants.dart';
import '../inputs/dropdown.dart';

class FormPatientInformation extends StatefulWidget {
  final Paciente paciente;
  final String prefix;
  final String label;
  final bool stack;
  final bool enabled;
  final bool fechaNacimiento;

  FormPatientInformation(
      {this.paciente,
      this.prefix = 'el',
      this.label = 'de su pareja',
      this.stack = true,
      this.enabled = true,
      this.fechaNacimiento = true});

  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<FormPatientInformation> {
  TextEditingController textControllerEstrato;
  FocusNode textFocusNodeEstrato;

  @override
  void initState() {   
    textControllerEstrato =
        TextEditingController(text: widget.paciente.estrato.toString());

    textFocusNodeEstrato = FocusNode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [    
        Container(
          margin: widget.stack
              ? EdgeInsets.symmetric(vertical: 35.0, horizontal: 5.0)
              : null,
          padding: widget.stack
              ? EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 30.0, bottom: 20.0)
              : null,
          decoration: widget.stack
              ? BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: kPrimaryColor, width: 2.0),
                )
              : null,
          child: Theme(
            data: temaFormularios(),
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: 
             [
              FormUserPersonalInformation(
                    usuario: widget.paciente,
                    prefix: widget.prefix,
                    label: widget.label,
                    fechaNacimiento: widget.fechaNacimiento,
              ),
              Text(
                'Estrato sociecómico',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                height: 8.0,
              ),
              Dropdown(
                enabled: widget.enabled,
                textController: textControllerEstrato,
                hintText: 'Estrato socieconómico',
                values: kEstratoSocioeconomico,
                validate: () {
                  if (textControllerEstrato.text.isNotEmpty)
                    widget.paciente.estrato =
                        int.parse(textControllerEstrato.text);

                  return ValidadoresInput.validateEmpty(
                      textControllerEstrato.text,
                      'Seleccione ' +
                          widget.prefix +
                          ' estrato sociecómico ' +
                          widget.label,
                      '');
                },
              ),
              SizedBox(
                height: 30.0,
              ),
            ]),
          ),
        ),
        if (widget.stack)
          labelContainerStack(widget.label != null && widget.label.isNotEmpty ? widget.label : 'personal' ),
      ],
    );
  }
}
