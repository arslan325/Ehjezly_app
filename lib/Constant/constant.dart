import 'package:ehjezly_app/Controllers/appointment_controller.dart';
import 'package:ehjezly_app/Controllers/notification_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Controllers/doctor_controller.dart';
import '../Controllers/image_controller.dart';
import '/Controllers/user_controller.dart';
import 'package:flutter/material.dart';


const  kBackgroundColor = Colors.white;
const kButtonColor = Color(0xff432c81);
const kLightTextColor = Color(0xff7b6ba8);
const kButtonTextColor = Colors.white;
const kLightGreyColor = Color(0xffedecf5);
const kLightGrey2Color = Color(0xfff4f5f6);


FirebaseAuth firebaseAuth = FirebaseAuth.instance;



UserController userController = UserController.instance;

ImagePickerController imagePickerController = ImagePickerController.instance;
DoctorController doctorController = DoctorController.instance;
AppointmentController appointmentController = AppointmentController.instance;
NotificationController notificationController = NotificationController.instance;

