import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:satpj_front_end_web/src/constants.dart';
import 'package:satpj_front_end_web/src/model/paciente.dart';
import 'package:satpj_front_end_web/src/model/acudiente.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/validators/validadores-input.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_inicio.dart';
import 'package:satpj_front_end_web/src/utils/widgets/button-forms.dart';
import 'package:satpj_front_end_web/src/utils/widgets/dropdown.dart';
import 'package:satpj_front_end_web/src/utils/widgets/rounded_text_field.dart';
import 'package:satpj_front_end_web/src/utils/widgets/tema-formularios.dart';
import 'package:satpj_front_end_web/src/views/registro/vista_pre_registro_1.dart';
import 'package:satpj_front_end_web/src/views/registro/vista_pre_registro_3.dart';




class PreRegisterPage2 extends StatefulWidget {
  
  static const route = '/pre-registro-2';
 
  PreRegisterPage2();
    
  @override
  _PreRegisterPage2State createState() => _PreRegisterPage2State();
}

Paciente paciente = new Paciente();
Acudiente madre = new Acudiente();
Acudiente padre = new Acudiente();

class _PreRegisterPage2State extends State<PreRegisterPage2> {
 
  @override
  Widget build(BuildContext context) {
    
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    if (arguments != null){
        print('Holi');
        paciente = arguments['arguments'] as Paciente;
        print(paciente.nombre);
    } 

    return Scaffold(
        backgroundColor: kAccentColor,
        appBar: toolbarInicio(context),
        
        body: ListView(
          children: [
            Column(
              children: [
                Theme(
                    data: temaFormularios(),
                    child: Card(
                    margin: EdgeInsets.only(
                        right: 80.0, left: 80.0, top: 20.0, bottom: 20.0),
                    elevation: 25.0,
                    child: Container(
                      width: 850.0, 
                      padding: EdgeInsets.all(40.0),
                      child: RegisterForm()
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}

insertarAcudientes(){
  print('MADRE');
  print(madre);
    print('Padre');
  print(padre);
  if(madre != null && madre.nombre.isNotEmpty && madre.apellido.isNotEmpty &&
     madre.tipoDocumento.isNotEmpty && madre.documento.isNotEmpty &&
     madre.email.isNotEmpty && madre.telefono.isNotEmpty){
     paciente.acudientes.add(madre);
  }

   if(padre != null && padre.nombre.isNotEmpty && padre.apellido.isNotEmpty &&
     padre.tipoDocumento.isNotEmpty && padre.documento.isNotEmpty &&
     padre.email.isNotEmpty && padre.telefono.isNotEmpty){
     paciente.acudientes.add(padre);
  }
  
}

class RegisterForm extends StatefulWidget {
  @override
  RegisterFormState createState() {
    return RegisterFormState();
  }
}

class RegisterFormState extends State<RegisterForm> {
  
  final _formKey = GlobalKey<FormState>();
  
  //--------------Madre o Responsable--------------
  TextEditingController textControllerNombresMadre;
  FocusNode textFocusNodeNombresMadre;
  bool _isEditingNombresMadre = false;

  TextEditingController textControllerApellidosMadre;
  FocusNode textFocusNodeApellidosMadre;
  bool _isEditingApellidosMadre = false;

  TextEditingController textControllerTipoDocumentoMadre;

  TextEditingController textControllerDocumentoMadre;
  FocusNode textFocusNodeDocumentoMadre;
  bool _isEditingDocumentoMadre = false;

  TextEditingController textControllerEmailMadre;
  FocusNode textFocusNodeEmailMadre;
  bool _isEditingEmailMadre = false;

  TextEditingController textControllerTelefonoMadre;
  FocusNode textFocusNodeTelefonoMadre;
  bool _isEditingTelefonoMadre = false;

  //--------------Padre o Responsable--------------
  TextEditingController textControllerNombresPadre;
  FocusNode textFocusNodeNombresPadre;
  bool _isEditingNombresPadre = false;

  TextEditingController textControllerApellidosPadre;
  FocusNode textFocusNodeApellidosPadre;
  bool _isEditingApellidosPadre = false;

  TextEditingController textControllerTipoDocumentoPadre;

  TextEditingController textControllerDocumentoPadre;
  FocusNode textFocusNodeDocumentoPadre;
  bool _isEditingDocumentoPadre = false;

  TextEditingController textControllerEmailPadre;
  FocusNode textFocusNodeEmailPadre;
  bool _isEditingEmailPadre = false;

  TextEditingController textControllerTelefonoPadre;
  FocusNode textFocusNodeTelefonoPadre;
  bool _isEditingTelefonoPadre = false;
  
  @override
  void initState() {

    //--------------Madre o Responsable--------------
    textControllerNombresMadre = TextEditingController(text: null);
    textControllerApellidosMadre = TextEditingController(text: null);
    textControllerTipoDocumentoMadre = TextEditingController(text: null);
    textControllerDocumentoMadre = TextEditingController(text: null);
    textControllerEmailMadre = TextEditingController(text: null);
    textControllerTelefonoMadre = TextEditingController(text: null);

    textFocusNodeNombresMadre = FocusNode();
    textFocusNodeApellidosMadre = FocusNode();
    textFocusNodeDocumentoMadre = FocusNode();
    textFocusNodeEmailMadre = FocusNode();
    textFocusNodeTelefonoMadre = FocusNode();
    
    //--------------Padre o Responsable--------------
    textControllerNombresPadre = TextEditingController(text: null);
    textControllerApellidosPadre = TextEditingController(text: null);
    textControllerTipoDocumentoPadre = TextEditingController(text: null);
    textControllerDocumentoPadre = TextEditingController(text: null);
    textControllerEmailPadre = TextEditingController(text: null);
    textControllerTelefonoPadre = TextEditingController(text: null);

    textFocusNodeNombresPadre = FocusNode();
    textFocusNodeApellidosPadre = FocusNode();
    textFocusNodeDocumentoPadre = FocusNode();
    textFocusNodeEmailPadre = FocusNode();
    textFocusNodeTelefonoPadre = FocusNode();

    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    var stackMadre = Stack(
      children: [
        Container(
          height: 400,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 35.0, horizontal: 5.0),
          padding: EdgeInsets.only(left: 20.0, right:20.0, top:30.0,  bottom: 20.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: kPrimaryColor, width: 2.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nombre de la madre o responsable',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                height: 8.0,
              ),
              RoundedTextFieldValidators(
                textFocusNode: textFocusNodeNombresMadre,
                textController: textControllerNombresMadre,
                textInputType: TextInputType.text,
                isEditing: _isEditingNombresMadre,
                hintText: 'Nombre de la madre o responsable',
                validate: () {
                  madre.nombre = textControllerNombresMadre.text;
                  return ValidadoresInput.validateEmpty(
                      textControllerNombresMadre.text,
                      'Ingrese el nombre de la madre o responsable',
                      '');
              }),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Apellidos de la madre o responsable',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                height: 8.0,
              ),
              RoundedTextFieldValidators(
                textFocusNode: textFocusNodeApellidosMadre,
                textController: textControllerApellidosMadre,
                textInputType: TextInputType.text,
                isEditing: _isEditingApellidosMadre,
                hintText: 'Apellidos de la madre o responsable',
                validate: () {
                  madre.nombre = textControllerApellidosMadre.text;
                  return ValidadoresInput.validateEmpty(
                      textControllerApellidosMadre.text,
                      'Ingrese los apellidos de la madre o responsable',
                      '');
              }),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Tipo de documento',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                height: 8.0,
              ),
              Dropdown(
                textController: textControllerTipoDocumentoMadre,
                hintText: 'Tipo de documento',
                values: kTtipoDocumento,
                validate: () {
                  madre.tipoDocumento = textControllerTipoDocumentoMadre.text;
                  return ValidadoresInput.validateEmpty(textControllerTipoDocumentoMadre.text,
                      'Seleccione el tipo de documento de la madre o responsable', '');
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Número de documento',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                height: 8.0,
              ),
              RoundedTextFieldValidators(
              textFocusNode: textFocusNodeDocumentoMadre,
              textController: textControllerDocumentoMadre,
              textInputType: TextInputType.number,
              isEditing: _isEditingDocumentoMadre,
              formatter: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
              hintText: 'Ingrese el número de documento de la madre o responsable',
              validate: () {
                madre.documento = textControllerDocumentoMadre.text;
                return ValidadoresInput.validateEmpty(
                    textControllerDocumentoMadre.text,
                    'Debe ingresar el número de documento de la madre o responsable',
                    '');
              }),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Email',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                height: 8.0,
              ),
              RoundedTextFieldValidators(
              textFocusNode: textFocusNodeEmailMadre,
              textController: textControllerEmailMadre,
              textInputType: TextInputType.emailAddress,
              isEditing: _isEditingEmailMadre,
              hintText: 'Ingrese el correo electrónico de la madre o responsable',
              validate: () {
                madre.email= textControllerEmailMadre.text;
                return ValidadoresInput.validateEmail(
                    textControllerEmailMadre.text,
                    );
              }),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Télefono',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0),
                
              ),
              SizedBox(
                height: 8.0,
              ),
            RoundedTextFieldValidators(
            textFocusNode: textFocusNodeTelefonoMadre,
            textController: textControllerTelefonoMadre,
            textInputType: TextInputType.phone,
            isEditing: _isEditingTelefonoMadre,
            hintText: 'Ingrese el teléfono de la madre o responsable',
            validate: () {
              madre.telefono = textControllerTelefonoMadre.text;
              return ValidadoresInput.validateEmpty(
                  textControllerTelefonoMadre.text,
                  'Debe ingresar el número de teléfono de la madre o responsable',
                  ''
                   );
             }),
            ],
          ),
        ),
        Positioned(
          left: 10,
          top: 20,
          child: Container(
                    color: Colors.white, 
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      color: kPrimaryColor, 
                      child: Text('Información de la madre o responsable',
                       style: TextStyle(fontSize: 18.0, 
                               color: Colors.white, 
                               ),
                               ),
                    )
                    ),
        ),
      ],
    );
    
    var stackPadre = Stack(
      children: [
         Container(
          margin: EdgeInsets.symmetric(vertical: 35.0, horizontal: 5.0),
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: kPrimaryColor, width: 2.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nombre del padre o responsable',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                height: 8.0,
              ),
              RoundedTextFieldValidators(
                textFocusNode: textFocusNodeNombresPadre,
                textController: textControllerNombresPadre,
                textInputType: TextInputType.text,
                isEditing: _isEditingNombresPadre,
                hintText: 'Nombre del padre o responsable',
                validate: () {
                  padre.nombre = textControllerNombresPadre.text;
                  return null;
              }),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Apellidos del padre o responsable',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                height: 8.0,
              ),
              RoundedTextFieldValidators(
                textFocusNode: textFocusNodeApellidosPadre,
                textController: textControllerApellidosPadre,
                textInputType: TextInputType.text,
                isEditing: _isEditingApellidosPadre,
                hintText: 'Apellidos del padre o responsable',
                validate: () {
                  padre.nombre = textControllerApellidosPadre.text;
                  return ValidadoresInput.validateEmpty(
                      textControllerApellidosPadre.text,
                      'Ingrese los apellidos del padre o responsable',
                      '');
              }),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Tipo de documento',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                height: 8.0,
              ),
              Dropdown(
                textController: textControllerTipoDocumentoPadre,
                hintText: 'Tipo de documento',
                values: kTtipoDocumento,
                validate: () {
                  padre.tipoDocumento = textControllerTipoDocumentoPadre.text;
                  return ValidadoresInput.validateEmpty(textControllerTipoDocumentoPadre.text,
                      'Seleccione el tipo de documento del padre o responsable', '');
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Número de documento',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                height: 8.0,
              ),
              RoundedTextFieldValidators(
              textFocusNode: textFocusNodeDocumentoPadre,
              textController: textControllerDocumentoPadre,
              textInputType: TextInputType.number,
              isEditing: _isEditingDocumentoPadre,
              formatter: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
              hintText: 'Ingrese el número de documento del padre o responsable',
              validate: () {
                padre.documento = textControllerDocumentoPadre.text;
                return ValidadoresInput.validateEmpty(
                    textControllerDocumentoPadre.text,
                    'Debe ingresar el número de documento del padre o responsable',
                    '');
              }),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Email',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                height: 8.0,
              ),
              RoundedTextFieldValidators(
              textFocusNode: textFocusNodeEmailPadre,
              textController: textControllerEmailPadre,
              textInputType: TextInputType.emailAddress,
              isEditing: _isEditingEmailPadre,
              hintText: 'Ingrese el correo electrónico del padre o responsable',
              validate: () {
                padre.email= textControllerEmailPadre.text;
                return ValidadoresInput.validateEmail(
                    textControllerEmailPadre.text,
                    );
              }),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Télefono',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0),
                
              ),
              SizedBox(
                height: 8.0,
              ),
            RoundedTextFieldValidators(
            textFocusNode: textFocusNodeTelefonoPadre,
            textController: textControllerTelefonoPadre,
            textInputType: TextInputType.phone,
            isEditing: _isEditingTelefonoPadre,
            hintText: 'Ingrese el teléfono del padre o responsable',
            validate: () {
              padre.telefono = textControllerTelefonoPadre.text;
              return ValidadoresInput.validateEmpty(
                  textControllerTelefonoPadre.text,
                  'Debe ingresar el número de teléfono del padre o responsable',
                  ''
                   );
             }),
            ],
          ),
        ),
        Positioned(
          left: 12,
          top: 20,
          child: Container(
                    color: Colors.white, 
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      color: kPrimaryColor, 
                      child: Text('Información del padre o responsable',
                       style: TextStyle(fontSize: 18.0, 
                               color: Colors.white, 
                               ),
                               ),
                    )
                    ),
        ),
      ],
    );

    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: 
          [
          stackMadre,
          SizedBox(
            height: 10.0,
          ),
          stackPadre,
          SizedBox(
            height: 20.0,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 126.0,
                  height: 40.0,
                  child: ButtonForms(
                    formKey: _formKey,
                    label: 'Atras',
                    color: Colors.grey[600],
                    route: PreRegisterPage1.route,
                  ),
                ),
                Container(
                  height: 40.0,
                  child: ButtonForms(
                    formKey: _formKey,
                    label: 'Siguiente',
                    color: kPrimaryColor,
                    route: PreRegisterPage3.route,
                    arguments: (){
                      insertarAcudientes();
                      return paciente;
                    },
                  ),
                ),
              ],
            ),

        ]));
  }
}

/*RoundedTextField(
                          hintText: 'Ingrese su número de documento',
                          type: TextInputType.number, 
                          formatter: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                          onChangedF: () async {
                                  await showDatePicker(
                                        context: context,
                                        initialDate: DateTime(2020, 11, 17),
                                        firstDate: DateTime(2017, 1),
                                        lastDate: DateTime(2022, 7),
                                        helpText: 'Select a date',
                                  );
                          },
                    
                 )*/
