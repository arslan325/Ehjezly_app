import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Constant/constant.dart';
import 'Account_Screens/account_screen.dart';
import 'Account_Screens/change_name.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

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
      body: Obx(()=>(
         Column(
          children: [
            const SizedBox(height: 20,),
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
            ListTileData(iconData: Icons.person,title: "Account",voidCallback: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>const AccountScreen()));
            },),
            ListTileData(iconData: Icons.notifications,title: "Notification",voidCallback: (){},),
            ListTileData(iconData: Icons.privacy_tip,title: "Privacy & Security",voidCallback: (){},),
            ListTileData(iconData: Icons.volume_down,title: "Sound",voidCallback: (){},),
            ListTileData(iconData: Icons.language,title: "Language",voidCallback: (){},)
          ],
        )
      ),
    ));
  }
}

class ListTileData extends StatelessWidget {
  final IconData iconData;
  final String title;
  final VoidCallback voidCallback;
  const ListTileData({required this.iconData,required this.title,required this.voidCallback,Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: voidCallback,
      leading: Icon(
        iconData,
        color: kLightTextColor,
      ),
      title: Text(title,style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: kButtonColor
      ),),
      trailing:  const Icon(
        Icons.arrow_forward_ios_outlined,
        color: kLightTextColor,
        size: 15,
      ),
    );
  }
}

