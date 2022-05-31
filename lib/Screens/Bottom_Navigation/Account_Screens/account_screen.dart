import 'package:ehjezly_app/Screens/Bottom_Navigation/Account_Screens/change_email.dart';
import 'package:ehjezly_app/Screens/Bottom_Navigation/Account_Screens/change_password.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Constant/constant.dart';
import '../setting_page.dart';
import 'change_name.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  Widget? _imageWidget(BuildContext context){
    if(userController.userData.value.profile == null){
      return const Image(
        image: AssetImage('images/avatar.png'),
        fit: BoxFit.cover,
      );
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text("Account",style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: kButtonColor
          ),),
        ),
        body: Obx(()=>SingleChildScrollView(
          child: (
              Column(
                children: [
                  const SizedBox(height: 40,),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Stack(
                          // alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundImage: userController.userData.value.profile != null?NetworkImage(userController.userData.value.profile!):null,
                              backgroundColor: kLightGreyColor,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: ClipOval(
                                    child: _imageWidget(context)),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (_)=>const ChangeNameAndProfile()));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(80),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey, //New
                                          blurRadius: 25.0,
                                          offset: Offset(0, -10))
                                    ],
                                  ),
                                  child: const CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.edit,
                                      color: kButtonColor,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Text(userController.userData.value.name ?? "Your Name",style: GoogleFonts.inter(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: kButtonColor
                        ),),
                        const SizedBox(height: 10,),
                        Text(userController.userData.value.email ?? "email@gmail.com",style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: kLightTextColor
                        ),),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30,),
                  ListTileData(iconData: Icons.person,title: "Change Name",voidCallback: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>const ChangeNameAndProfile()));
                  },),
                  ListTileData(iconData: Icons.email,title: "Change Email",voidCallback: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>const EditEmailAddressScreen()));
                  },),
                  ListTileData(iconData: Icons.lock,title: "Change Password",voidCallback: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>const ChangePassword()));
                  },),
                ],
              )
          ),
        ),
        ));
  }
}
