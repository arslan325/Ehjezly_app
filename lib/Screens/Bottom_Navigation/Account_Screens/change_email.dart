import 'package:ehjezly_app/widgets/custom_button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Constant/constant.dart';
import '../../../widgets/custom_textfield.dart';
class EditEmailAddressScreen extends StatefulWidget {
  const EditEmailAddressScreen({Key? key}) : super(key: key);

  @override
  _EditEmailAddressScreenState createState() => _EditEmailAddressScreenState();
}

class _EditEmailAddressScreenState extends State<EditEmailAddressScreen> {
  final TextEditingController _emailTextEditController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _emailTextEditController.text = userController.userData.value.email!;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Change Email Address",
            style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: kButtonColor
            ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_sharp,
            color: kButtonColor,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: kBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          child: Column(
            children: [
              const SizedBox(height: 40,),
              Form(
                key: _formKey,
                child: CustomTextField(
                  controller: _emailTextEditController,
                  hintText: 'Enter your new email',
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return 'Please enter your email';
                    }
                    else if(!EmailValidator.validate(value)){
                      return 'email address is not valid';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 30,),
              CustomButton(
                  title: 'Change Email',
                  clickFuction:() {
                if(_formKey.currentState!.validate()){
                  userController.changeEmail(_emailTextEditController.text.trim(),context);
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}

