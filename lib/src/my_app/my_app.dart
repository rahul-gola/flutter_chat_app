import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/services/app_service.dart';
import 'package:flutter_chat_app/src/login_screen/login_screen.dart';
import 'package:flutter_chat_app/src/spash_screen/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        key: AppService.appKey,
        navigatorKey: AppService.navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
