import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:threeclick/custom/app_button.dart';
import 'package:threeclick/custom/toast_message.dart';
import 'package:threeclick/custom/validate_connectivity.dart';
import 'package:threeclick/styles/app_colors.dart';
import 'package:threeclick/view_models/common/registration_provider.dart';

class OTPVerification extends StatefulWidget {
  const OTPVerification(
      {Key? key,
      required this.phone,
      required this.hashKey,
      required this.isVerified})
      : super(key: key);
  final String phone;
  final String hashKey;
  final bool isVerified;

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  String currentText = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: kPrimaryColor,
              height: size.height * 0.25,
              width: size.width,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Image.asset(
                    "assets/icons/logo.png",
                    scale: 2,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.09,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
              child: RichText(
                text: TextSpan(children: [
                  const TextSpan(
                      text:
                          "Enter the 6 digit, One Time Password send on your number +91 ",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 15)),
                  TextSpan(
                      text: widget.phone,
                      style: const TextStyle(
                          letterSpacing: 2,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15))
                ], style: const TextStyle(color: Colors.black54, fontSize: 15)),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              // key: formKey,
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 42),
                  child: PinCodeTextField(
                    appContext: context,
                    pastedTextStyle: TextStyle(
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                    length: 6,
                    blinkWhenObscuring: true,
                    animationType: AnimationType.fade,
                    validator: (v) {
                      if (v!.length < 3) {
                        return "I'm from validator";
                      } else {
                        return null;
                      }
                    },
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 40,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                        disabledColor: whiteColor),
                    cursorColor: Colors.black,
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: false,
                    errorAnimationController: errorController,
                    controller: textEditingController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      debugPrint(value);
                      setState(() {
                        currentText = value;
                      });
                    },
                  )),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Didn't get OTP?",
                      style: TextStyle(
                        fontSize: 16,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'WorkSans',
                      )),
                  InkWell(
                    onTap: () {
                      _resendOtp();
                    },
                    child: Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.black87,
                      ),
                      child: const Center(
                        child: Text(
                          "Resend OTP",
                          style: TextStyle(
                            fontSize: 12,
                            color: whiteColor,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'WorkSans',
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 150,
            ),
            Consumer<RegistrationProvider>(builder: (context, provider, child) {
              return AppButton(
                  isLoading: provider.showLoader,
                  onPressed: () {
                    verifyOTP();
                  },
                  title: 'Verify');
            })
          ],
        ),
      ),
    );
  }

  _resendOtp() {
    validateConnectivity(
        context: context,
        provider: () {
          var provider =
              Provider.of<RegistrationProvider>(context, listen: false);
          Map<String, dynamic> body = {
            'mobile_no': widget.phone,
          };
          provider.sendOtp(context: context, body: body).then((value) {
            if (value) {
              showToast('OTP resend to your mobile number.', isSuccess: true);
            }
          });
        });
  }

  void verifyOTP() async {
    validateConnectivity(
        context: context,
        provider: () {
          var provider =
              Provider.of<RegistrationProvider>(context, listen: false);
          Map<String, dynamic> body = {
            'otp': textEditingController.text,
            "hash_key": provider.hashKey
          };
          provider.verifyOtp(context: context, body: body).then((value) {
            if (value) {
              showToast('OTP verified successfully.', isSuccess: true);
              Navigator.pop(context, 'data');
            }
          });
        });
  }
}
