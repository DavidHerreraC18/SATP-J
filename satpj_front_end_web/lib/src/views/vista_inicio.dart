import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/utils/widgets/dialogo_autenticacion.dart';
import 'package:satpj_front_end_web/src/utils/widgets/toolbar_inicio.dart';

class VistaInicio extends StatelessWidget{

  final estiloTexto = new TextStyle(fontSize : 25);

  final conteo = 20;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: toolbarInicio(context),
      appBar: toolbarInicio(context),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: Text(
                    "Bienvenido al sistema de atención por telepsicología de la Universidad Javeriana",
                    style: Theme.of(context).textTheme.headline3,
                    textAlign: TextAlign.center,
                    )
                  )
                ],
              ),
            )
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(80),
              height:  MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.background
              ),
              child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                          TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
                              padding: MaterialStateProperty.all(EdgeInsets.all(16.0)),
                              shadowColor: MaterialStateProperty.all(Colors.black),
                              elevation: MaterialStateProperty.all(6.0),
                              textStyle: MaterialStateProperty.all(
                                TextStyle(
                                  color: Colors.white
                                ),
                              ),
                              enableFeedback: true,
                          ),
                          onPressed: (){

                          }, 
                          child: Text(
                            "QUIERO EL SERVICIO",
                            style: Theme.of(context).textTheme.subtitle2,
                            )
                          ),
                          TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.secondary),
                              padding: MaterialStateProperty.all(EdgeInsets.all(16.0)),
                              shadowColor: MaterialStateProperty.all(Colors.black),
                              elevation: MaterialStateProperty.all(6.0),
                              textStyle: MaterialStateProperty.all(
                                TextStyle(
                                  color: Colors.white
                                ),
                              ),
                              enableFeedback: true,
                          ),
                          onPressed: (){
                            //Navigator.pushNamed(context, 'login');
                             showDialog(
                                        context: context,
                                        builder: (context) => AuthDialog());
                          }, 
                          child: Text(
                            "INICIAR SESIÓN",
                            style: Theme.of(context).textTheme.subtitle2,
                            )
                          ),
                      ],
                    )
                )
              )
          )
        ]
      )
    );
  }
}