import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehjezly_app/Constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Models/appointment_model.dart';
import '../Models/doctor_model.dart';
import '../Screens/Bottom_Navigation/Oppointment/appointment_success.dart';
import '../Screens/Bottom_Navigation/Oppointment/select_treatment.dart';
import '../Screens/Bottom_Navigation/Oppointment/summary.dart';
import '../managers/preference_manager.dart';
import '../widgets/custom_dialogue.dart';
import '../widgets/loading_widget.dart';

class AppointmentController extends GetxController{
  static AppointmentController instance = Get.find();
  CollectionReference appointmentReference = FirebaseFirestore.instance.collection('Appointment');
  RxList<AppointmentModel> appointments = RxList<AppointmentModel>([]);

  @override
  onReady() {
    super.onReady();
    bindingStream();
  }

  bindingStream() {
    if (firebaseAuth.currentUser != null) {
      appointments.bindStream(getAppointment(firebaseAuth.currentUser!.uid));
    }
  }

  ///1: selected doctor for appointment
  List<DoctorModel> selectedDoctor =[];
  activeDoctor(DoctorModel doctorModel , context){
    selectedDoctor.clear();
    selectedDoctor.add(doctorModel);
    Navigator.push(context, MaterialPageRoute(builder: (_)=>const SelectTreatment()));
  }
  List doctorItemsToJson() => selectedDoctor.map((item) => item.toJson()).toList();

  ///2:selected treatment
  String? selectedTreatment ;

  ///2:selected date for appointment
  DateTime? selectedDate ;

  ///3:selected time for appointment
  TimeOfDay? selectedTime ;


  ///Get appointment loge in user
  Stream<List<AppointmentModel>> getAppointment(String uID) => appointmentReference
      .where("Patient Id", isEqualTo: uID)
      .orderBy("Publish Date", descending: true)
      .snapshots()
      .map((query) => query.docs
      .map((item) =>
      AppointmentModel.fromMap(item.data() as Map<String, dynamic>))
      .toList());



List<DateTime> dates =[];
    checkAvailableTime(DateTime time , context) {
      loadingDialogue(context: context , message: "checking the available times");
     appointmentReference.where("Status", isEqualTo: 'confirmed').get().then((value) {
       for (var element in value.docs) {
         dates.add(element['Appointment Day'].toDate());
       }

     });
     if(dates.contains(time)){
       Navigator.of(context).pop();
       customDialogue(
           title: "Something went wrong",
           bodyText: 'This time is not available because this time is booked by another patient.So, please choose another time.',
           context: context
       );
     }
     else{
       Navigator.of(context).pop();
       Navigator.push(context, MaterialPageRoute(builder: (_)=>const AppointmentSummary()));
       print("date is available");
     }
     dates.clear();
   }


  Future<void> bookAppointment(context , DateTime dateTime) async{
    loadingDialogue(context: context , message: "Appointment book started");
    String? userId = userController.userData.value.uid;
    String docId = appointmentReference.doc().id;
    await appointmentReference.doc(docId).set({
      'Appointment Id' : docId,
      'Patient Id':userId,
      'Patient Name' : userController.userData.value.name,
      'Patient Email' : userController.userData.value.email,
      'Doctor Name' : selectedDoctor.first.docName,
      'Treatment' : selectedTreatment,
      'Appointment Day' : dateTime,
      'Publish Date' : DateTime.now(),
      'Status' : "pending",
    }).then((value) {
      userController.sendNotification("Book Appointment",
          'Patient book an appointment for "${'$selectedTreatment'}" disease. please check the detail on portal.',
          PreferenceManager().getToken);
      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          maintainState: true,
          builder: (BuildContext context) => const AppointmentSuccess(),
        ),
            (Route<dynamic> route) => false,
      );
    }
    ).catchError((e){
      Navigator.pop(context);
      customDialogue(
          title: "Something went wrong",
          bodyText: e.message.toString(),
          context: context
      );
    });
  }

  Future<void> updateAppointmentData(Map<String, dynamic> data,String id , context) async{
    await appointmentReference.doc(id).update(
        data
    ).then((value) {
      Get.snackbar(
        "Successfully",
        "Details of user updated successfully",
        backgroundColor: const Color(0x85ffffff),
      );
    }
    ).catchError((e){
      Navigator.pop(context);
      customDialogue(
          title: "Something went wrong",
          bodyText: e.message.toString(),
          context: context
      );
    });
  }

  Future<void> deleteAppointment(String uid,context) async{
    await appointmentReference.doc(uid).delete().then((value) {
      Get.snackbar(
        "Successfully",
        "Details of appointment delete successfully",
        backgroundColor: const Color(0x85ffffff),
      );
    }
    ).catchError((e){
      customDialogue(
          title: "Something went wrong",
          bodyText: e.message.toString(),
          context: context
      );
    });
  }


}