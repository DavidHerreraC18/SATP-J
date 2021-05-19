import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';
import 'package:satpj_front_end_web/src/model/acudiente/acudiente.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_inicio.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_inicio_registro.dart';
import 'package:satpj_front_end_web/src/utils/widgets/botones/button_forms.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/container_stack.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/formulario_usuario.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/tema_formularios.dart';
import 'package:satpj_front_end_web/src/views/registro/vista_pre_registro.dart';
import 'package:satpj_front_end_web/src/views/registro/vista_pre_registro_3.dart';

class PreRegisterPage2 extends StatefulWidget {
  static const route = '/pre-registro-2';

  PreRegisterPage2();

  @override
  _PreRegisterPage2State createState() => _PreRegisterPage2State();
}

Paciente paciente = new Paciente();

class _PreRegisterPage2State extends State<PreRegisterPage2> {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    if (arguments != null) {
      paciente = arguments['arguments'] as Paciente;
      if (paciente != null) {
        paciente.acudientes = [];
      }
    }

    return Scaffold(
        backgroundColor: kAccentColor,
        appBar: toolbarInicioRegistro(context),
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
                        child: RegisterForm()),
                  ),
                )
              ],
            ),
          ],
        ));
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
  Acudiente madre;

  //--------------Padre o Responsable--------------
  Acudiente padre;

  @override
  void initState() {
    //--------------Madre o Responsable--------------
    madre = new Acudiente();
    madre.tipoUsuario = "Acudiente";

    //--------------Padre o Responsable--------------
    padre = new Acudiente();
    padre.tipoUsuario = "Acudiente";

    super.initState();
  }

  insertarAcudientes() {
    print('MADRE');
    print(madre);
    print('Padre');
    print(padre);
    if (madre != null &&
        madre.nombre.isNotEmpty &&
        madre.apellido.isNotEmpty &&
        madre.tipoDocumento.isNotEmpty &&
        madre.documento.isNotEmpty &&
        madre.email.isNotEmpty &&
        madre.telefono.isNotEmpty) {
      paciente.acudientes.add(madre);
    }

    if (padre != null &&
        padre.nombre.isNotEmpty &&
        padre.apellido.isNotEmpty &&
        padre.tipoDocumento.isNotEmpty &&
        padre.documento.isNotEmpty &&
        padre.email.isNotEmpty &&
        padre.telefono.isNotEmpty) {
      paciente.acudientes.add(padre);
    }
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
          padding:
              EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0, bottom: 20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: kPrimaryColor, width: 2.0),
          ),
          child: FormUserPersonalInformation(
            usuario: madre,
            prefix: 'el',
            label: 'de la madre, responsable o tutor legal',
            fechaNacimiento: true,
          ),
        ),
        labelContainerStack('de la madre, responsable o tutor legal'),
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
          child: FormUserPersonalInformation(
            usuario: padre,
            prefix: 'el',
            label: 'del padre, responsable o tutor legal',
            fechaNacimiento: true,
            requerido: false,
          ),
        ),
        labelContainerStack('del padre, responsable o tutor legal'),
      ],
    );

    return Form(
        key: _formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  route: PreRegisterHomePage.route,
                ),
              ),
              Container(
                height: 40.0,
                child: ButtonForms(
                  formKey: _formKey,
                  label: 'Siguiente',
                  color: kPrimaryColor,
                  route: PreRegisterPage3.route,
                  providerFunction: () {
                    insertarAcudientes();
                  },
                  arguments: paciente,
                ),
              ),
            ],
          ),
        ]));
  }
}
