
import 'package:flutter/material.dart';

class MyStyles {

  static const double fontSize = 20.0;
  static const String fontName = 'Hannom';

  static const TextStyle titleTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold
  );

  static const TextStyle textStyle = TextStyle(
    fontSize: fontSize,
    fontFamily: fontName,
    color: Colors.white
  );

  static TextStyle nonLatinTextStyle ({double size =20,Color? color }){
    return TextStyle(
        fontSize: size,
        fontFamily: fontName,
        color: color ?? Colors.white
    );
  }
}