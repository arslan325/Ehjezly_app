class UserModel{
  static const userName = "Full Name";
  static const userEmail = "Email";
  static const userId = "userID";
  static const userPassword = "password";
  static const userProfile = "profile";
  static const fcmToken = "Token";
  String? name;
  String? email;
  String? password;
  String? profile;
  String? uid;
  String? token;
  UserModel({
    this.name,
    this.email,
    this.profile,
    this.password,
  this.uid,
    this.token
  }
      );
  UserModel.fromMap(Map<String, dynamic> data){
    name = data[userName];
    email = data[userEmail];
    password = data[userPassword];
    profile = data[userProfile];
    uid = data[userId];
    token = data[fcmToken];
  }
  toJson() {
    return {
      userName:name,
      userEmail:email,
      userProfile:profile
    };
  }
}