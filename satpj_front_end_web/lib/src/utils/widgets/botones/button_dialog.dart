import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonDialog extends StatefulWidget {
  String label;
  Color color;
  Function function;
  BuildContext contextP;
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool paginator;
  Function provider;

  ButtonDialog(
      {GlobalKey<FormState> formKey,
      this.label,
      this.color,
      this.paginator = false,
      this.function,
      this.provider})
      : _formKey = formKey;

  @override
  _ButtonDialogState createState() => _ButtonDialogState();
}

class _ButtonDialogState extends State<ButtonDialog> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(widget.color),
      ),
      onPressed: () {
        if (widget._formKey != null) {
          if (widget._formKey.currentState.validate()) {
            if (widget.function != null) {
              if (widget.paginator == true)
                widget.function();
              else {
                widget.function();
                if (widget.provider != null) {
                  widget.provider();
                }
                Navigator.pop(context);
              }
            }
          }
        } else if (!widget.paginator && widget.function != null) {
          widget.function();
          Navigator.pop(context);
        } else if (widget.paginator && widget.function != null) {
          widget.function();
        } else {
          Navigator.pop(context);
        }
      },
      child: Text(widget.label.toString(),
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal)),
    );
  }
}
