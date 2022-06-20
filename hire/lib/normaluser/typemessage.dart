import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/chat.dart';

class newmessage extends StatefulWidget {
  final String? firstname;
  final String? lastname;
  newmessage({Key? key, required this.firstname, required this.lastname})
      : super(key: key);

  @override
  State<newmessage> createState() => _newmessageState(firstname, lastname);
}

class _newmessageState extends State<newmessage> {
  String? firstname = "";
  String? lastname = "";
  _newmessageState(firstname, lastname);
  final _controller = TextEditingController();
  String message = '';
  final _auth = FirebaseAuth.instance;
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(8),
      child: Row(children: [
        Text("${firstname!}"),
        Expanded(
          child: TextField(
              controller: _controller,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 255, 255, 255),
                labelText: "Type your message here",
                border: OutlineInputBorder(
                  borderSide: const BorderSide(width: 0),
                  gapPadding: 10,
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onChanged: (value) => setState(() {
                    message = value;
                  })),
        ),
        const SizedBox(
          width: 20,
        ),
        Container(
            padding: const EdgeInsets.all(8),
            decoration:
                const BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
            child: GestureDetector(
                onTap: () {
                  
                  postDetailsToFirestore();
                },
                child: const Icon(Icons.send, color: Colors.white)))
      ]),
    );
  }

  postDetailsToFirestore() async {
    // calling firestore
    //calling user model
    FocusScope.of(context).unfocus();

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    chatModel ChatModel = chatModel();

    //writing all values

    ChatModel.id = _auth.currentUser!.uid;
    ChatModel.firstname = firstname!;
    ChatModel.lastname = lastname!;

    ChatModel.message = _controller.text;
    ChatModel.time = now.toString();

    await firebaseFirestore
        .collection("chat")
        .doc(user!.uid)
        .set(ChatModel.toMap());
    Fluttertoast.showToast(msg: " Sent sucessfully");
    _controller.clear();
  }
}
