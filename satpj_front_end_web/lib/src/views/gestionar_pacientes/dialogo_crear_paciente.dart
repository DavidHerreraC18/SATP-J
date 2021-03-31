import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/paciente.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/button-forms.dart';
import 'package:satpj_front_end_web/src/utils/widgets/tema-formularios.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/formulario_paciente.dart';

class DialogoCrearPaciente extends StatefulWidget {
  
  Paciente paciente = new Paciente();

  DialogoCrearPaciente({this.paciente});

  @override
  _DialogoCrearPacienteState createState() => _DialogoCrearPacienteState();
}

class _DialogoCrearPacienteState extends State<DialogoCrearPaciente> {
 
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();  
  
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: temaFormularios(),  
        child: 
        Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Container(
          width: 800.0,
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