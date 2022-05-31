import 'package:ehjezly_app/Models/notification_model.dart';
import 'package:ehjezly_app/Screens/Bottom_Navigation/Oppointment/show_appointment.dart';
import 'package:ehjezly_app/Screens/Bottom_Navigation/Oppointment/show_notes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../Constant/constant.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              const SizedBox(height: 20,),
              Obx(() => (notificationController.notification.isNotEmpty)?
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: notificationController.notification.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      child: NotificationBox(
                        title: notificationController.notification[index].title ??"",
                        message: notificationController.notification[index].message ?? "",
                        color: kButtonColor,
                        id: notificationController.notification[index].uId!,
                        time: DateFormat('jm').format(notificationController.notification[index].time!),
                        voidCallback: (){
                          if(notificationController.notification[index].title == "Notes Updated"){
                            Get.to(const ShowDoctorNotes());
                          }
                          else{
                            Get.to(const ShowAppointment());
                          }

                         // appointmentController.activeDoctor(doctorController.doctors[index], context);

                        },
                      ),
                    );

                  }):
              SizedBox(
                height: 200,
                child: Center(
                    child: Text('notification data is empty.',
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
        ),
      ),
    );
  }
}
class NotificationBox extends StatelessWidget {
  final String message;
  final String title;
  final Color color;
  final String time;
  final VoidCallback voidCallback;
  final String id;
  const NotificationBox({required this.id,required this.time,required this.message,required this.title,required this.voidCallback,required this.color,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: voidCallback,
      child: Dismissible(
        direction: DismissDirection.endToStart,
        key: ObjectKey(notificationController.notification.length),
        background: Container(
            padding: EdgeInsets.all(30),
            color: kButtonColor,
            alignment: AlignmentDirectional.centerEnd,
            child: const Icon(Icons.delete,
              color: Colors.white,
            )),
        onDismissed: (direction){
          notificationController.deleteNotification(id,context);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xffedecf5),width: 1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CircleAvatar(
                    radius: 7,
                  backgroundColor: color),
                ),
              ),
              const SizedBox(width: 10,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(title,style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: kButtonColor
                        ),),
                        Text(time,style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: kLightTextColor
                        ),),
                      ],
                    ),

                    const SizedBox(height: 10,),
                    Text(message,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: kLightTextColor
                    ),),
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}