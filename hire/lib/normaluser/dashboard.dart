import 'package:flutter/material.dart';
import 'package:hire/normaluser/NavBar.dart';

class dashboard extends StatefulWidget {
  const dashboard({Key? key}) : super(key: key);

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
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
      drawer: const Navbar(),
      appBar: AppBar(
        title: const Text("Dashboard"),
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
