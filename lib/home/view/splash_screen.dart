import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/add_screen_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  TextFieldController getxTextEditingController =
      Get.put(TextFieldController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getxTextEditingController.readCatData();
    // getxTextEditingController.AddDataInlistOfEntry();
    // getxTextEditingController.GrandTotal();
  }

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 3),
      () {
        Get.offNamed('/tra');
      },
    );
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: Text("Jenil"),
        ),
      ),
    );
  }
}
