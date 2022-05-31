import '/Constant/constant.dart';
import '/Screens/login_screen.dart';
import '/Screens/signup_screen.dart';
import '/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width =MediaQuery.of(context).size.width.toInt();
    final height =MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30,left: 20,right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20,),
                Align(
                  alignment: Alignment.center,
                  child: Text("Welcome to",style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: kButtonColor
                  ),),
                ),
                const SizedBox(height: 10),
                Text("Ehjezly",style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: kButtonColor
                ),),
                const SizedBox(height: 50),
                SizedBox(
                  width: width*0.85,
                  child: const Image(
                    image: AssetImage('images/Lifesavers Bust.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 70,),
                CustomButton(title: 'Sign Up',
                  clickFuction:
                      (){
                        Get.to(const SignUpScreen());
                  },
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: MaterialButton(
                    elevation: 0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: const BorderSide(color: kButtonColor)
                    ),
                    onPressed: (){
                      Get.to(const LoginScreen());
                    },
                    child: Text("Login", style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: kButtonColor
                    ),),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
