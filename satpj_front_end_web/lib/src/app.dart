import 'package:firebase_core/firebase_core.dart';
import 'package:satpj_front_end_web/src/views/contador_page.dart';
import 'package:flutter/material.dart';
import 'package:satpj_front_end_web/src/utils/tema.dart';

class MyApp extends StatelessWidget{
  //final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  @override
  Widget build( context ){

    return MaterialApp(
      title: 'SATP - J',
      debugShowCheckedModeBanner: false,
      theme: temaSatpj(),
      home: ContadorPage(),
      /*home: FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot){
          if(snapshot.hasError){
            print('You have an error!!!!!! ${snapshot.error.toString()}');
            return Text('Something went wrong!');
          }else if(snapshot.hasData) {
            return ContadorPage();
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )*/
    );

  }

}