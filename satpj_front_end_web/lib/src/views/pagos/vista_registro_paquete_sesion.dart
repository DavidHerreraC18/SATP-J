import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:satpj_front_end_web/src/constants.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/model/paquete_sesion/paquete_sesion.dart';
import 'package:satpj_front_end_web/src/providers/provider_administracion_pacientes.dart';
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';
import 'package:satpj_front_end_web/src/providers/provider_pagos.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/validators/validadores-input.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_paciente.dart';
import 'package:satpj_front_end_web/src/utils/widgets/botones/button_forms.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/tema_formularios.dart';
import 'package:satpj_front_end_web/src/utils/widgets/inputs/rounded_text_field.dart';
import 'package:url_launcher/url_launcher.dart';

Paciente pacientePaquete;

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
  PaqueteSesion paquete = new PaqueteSesion();
  Paciente paciente = new Paciente();
  bool grupal = false;
  bool individual = false;
  bool primeraVez = false;
  String valor = '0.0';
  String total = '0.0';

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

  Future<String> obtenerPaciente() async {
    paciente = new Paciente();

    paciente = (await ProviderAdministracionPacientes.buscarPaciente(
        ProviderAuntenticacion.uid));
    print('PACIENTE ID' + paciente.id);
    return Future.value("Data download successfully");
  }

  _launchURL() async {
    const url = 'http://www.zonapagos.com/t_Husi';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  obtenerValorTerapia(bool primera, bool grupo) {
    if (primera) {
      valor = '\$6.600';
      paquete.total = 6.600;
      total = '\$6.600';
    } else if (!grupo) {
      if (textControllerSesionesTerapias.text != '0')
        paquete.cantidadSesiones =
            int.parse(textControllerSesionesTerapias.text);

      if (paciente.estrato == 1) {
        valor = '4.200';
        if (paquete.cantidadSesiones > 0) {
          paquete.total = (4.200 * paquete.cantidadSesiones);
          total = paquete.total.toStringAsFixed(3);
        }
      } else if (paciente.estrato == 2) {
        valor = '5.400';
        if (paquete.cantidadSesiones > 0) {
          paquete.total = 5.400 * paquete.cantidadSesiones;
          total = paquete.total.toStringAsFixed(3);
        }
      } else if (paciente.estrato == 3 || paciente.estrato == 4) {
        valor = '6.600';
        if (paquete.cantidadSesiones > 0) {
          paquete.total = 6.600 * paquete.cantidadSesiones;
          print('TOTAL');
          print(paquete.total);
          total = paquete.total.toStringAsFixed(3);
        }
      } else if (paciente.estrato == 5 || paciente.estrato == 6) {
        valor = '24.000';
        if (paquete.cantidadSesiones > 0) {
          paquete.total = 24.000 * paquete.cantidadSesiones;
          total = paquete.total.toStringAsFixed(3);
        }
      }
    } else {
      if (paciente.estrato == 1) {
        valor = '5.000';
        if (paquete.cantidadSesiones > 0) {
          paquete.total = 5.000 * paquete.cantidadSesiones;
          total = paquete.total.toStringAsFixed(3);
        }
      } else if (paciente.estrato == 2) {
        valor = '6.600';
        if (paquete.cantidadSesiones > 0) {
          paquete.total = 6.600 * paquete.cantidadSesiones;
          total = paquete.total.toStringAsFixed(3);
        }
      } else if (paciente.estrato == 3 || paciente.estrato == 4) {
        valor = '9.000';
        if (paquete.cantidadSesiones > 0) {
          paquete.total = 9.000 * paquete.cantidadSesiones;
          total = paquete.total.toStringAsFixed(3);
        }
      } else if (paciente.estrato == 5 || paciente.estrato == 6) {
        valor = '24.000';
        if (paquete.cantidadSesiones > 0) {
          paquete.total = 24.000 * paquete.cantidadSesiones;
          total = paquete.total.toStringAsFixed(3);
        }
      }
    }

    textControllerTotal.text = total;
    textControllerValorSesionTerapia.text = valor;
  }

  @override
  void initState() {
    paciente = pacientePaquete;

    paquete = new PaqueteSesion();
    paquete.cantidadSesiones = 0;
    paquete.paciente = paciente;
    valor = '0.0';

    textControllerSesionesTerapias = TextEditingController(text: '0');
    textControllerTotal = TextEditingController(text: total);
    textControllerValorSesionTerapia = TextEditingController(text: valor);
    textControllerPaquetes = TextEditingController();

    textControllerTotal.text = null;
    textControllerValorSesionTerapia.text = null;
    textControllerPaquetes.text = null;

    textFocusNodeSesionesTerapias = FocusNode();
    textFocusNodeTotal = FocusNode();
    textFocusNodeValorSesionTerapia = FocusNode();

    obtenerPaciente();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /*return FutureBuilder<String>(
      future: obtenerPaciente(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Time to Die');
        } else {
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else {*/
    return Container(
        child: Form(
      key: _formKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Tipo de sesión de terapia:',
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 18.0),
        ),
        SizedBox(
          height: 8.0,
        ),
        Row(
          children: [
            Checkbox(
                value: primeraVez,
                activeColor: kPrimaryColor,
                onChanged: (bool value) {
                  primeraVez = value;
                  grupal = false;
                  individual = false;
                  setState(() {
                    obtenerValorTerapia(primeraVez, grupal);
                  });
                }),
            Text(
              'Primera vez',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
        Row(
          children: [
            Checkbox(
                value: individual,
                activeColor: kPrimaryColor,
                onChanged: (bool value) {
                  setState(() {
                    individual = value;
                    primeraVez = false;
                    grupal = false;
                    obtenerValorTerapia(false, false);
                  });
                }),
            Text(
              'Individual',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
        Row(
          children: [
            Checkbox(
                value: grupal,
                activeColor: kPrimaryColor,
                onChanged: (bool value) {
                  setState(() {
                    grupal = value;
                    primeraVez = false;
                    individual = false;
                    obtenerValorTerapia(primeraVez, grupal);
                  });
                }),
            Text(
              'Pareja',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          'Cantidad de sesiones de terapia:',
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
            onChanged: () {
              setState(() {
                paquete.cantidadSesiones =
                    int.parse(textControllerSesionesTerapias.text);
                obtenerValorTerapia(primeraVez, grupal);
              });
            },
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
                    _launchURL();
                    paquete.paciente = paciente;
                    ProviderGestionPagos.crearPaqueteSesion(paquete);
                  }),
            ),
          ],
        ),
      ]),
    ));
    /*}
        }
      },
    );*/
  }
}
