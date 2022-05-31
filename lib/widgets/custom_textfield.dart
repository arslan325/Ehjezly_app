import '/Constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function validator;
  final String hintText;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final bool? hideText;
  const CustomTextField({
    required this.controller,
    required this.validator,
    required this.hintText,
    this.leadingIcon,
    this.trailingIcon,
    this.hideText,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: hideText??false,
      validator: (value) => validator(value),
      decoration: InputDecoration(
          hintText: hintText,
        suffixIcon: trailingIcon,
        prefix: leadingIcon,
       contentPadding: const EdgeInsets.symmetric(vertical: 17,horizontal: 10),
          hintStyle: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: kLightTextColor
          ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusColor: kButtonColor,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kButtonColor, width: 1.0),
          borderRadius: BorderRadius.circular(8),
        ),

      ),
    );
  }
}
