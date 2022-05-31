import '/Constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class CustomButton extends StatelessWidget {
  final String title;
  final Color? color;
  final Color? textColor;
  final VoidCallback clickFuction;
   const CustomButton({this.textColor,this.color,required this.title,required this.clickFuction});
  @override
  Widget build(BuildContext context) {
    final width =MediaQuery.of(context).size.width.toInt();
    return Container(
      height: 48,
      width: double.infinity,
      margin: const EdgeInsets.all(0),
      child: MaterialButton(
        elevation: 0,
        color: color ?? kButtonColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
        ),
        onPressed: clickFuction,
        child: Text(title, style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: textColor ?? Colors.white
        ),),
      ),
    );
  }
}