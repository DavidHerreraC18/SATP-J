import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:satpj_front_end_web/src/constants.dart';
import 'package:satpj_front_end_web/src/modelo/paciente.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/button-forms.dart';
import 'package:satpj_front_end_web/src/utils/widgets/dropdown.dart';
import 'package:satpj_front_end_web/src/utils/widgets/rounded_text_field.dart';
import 'package:satpj_front_end_web/src/utils/widgets/tema-formularios.dart';
import 'package:satpj_front_end_web/src/utils/widgets/toolbar_inicio.dart';
import 'package:satpj_front_end_web/src/views/register/pre_register_page_1.dart';
import 'package:satpj_front_end_web/src/views/register/pre_register_page_3.dart';



class PreRegisterPage2 extends StatefulWidget {
  
  static const route = '/pre-registro-2';
 
  PreRegisterPage2();
    
  @override
  _PreRegisterPage2State createState() => _PreRegisterPage2State();
}

class _PreRegisterPage2State extends State<PreRegisterPage2> {
 
  @override
  Widget build(BuildContext context) {
    final Paciente args = ModalRoute.of(context).settings.arguments;
    print(args.nombre+args.apellidos+args.tipoDocumento);
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
                        right: 100.0, left: 100.0, top: 20.0, bottom: 20.0),
                    elevation: 25.0,
                    child: Padding(
                      padding: EdgeInsets.all(40.0),
                      child: Container(width: 700, child: RegisterForm()),
                    ),
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
  @override
  Widget build(BuildContext context) {
    var stackMadre = Stack(
      children: [
        Container(
          height: 400,
        ),
        Positioned(
          top: 20,
          child: Container(
            width: 700,
            height: 685,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: kPrimaryColor, width: 2.0),
            ),
          ),
        ),
        Positioned(
          left: 10,
          top: 7,
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
        Container(
          margin: EdgeInsets.symmetric(vertical: 35.0, horizontal: 5.0),
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
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
              Container(
                  child: RoundedTextField(
                hintText: 'Ingrese el nombre de la madre o responsable',
              )),
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
              Container(
                  child: RoundedTextField(
                hintText: 'Ingrese los apellidos de la madre o responsable',
              )),
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
              Container(
                  height: 50.0,
                  child: Dropdown(
                    values: kTtipoDocumento,
                  )),
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
              RoundedTextField(
                hintText: 'Ingrese su número de documento',
                type: TextInputType.number,
                formatter: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
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
              RoundedTextField(
                hintText: 'Email',
                type: TextInputType.emailAddress,
              ),
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
              RoundedTextField(
                hintText: 'Télefono',
                type: TextInputType.number,
                formatter: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ]
              ),
            ],
          ),
        ),
      ],
    );
    
    var stackPadre = Stack(
      children: [
        Container(
          height: 400,
        ),
        Positioned(
          top: 20,
          child: Container(
            width: 700,
            height: 685,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: kPrimaryColor, width: 2.0),
            ),
          ),
        ),
        Positioned(
          left: 10,
          top: 7,
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
        Container(
          margin: EdgeInsets.symmetric(vertical: 35.0, horizontal: 5.0),
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
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
              Container(
                  child: RoundedTextField(
                hintText: 'Ingrese el nombre del padre o responsable',
              )),
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
              Container(
                  child: RoundedTextField(
                hintText: 'Ingrese los apellidos del padre o responsable',
              )),
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
              Container(
                  height: 50.0,
                  child: Dropdown(
                    values: kTtipoDocumento,
                  )),
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
              RoundedTextField(
                hintText: 'Ingrese su número de documento',
                type: TextInputType.number,
                formatter: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
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
              RoundedTextField(
                hintText: 'Email',
                type: TextInputType.emailAddress,
              ),
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
              RoundedTextField(
                hintText: 'Télefono',
                type: TextInputType.number,
                formatter: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ]
              ),
            ],
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
