import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hire/normaluser/Notification.dart';
import 'package:hire/normaluser/bigtext.dart';
import 'package:hire/normaluser/home.dart';
import 'package:hire/normaluser/loader.dart';
import 'package:hire/normaluser/login.dart';
import 'package:hire/models/user_model.dart';
import 'package:hire/normaluser/payment.dart';

import '../models/hire.dart';

class hire extends StatefulWidget {
  String? firstName = "";
  String? lastName = "";
  String? email = "";
  String? phone = "";
  hire({Key? key, this.firstName, this.lastName, this.email, this.phone})
      : super(key: key);

  @override
  State<hire> createState() => _hireState(firstName, lastName, email, phone);
}

class _hireState extends State<hire> {
  String? firstName = "";
  String? lastName = "";
  String? email = "";
  String? phone = "";
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
//Editing Controller

  bool loading = false;
  TextEditingController hourscontroller = new TextEditingController();

  _hireState(this.firstName, this.lastName, this.email, this.phone);

  @override
  Widget build(BuildContext context) {
    //email field
    final hours = TextFormField(
      autofocus: false,
      controller: hourscontroller,
      keyboardType: TextInputType.number,
      onSaved: (value) {
        hourscontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.watch),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Hours",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    final Confirmbutton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: const Color(0xFFF582AE),
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () => NotificationApi.showNotification(
            title: "Hiring Sucessfull ",
            body: "Successfully  you have Hired  to work for  ",
            payload: 'success '),
        child: const Text(
          "Confirm ",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return loading
        ? ColorLoader3()
        : Scaffold(
            backgroundColor: const Color(0xffFEF6E4),
            appBar: AppBar(
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title: const Text("Hiring Confirmation "),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(36),
                  child: Container(
                    color: const Color(0xffFEF6E4),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          BigText(text: "Hire this Professional "),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Text("Name : "),
                              Text(firstName!),
                              SizedBox(
                                width: 15,
                              ),
                              Text(lastName!),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Contact Details  : "),
                              Text(email!),
                              SizedBox(
                                width: 15,
                              ),
                              Text(phone!),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text("Hire for how many hours"),
                          hours,
                          const SizedBox(
                            height: 15,
                          ),
                          Text("Pay With  "),
                          GestureDetector(
                            child: Image.network(
                              "https://play-lh.googleusercontent.com/Xh_OlrdkF1UnGCnMN__4z-yXffBAEl0eUDeVDPr4UthOERV4Fll9S-TozSfnlXDFzw",
                              width: 80,
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Khaltipayment()));
                            },
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          Confirmbutton
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  postDetailsToFirestore() async {
    // calling firestore
    //calling user model

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    hireModel HireModel = hireModel();

    //writing all values

    HireModel.id = "001";
    HireModel.firstname = firstName;
    HireModel.lastname = lastName;
    HireModel.email = email;
    HireModel.phone = phone;
    HireModel.time = hourscontroller.text;

    await firebaseFirestore
        .collection("hire")
        .doc(user!.uid)
        .set(HireModel.toMap());
    Fluttertoast.showToast(msg: "sucessfully");
    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => home()), (route) => false);
  }
}
