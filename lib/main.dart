import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:threeclick/custom_providers.dart';
import 'package:threeclick/screens/common/app.dart';
import 'package:threeclick/view_models/common/login_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var state = LoginProvider(await SharedPreferences.getInstance());
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(CustomProvider(
        state: state,
        child:  MyApp(),
      )));
}
