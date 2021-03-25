import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/constants.dart';
import 'package:satpj_front_end_web/src/utils/widgets/dropdown.dart';
import 'package:satpj_front_end_web/src/utils/widgets/rounded_text_field.dart';

class PreAprobDialog extends StatefulWidget {
  PreAprobDialog({Key key}) : super(key: key);

  @override
  _PreAprobDialogState createState() => _PreAprobDialogState();
}

class _PreAprobDialogState extends State<PreAprobDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                    RoundedTextField(hintText: 'Ingrese su número de documento',),
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
                ]
          )
        ),
      ),
    );
  }
}
