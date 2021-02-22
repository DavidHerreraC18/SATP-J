import 'package:flutter/material.dart';


AppBar toolbarPaciente(){
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
            Ink(
              decoration: const ShapeDecoration(
              color: Color(0xFF2E5EAA),
              shape: CircleBorder(),
              ),
              child: IconButton(
                icon: Icon(Icons.home),
                color: Colors.white,
                onPressed: () {
                  // To do
                },
              ),
            ),
            SizedBox(width: 5.0),
            Ink(
              decoration: const ShapeDecoration(
              color: Color(0xFF2E5EAA),
              shape: CircleBorder(),
              ),
              child: IconButton(
                icon: Icon(Icons.mail),
                color: Colors.white,
                onPressed: () {
                  // To do
                },
              ),
            ),
            SizedBox(width: 5.0),
            Ink(
              decoration: const ShapeDecoration(
              color: Color(0xFF2E5EAA),
              shape: CircleBorder(),
              ),
              child: IconButton(
                icon: Icon(Icons.notifications),
                color: Colors.white,
                onPressed: () {
                  // To do
                },
              ),
            ),
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
                    child: Row( // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        Icon(
                          Icons.home,
                          color: Color(0xFF2E5EAA),
                          ),
                        SizedBox(width: 2.0),
                        Text(
                          "Inicio",
                          style: TextStyle(
                            color: Color(0xFF2E5EAA) 
                            ),
                          )
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Row( // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        Icon(
                          Icons.badge,
                          color: Color(0xFF2E5EAA),
                          ),
                        SizedBox(width: 2.0),
                        Text(
                          "Perfíl",
                          style: TextStyle(
                            color: Color(0xFF2E5EAA) 
                            ),
                          )
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 3,
                    child: Row( // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        Icon(
                          Icons.weekend,
                          color: Color(0xFF2E5EAA),
                          ),
                        SizedBox(width: 2.0),
                        Text(
                          "Sesiones Terapia",
                          style: TextStyle(
                            color: Color(0xFF2E5EAA) 
                            ),
                          )
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 4,
                    child: Row( // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        Icon(
                          Icons.payments,
                          color: Color(0xFF2E5EAA),
                          ),
                        SizedBox(width: 2.0),
                        Text(
                          "Pagos",
                          style: TextStyle(
                            color: Color(0xFF2E5EAA) 
                            ),
                          )
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 4,
                    child: Row( // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        Icon(
                          Icons.group,
                          color: Color(0xFF2E5EAA),
                          ),
                        SizedBox(width: 2.0),
                        Text(
                          "Grupos",
                          style: TextStyle(
                            color: Color(0xFF2E5EAA) 
                            ),
                          )
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 4,
                    child: Row( // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        Icon(
                          Icons.logout,
                          color: Color(0xFF2E5EAA),
                          ),
                        SizedBox(width: 2.0),
                        Text(
                          "Cerrar Sesión",
                          style: TextStyle(
                            color: Color(0xFF2E5EAA) 
                            ),
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 5.0),
          ],
        ),
    ],
  );
}

