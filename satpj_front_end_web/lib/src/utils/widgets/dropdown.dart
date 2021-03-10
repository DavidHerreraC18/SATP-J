import 'package:flutter/material.dart';
import 'package:groovin_widgets/groovin_widgets.dart';

import '../../constants.dart';

// ignore: must_be_immutable
class Dropdown extends StatefulWidget {
  
  List<String> values = [];
  Function onChanged;
  
  Dropdown({this.values});

  @override
  _DropdownState createState() => _DropdownState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _DropdownState extends State<Dropdown> {
  
  String valueSelected;

  @override
  Widget build(BuildContext context) {
    return  OutlineDropdownButton( 
      inputDecoration: getInputDecoration(''),
      value: valueSelected = widget.values.first,
      iconSize: 24,
      elevation: 16,           
      isExpanded : true,
      style: TextStyle(color: Colors.black87, fontSize: 14.0),
      onChanged: (newValue) {
        setState(() {
          valueSelected = newValue;
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