
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:satpj_front_end_web/src/constants.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/dropdown.dart';
import 'package:satpj_front_end_web/src/utils/widgets/rounded_text_field.dart';
import 'package:satpj_front_end_web/src/utils/widgets/toolbar_inicio.dart';
import 'package:satpj_front_end_web/src/views/register/pre_register_page_2.dart';

class PreRegisterPage1 extends StatefulWidget {
      
  @override
  _PreRegisterPage1State createState() => _PreRegisterPage1State();
}

class _PreRegisterPage1State extends State<PreRegisterPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: kAccentColor,
       appBar: toolbarInicio(),
       body: ListView(
          children: [
          Column( 
           children: [
           Card(
           margin: EdgeInsets.only(right: 400.0, left: 400.0, top: 20.0, bottom: 20.0),
           elevation: 25.0,
           child: Padding(
             padding: EdgeInsets.all(40.0),
             child:Container(
               width: 500,
               child: RegisterForm()
               ),
             ),
           )
          ],),
       ],
       )

       
    );
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
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
             children: [
                 Text('Nombres', textAlign: TextAlign.left,  style: TextStyle(fontSize: 18.0),),
                 SizedBox(height: 8.0,),
                 Container(child: RoundedTextField(hintText: 'Ingrese su nombre',)),
                 SizedBox(height: 20.0,),
                 Text('Apellidos', textAlign: TextAlign.left, style: TextStyle(fontSize: 18.0),),
                 SizedBox(height: 8.0,),
                 Container( child: RoundedTextField(hintText: 'Ingrese sus apellidos',)),
                 SizedBox(height: 20.0,),
                 Text('Tipo de documento', textAlign: TextAlign.left, style: TextStyle(fontSize: 18.0),),
                 SizedBox(height: 8.0,),
                 Container(height: 50.0,child: Dropdown(values: kTtipoDocumento,)),
                 SizedBox(height: 20.0,),
                 Text('Número de documento', textAlign: TextAlign.left, style: TextStyle(fontSize: 18.0),),
                 SizedBox(height: 8.0,),
                 RoundedTextField(
                          hintText: 'Ingrese su número de documento',
                          type: TextInputType.number, 
                          formatter: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                    
                 ),
                 SizedBox(height: 20.0,),
                 Text('Fecha de Nacimiento', textAlign: TextAlign.left, style: TextStyle(fontSize: 18.0),),
                 SizedBox(height: 8.0,),
                 RoundedTextField(
                          hintText: 'Fecha de Nacimiento',
                          type: TextInputType.datetime,                 
                 ),
                 SizedBox(height: 20.0,),
                 Text('Dirección', textAlign: TextAlign.left, style: TextStyle(fontSize: 18.0),),
                 SizedBox(height: 8.0,),
                 RoundedTextField(
                          hintText: 'Dirección',
                          type: TextInputType.streetAddress,                 
                 ),
                 SizedBox(height: 20.0,),
                 Text('Estrato sociecómico', textAlign: TextAlign.left, style: TextStyle(fontSize: 18.0),),
                 SizedBox(height: 8.0,),
                 RoundedTextField(
                          hintText: 'Estrato sociecómico',
                          type: TextInputType.streetAddress,                 
                 ),
                        
                 
                 
          SizedBox(height: 20.0,),      
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 40.0,
                child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
                  ),
                  onPressed: () {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    Navigator.pushNamed(context, PreRegisterPage2().route);
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, display a Snackbar.
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('Processing Data')));
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text('Siguiente', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal)),
                  ),
                ),
              ),
            ],
          ),
                 
          
             
             ]
      )
    );
  }
}


