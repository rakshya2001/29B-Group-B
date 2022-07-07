import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

import '../controllers/login_controller.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'assets/launch_image.png',
      splashIconSize: 300,
      nextScreen: const Mainpage(),
      splashTransition: SplashTransition.fadeTransition,
      duration: 3000,
      backgroundColor: Colors.white24,
    );
  }
}
