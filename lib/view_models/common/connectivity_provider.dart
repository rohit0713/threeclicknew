import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

class CheckInternet extends ChangeNotifier {
  String status = 'waiting...';
  // final Connectivity _connectivity = Connectivity();

  Future<bool> checkConnectivity() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
   
  }
}
