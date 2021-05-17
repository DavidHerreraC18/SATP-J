import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/formulario/formulario_extra.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/providers/provider_aprobacion_pacientes.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/validators/validadores-input.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/tema_formularios.dart';
import 'package:satpj_front_end_web/src/utils/widgets/inputs/rounded_text_field.dart';
import 'package:satpj_front_end_web/src/views/documentacion/vista_registro_documentos.dart';

class FormPatientExtraInformation extends StatefulWidget {
  final bool stack;
  final bool enabled;
  final Paciente pacienteActual;

  FormPatientExtraInformation({
    this.pacienteActual,
    this.stack = true,
    this.enabled = true,
  });

  @override
  _FormState createState() => _FormState(pacienteActual);
}

enum EscolaridadChar {
  ninguna,
  primaria_completa,
  primaria_incompleta,
  secundaria_completa,
  secundaria_incompleta,
  tecnico_completo,
  tecnico_incompleto,
  universitario_completo,
  universitario_incompleto,
  posgrado_completo,
  posgrado_incompleto,
  otro,
  unchecked,
}

enum CivilChar { soltero, casado, union_libre, separado, viudo, unchecked }

enum EpsChar {
  si,
  no,
  unchecked,
}

enum SaludChar {
  cotizante,
  beneficiario,
  unchecked,
}

class _FormState extends State<FormPatientExtraInformation> {
  Paciente pacienteActual;
  _FormState(Paciente paciente) {
    this.pacienteActual = paciente;
  }
  FormularioExtra formularioExtra;
  TextEditingController textControllerInsti;
  FocusNode textFocusNodeInsti;
  bool _isEditingInsti = false;

  TextEditingController textControllerSalud;
  FocusNode textFocusNodeSalud;
  bool _isEditingSalud = false;

  TextEditingController textControllerServicio;
  FocusNode textFocusNodeServicio;
  bool _isEditingServicio = false;

  TextEditingController textControllerNombre1;
  FocusNode textFocusNodeNombre1;
  bool _isEditingNombre1 = false;

  TextEditingController textControllerNombre2;
  FocusNode textFocusNodeNombre2;
  bool _isEditingNombre2 = false;

  TextEditingController textControllerTel1;
  FocusNode textFocusNodeTel1;
  bool _isEditingTel1 = false;

  TextEditingController textControllerTel2;
  FocusNode textFocusNodeTel2;
  bool _isEditingTel2 = false;

  TextEditingController textControllerOtroOcupacion;
  FocusNode textFocusNodeOtroOcupacion;
  bool _isEditingOtroOcupacion = false;

  TextEditingController textControllerOtroEscolaridad;
  FocusNode textFocusNodeOtroEscolaridad;
  bool _isEditingOtroEscolaridad = false;

  EscolaridadChar _resp = EscolaridadChar.unchecked;
  SaludChar _respSalud = SaludChar.unchecked;
  CivilChar _respCivil = CivilChar.unchecked;
  EpsChar _respEps = EpsChar.unchecked;
  bool eps = false;

  bool estudiante = false;
  bool empleado = false;
  bool trabajadorIndependiente = false;
  bool desempleado = false;
  bool hogar = false;
  bool otra = false;

