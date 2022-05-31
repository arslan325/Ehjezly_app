import 'dart:math';

import 'package:ehjezly_app/Constant/constant.dart';
import 'package:ehjezly_app/Controllers/appointment_controller.dart';
import 'package:ehjezly_app/Controllers/notification_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'Controllers/doctor_controller.dart';
import 'Controllers/image_controller.dart';
import 'Controllers/user_controller.dart';
import 'Screens/Bottom_Navigation/contact_us.dart';
import 'Screens/Bottom_Navigation/home_page.dart';
import 'Screens/Bottom_Navigation/notification_page.dart';
import 'Screens/Bottom_Navigation/setting_page.dart';
import 'Screens/home_screen.dart';
import 'Screens/welcome_screen.dart';
import 'managers/preference_manager.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceManager().init();
   await Firebase.initializeApp().then((value) {
    Get.put(UserController());
    Get.put(ImagePickerController());
    Get.put(DoctorController());
    Get.put(AppointmentController());
    Get.put(NotificationController());
  });

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: tintColor(color, 0.9),
      100: tintColor(color, 0.8),
      200: tintColor(color, 0.6),
      300: tintColor(color, 0.4),
      400: tintColor(color, 0.2),
      500: color,
      600: shadeColor(color, 0.1),
      700: shadeColor(color, 0.2),
      800: shadeColor(color, 0.3),
      900: shadeColor(color, 0.4),
    });
  }
  int tintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  Color tintColor(Color color, double factor) => Color.fromRGBO(
      tintValue(color.red, factor),
      tintValue(color.green, factor),
      tintValue(color.blue, factor),
      1);

  int shadeValue(int value, double factor) =>
      max(0, min(value - (value * factor).round(), 255));

  Color shadeColor(Color color, double factor) => Color.fromRGBO(
      shadeValue(color.red, factor),
      shadeValue(color.green, factor),
      shadeValue(color.blue, factor),
      1);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: generateMaterialColor(kButtonColor),
       primaryColor: kButtonColor
      ),
      initialRoute: 'welcome',
      routes: {
        'welcome':(context) => FirebaseAuth.instance.currentUser ==null? const WelcomeScreen() : const HomeScreen(),
        'Home':(context) => const HomePage(),
        'contactUs':(context) => const ContactUsPage(),
        'setting':(context) => const SettingPage(),
        'notification':(context) => const NotificationPage(),

      },
    );
  }
}

