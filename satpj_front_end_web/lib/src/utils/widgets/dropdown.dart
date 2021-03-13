import 'package:flutter/material.dart';
import 'package:groovin_widgets/groovin_widgets.dart';

import '../../constants.dart';

// ignore: must_be_immutable
class Dropdown extends StatefulWidget {
  
  bool cualSelected;
  List<String> values = [];
  Function onChanged;
  
  Dropdown({this.values, this.cualSelected});

  @override
  _DropdownState createState() => _DropdownState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _DropdownState extends State<Dropdown> {
  String selectedValue;

  @override
  Widget build(BuildContext context) {
    return  OutlineDropdownButton( 
      inputDecoration: getInputDecoration(''),
      value: selectedValue = widget.values.first,
      iconSize: 24,
      elevation: 16,           
      isExpanded : true,
      style: TextStyle(color: Colors.black87, fontSize: 14.0),
      onChanged: (newValue) {
        setState(() {
          selectedValue = newValue;
          if(newValue == kInstituciones.last){
              //widget.cualSelected = true;
          }
          //widget.onChanged();
        });
      },
      items: widget.values.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}