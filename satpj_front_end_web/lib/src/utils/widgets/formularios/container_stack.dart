import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';

Container containerStack() {
  return Container(
      margin: EdgeInsets.symmetric(vertical: 35.0, horizontal: 5.0),
      padding:
          EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0, bottom: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: kPrimaryColor, width: 2.0),
      ));
}

Positioned labelContainerStack(String label){

   return  Positioned(
            left: 10,
            top: 20,
            child: Container(
                color: Colors.white,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  color: kPrimaryColor,
                  child: Text(
                    'Información ' + label,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                )),
          );

}
