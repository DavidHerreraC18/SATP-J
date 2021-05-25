import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Barras/toolbar_inicio.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/dialogo_autenticacion.dart';
import 'package:satpj_front_end_web/src/views/registro/vista_pre_registro.dart';

class VistaInicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appBar: toolbarInicio(context),
        appBar: toolbarInicio(context),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  child: Container(
                padding: EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        "Bienvenido ",
                        style: TextStyle(
                            fontSize: 60.0,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2E5EAA)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        "Al sistema de atención por telepsicología de la Pontificia Universidad Javeriana",
                        style: Theme.of(context).textTheme.headline3,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              )),
              Expanded(
                  child: Container(
                      margin: EdgeInsets.all(80),
                      height: MediaQuery.of(context).size.height * 0.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).colorScheme.background),
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).colorScheme.primary),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.all(16.0)),
                                shadowColor:
                                    MaterialStateProperty.all(Colors.black),
                                elevation: MaterialStateProperty.all(6.0),
                                textStyle: MaterialStateProperty.all(
                                  TextStyle(color: Colors.white),
                                ),
                                enableFeedback: true,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, PreRegisterHomePage.route);
                              },
                              child: Text(
                                "QUIERO EL SERVICIO",
                                style: Theme.of(context).textTheme.subtitle2,
                              )),
                          TextButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).colorScheme.secondary),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.all(16.0)),
                                shadowColor:
                                    MaterialStateProperty.all(Colors.black),
                                elevation: MaterialStateProperty.all(6.0),
                                textStyle: MaterialStateProperty.all(
                                  TextStyle(color: Colors.white),
                                ),
                                enableFeedback: true,
                              ),
                              onPressed: () {
                                //Navigator.pushNamed(context, 'login');
                                showDialog(
                                    context: context,
                                    builder: (context) => AuthDialog());
                              },
                              child: Text(
                                "INICIAR SESIÓN",
                                style: Theme.of(context).textTheme.subtitle2,
                              )),
                        ],
                      ))))
            ]));
  }
}
