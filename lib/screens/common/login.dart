import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:threeclick/custom/app_button.dart';
import 'package:threeclick/custom/app_text_field.dart';
import 'package:threeclick/custom/have_account.dart';
import 'package:threeclick/custom/navigation.dart';
import 'package:threeclick/custom/toast_message.dart';
import 'package:threeclick/custom/validate_connectivity.dart';
import 'package:threeclick/screens/agent/agent_bottom_navigation.dart';
import 'package:threeclick/screens/common/forgot_password.dart';
import 'package:threeclick/screens/common/registration/agent_registration.dart';
import 'package:threeclick/screens/common/registration/emp_registration.dart';
import 'package:threeclick/screens/common/registration/employee_reg.dart';
import 'package:threeclick/screens/employee/employee_bottom_navigation.dart';
import 'package:threeclick/screens/employer/employer_bottom_navigation.dart';
import 'package:threeclick/styles/app_colors.dart';
import 'package:threeclick/view_models/common/login_provider.dart';

class Login extends StatefulWidget {
  final String role;
  const Login({super.key, required this.role});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    AppTextField(
                      controller: _phoneController,
                      keyBoardType: TextInputType.number,
                      labelText: 'Phone Number',
                      width: 1,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppTextField(
                      controller: _passwordController,
                      keyBoardType: TextInputType.number,
                      labelText: 'Password',
                      obscureText: true,
                      width: 1,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  slideTransition(context: context, to: const ForgetPassword());
                },
                child: const Text(
                  "Forget Password?",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.red),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Consumer<LoginProvider>(builder: (context, provider, child) {
                return AppButton(
                    isLoading: provider.showLoader,
                    onPressed: () {
                      _login();
                    },
                    title: "LOGIN");
              }),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                press: () {
                  if (widget.role == "user") {
                    slideTransition(context: context, to: const EmployeeReg());
                  } else if (widget.role == "agent") {
                    slideTransition(
                        context: context, to: const AgentRegistration());
                  } else {
                    slideTransition(
                        context: context, to: const EmpRegistration());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _login() {
    validateConnectivity(
        context: context,
        provider: () {
          var provider = Provider.of<LoginProvider>(context, listen: false);
          Map<String, dynamic> body = {
            'contact_no': _phoneController.text.toString(),
            'password': _passwordController.text.toString(),
          };
          provider.login(body, context: context).then((value) {
            if (value) {
              showToast('Logged in successfully.', isSuccess: true);
              navigateRemoveUntil(
                  context: context,
                  to: _navigation(
                      provider.userData.response?.user?[0].role ?? ''));
            }
          });
        });
  }

  _navigation(String userType) {
    switch (userType.toLowerCase()) {
      case 'user':
        return const EmployeeBottomNavigation();
      case 'company':
        return BottomNavigationBarEmployer();
      case 'individual':
        return BottomNavigationBarEmployer();
      case 'agent':
        return const AgentBottomNavigation();
    }
  }
}
