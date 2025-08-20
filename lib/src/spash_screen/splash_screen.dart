import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/src/home_screen/home_page.dart';
import 'package:flutter_chat_app/src/login_screen/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget child = const LoginScreen();

    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      child = HomePage();
    }
    return AnimatedSplashScreen(
      splash: Image.asset('assets/splash-logo.png'),
      nextScreen: child,
      duration: 4,
      splashIconSize: 70,
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}
