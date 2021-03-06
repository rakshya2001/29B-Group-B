import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hire/models/user_model.dart';
import 'package:hire/normaluser/contact.dart';
import 'package:hire/normaluser/dashboard.dart';
import 'package:hire/normaluser/home.dart';
import 'package:hire/normaluser/loader.dart';

import '../professionals/dashboard.dart';

class GateWay extends StatefulWidget {
  GateWay({Key? key}) : super(key: key);

  @override
  State<GateWay> createState() => _GateWayState();
}

class _GateWayState extends State<GateWay> {
  @override
  Widget build(BuildContext context) {
    return Controller();
  }
}

class Controller extends StatefulWidget {
  Controller();
  @override
  State<Controller> createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  _ControllerState();

  User? loggedUser = FirebaseAuth.instance.currentUser;
  UserModel userModel = UserModel();
  String? uid;
  String? role;
  String firstName = "";
  String lastName = "";
  String email = "";
  String? profile;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(loggedUser!.uid)
        .get()
        .then((value) {
      this.userModel = UserModel.fromMap(value.data());
      ColorLoader3();
      setState(() {
        uid = userModel.uid.toString();
        role = userModel.role.toString();
        email = userModel.email!;
        firstName = userModel.firstname!;
        lastName = userModel.lastname!;
        profile = userModel.image!;
        print(uid);
        print(firstName);
        print(lastName);
        print(email);
        print(profile);
      });
    });
  }

  route() {
    try {
      if (role == "normaluser") {
        return home(
          email: email,
          firstName: firstName,
          lastName: lastName,
          profile: profile,
        );
      } else if (role == 'professional') {
        return Dashboard();
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    ColorLoader3();
    return route();
  }
}
