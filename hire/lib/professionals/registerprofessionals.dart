import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hire/normaluser/login.dart';
import 'package:image_picker/image_picker.dart';

import '../models/user_model.dart';

class multilistedregister extends StatefulWidget {
  const multilistedregister({Key? key}) : super(key: key);

  @override
  State<multilistedregister> createState() => _multilistedregisterState();
}

class _multilistedregisterState extends State<multilistedregister> {
  File? image;
  File? image1;
  Future pickImage(ImageSource source) async {
    try {
      final image1 = await ImagePicker().pickImage(source: source);
      if (image1 == null) return;

      final imageTemporary = File(image1.path);
      setState(() => this.image1 = imageTemporary);
    } on PlatformException catch (e) {
      print("falied To pick Image : $e");
    }
  }

  Future pickImage2(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print("falied To pick Image : $e");
    }
  }

  int _activestepindex = 0;
  final TextEditingController firstnameController = new TextEditingController();
  final TextEditingController lastnameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController confirmpasswordController =
      new TextEditingController();
  final TextEditingController streetController = new TextEditingController();
  final TextEditingController cityController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController roleController = new TextEditingController();
  final TextEditingController categoryController = new TextEditingController();

  List<DropdownMenuItem<String>> get DropdownItem1 {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
        child: Text("Plumber"),
        value: "Plumber",
      ),
      const DropdownMenuItem(
          child: const Text("Electrician"), value: "Electrician")
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get DropdownItem2 {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
        child: Text("Full Time"),
        value: "fulltime",
      ),
      const DropdownMenuItem(child: Text("Part TIme"), value: "parttime")
    ];
    return menuItems;
  }

  String? selectedvalue = null;
  String? selectedvalue2 = null;

  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  List<Step> steplist() => [
        Step(
          state: _activestepindex <= 0 ? StepState.indexed : StepState.complete,
          isActive: _activestepindex >= 0,
          title: const Text(""),
          content: Container(
            child: Column(
              key: _formKey,
              children: <Widget>[
                const Text(" Personal Details"),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  autofocus: false,
                  controller: firstnameController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty ||
                        RegExp(r'^[a-z A-Z]$').hasMatch(value)) {
                      return ("Enter Correct name");
                    }
                    // reg expression for email validation
                  },
                  onSaved: (value) {
                    firstnameController.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    hintText: "firstname",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  autofocus: false,
                  controller: lastnameController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    RegExp regex = RegExp(r'^.{3,}$');
                    if (value!.isEmpty) {
                      return ("Please Enter Your lastname");
                    }
                    // reg expression for email validation
                    if (!regex.hasMatch(value)) {
                      return ("Please Enter a valid lastname(minimum three character");
                    }
                    return null;
                  },
                  onSaved: (value) {
                    lastnameController.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    hintText: "lastname",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  autofocus: false,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Please Enter Your Email");
                    }
                    // reg expression for email validation
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return ("Please Enter a valid email");
                    }
                    return null;
                  },
                  onSaved: (value) {
                    emailController.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.mail),
                    contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    hintText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  autofocus: false,
                  controller: passwordController,
                  obscureText: true,
                  validator: (value) {
                    RegExp regex = new RegExp(r'^.{6,}$');
                    if (value!.isEmpty) {
                      return ("Please Enter Your Password");
                    }
                    // reg expression for email validation
                    if (!regex.hasMatch(value)) {
                      return ("Please Enter a valid password(minimum six character");
                    }
                    return null;
                  },
                  onSaved: (value) {
                    passwordController.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.key),
                    contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    hintText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  autofocus: false,
                  controller: confirmpasswordController,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    RegExp regex = new RegExp(r'^.{6,}$');
                    if (confirmpasswordController.text !=
                        passwordController.text) {
                      return ("Password Doesnot match");
                    }
                    // reg expression for email validation
                    if (!regex.hasMatch(value!)) {
                      return ("Please Enter a valid password(minimum six character");
                    }
                    return null;
                  },
                  onSaved: (value) {
                    confirmpasswordController.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.key),
                    contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    hintText: " Confirm Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  autofocus: false,
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    RegExp regex = new RegExp(r'^.{10,}$');
                    if (value!.isEmpty) {
                      return ("Please Enter Your phone number");
                    }
                    // reg expression for email validation
                    if (!regex.hasMatch(value)) {
                      return ("Please Enter a valid password(minimum six character");
                    }
                    return null;
                  },
                  onSaved: (value) {
                    phoneController.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.phone),
                    contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    hintText: " Phone number",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          ),
        ),
        Step(
          state: _activestepindex <= 1 ? StepState.indexed : StepState.complete,
          isActive: _activestepindex >= 1,
          title: const Text(" "),
          content: Container(
            child: Column(children: <Widget>[
              const Text("Address Details "),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                autofocus: false,
                controller: streetController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  RegExp regex = new RegExp(r'^.{6,}$');
                  if (value!.isEmpty) {
                    return ("Street cannot be empty");
                  }
                  // reg expression for email validation
                  if (!regex.hasMatch(value)) {
                    return ("Please Enter a valid Street name(minimum six character");
                  }
                  return null;
                },
                onSaved: (value) {
                  streetController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.streetview),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: " Street",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                autofocus: false,
                controller: cityController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  RegExp regex = new RegExp(r'^.{6,}$');
                  if (value!.isEmpty) {
                    return ("city name cannot be empty");
                  }
                  // reg expression for email validation
                  if (!regex.hasMatch(value)) {
                    return ("Please Enter a valid city name(minimum six character");
                  }
                  return null;
                },
                onSaved: (value) {
                  cityController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.location_city),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "City ",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ]),
          ),
        ),
        Step(
          state: _activestepindex <= 2 ? StepState.indexed : StepState.complete,
          isActive: _activestepindex >= 2,
          title: const Text(" "),
          content: Container(
            child: Column(children: <Widget>[
              const Text(" Select Your preferred Services "),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.green, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.green, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) =>
                    value == null ? "Select a Category " : null,
                dropdownColor: Colors.green,
                onChanged: (String? newvalue) {
                  setState(
                    () {
                      selectedvalue2 = newvalue!;
                    },
                  );
                },
                items: DropdownItem1,
              ),
              const SizedBox(
                height: 40,
              ),
              const Text("Select Your Preferred time"),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.green, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.green, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) =>
                    value == null ? "Select a Particular time " : null,
                dropdownColor: Colors.green,
                onChanged: (String? newvalue) {
                  setState(
                    () {
                      selectedvalue = newvalue!;
                    },
                  );
                },
                items: DropdownItem2,
              ),
            ]),
          ),
        ),
        Step(
          state: _activestepindex <= 3 ? StepState.indexed : StepState.complete,
          isActive: _activestepindex >= 3,
          title: const Text(" "),
          // ignore: avoid_unnecessary_containers
          content: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  const Text("Please Upload the Document Mentioned below"),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Citizenship Photo",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  OutlineButton.icon(
                    onPressed: (() => pickImage(ImageSource.gallery)),
                    icon: Icon(Icons.browse_gallery_sharp),
                    label: Text("Choose from gallery"),
                    color: Colors.green,
                  ),
                  OutlineButton.icon(
                    onPressed: (() => pickImage(ImageSource.camera)),
                    icon: Icon(Icons.camera),
                    label: Text("Take from camera"),
                    color: Colors.green,
                  ),
                  const Text(
                    "Profile  Photo",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  OutlineButton.icon(
                    onPressed: (() => pickImage2(ImageSource.gallery)),
                    icon: Icon(Icons.browse_gallery_sharp),
                    label: Text("Choose from gallery"),
                    color: Colors.green,
                  ),
                  OutlineButton.icon(
                    onPressed: (() => pickImage2(ImageSource.camera)),
                    icon: Icon(Icons.camera),
                    label: Text("Take from camera"),
                    color: Colors.green,
                  ),
                ]),
          ),
        ),
        Step(
          state: StepState.complete,
          isActive: _activestepindex >= 4,
          title: const Text(" "),
          content: Container(
              color: Color(0xFFFEF6E4),
              child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  const Text(
                    "Verify Your Details ",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          Text(
                            "First Name : ${firstnameController.text}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w300),
                          ),
                          Text("Last Name : ${lastnameController.text}"),
                          Text("Email : ${emailController.text}"),
                          Text("Password : ${passwordController.text}"),
                          Text(
                              "Confirm Pasword : ${confirmpasswordController.text}"),
                          Text("Street  : ${streetController.text}"),
                          Text("City  : ${cityController.text}"),
                          Text("Phone number : ${phoneController.text}"),
                          Text("Category : ${selectedvalue2}"),
                          Text("Preferred Time : ${selectedvalue}"),
                        ],
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Citzenship Image : "),
                  ),
                  image1 != null
                      ? Image.file(image1!,
                          width: 160, height: 150, fit: BoxFit.cover)
                      : FlutterLogo(
                          size: 160,
                        ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Profile  Image : "),
                  ),
                  image != null
                      ? Image.file(image!,
                          width: 160, height: 150, fit: BoxFit.cover)
                      : FlutterLogo(
                          size: 160,
                        ),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xFFF582AE),
                    child: MaterialButton(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () {
                        signUp(emailController.text, passwordController.text);
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
                  ),
                ]),
              )),
        ),
      ];
  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                postDetailsToFirestore(),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async {
    // calling firestore
    //calling user model

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    //writing all values

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstname = firstnameController.text;
    userModel.lastname = lastnameController.text;
    userModel.password = passwordController.text;
    userModel.confirmpassword = confirmpasswordController.text;
    userModel.street = streetController.text;
    userModel.city = cityController.text;
    userModel.phone = phoneController.text;
    userModel.category = selectedvalue2;
    userModel.time = selectedvalue;
    userModel.role = "professional";

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created sucessfully");
    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _formKey,
        appBar: AppBar(
          title: const Text("Professional Register"),
        ),
        body: Stepper(
          type: StepperType.horizontal,
          currentStep: _activestepindex,
          steps: steplist(),
          onStepContinue: () {
            setState(() {
              if (_activestepindex < (steplist().length - 1)) {
                _activestepindex += 1;
                return;
              }
            });
          },
          onStepCancel: () {
            if (_activestepindex == 0) {
              return;
            }
            _activestepindex -= 1;
            setState(() {});
          },
          onStepTapped: (int index) {
            setState(() {
              _activestepindex = index;
            });
          },
        ));
  }
}

// ignore: camel_case_types

