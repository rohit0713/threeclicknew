import 'package:flutter/material.dart';
import 'package:threeclick/custom/app_button.dart';
import 'package:threeclick/custom/app_text.dart';
import 'package:threeclick/custom/navigation.dart';
import 'package:threeclick/screens/common/registration/agent_registration.dart';
import 'package:threeclick/screens/common/login.dart';
import 'package:threeclick/screens/common/registration/emp_registration.dart';
import 'package:threeclick/screens/common/registration/employee_reg.dart';
import 'package:threeclick/styles/app_colors.dart';

class WelcomeEmployee extends StatelessWidget {
  final String role;

  const WelcomeEmployee({Key? key, required this.role}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
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
                AppButton(
                    onPressed: () {
                      navigateTo(
                          context: context,
                          to: Login(
                            role: role,
                          ));
                    },
                    title: 'LOGIN'),
                const SizedBox(
                  height: 10,
                ),
                AppButton(
                    color: whiteColor,
                    textColor: kPrimaryColor,
                    onPressed: () {
                      if (role.toLowerCase() == 'agent') {
                        slideTransition(
                            context: context, to: const AgentRegistration());
                      } else if (role == 'employer') {
                        slideTransition(
                            context: context, to: const EmpRegistration());
                      } else {
                        slideTransition(
                            context: context, to: const EmployeeReg());
                      }
                    },
                    title: 'SIGN UP')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
