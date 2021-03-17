import 'package:flutter/material.dart';
import 'package:groovin_widgets/groovin_widgets.dart';

import '../../constants.dart';

// ignore: must_be_immutable
class Dropdown extends StatefulWidget {
  
  List<String> values = [];
  Function onChanged;
  dynamic selected;
  Dropdown({this.values, this.onChanged, this.selected});

  @override
  _DropdownState createState() => _DropdownState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _DropdownState extends State<Dropdown> {
  

  @override
  Widget build(BuildContext context) {
    return  OutlineDropdownButton( 
      inputDecoration: getInputDecoration(''),
      value: widget.selected,
      iconSize: 24,
      elevation: 16,           
      style: TextStyle(color: Colors.black87, fontSize: 17.0, fontFamily: 'Dubai'),
      items: widget.values.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        widget.selected = value;
        setState(() {
        });
        //widget.onChanged(value);
      },
    );
  }
}
