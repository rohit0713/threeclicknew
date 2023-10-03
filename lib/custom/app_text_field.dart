import 'package:flutter/material.dart';
import 'package:threeclick/styles/app_colors.dart';

class AppTextField extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? iconData;
  final Widget? leadingIcon;
  final String? labelText;
  final TextStyle? labelStyle;
  final TextStyle? style;
  final bool readOnly;
  final Color? borderColor;
  final TextEditingController? controller;
  final Function()? onTap;
  final String? hintText;
  final void Function(String value)? onChanged;
  final String? Function(String?)? validator;
  final String? initialValue;
  final bool obscureText;
  final FocusNode? focusNode;
  final int? maxLength;
  final int? maxLines;
  final String? counterText;
  final double? fontSize;
  final Widget? prefixIcon;
  final TextInputType? keyBoardType;
  final bool? enabled;
  final void Function(String)? onFieldSubmitted;
  final EdgeInsetsGeometry contentPadding;
  final String obscuringCharacter;
  final TextAlign textAlign;
  final String? helperText;
  const AppTextField({
    super.key,
    this.labelText,
    this.width = 1,
    this.iconData,
    this.controller,
    this.onTap,
    this.readOnly = false,
    this.height = 60,
    this.hintText,
    this.helperText,
    this.onChanged,
    this.prefixIcon,
    this.leadingIcon,
    this.initialValue,
    this.style = const TextStyle(),
    this.validator,
    this.fontSize = 14,
    this.obscureText = false,
    this.focusNode,
    this.keyBoardType,
    this.enabled = true,
    this.textAlign = TextAlign.start,
    this.onFieldSubmitted,
    this.maxLines = 1,
    this.borderColor,
    this.labelStyle,
    this.maxLength,
    this.counterText,
    this.obscuringCharacter = '•',
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
  });

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height,
      width: w * width!,
      child: TextFormField(
        onFieldSubmitted: onFieldSubmitted,
        enabled: enabled,
        focusNode: focusNode,
        initialValue: initialValue,
        validator: validator,
        onChanged: onChanged,
        readOnly: readOnly,
        obscureText: obscureText,
        onTap: onTap,
        textAlign: textAlign,
        keyboardType: keyBoardType,
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLength: maxLength,
        maxLines: maxLines,
        enableSuggestions: true,
        style: TextStyle(
            fontSize: fontSize,
            fontFamily: 'WorkSans',
            fontWeight: FontWeight.normal,
            color: kPrimaryColor),
        obscuringCharacter: obscuringCharacter,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          counterText: '',
          prefix: leadingIcon,
          filled: readOnly,
          hintText: hintText,
          helperText: helperText,
          suffixIcon: iconData,
          labelText: labelText == '' ? null : labelText,
          // contentPadding: contentPadding,
          alignLabelWithHint: true,
          labelStyle: const TextStyle(
              fontFamily: 'WorkSans',
              fontWeight: FontWeight.normal,
              color: kPrimaryColor),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: primaryTextColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: primaryTextColor,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: primaryTextColor, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: appRed),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: appRed),
          ),
        ),
      ),
    );
  }
}
