


import 'package:flutter/material.dart';
import 'package:threeclick/custom/app_button.dart';
import 'package:threeclick/custom/navigation.dart';
import 'package:threeclick/screens/common/welcome/welcome_employee.dart';
import 'package:threeclick/styles/app_colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}):super(key: key);


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

                   const Text(
                      "WELCOME TO 3 Clicks Jobs",
                      style: TextStyle(fontWeight: FontWeight.bold,color: whiteColor),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.05),
            const  Text(
                "Where do you want to go",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.05),
              AppButton(onPressed: (){
                navigateTo(context: context, to:const WelcomeEmployee(role: 'role'));
              }, title: 'Employee'),
              AppButton(onPressed: (){
                navigateTo(context: context, to:const WelcomeEmployee(role: 'role'));
              }, title: 'Agent'),
              AppButton(onPressed: (){
                navigateTo(context: context, to:const WelcomeEmployee(role: 'role'));
              }, title: 'Employer'),
            
            ],
          ),
        ],
      ),
    );
  }
}
