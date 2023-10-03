import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:threeclick/view_models/common/connectivity_provider.dart';
import 'package:threeclick/view_models/common/login_provider.dart';
import 'package:threeclick/view_models/common/registration_provider.dart';

class CustomProvider extends StatelessWidget {
  final Widget child;
  final LoginProvider state;
  const CustomProvider({super.key, required this.child, required this.state});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CheckInternet()),
        ChangeNotifierProvider(create: (context) => state),
        ChangeNotifierProvider(create: (context) => RegistrationProvider()),
      ],
      child: child,
    );
  }
}
