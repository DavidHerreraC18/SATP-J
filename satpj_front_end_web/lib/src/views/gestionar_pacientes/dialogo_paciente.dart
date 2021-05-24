import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/constants.dart';
import 'package:satpj_front_end_web/src/model/acudiente/acudiente.dart';
import 'package:satpj_front_end_web/src/model/formulario/formulario.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/providers/provider_administracion_pacientes.dart';
import 'package:satpj_front_end_web/src/providers/provider_pre_registro.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/validators/validadores-input.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/fotter_dialog.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/header_dialog.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/formulario_paciente.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/formulario_usuario.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/tema_formularios.dart';
import 'package:satpj_front_end_web/src/utils/widgets/inputs/rounded_text_field.dart';
import 'package:satpj_front_end_web/src/views/gestionar_pacientes/vista_administrar_pacientes.dart';

final PageController pageCtrlr = new PageController();
int currentContainer = 0;
final int numberOfContainers = 4;

void changeContainer(int container) {
  if (currentContainer + container > numberOfContainers - 1) return;

  pageCtrlr.animateToPage(
    currentContainer + container,
    duration: Duration(milliseconds: 350),
    curve: Curves.linear,
  );
}

// ignore: must_be_immutable
class DialogoPaciente extends StatefulWidget {
  Paciente paciente;
  Formulario formulario;
  IconData icon;
  bool enabled;
  bool fechaNacimiento;
  String labelButton;
  String labelHeader;

  DialogoPaciente(
      {this.paciente,
      this.icon,
      this.enabled = true,
      this.fechaNacimiento = true,
      this.labelButton,
      this.labelHeader}) {
    if (this.paciente == null) this.paciente = new Paciente();
  }

  @override
  DialogoPacienteState createState() {
    return DialogoPacienteState();
  }
}

class DialogoPacienteState extends State<DialogoPaciente> {
  @override
  void dispose() {
    pageCtrlr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(widget.icon, color: kPrimaryColor),
        onPressed: () {
          showGeneralDialog(
              barrierLabel: 'label',
              barrierDismissible: true,
              barrierColor: Colors.black.withOpacity(0.5),
              transitionDuration: Duration(milliseconds: 300),
              context: context,
              transitionBuilder: (context, anim1, anim2, child) {
                return SlideTransition(
                  position: Tween(begin: Offset(0, 1), end: Offset(0, 0))
                      .animate(anim1),
                  child: child,
                );
              },
              pageBuilder: (context, anim1, anim2) {
                return Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 600,
                    width: 800,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: PageView(
                      controller: pageCtrlr,
                      physics:
                          NeverScrollableScrollPhysics(), // disables scrolling
                      children: [
                        PrimeraPaginaCrearPaciente(
                          paciente: widget.paciente,
                          enabled: widget.enabled,
                          fechaNacimiento: widget.fechaNacimiento,
                          labelHeader: widget.labelHeader,
                        ),
                        SegundaPaginaCrearPaciente(
                          paciente: widget.paciente,
                          enabled: widget.enabled,
                          fechaNacimiento: false,
                        ),
                        TerceraPaginaCrearPaciente(
                          paciente: widget.paciente,
                          enabled: widget.enabled,
                          fechaNacimiento: false,
                        ),
                        CuartaPaginaCrearPaciente(
                          paciente: widget.paciente,
                          labelButton: widget.labelButton,
                          enabled: widget.enabled,
                          labelHeader: widget.labelHeader,
                        ),
                      ],
                      onPageChanged: (int index) =>
                          setState(() => currentContainer = index),
                    ),
                  ),
                );
              });
        });
  }
}

// ignore: must_be_immutable
class PrimeraPaginaCrearPaciente extends StatefulWidget {
  Paciente paciente;
  bool enabled;
  bool fechaNacimiento;
  String labelHeader;

  PrimeraPaginaCrearPaciente(
      {this.paciente,
      this.enabled = true,
      this.fechaNacimiento,
      this.labelHeader}) {
    if (paciente == null) paciente = new Paciente();
  }

  @override
  _PrimeraPaginaCrearPacienteState createState() =>
      _PrimeraPaginaCrearPacienteState();
}

