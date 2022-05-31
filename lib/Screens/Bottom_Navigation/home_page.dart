import 'package:ehjezly_app/Screens/Bottom_Navigation/Oppointment/show_notes.dart';
import 'package:ehjezly_app/Screens/Bottom_Navigation/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Constant/constant.dart';
import 'Oppointment/select_doctor.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child:(
             Column(
              children: [
                const SizedBox(height: 30,),
                const SizedBox(height: 20,),
                BoxShow(url:'images/Serum Bag.png', title: "Doctor Notes",voidCallback: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>const ShowDoctorNotes()));
                },),
                const SizedBox(height: 10,),
                BoxShow(url:'images/Stechoscope.png', title: "Book an appointment",voidCallback: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>const AppointmentBook1(show:true)));
                },),
              ],
            ))
        ),
      ),
    );
  }
}

class BoxShow extends StatelessWidget {
  final String url;
  final String title;
  final VoidCallback voidCallback;
  const BoxShow({required this.url,required this.title,required this.voidCallback,Key? key}) : super(key: key);

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
                image: AssetImage(url),
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
      ),
    );
  }
}

