import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/utils/widgets/botones/button_dialog.dart';

class FotterDialog extends StatefulWidget {

  String labelCancelBtn;
  String labelConfirmBtn;
  Color colorConfirmBtn;
  Color colorCancelBtn = Colors.grey[600];
  GlobalKey<FormState> _formKey = new GlobalKey<FormState> ();
  Function functionCancelBtn;
  Function functionConfirmBtn;
  double width;
  bool paginator;

  FotterDialog({
   this.labelCancelBtn = '', 
   this.labelConfirmBtn = '',
   this.colorConfirmBtn,
   GlobalKey<FormState> formKey,
   this.functionConfirmBtn,
   this.width,
   this.paginator = false,
   this.functionCancelBtn
   }): _formKey = formKey;


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
          margin:  widget.paginator ? EdgeInsets.only(bottom: 18.0, top: 10.0, left: 40.0, right: 40.0) : EdgeInsets.only(bottom: 18.0, top: 10.0), 
          child: Row(
            mainAxisAlignment: !widget.paginator ? MainAxisAlignment.center: MainAxisAlignment.spaceBetween,
            children: [
              if(widget.labelCancelBtn.isNotEmpty)
              Container(
                height: 35.0,
                width: widget.width,
                child: ButtonDialog(
                  label: widget.labelCancelBtn,
                  color: widget.colorCancelBtn,
                  function: widget.functionCancelBtn,
                  paginator: widget.paginator,
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Container(
                height: 35.0,
                width: widget.width,
                child: ButtonDialog(
                  formKey: widget._formKey,
                  label: widget.labelConfirmBtn,
                  color: widget.colorConfirmBtn,
                  function: widget.functionConfirmBtn,
                  paginator: widget.paginator,
                ),
              ),
            ],
          ))
    ]);
  }
}
