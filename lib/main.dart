import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:qtecsolutiontask/providers/homepage_screen_provider.dart';
import 'package:qtecsolutiontask/views/home_screen.dart';
import 'package:qtecsolutiontask/views/video_details_screen.dart';

import 'components.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => HomePageScreenProvider(),
      child: const MyApp())
  );
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
          MaterialApp(
            theme: lightTheme,
            debugShowCheckedModeBanner: false,
            scrollBehavior: const MaterialScrollBehavior().copyWith(dragDevices: {
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
            }),
            darkTheme: darkTheme,
            // home: AnnotatedRegion<SystemUiOverlayStyle>(
            //   value: SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
            //   child: child ??  const SizedBox(),
            // ),
            initialRoute: HomeScreen.routeName,
            routes: {
              HomeScreen.routeName : (context) => const HomeScreen(),
              VideoDetailScreen.routeName : (context) =>  VideoDetailScreen(),
            },
          ),
    );
  }
}


