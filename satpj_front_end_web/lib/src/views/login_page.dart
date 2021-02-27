import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/utils/widgets/toolbar_inicio.dart';

class LoginPage extends StatelessWidget{

  final estiloTexto = new TextStyle(fontSize : 25);

  final conteo = 20;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: toolbarInicio(context),
      body: Text("login") 
    );
  }
}