  @override
  void initState() {
    formularioExtra = new FormularioExtra();
    pacienteActual = widget.pacienteActual;
    formularioExtra.paciente = widget.pacienteActual;
    textControllerInsti = TextEditingController(text: null);
    textFocusNodeInsti = FocusNode();

    textControllerSalud = TextEditingController(text: null);
    textFocusNodeSalud = FocusNode();

    textControllerServicio = TextEditingController(text: null);
    textFocusNodeServicio = FocusNode();

    textControllerNombre1 = TextEditingController(text: null);
    textFocusNodeNombre1 = FocusNode();

    textControllerNombre2 = TextEditingController(text: null);
    textFocusNodeNombre2 = FocusNode();

    textControllerTel1 = TextEditingController(text: null);
    textFocusNodeTel1 = FocusNode();

    textControllerTel2 = TextEditingController(text: null);
    textFocusNodeTel2 = FocusNode();

    textControllerOtroEscolaridad = TextEditingController(text: null);
    textFocusNodeOtroEscolaridad = FocusNode();

    textControllerOtroOcupacion = TextEditingController(text: null);
    textFocusNodeOtroOcupacion = FocusNode();

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
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Escolaridad',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0),
              ),
              Column(
                children: <Widget>[
                  ListTile(
                    title: const Text('Ninguna'),
                    leading: Radio<EscolaridadChar>(
                      value: EscolaridadChar.ninguna,
                      groupValue: _resp,
                      onChanged: (EscolaridadChar value) {
                        setState(() {
                          _resp = value;
                          formularioExtra.escolaridad = 'Ninguna';
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Primaria incompleta'),
                    leading: Radio<EscolaridadChar>(
                      value: EscolaridadChar.primaria_incompleta,
                      groupValue: _resp,
                      onChanged: (EscolaridadChar value) {
                        setState(() {
                          _resp = value;
                          formularioExtra.escolaridad = 'Primaria incompleta';
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Primaria completa'),
                    leading: Radio<EscolaridadChar>(
                      value: EscolaridadChar.primaria_completa,
                      groupValue: _resp,
                      onChanged: (EscolaridadChar value) {
                        setState(() {
                          _resp = value;
                          formularioExtra.escolaridad = 'Primaria completa';
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Secundaria incompleta'),
                    leading: Radio<EscolaridadChar>(
                      value: EscolaridadChar.secundaria_incompleta,
                      groupValue: _resp,
                      onChanged: (EscolaridadChar value) {
                        setState(() {
                          _resp = value;
                          formularioExtra.escolaridad = 'Secundaria incompleta';
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Secundaria completa'),
                    leading: Radio<EscolaridadChar>(
                      value: EscolaridadChar.secundaria_completa,
                      groupValue: _resp,
                      onChanged: (EscolaridadChar value) {
                        setState(() {
                          _resp = value;
                          formularioExtra.escolaridad = 'Secundaria completa';
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Técnico incompleto'),
                    leading: Radio<EscolaridadChar>(
                      value: EscolaridadChar.tecnico_incompleto,
                      groupValue: _resp,
                      onChanged: (EscolaridadChar value) {
                        setState(() {
                          _resp = value;
                          formularioExtra.escolaridad = 'Técnico incompleto';
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Técnico completo'),
                    leading: Radio<EscolaridadChar>(
                      value: EscolaridadChar.tecnico_completo,
                      groupValue: _resp,
                      onChanged: (EscolaridadChar value) {
                        setState(() {
                          _resp = value;
                          formularioExtra.escolaridad = 'Técnico completo';
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Universitario incompleto'),
                    leading: Radio<EscolaridadChar>(
                      value: EscolaridadChar.universitario_incompleto,
                      groupValue: _resp,
                      onChanged: (EscolaridadChar value) {
                        setState(() {
                          _resp = value;
                          formularioExtra.escolaridad =
                              'Universitario incompleto';
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Universitario completo'),
                    leading: Radio<EscolaridadChar>(
                      value: EscolaridadChar.universitario_completo,
                      groupValue: _resp,
                      onChanged: (EscolaridadChar value) {
                        setState(() {
                          _resp = value;
                          formularioExtra.escolaridad =
                              'Universitario completo';
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Posgrado incompleto'),
                    leading: Radio<EscolaridadChar>(
                      value: EscolaridadChar.posgrado_incompleto,
                      groupValue: _resp,
                      onChanged: (EscolaridadChar value) {
                        setState(() {
                          _resp = value;
                          formularioExtra.escolaridad = 'Posgrado incompleto';
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Posgrado completo'),
                    leading: Radio<EscolaridadChar>(
                      value: EscolaridadChar.posgrado_completo,
                      groupValue: _resp,
                      onChanged: (EscolaridadChar value) {
                        setState(() {
                          _resp = value;
                          formularioExtra.escolaridad = 'Posgrado completo';
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: RoundedTextFieldValidators(
                        textFocusNode: textFocusNodeOtroEscolaridad,
                        textController: textControllerOtroEscolaridad,
                        textInputType: TextInputType.text,
                        isEditing: _isEditingOtroEscolaridad,
                        hintText: 'Otro',
                        validate: () {
                          if (_resp == EscolaridadChar.otro) {
                            formularioExtra.escolaridad =
                                textControllerOtroEscolaridad.text;
                            return ValidadoresInput.validateEmpty(
                                textControllerOtroEscolaridad.text,
                                'Debe ingresar  el valor correspondiente a Otro',
                                '');
                          }
                          return null;
                        }),
                    leading: Radio<EscolaridadChar>(
                      value: EscolaridadChar.otro,
                      groupValue: _resp,
                      onChanged: (EscolaridadChar value) {
                        setState(() {
                          _resp = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Ocupación',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0),
              ),
              Column(children: <Widget>[
                ListTile(
                  title: const Text('Estudiante'),
                  leading: Checkbox(
                    checkColor: kPrimaryColor,
                    activeColor: Colors.white,
                    value: this.estudiante,
                    onChanged: (bool value) {
                      setState(() {
                        this.estudiante = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Empleado'),
                  leading: Checkbox(
                    checkColor: kPrimaryColor,
                    activeColor: Colors.white,
                    value: this.empleado,
                    onChanged: (bool value) {
                      setState(() {
                        this.empleado = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Trabajador independiente'),
                  leading: Checkbox(
                    checkColor: kPrimaryColor,
                    activeColor: Colors.white,
                    value: this.trabajadorIndependiente,
                    onChanged: (bool value) {
                      setState(() {
                        this.trabajadorIndependiente = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Desempleado'),
                  leading: Checkbox(
                    checkColor: kPrimaryColor,
                    activeColor: Colors.white,
                    value: this.desempleado,
                    onChanged: (bool value) {
                      setState(() {
                        this.desempleado = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Hogar'),
                  leading: Checkbox(
                    checkColor: kPrimaryColor,
                    activeColor: Colors.white,
                    value: this.hogar,
                    onChanged: (bool value) {
                      setState(() {
                        this.hogar = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: RoundedTextFieldValidators(
                      textFocusNode: textFocusNodeOtroOcupacion,
                      textController: textControllerOtroOcupacion,
                      textInputType: TextInputType.text,
                      isEditing: _isEditingOtroOcupacion,
                      hintText: 'Otra',
                      validate: () {
                        if (this.otra == true) {
                          return ValidadoresInput.validateEmpty(
                              textControllerOtroOcupacion.text,
                              'Debe ingresar  el valor correspondiente a Otro',
                              '');
                        }
                        return null;
                      }),
                  leading: Checkbox(
                    checkColor: kPrimaryColor,
                    activeColor: Colors.white,
                    value: this.otra,
                    onChanged: (bool value) {
                      setState(() {
                        this.otra = value;
                      });
                    },
                  ),
                ),
              ]),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Institución donde trabaja o estudia',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                height: 8.0,
              ),
              RoundedTextFieldValidators(
                  textFocusNode: textFocusNodeInsti,
                  textController: textControllerInsti,
                  textInputType: TextInputType.text,
                  isEditing: _isEditingInsti,
                  hintText: 'Institución donde trabaja o estudia',
                  validate: () {
                    formularioExtra.lugarOcupacion = textControllerInsti.text;
                    return ValidadoresInput.validateEmpty(
                        textControllerInsti.text, 'Debe ingresar el lugar', '');
                  }),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Estado Civil',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                height: 8.0,
              ),
              Column(children: <Widget>[
                ListTile(
                  title: const Text('Soltero(a)'),
                  leading: Radio<CivilChar>(
                    value: CivilChar.soltero,
                    groupValue: _respCivil,
                    onChanged: (CivilChar value) {
                      setState(() {
                        _respCivil = value;
                        formularioExtra.estadoCivil = 'Soltero(a)';
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Casado(a)'),
                  leading: Radio<CivilChar>(
                    value: CivilChar.casado,
                    groupValue: _respCivil,
                    onChanged: (CivilChar value) {
                      setState(() {
                        _respCivil = value;
                        formularioExtra.estadoCivil = 'Casado(a)';
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Unión libre'),
                  leading: Radio<CivilChar>(
                    value: CivilChar.union_libre,
                    groupValue: _respCivil,
                    onChanged: (CivilChar value) {
                      setState(() {
                        _respCivil = value;
                        formularioExtra.estadoCivil = 'Unión libre';
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Separado(a)'),
                  leading: Radio<CivilChar>(
                    value: CivilChar.separado,
                    groupValue: _respCivil,
                    onChanged: (CivilChar value) {
                      setState(() {
                        _respCivil = value;
                        formularioExtra.estadoCivil = 'Separado(a)';
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Viudo(a)'),
                  leading: Radio<CivilChar>(
                    value: CivilChar.viudo,
                    groupValue: _respCivil,
                    onChanged: (CivilChar value) {
                      setState(() {
                        _respCivil = value;
                        formularioExtra.estadoCivil = 'Viudo(a)';
                      });
                    },
                  ),
                ),
              ]),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Servicio de salud',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                height: 8.0,
              ),
              Column(children: <Widget>[
                ListTile(
                  title: const Text('Si'),
                  leading: Radio<EpsChar>(
                    value: EpsChar.si,
                    groupValue: _respEps,
                    onChanged: (EpsChar value) {
                      setState(() {
                        _respEps = value;
                        formularioExtra.tieneEps = true;
                        eps = true;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('No'),
                  leading: Radio<EpsChar>(
                    value: EpsChar.no,
                    groupValue: _respEps,
                    onChanged: (EpsChar value) {
                      setState(() {
                        _respEps = value;
                        formularioExtra.tieneEps = false;
                        eps = false;
                      });
                    },
                  ),
                ),
              ]),
              SizedBox(
                height: 20.0,
              ),
              eps
                  ? Text(
                      '¿Cuál es su EPS?',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 18.0),
                    )
                  : SizedBox.shrink(),
              eps
                  ? SizedBox(
                      height: 8.0,
                    )
                  : SizedBox.shrink(),
              eps
                  ? RoundedTextFieldValidators(
                      textFocusNode: textFocusNodeSalud,
                      textController: textControllerSalud,
                      textInputType: TextInputType.text,
                      isEditing: _isEditingSalud,
                      hintText: 'Ingrese su EPS',
                      validate: () {
                        formularioExtra.eps = textControllerSalud.text;
                        return ValidadoresInput.validateEmpty(
                            textControllerSalud.text,
                            'Debe ingresar la Entidad Prestadora de Salud',
                            '');
                      })
                  : SizedBox.shrink(),
              eps
                  ? SizedBox(
                      height: 20.0,
                    )
                  : SizedBox.shrink(),
              eps
                  ? Text(
                      'Tipo de Vinculación',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 18.0),
                    )
                  : SizedBox.shrink(),
              eps
                  ? SizedBox(
                      height: 8.0,
                    )
                  : SizedBox.shrink(),
              eps
                  ? Column(children: <Widget>[
                      ListTile(
                        title: const Text('Cotizante'),
                        leading: Radio<SaludChar>(
                          value: SaludChar.cotizante,
                          groupValue: _respSalud,
                          onChanged: (SaludChar value) {
                            setState(() {
                              _respSalud = value;
                              formularioExtra.estadoEps = 'Cotizante';
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Beneficiario'),
                        leading: Radio<SaludChar>(
                          value: SaludChar.beneficiario,
                          groupValue: _respSalud,
                          onChanged: (SaludChar value) {
                            setState(() {
                              _respSalud = value;
                              formularioExtra.estadoEps = 'Beneficiario';
                            });
                          },
                        ),
                      ),
                    ])
                  : SizedBox.shrink(),
              Text(
                '¿Cómo se enteró del servicio de Consultores en Psicología?',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                height: 8.0,
              ),
              RoundedTextFieldValidators(
                  textFocusNode: textFocusNodeServicio,
                  textController: textControllerServicio,
                  textInputType: TextInputType.text,
                  isEditing: _isEditingServicio,
                  hintText: 'Ingrese su respuesta',
                  validate: () {
                    formularioExtra.servicio = textControllerServicio.text;
                    return ValidadoresInput.validateEmpty(
                        textControllerServicio.text,
                        'Por favor informenos',
                        '');
                  }),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Acudiente #1',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                'Nombre del acudiente',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                height: 8.0,
              ),
              RoundedTextFieldValidators(
                  textFocusNode: textFocusNodeNombre1,
                  textController: textControllerNombre1,
                  textInputType: TextInputType.text,
                  isEditing: _isEditingNombre1,
                  hintText: 'Ingrese el nombre del acudiente #1',
                  validate: () {
                    formularioExtra.nombreAcudiente1 =
                        textControllerNombre1.text;
                    return ValidadoresInput.validateEmpty(
                        textControllerNombre1.text,
                        'Ingrese el nombre del acudiente#1',
                        '');
                  }),
              SizedBox(
                height: 8.0,
              ),
              Text(
                'Número del acudiente',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                height: 8.0,
              ),
              RoundedTextFieldValidators(
                  textFocusNode: textFocusNodeTel1,
                  textController: textControllerTel1,
                  textInputType: TextInputType.text,
                  isEditing: _isEditingTel1,
                  hintText: 'Ingrese el número del acudiente #1',
                  validate: () {
                    formularioExtra.numeroAcudiente1 = textControllerTel1.text;
                    return ValidadoresInput.validateEmpty(
                        textControllerTel1.text,
                        'Ingrese el número del acudiente#1',
                        '');
                  }),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Acudiente #2',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                'Nombre del acudiente',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                height: 8.0,
              ),
              RoundedTextFieldValidators(
                  textFocusNode: textFocusNodeNombre2,
                  textController: textControllerNombre2,
                  textInputType: TextInputType.text,
                  isEditing: _isEditingNombre2,
                  hintText: 'Ingrese el nombre del acudiente #2',
                  validate: () {
                    formularioExtra.nombreAcudiente2 =
                        textControllerNombre2.text;
                    return ValidadoresInput.validateEmpty(
                        textControllerNombre2.text,
                        'Ingrese el nombre del acudiente#2',
                        '');
                  }),
              SizedBox(
                height: 8.0,
              ),
              Text(
                'Número del acudiente',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                height: 8.0,
              ),
              RoundedTextFieldValidators(
                  textFocusNode: textFocusNodeTel2,
                  textController: textControllerTel2,
                  textInputType: TextInputType.text,
                  isEditing: _isEditingTel2,
                  hintText: 'Ingrese el número del acudiente #2',
                  validate: () {
                    formularioExtra.numeroAcudiente2 = textControllerTel2.text;
                    return ValidadoresInput.validateEmpty(
                        textControllerTel2.text,
                        'Ingrese el número del acudiente#2',
                        '');
                  }),
              SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      height: 40.0,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(kPrimaryColor),
                        ),
                        onPressed: () {
                          validarInformacion();
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text("Siguiente",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.normal)),
                        ),
                      )),
                ],
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Future<void> validarInformacion() async {
    if (_resp != EscolaridadChar.unchecked &&
        _respCivil != CivilChar.unchecked &&
        _respEps != EpsChar.unchecked) {
      if (!estudiante &&
          !empleado &&
          !trabajadorIndependiente &&
          !desempleado &&
          !hogar &&
          !otra) {
      } else {
        formularioExtra.ocupacion = "";
        if (estudiante)
          formularioExtra.ocupacion = formularioExtra.ocupacion + "Estudiante,";
        if (empleado)
          formularioExtra.ocupacion = formularioExtra.ocupacion + "Empleado,";
        if (trabajadorIndependiente)
          formularioExtra.ocupacion =
              formularioExtra.ocupacion + "Trabajador Independiente,";
        if (desempleado)
          formularioExtra.ocupacion =
              formularioExtra.ocupacion + "Desempleado,";
        if (hogar)
          formularioExtra.ocupacion = formularioExtra.ocupacion + "Hogar,";
        if (otra && textControllerOtroOcupacion.text.isNotEmpty)
          formularioExtra.ocupacion = formularioExtra.ocupacion +
              textControllerOtroOcupacion.text +
              ",";
        if (_respEps == EpsChar.si) {
          if (_respSalud != SaludChar.unchecked) {
            if (textControllerSalud.text.isNotEmpty && eps == true) {
              formularioExtra.eps = textControllerSalud.text;
              formularioExtra.paciente = pacienteActual;
              await ProviderAprobacionPacientes.crearFormularioExtra(
                  formularioExtra);
              Navigator.pushNamed(context, VistaRegistroDocumentos.route);
            }
          }
        } else {
          if (pacienteActual == null) {
            print("DIE");
          }
          formularioExtra.paciente = pacienteActual;
          await ProviderAprobacionPacientes.crearFormularioExtra(
              formularioExtra);
          Navigator.pushNamed(context, VistaRegistroDocumentos.route);
        }
      }
    }
  }
}
