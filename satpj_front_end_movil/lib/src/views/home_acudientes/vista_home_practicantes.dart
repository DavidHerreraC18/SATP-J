import 'package:flutter/material.dart';
import 'package:satpj_front_end_movil/src/constants/constants_decoration.dart';
import 'package:satpj_front_end_movil/src/utils/widgets/botones/ButtonHome.dart';

import '../../utils/widgets/drawer_practicante.dart';

class VistaHomePracticantes {
  VistaHomePracticantes();
}

class HomePracticantes extends StatefulWidget {
  
  static const String route = '/home-practicantes';

  HomePracticantes();

  @override
  _HomePracticantesState createState() => _HomePracticantesState();
}

class _HomePracticantesState extends State<HomePracticantes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: DrawerPracticante(),
      body: Column(children: [
        Container(
            height: 80.0,
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: ButtonHome(label:'Sesión en curso'),
        ),
        /*Expanded(
          child: Card(
            elevation: 5.0,
            child: Container(child: Text('Calendario')),
          ),
        ),*/
        Container(
         height: 230.0,
         margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
         decoration: kContainerDecoration(context),
         child:
             ListView(
               scrollDirection: Axis.horizontal,
               children: [
    
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
                  
                    children: [ Center(
                      child: Text('4 de abril - 12:00 p.m',
                         style: TextStyle(
                            color: 
                                Theme.of(context).colorScheme.primary,
                            fontSize: 20.0
                            )
                   ),
                    ),
                    ]
                 ),
                 
                 ]
                ,
         ),
        )
      ],),
    );
  }
}
