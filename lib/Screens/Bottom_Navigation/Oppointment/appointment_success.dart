import 'package:ehjezly_app/Screens/home_screen.dart';
import 'package:ehjezly_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../Constant/constant.dart';

class AppointmentSuccess extends StatefulWidget {
  const AppointmentSuccess({Key? key}) : super(key: key);

  @override
  State<AppointmentSuccess> createState() => _AppointmentSuccessState();
}

class _AppointmentSuccessState extends State<AppointmentSuccess> with TickerProviderStateMixin{
  late final AnimationController animationControllerForSignUpCompleting;

  @override
  void initState() {
    super.initState();
    animationControllerForSignUpCompleting = AnimationController(vsync: this);
  }
  @override
  void dispose() {
    animationControllerForSignUpCompleting.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CircleAvatar(
              backgroundColor: kLightGreyColor,
              backgroundImage: userController.userData.value.profile != null?NetworkImage(userController.userData.value.profile!):null,
              radius: 30,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: userController.userData.value.profile == null?const Image(
                  image: AssetImage('images/avatar.png'),
                  fit: BoxFit.cover,
                ):null,
              ),
            ),
          ),
        ],
        title: Text("Success",style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: kButtonColor
        ),),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 70,),
            SizedBox(
              width: 190,
              height: 190,
              child: Lottie.asset(
                'images/done1.json',
                options: LottieOptions(enableMergePaths: true),
                fit: BoxFit.fill,
                controller: animationControllerForSignUpCompleting,
                onWarning: (warning) {
                  debugPrint("🔴 Lottie warning $warning");
                },
                onLoaded: (composition) {
                  Future.delayed(const Duration(microseconds: 900),
                          () {
                        animationControllerForSignUpCompleting
                          ..duration = composition.duration
                          ..forward();
                      });
                },
                //repeat: true,
              ),
            ),
            Text("Success",style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),),
            const SizedBox(height: 70,),
            CustomButton(title: "Home", clickFuction: (){
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  maintainState: true,
                  builder: (BuildContext context) => const HomeScreen(),
                ),
                    (Route<dynamic> route) => false,
              );
            })
          ],
        ),
      ),

    );
  }
}
