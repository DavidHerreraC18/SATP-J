import 'package:flutter/material.dart';

AppBar toolbarInicio(){
  return AppBar(
    leading: Image.asset(
      'lib/src/utils/images/logo_plataforma.png',
      fit: BoxFit.cover,
      height: 35.0,
      ),
    title: Text(
      "SATP-J", 
      style: TextStyle(
        color: Color(0xFF2E5EAA)
        )
      ),
    actions: [
      ButtonBar(
          children: <Widget>[
            TextButton(
              child: Text(
                'Inicio',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              onPressed: () {
                // To do
              },
            ),
            SizedBox(width: 30.0),
            TextButton(
              child: Text(
                'Nosotros',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              onPressed: () {
                // To do
              },
            ),
            SizedBox(width: 30.0),
            TextButton(
              child: Text(
                'Contáctanos',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              onPressed: () {
                // To do
              },
            ),
            SizedBox(width: 30.0),
            TextButton(
              child: Text(
                'Iniciar Sesión',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              style: TextButton.styleFrom(
                  backgroundColor: Color(0xFF2E5EAA),
                  textStyle: TextStyle(
                    color: Colors.white
                  ),
                  padding: EdgeInsets.all(16.0),
                ),
              onPressed: () {
                // To do
              },
            ),
          ],
        ),
    ],
  );
}

/*Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Color(0xFF2E5EAA);
    }*/
