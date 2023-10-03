import 'package:flutter/material.dart';
import 'package:threeclick/styles/app_colors.dart';

class AppButton extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final bool isLoading;
  final Color? color;
  final Color? textColor;
  final double width;
  const AppButton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.color,
      this.width = 0.8,
      this.textColor = Colors.white,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      width: size.width * width,
      decoration: BoxDecoration(
        border: Border.all(
            color: kPrimaryColor, width: 1.0, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(29),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: TextButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            primary: color ?? kPrimaryColor,
          ),
          /*  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          color: color,*/
          onPressed: onPressed,
          child: Text(
            title,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
