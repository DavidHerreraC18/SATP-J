import 'package:flutter/material.dart';



class ButtonForms extends StatelessWidget {
  
  final route;
  final label;
  final color;
  final arguments;

  ButtonForms({ Key key, 
    @required GlobalKey<FormState> formKey, this.label,
  this.route, this.color, this.arguments}) : _formKey = formKey, super(key: key);

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
              SnackBar(content: Text('Guardando Información', style: TextStyle(color: Colors.black),)));
          Navigator.pushNamed(context, route.toString(), arguments: arguments);
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
