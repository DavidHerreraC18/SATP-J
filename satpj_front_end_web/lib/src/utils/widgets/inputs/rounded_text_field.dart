import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants.dart';

// ignore: must_be_immutable
class RoundedTextField extends StatefulWidget {
  final String hintText;
  Function onChangedF;
  TextInputType type;
  List<TextInputFormatter> formatter;
  String validationText;
  bool enabled;

  RoundedTextField(
      {this.hintText,
      this.onChangedF,
      this.type,
      this.formatter,
      this.validationText, this.enabled = true});

  @override
  _RoundedTextFieldState createState() => _RoundedTextFieldState();
}

class _RoundedTextFieldState extends State<RoundedTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        maxLines: null,
        onChanged: widget.onChangedF,
        keyboardType: widget.type,
        inputFormatters: widget.formatter,
        decoration: inputDecoration(enabled: widget.enabled),
        validator: (value) {
          if (value.isEmpty) {
            return widget.validationText;
          }
          return null;
        });
  }
}

class RoundedTextFieldValidators extends StatefulWidget {
  FocusNode textFocusNode;
  TextInputType textInputType;
  TextEditingController textController;
  bool isEditing;
  Function validate;
  final String hintText;
  bool numberFormat;
  List<TextInputFormatter> formatter;
  bool enabled;
  
  RoundedTextFieldValidators(
      {this.textFocusNode,
      this.textInputType,
      this.textController,
      this.isEditing,
      this.validate,
      this.hintText,
      this.numberFormat,
      this.formatter,
      this.enabled = true});

  @override
  _RoundedTextFieldValidatorsState createState() =>
      _RoundedTextFieldValidatorsState();
}

class _RoundedTextFieldValidatorsState
    extends State<RoundedTextFieldValidators> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.textFocusNode,
      keyboardType: widget.textInputType,
      textInputAction: TextInputAction.next,
      inputFormatters: widget.formatter,
      controller: widget.textController,
      autofocus: false,
      enabled: widget.enabled ,
      onChanged: (value) {
        setState(() {
          widget.isEditing = true;
        });
      },
      validator: (value) {
          if (value.isEmpty && widget.validate() != null) {
            return widget.validate();
          }
          return null;
      },        
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 18.0),
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: borderField(),
        enabledBorder: enabledBorderField(),
        focusedBorder: focusedBorderField(),
        filled: true,
        hintText: widget.hintText,
        fillColor: Colors.white,
        errorText: widget.isEditing ? widget.validate() : null,
        errorStyle: TextStyle(
          fontSize: 12,
          color: Colors.redAccent,
        ),
      ),
    );
  }
}
