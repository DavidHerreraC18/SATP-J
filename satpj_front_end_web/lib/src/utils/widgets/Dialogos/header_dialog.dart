import 'package:flutter/material.dart';

import '../../tema.dart';

class HeaderDialog extends StatefulWidget {

  String label;

  HeaderDialog({this.label = ''});

  @override
  _HeaderDialogState createState() => _HeaderDialogState();
}

class _HeaderDialogState extends State<HeaderDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 45.0,
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
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
       ));
  }
}
