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
      this.validationText,
      this.enabled = true});

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

// ignore: must_be_immutable
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
  Function onChanged;
  double fontSize;
  
  RoundedTextFieldValidators(
      {this.textFocusNode,
      this.textInputType,
      this.textController,
      this.isEditing,
      this.validate,
      this.hintText,
      this.numberFormat,
      this.formatter,
      this.enabled = true,
      this.onChanged,
      this.fontSize = 18.0});

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
      enabled: widget.enabled,
      onChanged: (value) {
        setState(() {
          widget.isEditing = true;
          if(widget.onChanged != null){
             widget.onChanged();
          }
        });
      },
      validator: (value) {
        if (value.isEmpty && widget.validate() != null) {
          return widget.validate();
        }
        return null;
      },
      style: TextStyle(color: Colors.black, fontSize: widget.fontSize),
      decoration: InputDecoration(
        labelStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: widget.fontSize),
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

// ignore: must_be_immutable
class RoundedTextFieldDisabled extends StatefulWidget {
  TextInputType type;
  List<TextInputFormatter> formatter;
  bool enabled;
  String hintText;

  RoundedTextFieldDisabled(
      {this.hintText, this.type, this.formatter, this.enabled = false});

  @override
  _RoundedTextFieldDisabledState createState() =>
      _RoundedTextFieldDisabledState();
}

class _RoundedTextFieldDisabledState extends State<RoundedTextFieldDisabled> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: null,
      decoration: InputDecoration(
        labelStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 18.0),
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: borderField(),
        enabledBorder: enabledBorderField(),
        focusedBorder: focusedBorderField(),
        hintText: widget.hintText,
        fillColor: Colors.white,
      ),
      keyboardType: widget.type,
      inputFormatters: widget.formatter,
    );
  }
}
