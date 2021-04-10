import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:satpj_front_end_web/src/constants/constantes_data.dart';
import 'package:satpj_front_end_web/src/model/practicante/practicante.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/validators/validadores-input.dart';
import 'package:satpj_front_end_web/src/utils/widgets/inputs/dropdown.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/formulario_usuario.dart';
import 'package:satpj_front_end_web/src/utils/widgets/inputs/rounded_text_field.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/tema_formularios.dart';


class FormInternInformation extends StatefulWidget {
  
  Practicante practicante = new Practicante();
  String prefix;
  String label;
  bool enabled;

  FormInternInformation({this.practicante, this.prefix = 'el',
    this.label = 'del practicante', this.enabled = true, 
  });

  @override
  _FormState createState() => _FormState();

}

class _FormState extends State<FormInternInformation> {
  
  TextEditingController textControllerPregrado;
  FocusNode textFocusNodePregrado;
  bool _isEditingPregrado = false;

  TextEditingController textControllerSemestre;
  FocusNode textFocusNodeSemestre;
  bool _isEditingSemestre = false;

  TextEditingController textControllerEnfoque;
  FocusNode textFocusNodeEnfoque;
  
  bool pregrado = false;
  bool posgrado = false;

  @override
  void initState() {

    textControllerPregrado = TextEditingController(text: widget.practicante.pregrado.toString());
    textControllerSemestre = TextEditingController(text: widget.practicante.semestre.toString());
    textControllerEnfoque = TextEditingController(text: widget.practicante.enfoque);

    textFocusNodePregrado = FocusNode();
    textFocusNodeSemestre = FocusNode();
    textFocusNodeEnfoque = FocusNode();
   
    if(widget.enabled){
      textFocusNodeEnfoque.unfocus();
    }
    
    widget.practicante.pregrado && widget.practicante.pregrado != null ? 
      pregrado = true : posgrado = true;
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
      Theme(
      data: temaFormularios(),
      child: Column(
        children: [
          FormUserPersonalInformation (
            enabled: widget.enabled, 
            usuario: widget.practicante,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
               SizedBox(
                 height: 8.0,
               ),
               Text(
                 'Programa académico',
                 textAlign: TextAlign.left,
                 style: TextStyle(fontSize: 18.0),
               ),
               SizedBox(
                 height: 8.0,
               ),
               Row(
                 children: [
                   Checkbox(
                       value: pregrado,
                       activeColor: kPrimaryColor,
                       onChanged: (bool value) {
                         setState(() {
                           pregrado = value;
                           posgrado = false;
                           widget.practicante.pregrado = pregrado;
                         });
                       }),
                   Text(
                     'Pregrado',
                     style: TextStyle(fontSize: 18.0),
                   ),
                 ],
              ),
              Row(
                 children: [
                   Checkbox(
                       value: posgrado,
                       activeColor: kPrimaryColor,
                       onChanged: (bool value) {
                         setState(() {
                           posgrado = value;
                           pregrado = false;
                           widget.practicante.pregrado = pregrado;
                         });
                       }),
                   Text(
                     'Posgrado',
                     style: TextStyle(fontSize: 18.0),
                   ),
                 ],
              ),
              SizedBox(
                 height: 20.0,
               ),
               Text(
                 'Semestre',
                 textAlign: TextAlign.left,
                 style: TextStyle(fontSize: 18.0),
               ),
               SizedBox(
                 height: 8.0,
               ),
               RoundedTextFieldValidators(
                 textFocusNode: textFocusNodeSemestre,
                 textController: textControllerSemestre,
                 textInputType: TextInputType.number,
                 isEditing: _isEditingSemestre,
                 enabled: widget.enabled,
                 formatter: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                 hintText: 'Ingrese ' + widget.prefix + ' semestre ' + widget.label,
                 validate: () {
                  if (textControllerSemestre.text.isNotEmpty)
                      widget.practicante.semestre = int.parse(textControllerSemestre.text);
                   
                   return ValidadoresInput.validateEmpty(
                       textControllerSemestre.text,
                       'Debe ingresar ' + widget.prefix + ' semestre ' + widget.label,
                       '');
               }),
               SizedBox(
                 height: 20.0,
               ),
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
                 validate: () {
                   widget.practicante.enfoque = textControllerEnfoque.text;
                   return ValidadoresInput.validateEmpty(textControllerEnfoque.text,
                       'Seleccione ' + widget.prefix + ' enfoque ' + widget.label, '');
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