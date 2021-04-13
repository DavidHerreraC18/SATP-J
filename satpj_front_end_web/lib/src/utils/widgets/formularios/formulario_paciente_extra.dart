import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/validators/validadores-input.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/container_stack.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/formulario_usuario.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/tema_formularios.dart';
import 'package:satpj_front_end_web/src/utils/widgets/inputs/rounded_text_field.dart';

import '../../../constants.dart';
import '../inputs/dropdown.dart';

class FormPatientExtraInformation extends StatefulWidget {
  final Paciente paciente;
  final bool stack;
  final bool enabled;

  FormPatientExtraInformation({
    this.paciente,
    this.stack = true,
    this.enabled = true,
  });

  @override
  _FormState createState() => _FormState();
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
  otro
}

enum CivilChar { soltero, casado, union_libre, separado, viudo }

enum EpsChar {
  si,
  no,
}

enum SaludChar {
  cotizante,
  beneficiario,
}

class _FormState extends State<FormPatientExtraInformation> {
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

  EscolaridadChar _resp;
  SaludChar _respSalud;
  CivilChar _respCivil;
  EpsChar _respEps;
  bool eps = false;

  bool estudiante;
  bool empleado;
  bool trabajadorIndependiente;
  bool desempleado;
  bool hogar;
  bool otra;

  @override
  void initState() {
    textControllerInsti = TextEditingController(text: null);
    textFocusNodeInsti = FocusNode();

    textControllerSalud = TextEditingController(text: null);
    textFocusNodeSalud = FocusNode();

    textControllerNombre1 = TextEditingController(text: null);
    textFocusNodeNombre1 = FocusNode();

    textControllerNombre2 = TextEditingController(text: null);
    textFocusNodeNombre2 = FocusNode();

    textControllerTel1 = TextEditingController(text: null);
    textFocusNodeTel1 = FocusNode();

    textControllerTel2 = TextEditingController(text: null);
    textFocusNodeTel2 = FocusNode();

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
                children: <ListTile>[
                  ListTile(
                    title: const Text('Ninguna'),
                    leading: Radio<EscolaridadChar>(
                      value: EscolaridadChar.ninguna,
                      groupValue: _resp,
                      onChanged: (EscolaridadChar value) {
                        setState(() {
                          _resp = value;
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
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                'Ocupación',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0),
              ),
              Column(children: <ListTile>[
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
              ]),
              SizedBox(
                height: 8.0,
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
                    return null;
                  }),
              SizedBox(
                height: 8.0,
              ),
              Text(
                'Estado Civil',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                height: 8.0,
              ),
              Column(children: <ListTile>[
                ListTile(
                  title: const Text('Soltero(a)'),
                  leading: Radio<CivilChar>(
                    value: CivilChar.soltero,
                    groupValue: _respCivil,
                    onChanged: (CivilChar value) {
                      setState(() {
                        _respCivil = value;
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
                      });
                    },
                  ),
                ),
              ]),
              SizedBox(
                height: 8.0,
              ),
              Text(
                'Servicio de salud',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                height: 8.0,
              ),
              Column(children: <ListTile>[
                ListTile(
                  title: const Text('Si'),
                  leading: Radio<EpsChar>(
                    value: EpsChar.si,
                    groupValue: _respEps,
                    onChanged: (EpsChar value) {
                      setState(() {
                        _respEps = value;
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
                        eps = false;
                      });
                    },
                  ),
                ),
              ]),
              eps
                  ? Text(
                      '¿Cuál es su EPS?',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 18.0),
                    )
                  : [],
              eps
                  ? SizedBox(
                      height: 8.0,
                    )
                  : [],
              eps
                  ? RoundedTextFieldValidators(
                      textFocusNode: textFocusNodeSalud,
                      textController: textControllerSalud,
                      textInputType: TextInputType.text,
                      isEditing: _isEditingSalud,
                      hintText: 'Ingrese su EPS',
                      validate: () {
                        return null;
                      })
                  : [],
              eps
                  ? SizedBox(
                      height: 8.0,
                    )
                  : [],
              eps
                  ? Text(
                      'Tipo de Vinculación',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 18.0),
                    )
                  : [],
              eps
                  ? SizedBox(
                      height: 8.0,
                    )
                  : [],
              eps
                  ? Column(children: <ListTile>[
                      ListTile(
                        title: const Text('Cotizante'),
                        leading: Radio<SaludChar>(
                          value: SaludChar.cotizante,
                          groupValue: _respSalud,
                          onChanged: (SaludChar value) {
                            setState(() {
                              _respSalud = value;
                              eps = true;
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
                              eps = true;
                            });
                          },
                        ),
                      ),
                    ])
                  : [],
              Text(
                '¿Cómo se enteró del servicio de Consultores en Psicología?',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                height: 8.0,
              ),
              RoundedTextFieldValidators(
                  textFocusNode: textFocusNodeSalud,
                  textController: textControllerSalud,
                  textInputType: TextInputType.text,
                  isEditing: _isEditingSalud,
                  hintText: 'Ingrese su respuesta',
                  validate: () {
                    return null;
                  }),
              SizedBox(
                height: 8.0,
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
                    return null;
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
                    return null;
                  }),
              SizedBox(
                height: 8.0,
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
                    return null;
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
                    return null;
                  }),
              SizedBox(
                height: 8.0,
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
