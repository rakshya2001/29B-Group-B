import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hire/models/user_model.dart';
import 'package:hire/normaluser/NavBar.dart';
import 'package:hire/normaluser/dashboard.dart';
import 'package:hire/normaluser/home.dart';
import 'package:hire/normaluser/login.dart';

import '../normaluser/auth_Provider.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({Key? key}) : super(key: key);

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  UserModel userModel = UserModel();
  final _loggedUser = FirebaseAuth.instance.currentUser;
  String? firstName;
  String? lastName;
  String? email;
  String? profile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(_loggedUser!.uid)
        .get()
        .then((value) {
      userModel = UserModel.fromMap(value.data());
      setState(() {
        firstName = userModel.firstname;
        lastName = userModel.lastname;
        email = userModel.email;
        profile = userModel.image;
        if (profile == null) {
          profile = "";
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error"));
          } else if (snapshot.hasData) {
            return home(
              email: email,
              firstName: firstName,
              lastName: lastName,
              profile: profile,
            );
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
