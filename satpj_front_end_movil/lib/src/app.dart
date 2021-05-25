import 'package:satpj_front_end_movil/src/routes/rutas.dart';
import 'package:satpj_front_end_movil/src/utils/tema.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget{
  

  @override
  Widget build( context ){

    return MaterialApp(
      title: 'SATP - J',
      debugShowCheckedModeBanner: false,
      theme: temaSatpj(),
      routes: getAppRoutes(),
    );

  }

}