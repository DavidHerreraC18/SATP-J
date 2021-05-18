import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/constants/constantes_data.dart';
import 'package:satpj_front_end_web/src/model/supervisor/supervisor.dart';
import 'package:satpj_front_end_web/src/utils/validators/validadores-input.dart';
import 'package:satpj_front_end_web/src/utils/widgets/inputs/dropdown.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/formulario_usuario.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/tema_formularios.dart';

// ignore: must_be_immutable
class FormSupervisorInformation extends StatefulWidget {
  Supervisor supervisor = new Supervisor();
  String prefix;
  String label;
  bool enabled;

  FormSupervisorInformation({
    this.supervisor,
    this.prefix = 'el',
    this.label = 'del supervisor',
    this.enabled = true,
  });

  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<FormSupervisorInformation> {
  TextEditingController textControllerEnfoque;
  FocusNode textFocusNodeEnfoque;

  @override
  void initState() {
    textControllerEnfoque =
        new TextEditingController(text: widget.supervisor.enfoque);
    textFocusNodeEnfoque = new FocusNode();

    if (widget.enabled) {
      textFocusNodeEnfoque.unfocus();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Theme(
        data: temaFormularios(),
        child: Column(
          children: [
            FormUserPersonalInformation(
              enabled: widget.enabled,
              usuario: widget.supervisor,
              prefix: widget.prefix,
              label: widget.label,
            ),
            Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enfoque',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Dropdown(
                      textController: textControllerEnfoque,
                      enabled: widget.enabled,
                      focusNode: textFocusNodeEnfoque,
                      hintText: 'Enfoque',
                      values: kEnfoques,
                      onChanged: () {
                        if (textControllerEnfoque.text.isNotEmpty)
                          widget.supervisor.enfoque =
                              textControllerEnfoque.text;
                      },
                      validate: () {
                        widget.supervisor.enfoque = textControllerEnfoque.text;
                        return ValidadoresInput.validateEmpty(
                            textControllerEnfoque.text,
                            'Seleccione ' +
                                widget.prefix +
                                ' enfoque ' +
                                widget.label,
                            '');
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