class _PrimeraPaginaCrearPacienteState
    extends State<PrimeraPaginaCrearPaciente> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Theme(
        data: temaFormularios(),
        child: Form(
          key: _formKey,
          child: ListView(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                HeaderDialog(
                  label: widget.labelHeader + ' Paciente',
                  height: 55.0,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40.0),
                  child: FormPatientInformation(
                      paciente: widget.paciente,
                      prefix: 'el',
                      label: 'del paciente',
                      fechaNacimiento: widget.fechaNacimiento,
                      stack: false,
                      enabled: widget.enabled),
                ),
              ],
            ),
            widget.labelHeader == 'Crear'
                ? FotterDialog(
                    labelConfirmBtn: 'Siguiente',
                    colorConfirmBtn: kPrimaryColor,
                    formKey: _formKey,
                    paginator: true,
                    functionConfirmBtn: () {
                      changeContainer(
                          widget.paciente.esAdulto() == true ? 3 : 1);
                    },
                    width: 120.0,
                  )
                : Text(''),
            widget.labelHeader == 'Editar'
                ? FotterDialog(
                    labelConfirmBtn: 'Editar',
                    colorConfirmBtn: kPrimaryColor,
                    formKey: _formKey,
                    paginator: true,
                    functionConfirmBtn: () {
                      ProviderAdministracionPacientes.editarPaciente(
                          widget.paciente);
                      Future.delayed(Duration(milliseconds: 1000), () {
                        Navigator.of(context)
                            .pushNamed(VistaAdministrarPacientes.route);
                      });
                    },
                    width: 120.0,
                  )
                : Text(''),
          ]),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class SegundaPaginaCrearPaciente extends StatefulWidget {
  Paciente paciente;
  bool enabled;
  bool fechaNacimiento;

  SegundaPaginaCrearPaciente(
      {this.paciente, this.enabled = true, this.fechaNacimiento}) {
    if (paciente == null) paciente = new Paciente();
  }

  @override
  _SegundaPaginaCrearPacienteState createState() =>
      _SegundaPaginaCrearPacienteState();
}

class _SegundaPaginaCrearPacienteState
    extends State<SegundaPaginaCrearPaciente> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  Acudiente madre;

  @override
  void initState() {
    madre = new Acudiente();

    if (widget.paciente.acudientes != null) {
      if (widget.paciente.acudientes.isNotEmpty) {
        madre = widget.paciente.acudientes.first;
      }
    } else {
      widget.paciente.acudientes = [];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Theme(
        data: temaFormularios(),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(80),
          ),
          width: 700.0,
          child: Form(
            key: _formKey,
            child: ListView(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  HeaderDialog(
                    label: 'Información de la madre o responsable',
                    height: 55.0,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 40.0),
                    child: FormUserPersonalInformation(
                      usuario: madre,
                      prefix: 'el',
                      label: 'de la madre o responsable',
                      fechaNacimiento: widget.fechaNacimiento,
                      enabled: widget.enabled,
                    ),
                  ),
                ],
              ),
              FotterDialog(
                labelCancelBtn: 'Atrás',
                labelConfirmBtn: 'Siguiente',
                colorConfirmBtn: kPrimaryColor,
                formKey: _formKey,
                paginator: true,
                functionCancelBtn: () {
                  changeContainer(-1);
                },
                functionConfirmBtn: () {
                  widget.paciente.acudientes.add(madre);
                  changeContainer(1);
                },
                width: 120.0,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class TerceraPaginaCrearPaciente extends StatefulWidget {
  Paciente paciente;
  bool enabled;
  bool fechaNacimiento;

  TerceraPaginaCrearPaciente(
      {this.paciente, this.enabled = true, this.fechaNacimiento}) {
    if (paciente == null) paciente = new Paciente();
  }

  @override
  _TerceraPaginaCrearPacienteState createState() =>
      _TerceraPaginaCrearPacienteState();
}

class _TerceraPaginaCrearPacienteState
    extends State<TerceraPaginaCrearPaciente> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  Acudiente padre;

  @override
  void initState() {
    padre = new Acudiente();

    if (widget.paciente.acudientes == null) {
      widget.paciente.acudientes = [];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: Theme(
            data: temaFormularios(),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(80),
              ),
              width: 700.0,
              child: Form(
                key: _formKey,
                child: ListView(children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        HeaderDialog(
                          label: 'Información del padre o responsable',
                          height: 55.0,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 40.0),
                          child: FormUserPersonalInformation(
                            usuario: padre,
                            prefix: 'el',
                            label: 'del padre o responsable',
                            fechaNacimiento: widget.fechaNacimiento,
                            requerido: false,
                            enabled: widget.enabled,
                          ),
                        ),
                        FotterDialog(
                          labelCancelBtn: 'Atrás',
                          labelConfirmBtn: 'Siguiente',
                          colorConfirmBtn: kPrimaryColor,
                          formKey: _formKey,
                          paginator: true,
                          functionCancelBtn: () {
                            changeContainer(-1);
                          },
                          functionConfirmBtn: () {
                            if (padre.documento != null && padre.email != null)
                              widget.paciente.acudientes.add(padre);
                            changeContainer(1);
                          },
                          width: 120.0,
                        ),
                      ]),
                ]),
              ),
            )));
  }
}

