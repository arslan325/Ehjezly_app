import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../Constant/constant.dart';
import '../../../widgets/custom_button.dart';
import 'summary.dart';

class ChooseTime extends StatefulWidget {
  const ChooseTime({Key? key}) : super(key: key);

  @override
  State<ChooseTime> createState() => _ChooseTimeState();
}

class _ChooseTimeState extends State<ChooseTime> {

  TimeOfDay selectedTime = TimeOfDay.now();
  final now = appointmentController.selectedDate!;
  List<DateTime>? checkTimeDB;
  String from ="";
  String to ="";
  List<DateTime> unavailableDatetime =[];
  @override
  void initState() {
    super.initState();
    selectedTime = selectedTime.replacing(hour: selectedTime.hourOfPeriod);
    for(int i =0;i<appointmentController.selectedDoctor.first.unavailableTime!.length;i++){
      unavailableDatetime.add(appointmentController.selectedDoctor.first.unavailableTime![i].toDate());
    }
    from = DateFormat('jm').format(unavailableDatetime[0]);
    to = DateFormat('jm').format(unavailableDatetime[1]);

   

  }

  @override
  Widget build(BuildContext context) {
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
        title: Text("Choose a time",style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: kButtonColor
        ),),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.access_time),
          //backgroundColor: new Color(0xFFE57373),
          onPressed: () async{
            final TimeOfDay? timeOfDay = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if(timeOfDay != null && timeOfDay != selectedTime)
            {
              setState(() {
                selectedTime = timeOfDay;
              });
            }
          }
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            const SizedBox(height: 50,),
            Text("Choose a suitable time for Appointment",style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black
            ),),
            const SizedBox(height: 20,),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: kButtonColor
                  ),
                  child: Center(
                    child: Text("${selectedTime.hourOfPeriod}",style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.white
                    ),),
                  ),
                ),
                const SizedBox(width: 5,),
                Text(":",style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black
                ),),
                const SizedBox(width: 5,),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black12
                  ),
                  child: Center(
                    child: Text("${selectedTime.minute}",style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black
                    ),),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40,),
            Text("Note: doctor are not available in this time slot. So you need to choose another suitable time to book appointment",style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black
            ),),
            const SizedBox(height: 20,),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: kButtonColor
              ),
              child: Center(
                child: Text("$from - $to",style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                ),),
              ),
            ),
            const SizedBox(height: 70,),
            CustomButton(
                title: "Next", clickFuction: (){
              DateTime time = DateTime(now.year, now.month, now.day, selectedTime.hour, selectedTime.minute);
              appointmentController.selectedTime = selectedTime;
              appointmentController.checkAvailableTime(time,context);
            }),
          ],
        ),
      ),
    );
  }
}
