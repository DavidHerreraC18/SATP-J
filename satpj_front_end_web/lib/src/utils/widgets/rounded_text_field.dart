import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants.dart';

// ignore: must_be_immutable
class RoundedTextField extends StatefulWidget {
  
  final String hintText;
  Function onChangedF;
  TextInputType type;
  List<TextInputFormatter> formatter; 
  String validatioText;

  RoundedTextField({this.hintText, this.onChangedF, this.type, this.formatter, this.validatioText});

  @override
  _RoundedTextFieldState createState() => _RoundedTextFieldState();
}

class _RoundedTextFieldState extends State<RoundedTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
       onChanged: widget.onChangedF,
       keyboardType: widget.type,
       inputFormatters: widget.formatter,
       decoration: getInputDecoration(widget.hintText),
       validator: (value) {
        if (value.isEmpty) {
          
          return widget.validatioText;
        }
        return null;
        }
     );
  }
}