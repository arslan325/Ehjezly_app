import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Constant/constant.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController verifyNewPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text("Change Password",style: GoogleFonts.inter(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: kButtonColor
        ),),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_sharp,
            color: kButtonColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: kBackgroundColor,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Change your password",
                  style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Enter your old and new password to reset your password",
                  style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  CustomTextField(
                    validator: (value){
                      if(value.trim().isEmpty){
                        return 'please enter your old password';
                      }
                      if(value != userController.userData.value.password){
                        return 'old password is wrong';
                      }
                      else{
                        return null;
                      }
                    },
                    controller: oldPasswordController,
                    hintText: "old password",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    validator: (value){
                      if(value.trim().isEmpty){
                        return 'please enter your new password';
                      }
                      if(value == oldPasswordController.text){
                        return 'new password must be different from old password';
                      }
                      else{
                        return null;
                      }
                    },
                    controller: newPasswordController,
                    hintText: "New password",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    validator: (value){
                      if(value.trim().isEmpty){
                        return 'please enter your confirm password';
                      }
                      else if(value != newPasswordController.text){
                        return 'password does not match with new password';
                      }
                      else{
                        return null;
                      }
                    },
                    controller: verifyNewPasswordController,
                    hintText: "Confirm password",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      title: 'Save',
                      clickFuction:() {
                        if(_formKey.currentState!.validate()){
                          userController.changePassword(
                            oldPasswordController.text.trim(),
                            newPasswordController.text.trim(),
                            context,
                          );
                        }
                      }),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
