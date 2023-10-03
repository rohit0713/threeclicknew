import 'package:flutter/material.dart';
import 'package:threeclick/custom/app_button.dart';
import 'package:threeclick/custom/app_text_field.dart';
import 'package:threeclick/custom/have_account.dart';
import 'package:threeclick/custom/navigation.dart';
import 'package:threeclick/custom/toast_message.dart';
import 'package:threeclick/custom/validate_connectivity.dart';
import 'package:threeclick/screens/common/registration/agent_personal_info.dart';
import 'package:threeclick/screens/common/login.dart';
import 'package:threeclick/styles/app_colors.dart';

class AgentRegistration extends StatefulWidget {
  const AgentRegistration({super.key});

  @override
  State<AgentRegistration> createState() => _AgentRegistrationState();
}

class _AgentRegistrationState extends State<AgentRegistration> {
  bool _obscureText = true;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    AppTextField(
                      controller: _nameController,
                      labelText: "Name",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppTextField(
                      controller: _emailController,
                      labelText: "Email",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppTextField(
                      controller: _passwordController,
                      labelText: "Password",
                      obscureText: _obscureText,
                      iconData: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: primaryTextColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppTextField(
                      controller: _phoneController,
                      keyBoardType: TextInputType.number,
                      labelText: "Phone",
                      maxLength: 10,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppTextField(
                      controller: _ageController,
                      keyBoardType: TextInputType.number,
                      labelText: "Age",
                      maxLength: 2,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    AppButton(
                        onPressed: () {
                          _submit();
                        },
                        title: 'SIGN UP'),
                    SizedBox(height: size.height * 0.03),
                    AlreadyHaveAnAccountCheck(
                      login: false,
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const Login(
                                role: 'Agent',
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _submit() {
    validateConnectivity(
        context: context,
        provider: () {
          if (_nameController.text.isEmpty) {
            showToast('Please enter your name.');
          } else if (_emailController.text.isEmpty) {
            showToast('Please enter your email.');
          } else if (!isValidEmail(_emailController.text)) {
            showToast('Please enter valid email.');
          } else if (_passwordController.text.isEmpty) {
            showToast('Please enter your password.');
          } else if (!isValidPassword(_passwordController.text)) {
            showToast(
                "Password must contain at least 8 characters with\none uppercase , one lowercase , one number and\none special character.");
          } else if (_phoneController.text.isEmpty) {
            showToast('Please enter your phone number.');
          } else if (int.tryParse(_phoneController.text) == null ||
              _phoneController.text.length < 10) {
            showToast('Please enter valid phone number.');
          } else if (_ageController.text.isEmpty) {
            showToast('Please enter your age.');
          } else {
            navigateTo(
                context: context,
                to: AgentPersonalInfo(
                    name: _nameController.text,
                    password: _passwordController.text,
                    email: _emailController.text,
                    phone: _phoneController.text,
                    age: _ageController.text));
          }
        });
  }

  bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  bool isValidPassword(String password) {
    return RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)").hasMatch(password);
  }
}
