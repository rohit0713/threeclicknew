import 'package:flutter/material.dart';

Future<dynamic> navigateTo(
    {required BuildContext context, required Widget to}) async {
  var res = await Navigator.push(context, MaterialPageRoute(
    builder: (context) {
      return to;
    },
  ));
  return res;
}

navigateRemoveUntil({required BuildContext context, required Widget to}) {
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
    builder: (context) {
      return to;
    },
  ), (route) => false);
}

navigateReplaceMent({required BuildContext context, required Widget to}) {
  Navigator.pushReplacement(context, MaterialPageRoute(
    builder: (context) {
      return to;
    },
  ));
}

Future bottomUpNavigation(
    {required BuildContext context, required Widget to}) async {
  var res = await Navigator.push(
      context,
      PageRouteBuilder(
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) {
          return to;
        },
      ));
  return res;
}

slideTransition({required BuildContext context, required Widget to}) {
  Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return to;
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ));
}
