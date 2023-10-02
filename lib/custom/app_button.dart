

import 'package:flutter/material.dart';
import 'package:threeclick/styles/app_colors.dart';


class AppButton extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final bool isLoading;
  final Color? color;
  const AppButton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.color,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        height: 50,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: ElevatedButton(
          onPressed: isLoading == true ? null : onPressed,
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                color ?? kPrimaryColor,
              ),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              )),
          child: Center(
              child: isLoading == true
                  ?const CircularProgressIndicator(
                      color: whiteColor,
                    )
                  : Text(
                      title,
                      style:const TextStyle(
                          fontSize: 16,
                          color: whiteColor,
                          fontWeight: FontWeight.w400),
                    )),
        ),
      ),
    );
  }
}
