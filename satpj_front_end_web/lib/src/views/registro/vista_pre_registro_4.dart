import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_inicio.dart';
import 'package:satpj_front_end_web/src/utils/widgets/formularios/tema_formularios.dart';

class PreRegisterPage4 extends StatelessWidget {
  static const route = '/pre-registro-4';
  const PreRegisterPage4();

  @override
  Widget build(BuildContext context) {
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
                          padding: EdgeInsets.all(40.0),
                          width: 600.0,
                          child: Column(
                            children: [
                              Text(
                                'Gracias por registrarte',
                                style: TextStyle(
                                    fontSize: 40.0, color: kPrimaryColor),
                              ),
                              SizedBox(height: 5.0,),
                              Text(
                                'En los proximos días el Consultorio se estará comunicando via telefónica o por correo electrónico.' 
                                ,
                                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300, height: 1.3),
                                textAlign: TextAlign.center,
                                
                              ),
                              SizedBox(height: 5.0,),
                              Text(
                                'Si tienes alguna inquietud puedes comunicarte al',
                                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300, height: 1.3),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                '3208320, Extensiones: 5405 ó 5407',
                                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500, height: 1.3, color: kPrimaryColor),
                                textAlign: TextAlign.center,
                              )
                            ],
                          )),
                    ))
              ],
            ),
          ],
        ));
  }
}
