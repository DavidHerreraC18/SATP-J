import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/validators/validadores-input.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/formulario_usuario.dart';
import 'package:satpj_front_end_web/src/utils/widgets/tema-formularios.dart';

import '../../../constants.dart';
import '../dropdown.dart';

class FormPatientInformation extends StatefulWidget {
  Paciente paciente = new Paciente();
  String prefix;
  String label;
  bool stack;
  bool enabled;
  bool fechaNacimiento;

  FormPatientInformation(
      {this.paciente,
      this.prefix = 'la',
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

  bool esAdulto({String fechaNacimiento = '00-00-0000'}) {
    if (fechaNacimiento != null && fechaNacimiento.isNotEmpty) {
      DateTime birthDate = new DateFormat("yyyy-MM-dd").parse(fechaNacimiento);
      DateTime today = DateTime.now();

      int yearDiff = today.year - birthDate.year;
      int monthDiff = today.month - birthDate.month;
      int dayDiff = today.day - birthDate.day;
      widget.paciente.edad = yearDiff;

      if (yearDiff > 18 || (yearDiff == 18 && monthDiff >= 0 && dayDiff >= 0)) {
        return true;
      }
    }
    return false;
  }

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
          Positioned(
            left: 10,
            top: 20,
            child: Container(
                color: Colors.white,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  color: kPrimaryColor,
                  child: Text(
                    'Información personal ' + widget.label,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                )),
          )
      ],
    );
  }
}
