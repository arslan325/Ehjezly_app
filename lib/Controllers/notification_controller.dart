
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../Models/notification_model.dart';
import '../widgets/custom_dialogue.dart';
class NotificationController extends GetxController {
  static NotificationController instance = Get.find();
  CollectionReference notificationReference = FirebaseFirestore.instance.collection('Notification');
  RxList<NotificationModel> notification = RxList<NotificationModel>([]);

  @override
  onReady() {
    super.onReady();
    bindingStream();
  }
  bindingStream() {
    if (FirebaseAuth.instance.currentUser != null) {
      notification.bindStream(getAllNotification(FirebaseAuth.instance.currentUser!.uid));
    }
  }

  Stream<List<NotificationModel>> getAllNotification(String uID) => notificationReference
      .where("User Id", isEqualTo: uID)
      .orderBy("Notification On", descending: true)
      .snapshots()
      .map((query) => query.docs
      .map((item) =>
      NotificationModel.fromMap(item.data() as Map<String, dynamic>))
      .toList());


  Future<void> deleteNotification(String uid,context) async{
    await notificationReference.doc(uid).delete().then((value) {
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