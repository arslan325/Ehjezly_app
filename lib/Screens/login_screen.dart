import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Constant/constant.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import 'forget_password_screen.dart';
import 'signup_screen.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTextEditController = TextEditingController();

  final TextEditingController _passwordTextEditController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool obscure = true;

  void visibility(){
    setState(() {
      obscure = !obscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width =MediaQuery.of(context).size.width.toInt();
    final height =MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30,),
                Align(
                  alignment: Alignment.center,
                  child: Text("Welcome Back",style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: kButtonColor
                  ),),
                ),
                const SizedBox(height: 10),
                Text("Login",style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
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
                        SizedBox(height: height*0.020,),
                        CustomTextField(
                            controller: _passwordTextEditController,
                            hideText: obscure,
                            trailingIcon: obscure ? IconButton(
                              icon: const Icon(Icons.remove_red_eye,
                                color: kLightTextColor,),
                              onPressed: visibility,
                            ) : IconButton
                              (onPressed: visibility,
                                icon: const Icon(Icons.visibility_off,
                                  color: kLightTextColor,
                                )),
                            hintText: "Password",
                            validator:(value) {
                              if (value.trim().isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },),
                      ],
                    )),
                SizedBox(height: height*0.015,),
                InkWell(
                  onTap: (){
                    Get.to(const ForgetPasswordScreen());
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text("Forgot Password?",style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: kButtonColor
                    ),),
                  ),
                ),
                const SizedBox(height: 30,),
                CustomButton(title: 'Login',
                  clickFuction: (){
                    if(_formKey.currentState!.validate()){
                      userController.logIn(_emailTextEditController.text,
                          _passwordTextEditController.text, context);
                    }
                  },
                ),
                const SizedBox(height: 5,),
                TextButton(
                  onPressed: (){
                    Get.to(const SignUpScreen());
                  },
                  child:Text.rich(
                      TextSpan(
                          children: <InlineSpan>[
                            TextSpan(
                              text: 'Don’t have an account? ',
                              style: GoogleFonts.inter(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                  color: kLightTextColor
                              ),
                            ),
                            TextSpan(
                              text: 'Sign Up',
                              style: GoogleFonts.inter(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: kButtonColor
                              ),
                            ),
                          ]
                      )
                  ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
