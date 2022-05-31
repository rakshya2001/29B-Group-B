import 'package:flutter/material.dart';
import 'package:hire/normaluser/NavBar.dart';

class dashboard extends StatefulWidget {
  dashboard({Key? key, this.firstName, this.lastName, this.email})
      : super(key: key);
  String? firstName;
  String? lastName;
  String? email;
  @override
  State<dashboard> createState() => _dashboardState(firstName, lastName, email);
}

class _dashboardState extends State<dashboard> {
  String? firstName;
  String? lastName;
  String? email;

  _dashboardState(this.firstName, this.lastName, this.email);
  @override
  Widget build(BuildContext context) {
    final viewmore = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: const Color(0xFFF582AE),
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {},
        child: const Text(
          "View All Services",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Color(0xFFFEF6E4),
      drawer: Navbar(
        firstName: firstName,
        lastName: lastName,
        email: email,
      ),
      body: Center(
        child: Container(
          child: Column(children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                "Top Services",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 300,
              width: 500,
              child: Card(
                child: Row(children: <Widget>[
                  const Text("Electrician"),
                  SizedBox(
                    width: 50,
                  ),
                  const Text("Plumber")
                ]),
              ),
            ),
            viewmore,
          ]),
        ),
      ),
    );
  }
}