// ignore: must_be_immutable
class CuartaPaginaCrearPaciente extends StatefulWidget {
  Paciente paciente;
  Formulario formularioPreRegistro;
  bool enabled;
  String labelButton;
  String labelHeader;

  CuartaPaginaCrearPaciente(
      {this.paciente,
      this.enabled = true,
      this.labelButton,
      this.labelHeader,
      this.formularioPreRegistro}) {
    if (paciente == null) paciente = new Paciente();
  }

  @override
  _CuartaPaginaCrearPacienteState createState() =>
      _CuartaPaginaCrearPacienteState();
}

class _CuartaPaginaCrearPacienteState extends State<CuartaPaginaCrearPaciente> {
  Formulario formularioPreRegistro;

  TextEditingController textControllerInstitucionRemision;

  TextEditingController textControllerNombreInstitucion;
  FocusNode textFocusNodeNombreInstitucion;
  bool _isEditingNombreInstitucion = false;

  TextEditingController textControllerMotivo;
  FocusNode textFocusNodeMotivo;
  bool _isEditingMotivo = false;

  TextEditingController textControllerInstitucionAtencion;
  FocusNode textFocusNodeInstitucionAtencion;
  bool _isEditingInstitucionAtencion = false;

  bool decisionPropia = false;
  bool cualRemision = false;
  bool atendidoNo = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    formularioPreRegistro = new Formulario();
    formularioPreRegistro.fueAtendido = false;
    widget.paciente.remitido = false;
    widget.paciente.estadoAprobado = 'PendienteAprobacion';

    textControllerInstitucionRemision =
        TextEditingController(text: formularioPreRegistro.remitente);
    textControllerMotivo =
        TextEditingController(text: formularioPreRegistro.motivoConsulta);
    textControllerInstitucionAtencion =
        TextEditingController(text: formularioPreRegistro.lugarAtencion);
    textControllerNombreInstitucion =
        TextEditingController(text: formularioPreRegistro.lugarAtencion);

