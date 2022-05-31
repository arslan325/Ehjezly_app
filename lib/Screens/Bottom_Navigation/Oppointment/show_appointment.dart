import 'package:ehjezly_app/Models/appointment_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../Constant/constant.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_dialogue.dart';

class ShowAppointment extends StatefulWidget {
  const ShowAppointment({Key? key}) : super(key: key);

  @override
  State<ShowAppointment> createState() => _ShowAppointmentState();
}

class _ShowAppointmentState extends State<ShowAppointment> {

  Widget showStatusText(String status){
    if(status == "confirmed"){
      return Text(
        status,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.green,
        ),
      );
    }
    else if(status == "done"){
      return Text(
        status,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.green,
        ),
      );
    }
    else {
      return Text(
        status,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.red,
        ),
      );
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
        title: Text("Appointment",style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: kButtonColor
        ),),
      ),
        body: ListView(
          children: [
            //const SizedBox(height: 20,),
            Obx(() => (appointmentController.appointments.isNotEmpty)?
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: appointmentController.appointments.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(12),
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Appointment # " + index.toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: kButtonColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              appointmentController.appointments[index].status =="pending"? InkWell(
                                onTap: (){
                                  confirmationDialogue(title: "Confirmation",
                                      bodyText: "Are you sure you want to delete the details of appointment?",
                                      function: (){
                                        appointmentController.deleteAppointment(appointmentController.appointments[index].appointmentId??"", context).catchError((e){
                                          Navigator.pop(context);
                                          customDialogue(
                                              title: "Something went wrong",
                                              bodyText: e.message.toString(),
                                              context: context
                                          );
                                        });
                                      },
                                      context: context
                                  );
                                },
                                child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: const Icon(Icons.delete,
                                      color: Colors.white,
                                    )
                                ),
                              ):Container(),
                            ],
                          ),
                          const Divider(
                            thickness: 1,
                            height: 32,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Date",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                DateFormat('yyyy-MMMM-dd').format(appointmentController.appointments[index].appointmentDate!),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 1,
                            height: 32,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Time",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              //DateFormat('jm').format(time!)
                              Text(
                                DateFormat('jm').format(appointmentController.appointments[index].appointmentDate!),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 1,
                            height: 32,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Doctor Name",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                appointmentController.appointments[index].doctorName!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 1,
                            height: 32,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Treatment",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                appointmentController.appointments[index].treatment!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 1,
                            height: 32,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Status",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              showStatusText(appointmentController.appointments[index].status!)
                            ],
                          ),
                          appointmentController.appointments[index].status == "confirmed"? Container(
                            margin: const EdgeInsets.only(top: 15),
                            child: CustomButton(title: "Complete", clickFuction: (){
                              appointmentController.updateAppointmentData(
                                  {
                                    AppointmentModel.appointmentSTATUS : "done"
                                  },
                                  appointmentController.appointments[index].appointmentId!, context);
                            }),
                          ):Container(),
                        ],
                      ),
                    ),
                  );

                }):
            SizedBox(
              height: 200,
              child: Center(
                  child: Text('Appointment data is empty.',
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
