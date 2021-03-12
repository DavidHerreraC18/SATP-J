import 'package:flutter/material.dart';

import '../tema.dart';


class ButtonForms extends StatelessWidget {
  
  final route;
  final label;
  final color;

  ButtonForms({ Key key, 
    @required GlobalKey<FormState> formKey, this.label,
  this.route, this.color}) : _formKey = formKey, super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(color),
      ),
      onPressed: () {
        // Validate returns true if the form is valid, or false
        // otherwise.
        if (_formKey.currentState.validate()) {
          // If the form is valid, display a Snackbar.
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Guardando Información')));
          Navigator.pushNamed(context, route.toString());
        }      
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(label.toString(),
            style: TextStyle(
                fontSize: 18.0, fontWeight: FontWeight.normal)),
      ),
    );
  }
}
