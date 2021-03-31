import 'package:flutter/material.dart';



class ButtonDialog extends StatelessWidget {
  
  final String label;
  final Color color;
 
  ButtonDialog({ Key key, 
   GlobalKey<FormState> formKey, this.label,
   this.color}) : _formKey = formKey, super(key: key);

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
          print('hola?');
           Navigator.pop(context);        
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
