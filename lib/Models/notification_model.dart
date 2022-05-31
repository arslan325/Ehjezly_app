class NotificationModel{
  static const notificationId = "Uid";
  static const notificationTitle = "Title";
  static const notificationMessage = "Message";
  static const notificationTime = "Notification On";
  String? uId;
  String? title;
  String? message;
  DateTime? time;

  NotificationModel({
    this.uId,
    this.title,
    this.message,
    this.time
  });

  NotificationModel.fromMap(Map<String, dynamic> data){
    uId = data[notificationId];
    title = data[notificationTitle];
    message = data[notificationMessage];
    time = data[notificationTime].toDate();
  }
}