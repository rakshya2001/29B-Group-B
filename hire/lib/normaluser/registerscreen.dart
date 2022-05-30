import 'package:flutter/material.dart';
import 'package:hire/normaluser/login.dart';
import 'package:hire/normaluser/registerpage.dart';

import '../professionals/registerprofessionals.dart';

class registerScreen extends StatefulWidget {
  const registerScreen({Key? key}) : super(key: key);

  @override
  State<registerScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
  @override
  Widget build(BuildContext context) {
    final registerButtonuser = Material(
      elevation: 5,
      color: Color(0xFFF582AE),
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => registerpage()));
        },
        child: const Text(
          "Register",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    final registerButtonprofessional = Material(
      elevation: 5,
      color: Color(0xFFF582AE),
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => multilistedregister()));
        },
        child: const Text(
          "Register",
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
      backgroundColor: Color(0xffFEF6E4),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: Color(0xfff3fbfb)),
                child: Column(children: <Widget>[
                  const SizedBox(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Register as Normal User",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "People Who are looking for Workers "
                        "can register as Normal Users.",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [registerButtonuser],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 150,
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Image.asset(
                          "assets/user.png",
                          fit: BoxFit.contain,
                        )),
                  ),
                ]),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    color: Color(0xfff3fbfb)),
                child: Column(children: <Widget>[
                  const SizedBox(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Register as Professional User",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "People Who are looking for work "
                        "can register as Professional Users.",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [registerButtonprofessional],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 150,
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Image.asset(
                          "assets/professional.png",
                          fit: BoxFit.contain,
                        )),
                  ),
                ]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Already have a Account ?  ",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w400,
                          fontSize: 25),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
