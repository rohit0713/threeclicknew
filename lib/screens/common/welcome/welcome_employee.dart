import 'package:flutter/material.dart';
import 'package:threeclick/custom/app_button.dart';
import 'package:threeclick/custom/app_text.dart';
import 'package:threeclick/styles/app_colors.dart';

class WelcomeEmployee extends StatelessWidget {
  final String role;

  const WelcomeEmployee({Key? key, required this.role}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                color: kPrimaryColor,
                height: size.height * 0.45,
                width: size.width,
                child: Column(
                  children: [
                    Image.asset(
                      "assets/icons/logo.png",
                      height: size.height * 0.30,
                    ),
                    SizedBox(height: size.height * 0.05),
                    appText(
                        title: "WELCOME TO 3 Clicks Jobs",
                        fontWeight: FontWeight.bold,
                        color: whiteColor),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.05),
              AppButton(onPressed: () {}, title: 'LOGIN'),
              AppButton(onPressed: () {}, title: 'SIGN UP')
            ],
          ),
        ],
      ),
    );
  }
}
