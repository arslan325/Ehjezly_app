import 'package:ehjezly_app/Screens/Bottom_Navigation/Oppointment/choose_day.dart';
import 'package:ehjezly_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Constant/constant.dart';
import '../../../Controllers/appointment_controller.dart';

class SelectTreatment extends StatefulWidget {
  const SelectTreatment({Key? key}) : super(key: key);

  @override
  State<SelectTreatment> createState() => _SelectTreatmentState();
}

class _SelectTreatmentState extends State<SelectTreatment> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedLocation ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_sharp,
            color: kButtonColor,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CircleAvatar(
              backgroundColor: kLightGreyColor,
              backgroundImage: userController.userData.value.profile != null?NetworkImage(userController.userData.value.profile!):null,
              radius: 30,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: userController.userData.value.profile == null?const Image(
                  image: AssetImage('images/avatar.png'),
                  fit: BoxFit.cover,
                ):null,
              ),
            ),
          ),
        ],
        title: Text("select a treatment",style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: kButtonColor
        ),),
      ),
      body: Column(children: [
        const SizedBox(height: 50,),
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("select a suitable treatment that you need",style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black
                ),),
                const SizedBox(height: 20,),
                Container(
                  width: double.infinity,
                  // padding: const EdgeInsets.symmetric(horizontal: 20),
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(8),
                  //   border: Border.all(color: Colors.white),
                  // ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField(
                      // isExpanded: true,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: kLightTextColor, width: 1.0),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusColor: kButtonColor,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: kButtonColor, width: 1.0),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red, width: 1.0),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red, width: 2.0),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      iconEnabledColor: kButtonColor,
                      dropdownColor: kBackgroundColor,
                      style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black
                      ),
                      hint: Text('select treatment',style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: kButtonColor
                      ),),
                      validator: (value) => value == null ? 'please select your treatment' : null,
                      value:_selectedLocation,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedLocation = newValue as String?;
                        });
                      },
                      items: appointmentController.selectedDoctor.first.treatment!.map((treatment) {
                        return DropdownMenuItem(
                          child: Text(treatment),
                          value: treatment,
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomButton(
                    title: "Next", clickFuction: (){
                      if(_formKey.currentState!.validate()){
                        appointmentController.selectedTreatment = _selectedLocation ;
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>const ChooseDay()));
                        print(appointmentController.doctorItemsToJson());
                      }
                })
              ],
            ),
          ),
        )
      ],),
    );
  }
}
