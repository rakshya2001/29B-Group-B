import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hire/normaluser/loader.dart';
import 'package:hire/normaluser/login.dart';
import 'package:hire/models/user_model.dart';

class registerpage extends StatefulWidget {
  const registerpage({Key? key}) : super(key: key);

  @override
  State<registerpage> createState() => _registerpageState();
}

class _registerpageState extends State<registerpage> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
//Editing Controller
  final TextEditingController firstnameController = new TextEditingController();
  final TextEditingController lastnameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController confirmpasswordController =
      new TextEditingController();
  final TextEditingController streetController = new TextEditingController();
  final TextEditingController cityController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController roleController = new TextEditingController()
    ..text = "normaluser";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final role = TextFormField(
      controller: roleController,
      enabled: false,
      autofocus: false,
      decoration: new InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.only(left: 500)),
    );
    final firstname = TextFormField(
      autofocus: false,
      controller: firstnameController,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty || RegExp(r'^[a-z A-Z]$').hasMatch(value)) {
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    final lastname = TextFormField(
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    //email field
    final emailfield = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    final passwordfield = TextFormField(
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final confirmpasswordfield = TextFormField(
      autofocus: false,
      controller: confirmpasswordController,
      obscureText: true,
      keyboardType: TextInputType.text,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (confirmpasswordController.text != passwordController.text) {
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    final streetfield = TextFormField(
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    final cityfield = TextFormField(
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    final phonefield = TextFormField(
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    final Registerbutton = Material(
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
    );

    return  loading ? ColorLoader3() :
    Scaffold(
      backgroundColor: const Color(0xffFEF6E4),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Register"),
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
                    firstname,
                    const SizedBox(
                      height: 35,
                    ),
                    lastname,
                    const SizedBox(
                      height: 35,
                    ),
                    emailfield,
                    const SizedBox(
                      height: 35,
                    ),
                    passwordfield,
                    const SizedBox(
                      height: 35,
                    ),
                    confirmpasswordfield,
                    const SizedBox(
                      height: 35,
                    ),
                    streetfield,
                    const SizedBox(
                      height: 35,
                    ),
                    cityfield,
                    const SizedBox(
                      height: 35,
                    ),
                    phonefield,
                    const SizedBox(
                      height: 35,
                    ),
                    role,
                    Registerbutton,
                    const SizedBox(
                      height: 35,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                postDetailsToFirestore(),
              })
          .catchError((e) {
        setState(() {
          bool loading = false;
        });
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
    userModel.role = roleController.text;

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
}
