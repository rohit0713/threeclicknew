import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:threeclick/custom/app_button.dart';
import 'package:threeclick/custom/app_text.dart';
import 'package:threeclick/custom/app_text_field.dart';
import 'package:threeclick/custom/have_account.dart';
import 'package:threeclick/custom/toast_message.dart';
import 'package:threeclick/custom/validate_connectivity.dart';
import 'package:threeclick/screens/common/login.dart';
import 'package:threeclick/styles/app_colors.dart';
import 'package:threeclick/view_models/common/login_provider.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: kPrimaryColor,
              height: size.height * 0.35,
              width: size.width,
              child: Image.asset(
                "assets/icons/logo.png",
                height: size.height * 0.35,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            RichText(
                text: const TextSpan(children: [
              TextSpan(
                text: "Did you ",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: blackColor),
              ),
              TextSpan(
                text: "forget your password?  ",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ])),
            const SizedBox(
              height: 18,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: appText(
                title:
                    "Please fill in the email you've used to create a ThreeClick account and we'll send a reset link",
                textAlign: TextAlign.center,
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: kPrimaryColor,
              ),
            ),
            const SizedBox(
              height: 48,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appText(
                    title: "Email ID*",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  AppTextField(
                    controller: emailController,
                    labelText: 'Email*',
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Consumer<LoginProvider>(builder: (context, provider, child) {
              return AppButton(
                  isLoading: provider.showLoader,
                  onPressed: () {
                    forgetPassword();
                  },
                  title: 'Submit');
            }),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const Login(
                        role: '',
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void forgetPassword() async {
    validateConnectivity(
        context: context,
        provider: () {
          if (emailController.text.isEmpty) {
            showToast('Please enter email.');
          } else {
            var provider = Provider.of<LoginProvider>(context, listen: false);
            Map<String, dynamic> body = {
              'email': emailController.text,
            };
            provider.forgotPassword(context: context, body: body).then((value) {
              if (value) {
                Navigator.pop(context);
              }
            });
          }
        });
  }
}
