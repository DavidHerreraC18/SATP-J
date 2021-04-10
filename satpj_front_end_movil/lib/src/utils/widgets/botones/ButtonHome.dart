import 'package:flutter/material.dart';

String _label;
Color _color;
Function _function;

class ButtonHome extends StatefulWidget {
  ButtonHome({
    String label = '',
    Color color,
    Function function,
  }) {
    _label = label;
    _color = color;
    _function = function;
  }

  @override
  _ButtonHomeState createState() => _ButtonHomeState();
}

class _ButtonHomeState extends State<ButtonHome> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(Theme.of(context).colorScheme.secondary),
        padding: MaterialStateProperty.all(EdgeInsets.all(16.0)),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        shadowColor: MaterialStateProperty.all(Colors.black),
        elevation: MaterialStateProperty.all(6.0),
        textStyle: MaterialStateProperty.all(
          TextStyle(color: Colors.white),
        ),
        enableFeedback: true,
      ),
      onPressed: () {
        if (_function != null) {
          _function();
        }

        Navigator.pop(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _label,
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 10.0
          ),
          Icon(
             Icons.video_call_rounded, 
             color: Colors.white,
             size: 30.0,
          ),
        ],
      ),
    );
  }
}
