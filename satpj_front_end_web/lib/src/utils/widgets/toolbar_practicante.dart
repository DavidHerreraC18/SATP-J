import 'package:flutter/material.dart';


AppBar toolbarPracticante(){
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
                          Icons.group,//TOCA CAMBIAR EL ICONO
                          color: Color(0xFF2E5EAA),
                          ),
                        SizedBox(width: 2.0),
                        Text(
                          "Pacientes",
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
                          Icons.today,
                          color: Color(0xFF2E5EAA),
                          ),
                        SizedBox(width: 2.0),
                        Text(
                          "Mi Horario",
                          style: TextStyle(
                            color: Color(0xFF2E5EAA) 
                            ),
                          )
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 5,
                    child: Row( // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        Icon(
                          Icons.assignment_turned_in,
                          color: Color(0xFF2E5EAA),
                          ),
                        SizedBox(width: 2.0),
                        Text(
                          "Reportes",
                          style: TextStyle(
                            color: Color(0xFF2E5EAA) 
                            ),
                          )
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 6,
                    child: Row( // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        Icon(
                          Icons.group,
                          color: Color(0xFF2E5EAA),
                          ),
                        SizedBox(width: 2.0),
                        Text(
                          "Mi Supervisor",
                          style: TextStyle(
                            color: Color(0xFF2E5EAA) 
                            ),
                          )
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 7,
                    child: Row( // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        Icon(
                          Icons.assignment_rounded,//QUEJESA JOA
                          color: Color(0xFF2E5EAA),
                          ),
                        SizedBox(width: 2.0),
                        Text(
                          "Mi Tareas",
                          style: TextStyle(
                            color: Color(0xFF2E5EAA) 
                            ),
                          )
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 8,
                    child: Row( // Replace with a Row for horizontal icon + text
                      children: <Widget>[
                        Icon(
                          Icons.verified,
                          color: Color(0xFF2E5EAA),
                          ),
                        SizedBox(width: 2.0),
                        Text(
                          "Certificaciones",
                          style: TextStyle(
                            color: Color(0xFF2E5EAA) 
                            ),
                          )
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 9,
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

