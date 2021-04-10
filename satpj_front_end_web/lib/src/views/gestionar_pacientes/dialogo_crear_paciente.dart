import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/constants.dart';
import 'package:satpj_front_end_web/src/model/acudiente/acudiente.dart';
import 'package:satpj_front_end_web/src/model/formulario/formulario.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/validators/validadores-input.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/fotter_dialog.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/header_dialog.dart';
import 'dart:typed_data';
import 'package:satpj_front_end_web/src/utils/widgets/Firmas/pad_firmas.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/formulario_paciente.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/formulario_usuario.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/tema_formularios.dart';
import 'package:satpj_front_end_web/src/utils/widgets/inputs/rounded_text_field.dart';

final PageController pageCtrlr = new PageController();
int currentContainer = 0;
final int numberOfContainers = 5;

void changeContainer(int container) {
  if (currentContainer + container > numberOfContainers - 1) return;

  if (container < 1) {
    pageCtrlr.animateToPage(
      currentContainer - container,
      duration: Duration(milliseconds: 350),
      curve: Curves.linear,
    );
  }
  
  pageCtrlr.animateToPage(
      currentContainer + container,
      duration: Duration(milliseconds: 350),
      curve: Curves.linear,
  );

}

class DialogoCrearPaciente extends StatefulWidget {
  @override
  DialogoCrearPacienteState createState() {
    return DialogoCrearPacienteState();
  }
}

Paciente paciente;

class DialogoCrearPacienteState extends State<DialogoCrearPaciente> {
  @override
  void initState() {
    paciente = new Paciente();
    paciente.acudientes = [];
    super.initState();
  }

  @override
  void dispose() {
    pageCtrlr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: Text("Subir"),
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
                        PrimeraPaginaCrearPaciente(),
                        SegundaPaginaCrearPaciente(),
                        TerceraPaginaCrearPaciente(),
                        CuartaPaginaCrearPaciente(),
                        QuintaPaginaConsentimientoPrincipal()
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

class PrimeraPaginaCrearPaciente extends StatefulWidget {
  PrimeraPaginaCrearPaciente();

  @override
  _PrimeraPaginaCrearPacienteState createState() =>
      _PrimeraPaginaCrearPacienteState();
}

class _PrimeraPaginaCrearPacienteState
    extends State<PrimeraPaginaCrearPaciente> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

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
                  label: 'Crear Paciente',
                  height: 55.0,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40.0),
                  child: FormPatientInformation(
                    paciente: paciente,
                    prefix: 'el',
                    label: 'del paciente',
                    fechaNacimiento: true,
                    stack: false,
                  ),
                ),
              ],
            ),
            FotterDialog(
              labelConfirmBtn: 'Siguiente',
              colorConfirmBtn: kPrimaryColor,
              formKey: _formKey,
              paginator: true,
              functionConfirmBtn: () {
                changeContainer(!paciente.esAdulto() ? 3 : 1);
              },
              width: 120.0,
            ),
          ]),
        ),
      ),
    );
  }
}

class SegundaPaginaCrearPaciente extends StatefulWidget {
  SegundaPaginaCrearPaciente();

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
                      fechaNacimiento: true,
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

class TerceraPaginaCrearPaciente extends StatefulWidget {
  TerceraPaginaCrearPaciente();

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
                            fechaNacimiento: true,
                            requerido: false,
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

class CuartaPaginaCrearPaciente extends StatefulWidget {
  CuartaPaginaCrearPaciente();

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
    paciente.remitido = false;
    paciente.estadoAprobado = 'PendienteAprobacion';

    formularioPreRegistro = new Formulario();
    formularioPreRegistro.fueAtendido = false;

    textControllerInstitucionRemision = TextEditingController(text: null);
    textControllerMotivo = TextEditingController(text: null);
    textControllerInstitucionAtencion = TextEditingController(text: null);
    textControllerNombreInstitucion = TextEditingController(text: null);

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
                    label: 'Crear Paciente',
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
                                          paciente.remitido = false;
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
                                      value: paciente.remitido,
                                      activeColor: kPrimaryColor,
                                      onChanged: (bool value) {
                                        setState(() {
                                          paciente.remitido = value;
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
                                children: paciente.remitido
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
                      currentContainer = 0;
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Guardando Información')));
                    },
                    width: 120.0,
                  ),
                ]))));
  }
}

class QuintaPaginaConsentimientoPrincipal extends StatefulWidget {
  @override
  QuintaPaginaConsentimientoPrincipalState createState() {
    return QuintaPaginaConsentimientoPrincipalState();
  }
}

