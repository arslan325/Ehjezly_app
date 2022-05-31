import '/Constant/constant.dart';
import '/Screens/no_internet_screen.dart';
import '/widgets/custom_button.dart';
import '/widgets/custom_textfield.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailTextEditController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final width =MediaQuery.of(context).size.width.toInt();
    final height =MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Column(
              children: [
                const SizedBox(height: 70,),
                Text("Reset Password",style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: kButtonColor
                ),),
                const SizedBox(height: 5,),
                Text("Please enter email for reset your password.",style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: kButtonColor
                ),),
                const SizedBox(height: 30),
                SizedBox(
                  width: width*0.75,
                  child: const Image(
                    image: AssetImage('images/Lifesavers Bust.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: height*0.025,),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                            controller: _emailTextEditController,
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return 'Please enter your email';
                              }
                              else if(!EmailValidator.validate(value)){
                                return 'email address is not valid';
                              }
                              return null;
                            },
                            hintText: "Email"),
                      ],
                    )),
                const SizedBox(height: 20,),
                CustomButton(title: 'Reset Password',
                  clickFuction: (){
                    if(_formKey.currentState!.validate()){
                      userController.resetPassword(_emailTextEditController.text,context);
                      // Get.to(const NoInternetConnectionScreen());
                      // print("login");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
