import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        margin: EdgeInsets.only(top: size.height * 0.005),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Align(
                alignment: FractionalOffset.center,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.asset(
                    "assets/icons/logo.png",
                    fit: BoxFit.fill,
                    height: size.height * 0.4,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  startTime() async {
    return new Timer(Duration(milliseconds: 3000), NavigatorPage);
  }

  Future<void> NavigatorPage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLogging = prefs.getBool("isLogging");
    String? role = prefs.getString("role")?.toLowerCase();
    if (isLogging == null || role == null) {
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) {
      //       return WelcomeChooseScreen();
      //     },
      //   ),
      // );
    } else {
      if (isLogging) {
        if (role.toString().compareTo("user") == 0) {
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) {
          //       return EmployeeBottomNavigation(
          //         currentIndex: 0,
          //       );
          //     },
          //   ),
          // );
        } else if (role.toString().toLowerCase().compareTo("company") == 0 ||
            role.toString().toLowerCase().compareTo("individual") == 0) {
          // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          //   builder: (context) {
          //     return bottomNavigationBarEmployer(
          //       currentIndex: 0,
          //     );
          //   },
          // ), (e) => false);
        } else {
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) {
          //       return bottomNavigationBarT2();
          //     },
          //   ),
          // );
        }
      } else {
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) {
        //       return WelcomeChooseScreen();
        //     },
        //   ),
        // );
      }
    }
  }
}
