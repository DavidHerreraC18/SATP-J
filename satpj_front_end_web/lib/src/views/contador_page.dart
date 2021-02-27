import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/utils/widgets/toolbar_auxiliar_administrativo.dart';
import 'package:satpj_front_end_web/src/utils/widgets/toolbar_inicio.dart';
import 'package:satpj_front_end_web/src/utils/widgets/toolbar_paciente.dart';
import 'package:satpj_front_end_web/src/utils/widgets/toolbar_practicante.dart';

class ContadorPage extends StatefulWidget {

  @override
  createState() => _ContadorPageState();


}

class _ContadorPageState extends State<ContadorPage>{

  //final _estiloTexto = Theme.of(context)

  int _conteo = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFFD4EDEB),
      appBar: toolbarAuxiliarAdministrativo(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Número de taps:',style: Theme.of(context).textTheme.headline1),
            Text('$_conteo' ,style: Theme.of(context).textTheme.subtitle1),
          ],
        ),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _crearBotones(),
    );
  }

  Widget _crearBotones(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(width: 30.0),
        FloatingActionButton(child: Icon(Icons.exposure_zero),onPressed: _reset),
        Expanded(child: SizedBox()),
        FloatingActionButton(child: Icon(Icons.remove),onPressed: _sustraer),
        SizedBox(width: 5.0,),
        FloatingActionButton(child: Icon(Icons.add),onPressed: _agregar)
      ],
    );
    
  }

  void _agregar(){
    setState(() =>_conteo++);
  }
  void _sustraer(){
    setState(() =>_conteo--);
  }
  void _reset(){
    setState(() =>_conteo=0);
  }
}