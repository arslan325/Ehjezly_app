
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehjezly_app/widgets/custom_dialogue.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../Constant/constant.dart';
import '../Models/user_model.dart';
import '../Screens/home_screen.dart';
import '../Screens/welcome_screen.dart';
import '../managers/preference_manager.dart';
import '/Screens/login_screen.dart';
import '/widgets/loading_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class UserController extends GetxController{
  static UserController instance = Get.find();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late Rx<User?> firebaseUser;
  Rx<UserModel> userData = UserModel().obs;
  User? currentUser = FirebaseAuth.instance.currentUser;


  CollectionReference userReference =
  FirebaseFirestore.instance.collection('users');

  CollectionReference adminReference =
  FirebaseFirestore.instance.collection('Admin');

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(currentUser);
    firebaseUser.bindStream(firebaseAuth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    //binding all Streams
    currentUser = user;
    if (currentUser != null) {
      doctorController.bindingStream();
      appointmentController.bindingStream();
      notificationController.bindingStream();
      // cartController.bindingStream();
      userData.bindStream(listenToUser());
    }

  }
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  Future<void> updateFCMDeviceToken() async{
    var token = await firebaseMessaging.getToken();
    await userReference.doc(currentUser?.uid).update({
      'Token':token,
    });
    firebaseMessaging.subscribeToTopic('allUsers');
  }

  Stream<UserModel> listenToUser() =>
      userReference.doc(firebaseUser.value?.uid)
          .snapshots()
          .map((snapshot) => UserModel.fromMap(snapshot.data()as Map<String, dynamic>));



  Future<void> signUp(
      String name, email, password, context) async {
    loadingDialogue(context: context , message: "Registration process started");
    // await sharedPreferences!.clear();
    await firebaseAuth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((auth) {
      currentUser = auth.user;
      FirebaseFirestore.instance.collection("users").doc(currentUser!.uid).set({
        "userID": currentUser!.uid,
        "Email": currentUser!.email,
        "Full Name": name,
        "password": password,
      }).then((value) async {
        Navigator.pop(context);

        Get.to(const LoginScreen());
      }).catchError((onError) {
        Navigator.pop(context);
        Get.snackbar(
          "Something went wrong",
          onError.message.toString(),
          backgroundColor: const Color(0x85ffffff),
        );
      });
    }).catchError((onError) {
      Navigator.pop(context);
      Get.snackbar(
        "Something went wrong",
        onError.message.toString(),
        backgroundColor: const Color(0x85ffffff),
      );
    });
  }

  List token =[];
  Future<void> logIn(
      String email, password, context) async {
    loadingDialogue(context: context , message: "Login process started");
    // await sharedPreferences!.clear();
    await firebaseAuth
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((auth) async{
      currentUser = auth.user;
      final dataSnapshot = await userReference
          .doc(currentUser!.uid)
          .get();
      if(dataSnapshot.exists){
        if(currentUser != null){
          updateFCMDeviceToken();
           await adminReference
              .get().then((value) {
            PreferenceManager().setToken = value.docs.first["Token"];
          });
          Navigator.pop(context);
          Get.offAll(const HomeScreen());
        }
      }
      else{
        Navigator.pop(context);
        firebaseAuth.signOut();
        Get.snackbar(
          "Something went wrong",
          "There is no user record corresponding to this identifier. The user may have been deleted.",
          backgroundColor: const Color(0x85ffffff),
        );
      }
      }).catchError((onError) {
        Navigator.pop(context);
        Get.snackbar(
          "Something went wrong",
          onError.message.toString(),
          backgroundColor: const Color(0x85ffffff),
        );
      });
  }

  Future<void> resetPassword(String email, context) async {
    loadingDialogue(context: context , message: "Sending email");
    await firebaseAuth.sendPasswordResetEmail(email: email).then((value) {
      Navigator.pop(context);
      customDialogue(context:context,title: "Check your email",bodyText: "We have sent a password recover instructions to your email",);
    }).catchError((error) {
      Navigator.pop(context);
      Get.snackbar(
        "Something went wrong",
        error.message.toString(),
        backgroundColor: const Color(0x85ffffff),
      );
    });
  }

  Future<void> updateUserData(Map<String, dynamic> data,context) async{
    await userReference.doc(firebaseUser.value?.uid).update(
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

  Future<void> changeEmail(String newEmail , context) async{
    loadingDialogue(context: context, message: 'Updating user email');
    User? user =  FirebaseAuth.instance.currentUser;
    user?.updateEmail(newEmail).then((value) {
      updateUserData({UserModel.userEmail:newEmail},context);
      Get.back();
      Get.back();
    }).catchError((e){
      Get.back();
      customDialogue(
          title: "Something went wrong",
          bodyText: e.message.toString(),
          context: context
      );
    });
  }

  Future<void> changePassword(String oldPassword, newPassword, context) async {
    String email = currentUser!.email!;
    loadingDialogue(context: context, message: 'Updating user password');
    firebaseAuth
        .signInWithEmailAndPassword(
      email: email,
      password: oldPassword,
    ).then((value) {
      currentUser?.updatePassword(newPassword).then((value) {
        updateUserData({UserModel.userPassword:newPassword},context);
        Get.back();
        Get.back();
      }).catchError((error) {
        Navigator.pop(context);
        customDialogue(
            title: "Something went wrong",
            bodyText: error.message.toString(),
            context: context
        );
      });
    }).catchError((onError) {
      Navigator.pop(context);
      customDialogue(
          title: "Something went wrong",
          bodyText: onError.message.toString(),
          context: context
      );
    });
  }

  void  signOut ()async{
    await firebaseAuth.signOut();
    Get.offAll(const WelcomeScreen());
  }


  Future<void> sendNotification(String notificationTitle, String notificationBody, String targetFCMToken) async {
    const String _url = 'https://fcm.googleapis.com/fcm/send';
    Map<String, String> _headers = <String, String>{};
    _headers['Content-Type'] = 'application/json';
    _headers['Authorization'] = 'key=AAAAZgaK2Vw:APA91bGjE-ptI0bDOagsa6pDnEO23t8XhdPlYZE-Uf9USo_AFo57GhrnWtMeHy5tBMAGJpy7R9haLe5dHFMkmChmAl2VnifXuvTSV_XkQ1wJBSiGzGzOXOoIiwG7LKkethXBWHid18Ph';

    Map<String, dynamic> _body = Map<String, dynamic>();
    _body['notification'] = {
      'title': notificationTitle,
      'body': notificationBody,
      //'image': imageUrl,
      'sound': 'default'
    };
    _body['priority'] = 'high';
    _body['data'] = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': '1',
      'status': 'done'
    };
    _body['to'] = targetFCMToken;
    await http.post(Uri.parse(_url), headers: _headers, body: jsonEncode(_body),);

  }

}