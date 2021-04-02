import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/utils/widgets/botones/button_dialog.dart';

import '../../tema.dart';

class FotterDialog extends StatefulWidget {

  String labelCancelBtn;
  String labelConfirmBtn;
  Color colorConfirmBtn;

  FotterDialog({
   this.labelCancelBtn = '', 
   this.labelConfirmBtn = '',
   this.colorConfirmBtn
   });

  @override
  _FotterDialogState createState() => _FotterDialogState();
}

class _FotterDialogState extends State<FotterDialog> {
  @override
  Widget build(BuildContext context) {
    return Column(
     children: [
      Divider(
        color: Colors.grey[400],
        height: 20,
      ),
      Container(
          margin: EdgeInsets.only(bottom: 18.0, top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 35.0,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.grey[600]),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.0),
                    child: Text(widget.labelCancelBtn,
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.normal)),
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Container(
                height: 35.0,
                child: ButtonDialog(
                  //formKey: _formKey,
                  label: widget.labelConfirmBtn,
                  color: widget.colorConfirmBtn,
                ),
              ),
            ],
          ))
    ]);
  }
}
