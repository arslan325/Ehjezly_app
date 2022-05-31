import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel{

  static const appointmentID = "Appointment Id";
  static const patientID = "Patient Id";
  static const doctorNAME = "Doctor Name";
  static const patientNAME = "Patient Name";
  static const patientEMAIL = "Patient Email";
  static const patientTREATMENT = "Treatment";
  static const appointmentDATE = "Appointment Day";
  static const publishDATE = "Publish Date";
  static const appointmentSTATUS = "Status";
  static const docNotes = "Notes";

  String? appointmentId;
  String? patientId;
  String? doctorName;
  String? patientName;
  String? patientEmail;
  String? treatment;
  DateTime? appointmentDate;
  DateTime? publishDate;
  String? status;
  String? notes;

  AppointmentModel({
    this.appointmentId,
    this.patientId,
    this.doctorName,
    this.patientName,
    this.patientEmail,
    this.treatment,
    this.appointmentDate,
    this.publishDate,
    this.status,
    this.notes
  });

  AppointmentModel.fromMap(Map<String, dynamic> data){
    appointmentId = data[appointmentID];
    patientId = data[patientID];
    doctorName = data[doctorNAME];
    patientName = data[patientNAME];
    patientEmail = data[patientEMAIL];
    treatment = data[patientTREATMENT];
    appointmentDate = data[appointmentDATE].toDate();
    publishDate = data[publishDATE].toDate();
    status = data[appointmentSTATUS];
    notes = data[docNotes];
  }
}