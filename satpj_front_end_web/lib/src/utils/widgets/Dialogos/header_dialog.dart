import 'package:flutter/material.dart';

import '../../tema.dart';

// ignore: must_be_immutable
class HeaderDialog extends StatefulWidget {
  String label;
  double height;
  HeaderDialog({this.label = '', this.height = 45.0});

  @override
  _HeaderDialogState createState() => _HeaderDialogState();
}

class _HeaderDialogState extends State<HeaderDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(3.6)),
          color: kPrimaryColor,
        ),
        margin: EdgeInsets.only(bottom: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(
                widget.label,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.white,
                size: 20.0,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ));
  }
}
