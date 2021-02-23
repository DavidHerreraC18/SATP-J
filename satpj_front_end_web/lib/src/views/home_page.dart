


import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/utils/widgets/toolbar_inicio.dart';

class HomePage extends StatelessWidget{

  final estiloTexto = new TextStyle(fontSize : 25);

  final conteo = 20;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: toolbarInicio(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Número de clicks:',style: estiloTexto),
            Text('$conteo' ,style: estiloTexto),
          ],
        ),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {

          print('Hola Mundo!');
          //conteo = conteo + 1;
        },
      ),
    );
  }
}