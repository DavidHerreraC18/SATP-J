import 'package:flutter/material.dart';

import '../../tema.dart';

// ignore: must_be_immutable
class CheckBoxWithLabel extends StatefulWidget {
  bool selected;
  final List<bool> updateValues;
  final String label;

  CheckBoxWithLabel({this.selected, this.updateValues, this.label});

  @override
  _CheckBoxWithLabelState createState() => _CheckBoxWithLabelState();
}

class _CheckBoxWithLabelState extends State<CheckBoxWithLabel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Checkbox(
              value: widget.selected,
              activeColor: kPrimaryColor,
              onChanged: (bool value) {
                setState(() {
                  widget.selected = value;
                  for (var update in widget.updateValues) {
                    print('JOLINES');
                    print(update);
                    update = false;
                  }
                });
              }),
          Text(
            widget.label,
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}
