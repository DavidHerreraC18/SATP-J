import 'package:flutter/material.dart';

import '../utils/widgets/dialogo_autenticacion.dart';
import 'contador_page.dart';

class VistaInicio extends StatelessWidget {
  //const VistaInicio({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "lib/src/utils/images/logo_plataforma.png",
                ),
              Text(
                "SATP-J",
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(height: 50.0),
              TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.primary),
                    padding: MaterialStateProperty.all(EdgeInsets.all(16.0)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      )
                    ),
                    shadowColor: MaterialStateProperty.all(Colors.black),
                    elevation: MaterialStateProperty.all(6.0),
                    textStyle: MaterialStateProperty.all(
                      TextStyle(color: Colors.white),
                    ),
                    enableFeedback: true,
                  ),
                  onPressed: () {},
                  child: Text(
                    "QUIERO EL SERVICIO",
                    style: Theme.of(context).textTheme.subtitle2,
                  )),
              SizedBox(height: 30.0),
              OutlinedButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(
                      Colors.blue
                    ),
                    side: MaterialStateProperty.all(
                      BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2.0
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                        //Colors.white
                        Color(0xFFD4EDEB)
                        ),
                    //shape: MaterialS,
                    padding: MaterialStateProperty.all(EdgeInsets.all(16.0)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      )
                    ),
                    shadowColor: MaterialStateProperty.all(Colors.black),
                    elevation: MaterialStateProperty.all(6.0),
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
                    style: Theme.of(context).textTheme.subtitle1,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
