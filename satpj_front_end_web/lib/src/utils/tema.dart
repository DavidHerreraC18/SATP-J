import 'package:flutter/material.dart';

ThemeData temaSatpj(){
  return ThemeData(
    // Define the default brightness and colors.
    //brightness: Brightness.dark,
    primaryColor: Colors.white,
    accentColor: Color(0xFF23D797),

    // Define the default font family.
    fontFamily: 'Dubai',

    // Define the default TextTheme. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold, color: Colors.blue),
    ),
  );
}