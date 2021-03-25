import 'package:flutter/material.dart';
import 'package:groovin_widgets/groovin_widgets.dart';

import '../../constants.dart';

// ignore: must_be_immutable
class Dropdown extends StatefulWidget {
  
  List<String> values = [];
  Function onChanged;
  dynamic selected;
  FocusNode textFocusNode;
  TextInputType textInputType;
  TextEditingController textController;
  bool isEditing;
  Function validate;
  String hintText;

  Dropdown({this.values, this.onChanged, this.selected,
      this.textController,
      this.hintText,
      this.validate
  });

  @override
  _DropdownState createState() => _DropdownState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _DropdownState extends State<Dropdown> {
  
  @override
  Widget build(BuildContext context) {
    return  DropdownButtonFormField<String>( 
      iconSize: 24,
      elevation: 16,
      hint: Text(widget.hintText), 
      decoration: inputDecoration,          
      style: TextStyle(color: Colors.black87, fontSize: 17.0, fontFamily: 'Dubai'),
      items: ['One', 'Two', 'Free', 'Four'].map((value) => 
        DropdownMenuItem(
          value: value,
          child: Text(value),
        )
      ).toList(),
      onChanged: (value) {
        setState(() {
          widget.textController.text = value;
        });
      }, 
     //autovalidateMode: AutovalidateMode.,
     validator: (value) => value == null ? widget.validate() : null,
    );
  }
}
