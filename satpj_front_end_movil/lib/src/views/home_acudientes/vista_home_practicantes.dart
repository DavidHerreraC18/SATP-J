import 'package:flutter/material.dart';

import '../../utils/widgets/drawer_practicante.dart';

class VistaHomePracticantes {
  VistaHomePracticantes();
}

class HomePracticantes extends StatefulWidget {
  HomePracticantes({Key key}) : super(key: key);

  @override
  _HomePracticantesState createState() => _HomePracticantesState();
}

class _HomePracticantesState extends State<HomePracticantes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerPracticante(),
      body: Column(children: [
        Container(),
      ],),
    );
  }
}
