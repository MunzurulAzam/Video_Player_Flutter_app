import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:qtecsolutiontask/views/home_screen.dart';
import 'package:qtecsolutiontask/views/video_details_screen.dart';

import 'components.dart';
import 'controllers/data_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: baseScreenSize,
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      builder: (context, child) =>
          GetMaterialApp(
            theme: lightTheme,
            debugShowCheckedModeBanner: false,
            initialBinding: InitializedBinding(),
            scrollBehavior: const MaterialScrollBehavior().copyWith(dragDevices: {
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
            }),
            darkTheme: darkTheme,
            home: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
              child: child!,
            ),
          ),
      child: const HomeScreen(),
    );
  }
}
class InitializedBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DataController());
  }
}


