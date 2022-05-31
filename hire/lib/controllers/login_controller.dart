import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hire/normaluser/home.dart';
import 'package:hire/normaluser/login.dart';

class Mainpage extends StatelessWidget {
  const Mainpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
       
           if(snapshot.hasError){
            return Center(child: Text("something went wrong"));
          }
          return LoginScreen();
        },
      ),
    );
  }
}
