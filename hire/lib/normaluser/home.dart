import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hire/models/user_model.dart';
import 'package:hire/normaluser/contact.dart';
import 'package:hire/normaluser/dashboard.dart';
import 'package:hire/normaluser/favourite.dart';
import 'package:hire/normaluser/professsional.dart';
import 'package:hire/normaluser/profile.dart';
import 'package:hire/normaluser/search.dart';

import 'NavBar.dart';

class home extends StatefulWidget {
  String? firstName;
  String? lastName;
  String? email;
  home({this.firstName, this.lastName, this.email}) : super();

  @override
  State<home> createState() => _homeState(firstName, lastName, email);
}

class _homeState extends State<home> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInuser = UserModel();
  String? firstName;
  String? lastName;
  String? email;

  //properties
  _homeState(this.firstName, this.lastName, this.email);
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(user!.uid)
  //       .get()
  //       .then((value) {
  //     this.loggedInuser = UserModel.fromMap(value.data());
  //   }).whenComplete(() {
  //     setState(() {
  //       firstName = loggedInuser.firstname.toString();
  //       lastName = loggedInuser.lastname.toString();
  //       email = loggedInuser.email.toString();
  //     });
  //   });
  // }

  int currentTab = 0;
  final List<Widget> screens = [
    dashboard(),
    const professional(),
    const favourite(),
    const profile(),
    Navbar(),
  ];

  // active tab
  Widget currentScreen = dashboard(); // initial screen of viewport

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(
        firstName: firstName,
        lastName: lastName,
        email: email,
      ),
      appBar: AppBar(
        title: currentTab == 2
            ? Text("Hire a New Professional")
            : Text(
                "Dashboard",
              ),
      ),
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      //floating button
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search),
        backgroundColor: Colors.orangeAccent,
        onPressed: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Search()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      //bottom app bar
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.green,
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  setState(
                    () {
                      currentScreen = dashboard();
                      currentTab = 0;
                    },
                  );
                },
                icon: Icon(
                  Icons.dashboard,
                  color: currentTab == 0 ? Colors.white : Colors.black,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(
                    () {
                      currentScreen = const favourite();
                      currentTab = 1;
                    },
                  );
                },
                icon: Icon(
                  Icons.favorite,
                  color: currentTab == 1 ? Colors.white : Colors.black,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(
                    () {
                      currentScreen = const professional();
                      currentTab = 2;
                    },
                  );
                },
                icon: Icon(
                  Icons.group,
                  size: 30,
                  color: currentTab == 2 ? Colors.white : Colors.black,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(
                    () {
                      currentScreen = const profile();
                      currentTab = 3;
                    },
                  );
                },
                icon: Icon(
                  Icons.person,
                  size: 30,
                  color: currentTab == 3 ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
