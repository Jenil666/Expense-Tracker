import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/add_screen_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  TextFieldController getxTextEditingController =
      Get.put(TextFieldController());



  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 3),
      () {
        Get.offNamed('/tra');
      },
    );
    return  SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text("Jenil",style: GoogleFonts.babylonica(fontSize: 100,color: Color(0xff434273))),
        ),
      ),
    );
  }
}
