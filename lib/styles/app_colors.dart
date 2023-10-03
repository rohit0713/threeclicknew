import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF172243);
const kPrimaryLightColor = Color(0xFFF1E6FF);
const primaryTextColor = Colors.black;
const whiteColor = Colors.white;
const blackColor = Colors.black;
Color darkGreen = const Color.fromRGBO(66, 192, 56, 1);
const locationTextColor = Color(0xFFB6B6B6);
Color appRed = const Color.fromARGB(255, 247, 5, 50);

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
