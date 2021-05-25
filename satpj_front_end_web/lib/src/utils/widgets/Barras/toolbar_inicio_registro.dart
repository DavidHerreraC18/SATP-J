import 'package:flutter/material.dart';

AppBar toolbarInicioRegistro(BuildContext context) {
  return AppBar(
    leading: Image.asset(
      'lib/src/utils/images/logo_plataforma.png',
      fit: BoxFit.cover,
      height: 35.0,
    ),
    title: Text("SATP-J",
        style: TextStyle(color: Theme.of(context).colorScheme.primary)),
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
              Navigator.pushNamed(context, '/');
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
        ],
      ),
    ],
  );
}

Color getColor(Set<MaterialState> states) {
  /*const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };*/
  if (states.contains(MaterialState.pressed)) {
    return Color(0xFF7CA8EF);
  } else if (states.contains(MaterialState.hovered)) {
    return Color(0xFF618ED6);
  }
  return Color(0xFF2E5EAA);
}
