
import 'package:flutter/material.dart';

Text appText(
    {required String title,
    double fontSize = 12,
    FontWeight fontWeight = FontWeight.w400,
    Color? color,
    TextAlign? textAlign,
    TextOverflow? textOverflow}) {
  return Text(
    title,
    textAlign: textAlign,
    style: TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      overflow: textOverflow,
    ),
  );
}
