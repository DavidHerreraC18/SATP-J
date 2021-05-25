import 'package:flutter/material.dart';

class BotonesTablaAdmision extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Row(
          children: <IconButton>[
            IconButton(
              icon:Icon(Icons.done_outline),
              onPressed: (){

              },),
            IconButton(
              icon:Icon(Icons.do_not_disturb_on),
              onPressed: (){

              },),
              IconButton(
              icon:Icon(Icons.visibility),
              onPressed: (){

              },),  
          ],
        ),
      ),
    );
  }
}