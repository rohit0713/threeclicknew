
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:threeclick/styles/app_colors.dart';

var fToast;
showToast(String input,
    {ToastGravity? alignment = ToastGravity.BOTTOM, bool isSuccess = false}) {
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: isSuccess ? darkGreen : appRed,
    ),
    child: Text(
      input,
      maxLines: 10,
      overflow: TextOverflow.visible,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontFamily: 'OpenSans',
        color: Color.fromRGBO(255, 255, 255, 1),
        fontSize: 14,
      ),
    ),
  );

  fToast.showToast(
    child: toast,
    gravity: alignment,
    toastDuration: const Duration(seconds: 3),
  );
}
