import 'package:flutter/material.dart';

ThemeData temaSatpj(){
  return ThemeData(

    //accentColor: Color(0xFF23D797)
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white
    ),

    iconTheme: IconThemeData(
      color: Color(0xFFD4EDEB),
    ),
    colorScheme: ColorScheme(
      primary: Color(0xFF2E5EAA), 
      primaryVariant: Color(0xFF24467C), 
      secondary: Color(0xFF23D797), 
      secondaryVariant: Color(0xFF1DA776),
      surface: Color(0xFF959595),
      background: Color(0xFFD4EDEB),
      error: Color(0xFFEE2E31),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      onBackground: Colors.black,
      onError: Colors.white,
      brightness: Brightness.light,
      ),
    // Define the default font family.
    fontFamily: 'Dubai',
    // Define the default TextTheme. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w900, color: Color(0xFF2E5EAA)),
      headline2: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w900, color: Colors.white),
      headline3: TextStyle(fontSize: 30.0, color: Color(0xFF2E5EAA)),
      subtitle1: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal, color: Color(0xFF2E5EAA)),
      subtitle2: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700, color: Colors.white),
      bodyText1: TextStyle(fontSize: 12.0, color: Color(0xFF2E5EAA)),
    ),
  );
}

const kAccentColor = Color(0xFF23D797);
const kPrimaryColor = Color(0xFF2E5EAA);