    textFocusNodeMotivo = FocusNode();
    textFocusNodeInstitucionAtencion = FocusNode();
    textFocusNodeNombreInstitucion = FocusNode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: Theme(
            data: temaFormularios(),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                width: 700.0,
                child: ListView(children: [
                  HeaderDialog(
                    label: widget.labelHeader + ' Paciente',
                    height: 55.0,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 40.0),
                    child: Form(
                        key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Solicita la atención psicológica por:',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 18.0),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                      value: decisionPropia,
                                      activeColor: kPrimaryColor,
                                      onChanged: (bool value) {
                                        setState(() {
                                          decisionPropia = value;
                                          widget.paciente.remitido = false;
                                          cualRemision = false;
                                        });
                                      }),
                                  Text(
                                    'Decisión propia',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                      value: widget.paciente.remitido,
                                      activeColor: kPrimaryColor,
                                      onChanged: (bool value) {
                                        setState(() {
                                          widget.paciente.remitido = value;
                                          decisionPropia = false;
                                          cualRemision = false;
                                        });
                                      }),
                                  Text(
                                    'Remitido',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: widget.paciente.remitido
                                    ? [
                                        SizedBox(height: 8.0),
                                        Text(
                                          'Fue remitido por:',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(fontSize: 18.0),
                                        ),
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                        DropdownButtonFormField<String>(
                                          iconSize: 24,
                                          elevation: 16,
                                          hint: Text('Instituciones'),
                                          decoration: inputDecoration(),
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 17.0,
                                              fontFamily: 'Dubai'),
                                          items: kInstituciones
                                              .map((value) => DropdownMenuItem(
                                                    value: value,
                                                    child: Text(
                                                      value,
                                                      style: TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 16.5,
                                                          fontFamily: 'Dubai'),
                                                    ),
                                                  ))
                                              .toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              textControllerInstitucionRemision
                                                  .text = value;
                                              formularioPreRegistro.remitente =
                                                  value;
                                              if (textControllerInstitucionRemision
                                                      .text ==
                                                  'Otra') {
                                                cualRemision = true;
                                                formularioPreRegistro
                                                    .remitente = '';
                                              }
                                            });
                                          },
                                          validator: (value) => value == null
                                              ? ValidadoresInput.validateEmpty(
                                                  textControllerInstitucionRemision
                                                      .text,
                                                  'Seleccione una institución',
                                                  '')
                                              : null,
                                        ),
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                      ]
                                    : [],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: cualRemision
                                    ? [
                                        Text(
                                          'Indique el nombre de la institución de donde fue remitido:',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(fontSize: 18.0),
                                        ),
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                        RoundedTextFieldValidators(
                                            textFocusNode:
                                                textFocusNodeNombreInstitucion,
                                            textController:
                                                textControllerNombreInstitucion,
                                            textInputType: TextInputType.text,
                                            isEditing:
                                                _isEditingNombreInstitucion,
                                            hintText: 'Institución de remisión',
                                            validate: () {
                                              formularioPreRegistro.remitente =
                                                  textControllerNombreInstitucion
                                                      .text;
                                              if (cualRemision) {
                                                return ValidadoresInput.validateEmpty(
                                                    textControllerNombreInstitucion
                                                        .text,
                                                    'Debe ingresar el nombre de la institución de donde fue remitido',
                                                    '');
                                              }
                                              return null;
                                            }),
                                      ]
                                    : [],
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                'Motivo de la consulta:',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 18.0),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              RoundedTextFieldValidators(
                                  textFocusNode: textFocusNodeMotivo,
                                  textController: textControllerMotivo,
                                  textInputType: TextInputType.text,
                                  isEditing: _isEditingMotivo,
                                  hintText: 'Motivo de la consulta',
                                  validate: () {
                                    formularioPreRegistro.motivoConsulta =
                                        textControllerMotivo.text;
                                    return ValidadoresInput.validateEmpty(
                                        textControllerMotivo.text,
                                        'Debe ingresar el Motivo de la consulta',
                                        '');
                                  }),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                'Anteriormente ha recibido atención por psicológia o psiquiatría:',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 18.0),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                      value: formularioPreRegistro.fueAtendido,
                                      activeColor: kPrimaryColor,
                                      onChanged: (bool value) {
                                        setState(() {
                                          formularioPreRegistro.fueAtendido =
                                              value;
                                          atendidoNo = false;
                                        });
                                      }),
                                  Text(
                                    'Sí',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: formularioPreRegistro.fueAtendido
                                    ? [
                                        Text(
                                          '¿Dónde recibió la atención médica?',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(fontSize: 18.0),
                                        ),
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                        RoundedTextFieldValidators(
                                            textFocusNode:
                                                textFocusNodeInstitucionAtencion,
                                            textController:
                                                textControllerInstitucionAtencion,
                                            textInputType: TextInputType.text,
                                            isEditing:
                                                _isEditingInstitucionAtencion,
                                            hintText:
                                                'Institución donde recibio atención psicológica',
                                            validate: () {
                                              formularioPreRegistro
                                                      .lugarAtencion =
                                                  textControllerInstitucionAtencion
                                                      .text;
                                              if (formularioPreRegistro
                                                  .fueAtendido) {
                                                return ValidadoresInput.validateEmpty(
                                                    textControllerInstitucionAtencion
                                                        .text,
                                                    'Ingrese el nombre de la institución donde recibio atención psicológica',
                                                    '');
                                              }
                                              return null;
                                            }),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                      ]
                                    : [],
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                      value: atendidoNo,
                                      activeColor: kPrimaryColor,
                                      onChanged: (bool newValue) {
                                        setState(() {
                                          atendidoNo = newValue;
                                          formularioPreRegistro.fueAtendido =
                                              false;
                                        });
                                      }),
                                  Text(
                                    'No',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                            ])),
                  ),
                  widget.enabled
                      ? FotterDialog(
                          labelCancelBtn: 'Atrás',
                          labelConfirmBtn: widget.labelButton,
                          colorConfirmBtn: kPrimaryColor,
                          formKey: _formKey,
                          paginator: true,
                          functionCancelBtn: () {
                            changeContainer(-1);
                          },
                          functionConfirmBtn: () {
                            if (widget.labelHeader == 'Crear') {
                              ProviderPreRegistro.crearFormularioIndividual(
                                  formularioPreRegistro, widget.paciente);
                              Future.delayed(Duration(milliseconds: 1000), () {
                                Navigator.of(context)
                                    .pushNamed(VistaAdministrarPacientes.route);
                              });
                            }
                            if (widget.labelHeader == 'Editar') {
                              ProviderPreRegistro.editarFormularioIndividual(
                                  formularioPreRegistro, widget.paciente);
                            }
                            currentContainer = 0;
                          },
                          width: 120.0,
                        )
                      : FotterDialog(
                          labelCancelBtn: 'Atrás',
                          paginator: true,
                          width: 120.0,
                        ),
                ]))));
  }
}
