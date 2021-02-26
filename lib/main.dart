import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:page_transition/page_transition.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Quíron',
        home: AnimatedSplashScreen(
            duration: 5000,
            splash: Image.asset(
              "images/Quíron_Logo_SplashScreen.png",
            ),
            backgroundColor: Color(0xff15EBC4),
            splashIconSize: 200,
            nextScreen: LoginScreen()));
  }
}
