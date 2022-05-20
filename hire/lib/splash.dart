// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:hire/login.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    //_navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 1500), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(135, 90, 199, 214),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 190.0,
              width: 190.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/launch_image.png'),
                    fit: BoxFit.fill),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(36.0),
              child: const Text('Hire  ',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
