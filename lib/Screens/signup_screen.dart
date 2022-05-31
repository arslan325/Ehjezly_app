import '/Constant/constant.dart';
import '/Screens/forget_password_screen.dart';
import '/Screens/login_screen.dart';
import '/widgets/custom_button.dart';
import '/widgets/custom_textfield.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameTextEditingController = TextEditingController();
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
                Text("Sign Up",style: GoogleFonts.inter(
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
                            controller: _nameTextEditingController,
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return 'Please enter your name';
                              }
                              else if(value.length < 3 ){
                                return 'name field contains at least 3 characters';
                              }
                              return null;
                            },
                            hintText: "Full Name"),
                        SizedBox(height: height*0.020,),
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
                            else if(value.length < 6 ){
                              return 'password contains at least 6 characters';
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
                CustomButton(title: 'Sign Up',
                  clickFuction: (){
                    if(_formKey.currentState!.validate()){
                      userController.signUp(
                        _nameTextEditingController.text.trim(),
                        _emailTextEditController.text.trim(),
                        _passwordTextEditController.text.trim(),
                        context,
                      );
                    }
                  },
                ),
                const SizedBox(height: 5,),
                TextButton(
                  onPressed: (){
                    Get.off(const LoginScreen());
                  },
                  child:Text.rich(
                      TextSpan(
                          children: <InlineSpan>[
                            TextSpan(
                              text: 'Already have an account? ',
                              style: GoogleFonts.inter(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                  color: kLightTextColor
                              ),
                            ),
                            TextSpan(
                              text: 'Login',
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