class QuintaPaginaConsentimientoPrincipalState
    extends State<QuintaPaginaConsentimientoPrincipal> {
  Uint8List _signatureData;
  bool _isSigned = false;

  callBack(Uint8List _signatureData, bool _isSigned) {
    this._signatureData = _signatureData;
    this._isSigned = _isSigned;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox.shrink(),
                IconButton(
                    icon: Icon(
                      Icons.cancel,
                      color: kPrimaryColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            ),
            Text(
              "Firma",
              textAlign: TextAlign.center,
              style: TextStyle(color: kPrimaryColor, fontSize: 25),
            ),
            SizedBox(width: 50),
            PadFirmas(callBack),
            SizedBox(width: 50),
            Container(
              height: 50,
              width: 235,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Material(
                borderRadius: BorderRadius.circular(30),
                color: kPrimaryColor,
                child: MaterialButton(
                  onPressed: () {
                    currentContainer = 0;
                    print(_isSigned);
                    print(_signatureData);
                    if (_isSigned) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Processing Data')));
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Text(
                        "Completar",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  void completarConsentimientoPrincipal() {}
}

class InfoPacientePrincipal {
  String nombre;
  String edad;
  String fecha;
  String cedula;
  List<String> respuestas = [];
  Uint8List _signatureData;

  InfoPacientePrincipal(this.nombre, this.edad, this.fecha, this.cedula,
      this.respuestas, this._signatureData);
}

/*
final PageController pageCtrlr = new PageController();
int currentContainer = 0;
bool _success = true;
final int numberOfContainers = 4;

Paciente paciente = new Paciente();

void changeContainer() {
  if (currentContainer + 1 > numberOfContainers - 1) return;

  pageCtrlr.animateToPage(
    currentContainer + 1,
    duration: Duration(milliseconds: 750), curve: Curves.linear,
    // you can change the duration of the animation and curve
  );
}

class DialogoCrearPaciente extends StatefulWidget {
   
  DialogoCrearPaciente({Paciente pacienteNuevo}) {
    paciente = pacienteNuevo ;
  }

  @override
  DialogoCrearPacienteState createState() {
    return DialogoCrearPacienteState();
  }
}

class DialogoCrearPacienteState extends State<DialogoCrearPaciente> {
  
  @override
  void dispose() {
    pageCtrlr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: Text("Subir"),
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
                    height: 500,
                    width: 700,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: PageView(
                      controller:
                          pageCtrlr, // assign your page controller to the page view
                      physics:
                          NeverScrollableScrollPhysics(), // disables scrolling
                      children: [
                       FormularioCrearPaciente(paciente: paciente),
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

class FormularioCrearPaciente extends StatefulWidget {
  
  Paciente paciente = new Paciente();

  FormularioCrearPaciente({this.paciente});

  @override
  _FormularioCrearPacienteState createState() => _FormularioCrearPacienteState();
}

class _FormularioCrearPacienteState extends State<FormularioCrearPaciente> {
 
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();  
  
  @override
  Widget build(BuildContext context) {
    return Material(
          child: Theme(
          data: temaFormularios(),  
          child: 
          Container(
            width: 700.0,
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                    Container(
                      height: 55.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(4.1)),
                        color: kPrimaryColor,
                      ),
                      margin: EdgeInsets.only(bottom: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text('Crear Paciente',
                             textAlign: TextAlign.left,
                             style: TextStyle(fontSize: 20.0, color: Colors.white),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.white),
                            onPressed: (){
                              Navigator.pop(context, widget.paciente);
                            },
                      ),
                        ],
                    )),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 40.0),
                      child: 
                        FormPatientInformation(
                        paciente: widget.paciente,
                        prefix: 'el',
                        label: 'del paciente',
                        fechaNacimiento: true,
                        stack: false,
                        ),
                    ),
                   ],
                  ),
                   Divider(
                      color: Colors.grey[400],
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 18.0, top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: 
                        [ 
                          Container(
                            width: 120.0,
                            height: 35.0,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    Colors.grey[600]),
                              ),
                              onPressed: () {
                                 Navigator.pop(context);
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: Text('Cancelar',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.normal)),
                              ),
                            ),
                          ),
                          SizedBox(width: 8.0,),
                          Container(
                            width: 120.0,
                            height: 35.0,
                            child: ButtonForms(
                              formKey: _formKey,
                              label: 'Crear',
                              color: kPrimaryColor,
                            ),
                          ),
                        ],
                    )),
               ]
              ),
            ),
          ),
      ),
    );
  }
}
*/
/*Scaffold(
        backgroundColor: Colors.grey[300],
        body: ListView(
          children: [
            Column(
              children: [
                Card(
                  margin: EdgeInsets.only(
                      right: 100.0, left: 100.0, top: 20.0, bottom: 20.0),
                  elevation: 25.0,
                  child: Column(
                    children: [
                      Container(
                          padding: EdgeInsets.all(40.0),
                          width: 900,
                          child: FormPersonalInformation(
                            paciente: widget.paciente,
                            prefix: 'el',
                            label: 'del paciente',
                            stack: false,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));*/
