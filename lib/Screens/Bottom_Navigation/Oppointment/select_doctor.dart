import 'package:ehjezly_app/Screens/Bottom_Navigation/Oppointment/select_treatment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Constant/constant.dart';
import '../../../Controllers/appointment_controller.dart';
import '../home_page.dart';

class AppointmentBook1 extends StatefulWidget {
  final bool? show;
  const AppointmentBook1({this.show,Key? key}) : super(key: key);

  @override
  _AppointmentBook1State createState() => _AppointmentBook1State();
}

class _AppointmentBook1State extends State<AppointmentBook1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: widget.show ==true ? AppBar(
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
          title: Text("Book a appointment",style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: kButtonColor
          ),),
        ):null,
      body: ListView(
        children: [
          const SizedBox(height: 20,),
          Obx(() => (doctorController.doctors.isNotEmpty)?
          ListView.builder(
            shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: doctorController.doctors.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: DoctorBoxShow(
                    url: doctorController.doctors[index].docImage ??"",
                    title: doctorController.doctors[index].docName ?? "",
                    voidCallback: (){
                      appointmentController.activeDoctor(doctorController.doctors[index], context);

                    },
                  ),
                );

              }):
          SizedBox(
            height: 200,
            child: Center(
                child: Text('Doctors data is empty.',
                    style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black
                    )
                )),
          ),
          ),
        ],
      )
    );
  }
}

class DoctorBoxShow extends StatelessWidget {
  final String url;
  final String title;
  final VoidCallback voidCallback;
  const DoctorBoxShow({required this.url,required this.title,required this.voidCallback,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: voidCallback,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        height: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kLightGreyColor,
        ),
        child: Row(
          children: [
            Expanded(
              flex:2,
              child: Text(title,style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: kButtonColor
              ),),
            ),
            Expanded(
              child: Image(
                image: NetworkImage(url),
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
      ),
    );
  }
}
