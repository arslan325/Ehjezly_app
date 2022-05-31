import '/Constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoInternetConnectionScreen extends StatefulWidget {
  const NoInternetConnectionScreen({Key? key}) : super(key: key);

  @override
  _NoInternetConnectionScreenState createState() => _NoInternetConnectionScreenState();
}

class _NoInternetConnectionScreenState extends State<NoInternetConnectionScreen> {
  @override
  Widget build(BuildContext context) {
    final width =MediaQuery.of(context).size.width.toInt();
    final height =MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: width*0.65,
                child: const Image(
                  image: AssetImage('images/Lifesavers Bust.png'),
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20,),
              Text("No Internet Connection",style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kButtonColor
              ),),
              const SizedBox(height: 5,),
              Text("Tap the screen to try again",style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: kLightTextColor
              ),),
            ],
    ),
          ),
        ),
      ),
    );
  }
}
