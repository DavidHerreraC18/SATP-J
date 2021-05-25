

import 'package:flutter/material.dart';

ThemeData temaFormularios(){
  return ThemeData(
    
    primaryColor: Color(0xFF2E5EAA),
    accentColor: Color(0xFF23D797),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white
    ),

    iconTheme: IconThemeData(
      color: Color(0xFFD4EDEB),
    ),
    
    /*colorScheme: ColorScheme(
      primary: Color(0xFF2E5EAA), 
      primaryVariant: Color(0xFF24467C), 
      secondary: Color(0xFF23D797), 
      secondaryVariant: Color(0xFF1DA776),
      surface: Color(0xFF959595),
      background: Color(0xFFD4EDEB),
      error: Color(0xFFEE2E31),
      onPrimary: Colors.black,
      onSecondary: Colors.white,
      onSurface: Colors.black, //here
      onBackground: Colors.white,
      onError: Colors.white,
      brightness: Brightness.light,
      ),*/

    // Define the default font family.
    fontFamily: 'Dubai',
    // Define the default TextTheme. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
    //  headline1: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w900, color: Color(0xFF2E5EAA)),
    //  headline2: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w900, color: Colors.white),
    //  headline3: TextStyle(fontSize: 30.0, color: Color(0xFF2E5EAA)),
    subtitle1: TextStyle(fontSize: 17.0, fontWeight: FontWeight.normal),
    //  subtitle2: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700, color: Colors.white),
      bodyText1: TextStyle(fontSize: 12.0, color: Colors.black),
    ),
  );
}