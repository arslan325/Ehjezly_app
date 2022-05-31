import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Constant/constant.dart';
import '../../../Models/user_model.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_dialogue.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/loading_widget.dart';

class ChangeNameAndProfile extends StatefulWidget {
  const ChangeNameAndProfile({Key? key}) : super(key: key);

  @override
  State<ChangeNameAndProfile> createState() => _ChangeNameAndProfileState();
}

class _ChangeNameAndProfileState extends State<ChangeNameAndProfile> {
  final TextEditingController _nameTextEditController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? image;
  @override
  void initState() {
    super.initState();
    _nameTextEditController.text = userController.userData.value.name??"your name";
  }
  Future pickImage() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(file == null) return null;
    setImage(File(file.path));
  }
  void setImage(File? newImage) {
    setState(() {
      image = newImage;
    });
  }
  Widget? _imageWidget(BuildContext context){
    if(image == null && userController.userData.value.profile == null){
      return const Icon(
        Icons.add_a_photo,
        size: 40,
        color: Colors.white,
      );
    }
    else if(image != null) {
      return Image(
        image: FileImage(image!),
        fit: BoxFit.cover,
        width: 120.0,
        height: 120.0,
      );
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text("Edit Profile",style: GoogleFonts.inter(
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
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          child: Column(
            children: [
              const SizedBox(height: 40,),
              Stack(
                children: [
                  Obx(()=>
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: kLightTextColor,
                        backgroundImage: userController.userData.value.profile != null?NetworkImage(userController.userData.value.profile!):null,
                        child: ClipOval(
                            child: _imageWidget(context)),
                      ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80),
                            border: Border.all(color: Colors.white,
                                width: 2
                            )
                        ),
                        child: InkWell(
                          onTap: () {
                            pickImage();
                          } ,
                          child: const CircleAvatar(
                            radius: 20,
                            backgroundColor: kButtonColor,
                            child: Icon(
                              Icons.add_a_photo,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30,),
              Form(
                key: _formKey,
                child: CustomTextField(
                  controller: _nameTextEditController,
                  hintText: 'Enter your new name',
                  validator: (value){
                    if(value.trim().isEmpty){
                      return 'please enter your name';
                    }
                    else{
                      return null;
                    }
                  },
                ),
              ),
              const SizedBox(height: 30,),
              CustomButton(
                  title: 'Save',
                  clickFuction:() {
                    if(image == null && userController.userData.value.profile == null){
                      customDialogue(
                          title: "Something went wrong",
                          bodyText: 'Please select image from gallery',
                          context: context
                      );
                    }
                    else if(image == null && _formKey.currentState!.validate()){
                      loadingDialogue(context: context, message: 'Updating user details');
                      userController.updateUserData({
                        UserModel.userProfile:userController.userData.value.profile,
                        UserModel.userName:_nameTextEditController.text.trim()
                      },context);
                      Get.back();
                      Get.back();
                    }
                    else if(_formKey.currentState!.validate()){
                      loadingDialogue(context: context, message: 'Updating user details');
                      imagePickerController.uploadImageToFirebase('User Images',_nameTextEditController.text,image!).then((url) {
                        setState(() {
                          userController.updateUserData(
                              {
                                UserModel.userProfile:url,
                                UserModel.userName:_nameTextEditController.text.trim()
                              },
                              context);
                          Navigator.pop(context);
                          Get.back();
                        });
                      }).catchError((error) {
                        Navigator.pop(context);
                        Get.snackbar(
                          "Something went wrong",
                          error.message.toString(),
                          backgroundColor: const Color(0x85ffffff),
                        );
                      });
                    }
              })
            ],
          ),
        ),
      ),
    );
  }
}
