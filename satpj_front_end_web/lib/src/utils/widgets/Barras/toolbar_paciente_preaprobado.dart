import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/providers/provider_autenticacion.dart';

AppBar toolbarPacientePreaprobado(BuildContext context) {
  return AppBar(
    leading: Image.asset(
      'lib/src/utils/images/logo_plataforma.png',
      fit: BoxFit.cover,
      height: 35.0,
    ),
    title: Text("SATP-J", style: TextStyle(color: Color(0xFF2E5EAA))),
    actions: [
      ButtonBar(
        children: <Widget>[
          SizedBox(width: 5.0),
          Ink(
            decoration: const ShapeDecoration(
              color: Color(0xFF2E5EAA),
              shape: CircleBorder(),
            ),
            child: PopupMenuButton(
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
              ),
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Icon(
                        Icons.logout,
                        color: Color(0xFF2E5EAA),
                      ),
                      SizedBox(width: 2.0),
                      Text("Cerrar Sesión",
                          style: Theme.of(context).textTheme.bodyText1)
                    ],
                  ),
                ),
              ],
              onSelected: (value) {
                switch (value) {
                  case 1:
                    {
                      ProviderAuntenticacion.signOut();
                      Navigator.pushNamed(context, "/");
                    }
                    break;
                }
              },
            ),
          ),
          SizedBox(width: 5.0),
        ],
      ),
    ],
  );
}
