import 'package:databased_first_program/home/view/category_operations.dart';
import 'package:databased_first_program/home/view/splash_screen.dart';
import 'package:databased_first_program/home/view/transction_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'home/view/home_screen.dart';

void main() {
  runApp(
    // DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) =>
          Sizer(
        builder: (context, orientation, deviceType) => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          // initialRoute: '/home',
          getPages: [
            GetPage(name: '/', page: () => SplashScreen(),),
            GetPage(name: '/home', page: () => HomeScreen(),),
            GetPage(name: '/tra', page: () => TransctionScreen(),),
            GetPage(name: '/categoryCurd', page: () => CategoryScreen(),),
          ],
        ),
      ),
    // ),
  );
}
