import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/constants.dart';
import 'package:satpj_front_end_web/src/model/comprobante_pago/comprobante_pago.dart';
import 'package:satpj_front_end_web/src/model/paquete_sesion/paquete_sesion.dart';
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';
import 'package:satpj_front_end_web/src/providers/provider_pagos.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/validators/validadores-input.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_paciente.dart';
import 'package:satpj_front_end_web/src/utils/widgets/botones/button_forms.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/tema_formularios.dart';
import 'package:satpj_front_end_web/src/utils/widgets/inputs/rounded_text_field.dart';
import 'package:satpj_front_end_web/src/utils/widgets/loading/LoadingWanderingCube.dart';

final registroPago = ComprobantePago();

class VistaRegistroPago extends StatefulWidget {
  static const route = '/registro-pago';

  @override
  _VistaRegistroPagoState createState() => _VistaRegistroPagoState();
}

class _VistaRegistroPagoState extends State<VistaRegistroPago> {
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
                    child: FormularioRegistroPago(),
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

class FormularioRegistroPago extends StatefulWidget {
  @override
  _FormularioRegistroPagoState createState() => _FormularioRegistroPagoState();
}

class _FormularioRegistroPagoState extends State<FormularioRegistroPago> {
  List<PaqueteSesion> paquetesSesiones = [];
  PaqueteSesion selectedP;
  ComprobantePago comprobantePago;

  TextEditingController textControllerReferenciaPago;
  FocusNode textFocusNodeReferenciaPago;
  bool _isEditingReferenciaPago = false;

  TextEditingController textControllerTotal;
  FocusNode textFocusNodeTotal;
  bool _isEditingTotal = false;

  TextEditingController textControllerObservaciones;
  FocusNode textFocusNodeObservaciones;
  bool _isEditingObservaciones = false;

  TextEditingController textControllerPaquetes;

  var _formKey = GlobalKey<FormState>();

  Future<String> inicializarPaqueteSesiones() async {
    paquetesSesiones = [];
    paquetesSesiones =
        await ProviderGestionPagos.obtenerPaquetesSesionesPaciente(
            ProviderAuntenticacion.uid);
    return Future.value("Data download successfully");
  }

  @override
  void initState() {
    comprobantePago = new ComprobantePago();
    comprobantePago.fecha = DateTime.now();

    textControllerReferenciaPago = TextEditingController();
    textControllerTotal = TextEditingController();
    textControllerObservaciones = TextEditingController();
    textControllerPaquetes = TextEditingController();

    textControllerReferenciaPago.text = null;
    textControllerTotal.text = null;
    textControllerObservaciones.text = null;
    textControllerPaquetes.text = null;

    textFocusNodeReferenciaPago = FocusNode();
    textFocusNodeTotal = FocusNode();
    textFocusNodeObservaciones = FocusNode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: inicializarPaqueteSesiones(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingWanderingCube();
        } else {
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else {
            return Container(
                child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Paquete de sesión:',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    DropdownButtonFormField<PaqueteSesion>(
                      hint: Text('Paquetes'),
                      value: selectedP,
                      decoration: inputDecoration(),
                      onChanged: (PaqueteSesion value) {
                        comprobantePago.paqueteSesion = value;
                      },
                      items: paquetesSesiones.map((PaqueteSesion p) {
                        return DropdownMenuItem<PaqueteSesion>(
                          value: p,
                          child: Text(
                            'Fecha: ' +
                                p.fecha.day.toString() +
                                '/' +
                                p.fecha.month.toString() +
                                '/' +
                                p.fecha.year.toString() +
                                ' - Sesiones: ' +
                                p.cantidadSesiones.toString(),
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      validator: (value) => value == null
                          ? ValidadoresInput.validateEmpty(value.toString(),
                              'Debe seleccionar un paquete', '')
                          : null,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Referencia de pago:',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    RoundedTextFieldValidators(
                        textFocusNode: textFocusNodeReferenciaPago,
                        textController: textControllerReferenciaPago,
                        textInputType: TextInputType.text,
                        isEditing: _isEditingReferenciaPago,
                        hintText: 'Referencia de pago',
                        validate: () {
                          comprobantePago.referenciaPago =
                              textControllerReferenciaPago.text;
                          return ValidadoresInput.validateEmpty(
                              textControllerReferenciaPago.text,
                              'La referencia de pago',
                              'vacia');
                        }),
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
                    Text(
                      'Observaciones:',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    RoundedTextFieldValidators(
                      textFocusNode: textFocusNodeObservaciones,
                      textController: textControllerObservaciones,
                      textInputType: TextInputType.number,
                      isEditing: _isEditingObservaciones,
                      hintText: 'Observaciones',
                      validate: () {},
                    ),
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
                              route: VistaRegistroPago.route,
                              providerFunction: () {
                                comprobantePago.valorTotal = double.parse(
                                    textControllerTotal.text.substring(0,
                                        textControllerTotal.text.length - 4));
                                ProviderGestionPagos
                                    .crearComprobantePagoPaciente(
                                        comprobantePago);
                              }),
                        ),
                      ],
                    ),
                  ]),
            ));
          }
        }
      },
    );
  }
}
