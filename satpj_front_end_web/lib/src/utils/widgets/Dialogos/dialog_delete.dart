import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/fotter_dialog.dart';
import 'package:satpj_front_end_web/src/utils/widgets/Dialogos/header_dialog.dart';

class DialogDelete extends StatefulWidget {
  String labelHeader;
  String label;
  String labelCancelBtn;
  String labelConfirmBtn;
  Color colorConfirmBtn;

  DialogDelete(
      {this.labelHeader = '',
      this.label = '',
      this.labelCancelBtn = '',
      this.labelConfirmBtn = '',
      this.colorConfirmBtn});

  @override
  _DialogDeleteState createState() => _DialogDeleteState();
}

class _DialogDeleteState extends State<DialogDelete> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Dialog(
        child: Container(
          height: 238.0,
          width: 350.0,
          child: Column(
            children: [
              HeaderDialog(
                label: widget.labelHeader,
              ),
              Container(
                margin: EdgeInsets.all(15.0),
                alignment: Alignment.center,
                child: Text(
                  widget.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0, 
                    fontWeight: FontWeight.normal 
                    )
                ),
              ),
              FotterDialog(
                labelCancelBtn: widget.labelCancelBtn,
                labelConfirmBtn: widget.labelConfirmBtn,
                colorConfirmBtn: widget.colorConfirmBtn,
              )
            ],
          ),
        ),
      ),
    );
  }
}
