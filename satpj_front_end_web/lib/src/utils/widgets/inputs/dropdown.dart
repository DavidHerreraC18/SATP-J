import 'package:flutter/material.dart';

import '../../../constants.dart';

// ignore: must_be_immutable
class Dropdown extends StatefulWidget {
  
  List<String> values = [];
  Function onChanged;
  FocusNode focusNode;
  TextInputType textInputType;
  TextEditingController textController;
  bool isEditing;
  Function validate;
  String hintText;
  bool optional;
  bool enabled;

  Dropdown({this.values, 
      this.onChanged, 
      this.textController,
      this.hintText,
      this.validate,
      this.optional,
      this.enabled = true,
      this.focusNode
  });

  @override
  _DropdownState createState() => _DropdownState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _DropdownState extends State<Dropdown> {
  
  String selected;

  @override
  void initState() {
    if(widget.focusNode != null){
       widget.focusNode.unfocus();
    }
     
     super.initState();
  }
  
  defineValue() {
     if(widget.textController.text == null)
        selected = null;
    else{
       for(String val in widget.values){
         if(val == widget.textController.text){
            selected = val;
            return;
         }
       }
    }
  }

  @override
  Widget build(BuildContext context) {
    
    defineValue();

    var drop = DropdownButtonFormField<String>(
      value: selected,
      iconSize: 24,
      elevation: 16,
      focusNode: widget.focusNode,
      hint: Text(widget.hintText), 
      decoration: inputDecoration(enabled: widget.enabled),          
      style: TextStyle(color: Colors.black87, fontSize: 17.0, fontFamily: 'Dubai'),
      items: widget.values.map((value) => 
        DropdownMenuItem(
          value: value,
          child: Text(value, style: TextStyle(color: Colors.black87, fontSize: 16.5, fontFamily: 'Dubai'),),
        )
      ).toList(),
      onChanged: widget.enabled ? (value) {
        setState(() {
          widget.textController.text = value;
          widget.optional = true;
          if(widget.onChanged != null){
            widget.onChanged();
          }
        });
      } : (String value){
        return null;
      }, 
     validator: (value) => value == null ? widget.validate() : null,
    );

    if( widget.textController.text != null ){  
        print(widget.textController.text);      
        setState(() {
          drop.onChanged('');
        });
        
    }

    return drop;
  }
}
