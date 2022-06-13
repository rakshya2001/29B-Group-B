import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:hire/normaluser/login.dart';

class Resetpassword extends StatefulWidget {
  const Resetpassword({Key? key}) : super(key: key);

  @override
  State<Resetpassword> createState() => _ResetpasswordState();
}

class _ResetpasswordState extends State<Resetpassword> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final snackbar = SnackBar(
        content:
            Text("Reset Email successfully send to ${emailController.text}. Check Your email Address and change the password"),
      
        );

    final emailField = TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        // validator: (value) {
        //   if (value!.isEmpty) {
        //     return ("Please Enter Your Email");
        //   }
        //   // reg expression for email validation
        //   if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
        //       .hasMatch(value)) {
        //     return ("Please Enter a valid email");
        //   }
        //   return null;
        // },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
             if (_formKey.currentState!.validate()) {
            resetpassword();
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
             Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
             }
          },
          child: const Text(
            "Send Email",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: Text(
              " Please Enter your Registered Email Address ",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          emailField,
          SizedBox(
            height: 15,
          ),
          loginButton,
        ],
      ),
    );
  }

  Future resetpassword() async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailController.text);
  }
}
