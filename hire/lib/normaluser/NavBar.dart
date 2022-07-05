import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hire/controllers/google_signin.dart';
import 'package:hire/models/user_model.dart';
import 'package:hire/normaluser/contact.dart';

import 'package:hire/normaluser/home.dart';
import 'package:hire/normaluser/login.dart';
import 'package:hire/normaluser/profile.dart';
import 'package:provider/provider.dart';

import 'aboutus.dart';

class Navbar extends StatefulWidget {
  Navbar({Key? key, this.firstName, this.lastName, this.email})
      : super(key: key);
  String? firstName = "";
  String? lastName = "";
  String? email = "";

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  String? firstName = "";
  String? fullName = "";
  String? lastName = "";
  String? email = "";
  String? photoURL = "";
  String? googleEmail = "";
  User user = FirebaseAuth.instance.currentUser!;

  String? profileGoogleUrl = "";
  double rating = 0;
  UserModel userModel = UserModel();
  @override
  void initState() {
    super.initState();
    firstName = user.displayName;
    email = user.email;
    if (user.emailVerified) {
      profileGoogleUrl = user.photoURL;
    } else {
      getUserDetail();
    }
  }

  getUserDetail() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((value) {
      if (value.exists) {
        userModel = UserModel.fromMap(value.data());
        firstName = userModel.firstname;
        lastName = userModel.lastname;
        setState(() {
          fullName = "${firstName} ${lastName}";
        });
        if (userModel.image != null) {
          setState(() {
            photoURL = userModel.image;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: fullName != ""
                ? Text(" ${fullName} ")
                : Text(" $firstName $lastName"),
            accountEmail:
                googleEmail != "" ? Text(" ${googleEmail}") : Text("$email"),
            currentAccountPicture: user.emailVerified
                ? CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(profileGoogleUrl.toString()))
                : photoURL != ""
                    ? CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(photoURL.toString()))
                    : CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage("assets/aashutosh.jpg")),
            decoration: user.emailVerified
                ? BoxDecoration(
                    color: Colors.green,
                    image: DecorationImage(
                      image: NetworkImage(
                        profileGoogleUrl!,
                      ),
                      fit: BoxFit.cover,
                    ),
                  )
                : photoURL != ""
                    ? BoxDecoration(
                        color: Colors.green,
                        image: DecorationImage(
                          image: NetworkImage(
                            photoURL!,
                          ),
                          fit: BoxFit.cover,
                        ),
                      )
                    : BoxDecoration(
                        color: Colors.green,
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/aashutosh.jpg",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => home()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_phone),
            title: const Text("Contact Us "),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const contact()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("About Us "),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Aboutus()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout "),
            onTap: () {
              final provider =
                  Provider.of<GoogleSignInController>(context, listen: false);
              provider.logout();
              Logout(context);
            },
          ),
          const Divider(
            color: Colors.black,
          ),
          Align(
            alignment: Alignment.center,
            child: Column(children: <Widget>[
              Text("Rating : $rating", style: const TextStyle(fontSize: 25)),
              const SizedBox(height: 15),
              RatingBar.builder(
                minRating: 0,
                itemSize: 50,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                updateOnDrag: true,
                onRatingUpdate: (rating) => setState(() {
                  this.rating = rating;
                }),
              ),
            ]),
          )
        ],
      ),
    );
  }

  Future<void> Logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
