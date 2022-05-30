import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hire/models/user_model.dart';
import 'package:hire/normaluser/contact.dart';

import 'package:hire/normaluser/home.dart';
import 'package:hire/normaluser/login.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInuser = UserModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection("Users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInuser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  double rating = 0;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName:
                Text("${loggedInuser.firstname} ${loggedInuser.lastname}"),
            accountEmail: Text("${loggedInuser.email}"),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  "https://cdn.vectorstock.com/i/1000x1000/20/76/man-avatar-profile-vector-21372076.webp",
                  height: 90,
                  width: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.green,
              image: DecorationImage(
                image: NetworkImage(
                  "https://th.bing.com/th/id/OIP.IApVvI7lUml_gN8K6vhkiQHaNK?w=186&h=331&c=7&r=0&o=5&pid=1.7",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const home()));
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const contact()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout "),
            onTap: () {
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
    Navigator.of(context).pushReplacement( MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
