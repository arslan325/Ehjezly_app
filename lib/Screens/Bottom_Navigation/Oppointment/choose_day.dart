import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../Constant/constant.dart';
import '../../../managers/preference_manager.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_dialogue.dart';
import 'choose_time.dart';

class ChooseDay extends StatefulWidget {
  const ChooseDay({Key? key}) : super(key: key);

  @override
  State<ChooseDay> createState() => _ChooseDayState();
}

class _ChooseDayState extends State<ChooseDay> {
   DateTime? date ;
  List<DateTime> unselectedDate = [];
  void _onDateChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      date = args.value;
    });
    print(date.toString());
  }
  @override
  void initState() {
    super.initState();
    for(int i =0;i<appointmentController.selectedDoctor.first.dateTime!.length;i++){
      unselectedDate.add(appointmentController.selectedDoctor.first.dateTime![i].toDate());
    }
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
        title: Text("Choose a day",style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: kButtonColor
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50,),
            Text("Choose a suitable date for Appointment",style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black
            ),),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: SfDateRangePicker(
                backgroundColor: kBackgroundColor,
                selectionColor: kButtonColor,
                showNavigationArrow: true,
                todayHighlightColor: kButtonColor,
                monthCellStyle:  const DateRangePickerMonthCellStyle(
                  todayTextStyle: TextStyle(color: kButtonColor),
                  blackoutDateTextStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: Colors.red,
                      decoration: TextDecoration.lineThrough),

                ),
                toggleDaySelection: true,
                view: DateRangePickerView.month,
                enablePastDates : false,
                selectionMode: DateRangePickerSelectionMode.single,
                 monthViewSettings: DateRangePickerMonthViewSettings(blackoutDates:unselectedDate),
                onSelectionChanged: (val){
                  _onDateChanged(val);
                },
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            CustomButton(
                title: "Next", clickFuction: (){
              if(date == null){
                customDialogue(
                    title: "Something went wrong",
                    bodyText: 'Please select unavailable dates for doctor',
                    context: context
                );
              }
              else{
                appointmentController.selectedDate = date;
              Navigator.push(context, MaterialPageRoute(builder: (_)=>const ChooseTime()));
              print(PreferenceManager().getToken);
              }
            })
          ],
        ),
      ),
    );
  }
}
