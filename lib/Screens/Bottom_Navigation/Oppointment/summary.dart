import 'package:ehjezly_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../Constant/constant.dart';
import '../../../widgets/custom_dialogue.dart';
import '../../home_screen.dart';
import 'appointment_success.dart';

class AppointmentSummary extends StatefulWidget {
  const AppointmentSummary({Key? key}) : super(key: key);

  @override
  State<AppointmentSummary> createState() => _AppointmentSummaryState();
}

class _AppointmentSummaryState extends State<AppointmentSummary> {
  //DateFormat('jm').format(time!)
   DateTime? time ;
  TimeOfDay t = appointmentController.selectedTime!;
   final now = appointmentController.selectedDate!;
  @override
  void initState() {
    super.initState();
    setState(() {
      time = DateTime(now.year, now.month, now.day, t.hour, t.minute);
    });
  }
  @override
  Widget build(BuildContext context) {
    ///for AM or PM
   // print(DateFormat('a').format(time!));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
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
        title: Text("Summary",style: GoogleFonts.inter(
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
            Text(DateFormat('MMMM').format(appointmentController.selectedDate!).toUpperCase(),style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kButtonColor
            ),),
            const SizedBox(height: 15,),
            Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                color: kButtonColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(appointmentController.selectedDate!.day.toString(),
                  //textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),),
              ),
            ),
            const SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: kButtonColor
                      ),
                      child: Center(
                        child: Text(DateFormat('h').format(time!),style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.white
                        ),),
                      ),
                    ),
                    const SizedBox(width: 5,),
                    Text(":",
                      style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black
                      ),),
                    const SizedBox(width: 5,),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.black12
                      ),
                      child: Center(
                        child: Text(DateFormat('m').format(time!),style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.black
                        ),),
                      ),
                    ),
                    const SizedBox(width: 5,),
                  ],
                ),
                Container(
                  width: 40,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: kButtonColor
                  ),
                  child: Center(
                    child: Text(DateFormat('a').format(time!).toUpperCase(),style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.white
                    ),),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 70,),
            Row(
              children: [
                Expanded(
                  child: CustomButton(title: "Cancel",color: Colors.black12, textColor: Colors.black,
                      clickFuction: (){
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            maintainState: true,
                            builder: (BuildContext context) => const HomeScreen(),
                          ),
                              (Route<dynamic> route) => false,
                        );
                      }),
                ),
                const SizedBox(width: 10,),
                Expanded(
                    child: CustomButton(title: "Confirm", clickFuction: (){
                      if(time != null){
                        appointmentController.bookAppointment(context , time!);
                      }
                      else{
                        customDialogue(
                            title: "Something went wrong",
                            bodyText: 'Please select unavailable dates for doctor',
                            context: context
                        );
                      }


                    })),
              ],
            )

          ],
        ),
      ),
    );
  }
}
