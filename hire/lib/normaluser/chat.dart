import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hire/models/chat.dart';
import 'package:hire/normaluser/typemessage.dart';

class Chat extends StatefulWidget {
  final String? firstname;
  final String? lastname;
  const Chat({Key? key, required this.firstname, required this.lastname})
      : super(key: key);

  @override
  State<Chat> createState() => _ChatState(firstname, lastname);
}

class _ChatState extends State<Chat> {
  String? firstname = "";
  String? lastname = "";
  _ChatState(this.firstname, this.lastname);
    final _controller = TextEditingController();
  String message = '';
  final _auth = FirebaseAuth.instance;
  DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${firstname!} ${lastname!}"),
        
      ),
      body :Container(
      
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
                  print(firstname);
                  postDetailsToFirestore();
                },
                child: const Icon(Icons.send, color: Colors.white)))
      ]),
    ));
  }

  postDetailsToFirestore() async {
    // calling firestore
    //calling user model

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
    Fluttertoast.showToast(msg: "sucessfully");
  }
    
  }

