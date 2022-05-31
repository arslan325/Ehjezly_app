import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Constant/constant.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 60,),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            color: kLightGrey2Color,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20,),
                Text("Contact Us",style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),),
                const SizedBox(height: 20,),
                Text("02-2771234",style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),),
                const SizedBox(height: 10,),
                Text("hospital@gmail.com",style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),),
                const SizedBox(height: 30,),
                Text("street address , Bethlehem \n Palestine ",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black
                ),),
                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){},
                      child: const CircleAvatar(
                        radius: 23,
                        backgroundColor: Colors.black,
                        child: Icon(
                          Icons.facebook,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    GestureDetector(
                      onTap: (){},
                      child: const CircleAvatar(
                        radius: 23,
                        backgroundColor: Colors.black,
                        child: Icon(
                          Icons.facebook,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20,),
              ],
            ),
          ),
        ],
      )
    );
  }
}
