import 'package:flutter/material.dart';

class MyConstant {
//field
  static Color primary = Color.fromARGB(255, 32, 79, 51);
  static Color dark = Color.fromARGB(255, 15, 36, 23);
  static Color light = Color.fromARGB(255, 62, 152, 98);
  static Color active = Color.fromARGB(255, 152, 62, 126);

//method

  BoxDecoration planBox() {
    return BoxDecoration(color: light.withOpacity(0.25));
  }

  TextStyle h1Style() {
    return TextStyle(
      color: dark,
      fontSize: 36,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle h2Style() {
    return TextStyle(
      color: dark,
      fontSize: 18,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle h3Style() {
    return TextStyle(
      color: dark,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    );
  }

  TextStyle h3ActiveStyle() {
    return TextStyle(
      color: active,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
  }
}
