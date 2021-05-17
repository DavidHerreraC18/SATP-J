import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:satpj_front_end_web/src/constants.dart';
import 'package:satpj_front_end_web/src/model/paquete_sesion/paquete_sesion.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/validators/validadores-input.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_paciente.dart';
import 'package:satpj_front_end_web/src/utils/widgets/botones/button_forms.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/tema_formularios.dart';
import 'package:satpj_front_end_web/src/utils/widgets/inputs/rounded_text_field.dart';

class VistaRegistroPaquetesSesiones extends StatefulWidget {
  
  static const route = '/registrar-paquetes';

  VistaRegistroPaquetesSesiones();

  @override
  _VistaRegistroPaquetesSesionesState createState() =>
      _VistaRegistroPaquetesSesionesState();
}

class _VistaRegistroPaquetesSesionesState
    extends State<VistaRegistroPaquetesSesiones> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAccentColor,
      appBar: toolbarPaciente(context),
      body: ListView(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Theme(
              data: temaFormularios(),
              child: Card(
                margin: EdgeInsets.only(
                    right: 400.0, left: 400.0, top: 20.0, bottom: 20.0),
                elevation: 25.0,
                child: Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Container(
                    width: 700,
                    child: FormularioRegistroPaquetesSesiones(),
                  ),
                ),
              ),
            )
          ],
        ),
      ]),
    );
  }
}

class FormularioRegistroPaquetesSesiones extends StatefulWidget {
  @override
  _FormularioRegistroPaquetesSesionesState createState() =>
      _FormularioRegistroPaquetesSesionesState();
}

class _FormularioRegistroPaquetesSesionesState
    extends State<FormularioRegistroPaquetesSesiones> {
  PaqueteSesion paquete;

  TextEditingController textControllerSesionesTerapias;
  FocusNode textFocusNodeSesionesTerapias;
  bool _isEditingSesionesTerapias = false;

  TextEditingController textControllerTotal;
  FocusNode textFocusNodeTotal;
  bool _isEditingTotal = false;

  TextEditingController textControllerValorSesionTerapia;
  FocusNode textFocusNodeValorSesionTerapia;
  bool _isEditingValorSesionTerapia = false;

  TextEditingController textControllerPaquetes;

  var _formKey = GlobalKey<FormState>();


  obtenerEstrato(){
    
  }

  @override
  void initState() {
    textControllerSesionesTerapias = TextEditingController(text: null);
    textControllerTotal = TextEditingController();
    textControllerValorSesionTerapia = TextEditingController();
    textControllerPaquetes = TextEditingController();
    


    textControllerTotal.text = null;
    textControllerValorSesionTerapia.text = null;
    textControllerPaquetes.text = null;

    textFocusNodeSesionesTerapias = FocusNode();
    textFocusNodeTotal = FocusNode();
    textFocusNodeValorSesionTerapia = FocusNode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Form(
      key: _formKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Sesiones de terapia:',
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 18.0),
        ),
        SizedBox(
          height: 8.0,
        ),
        RoundedTextFieldValidators(
            textFocusNode: textFocusNodeSesionesTerapias,
            textController: textControllerSesionesTerapias,
            textInputType: TextInputType.number,
            isEditing: _isEditingSesionesTerapias,
            formatter: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            hintText: 'Sesiones de terapia',
            validate: () {
              paquete.cantidadSesiones =
                  int.parse(textControllerSesionesTerapias.text);
              return ValidadoresInput.validateEmpty(
                  textControllerSesionesTerapias.text,
                  'Las sesiones de terapia no pueden estar vacías',
                  '');
            }),
        SizedBox(
          height: 20.0,
        ),
        Text(
          'Valor sesión de terapia:',
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 18.0),
        ),
        SizedBox(
          height: 8.0,
        ),
        RoundedTextFieldValidators(
          textFocusNode: textFocusNodeValorSesionTerapia,
          textController: textControllerValorSesionTerapia,
          textInputType: TextInputType.number,
          isEditing: _isEditingValorSesionTerapia,
          hintText: 'Valor sesión de terapia',
          formatter: [currencyformatPesosColombianos],
          validate: () {},
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          'Valor total:',
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 18.0),
        ),
        SizedBox(
          height: 8.0,
        ),
        RoundedTextFieldValidators(
            textFocusNode: textFocusNodeTotal,
            textController: textControllerTotal,
            textInputType: TextInputType.number,
            isEditing: _isEditingTotal,
            hintText: 'Total',
            formatter: [currencyformatPesosColombianos],
            validate: () {
              return ValidadoresInput.validateCurrency(
                  textControllerTotal.text, 'total');
            }),
        SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 40.0,
              child: ButtonForms(
                  formKey: _formKey,
                  label: 'Registrar',
                  color: kPrimaryColor,
                  route: VistaRegistroPaquetesSesiones.route,
                  providerFunction: () {
                  
                  }),
            ),
          ],
        ),
      ]),
    ));
  }
}
