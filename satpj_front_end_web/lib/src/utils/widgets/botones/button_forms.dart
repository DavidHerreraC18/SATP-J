import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/model/paciente/paciente.dart';

class ButtonForms extends StatelessWidget {
  final GlobalKey<FormState> _formKey;
  final String route;
  final String label;
  final Color color;
  final arguments;
  final Function(int) functionRouting;
  final Function providerFunction;

  ButtonForms(
      {GlobalKey<FormState> formKey,
      this.label,
      this.route = '/',
      this.color,
      this.arguments,
      this.functionRouting,
      this.providerFunction})
      : _formKey = formKey;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(color),
      ),
      onPressed: () {
        if (_formKey != null) {
          if (_formKey.currentState.validate()) {
            String finalRoute = route;

            if (arguments is Paciente && functionRouting != null) {
              finalRoute = functionRouting(arguments.edad).toString();
              print('RUTA' + finalRoute + arguments.edad.toString());
            }
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
              'Guardando Información',
              style: TextStyle(color: Colors.black),
            )));
            Navigator.pushNamed(context, finalRoute,
                arguments: {'arguments': arguments});
          }
        }

        if (providerFunction != null) {
          providerFunction();
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(label.toString(),
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal)),
      ),
    );
  }
}
