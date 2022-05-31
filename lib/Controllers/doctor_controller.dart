import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../Constant/constant.dart';
import '../Models/doctor_model.dart';
import '../Screens/Bottom_Navigation/Oppointment/appointment_success.dart';
import '../Screens/Bottom_Navigation/Oppointment/select_treatment.dart';
import '../widgets/custom_dialogue.dart';
import '../widgets/loading_widget.dart';
class DoctorController extends GetxController {
  static DoctorController instance = Get.find();
  CollectionReference doctorReference = FirebaseFirestore.instance.collection('Doctors');
  RxList<DoctorModel> doctors = RxList<DoctorModel>([]);

  @override
  onReady() {
    super.onReady();
    bindingStream();
  }
  bindingStream() {
    if (FirebaseAuth.instance.currentUser != null) {
      doctors.bindStream(getAllDoctors());
    }
  }
  Stream<List<DoctorModel>> getAllDoctors() =>
      doctorReference.orderBy('Publish Date', descending: true).snapshots().map((query) =>
          query.docs.map((item) => DoctorModel.fromMap(item.data() as Map<String, dynamic>)).toList());



}