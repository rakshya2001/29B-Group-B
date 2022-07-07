import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hire/models/MessageModel.dart';
import 'package:hire/models/chatRoomModel.dart';
import 'package:hire/models/user_model.dart';

import 'package:uuid/uuid.dart';

class ChatRoom extends StatefulWidget {
  String username;
  UserModel targetUser;

  final ChatRoomModel chatroom;

  ChatRoom(
      {required this.targetUser,
      required this.chatroom,
      required this.username,
      Key? key})
      : super(key: key);

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  var uuid = const Uuid();
  UserModel customer = UserModel();
  User? firebaseUser = FirebaseAuth.instance.currentUser;
  final CollectionReference CustomerData =
      FirebaseFirestore.instance.collection('users');

  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('photo............................');
    print(widget.targetUser.firstname.toString());
    UserData();
  }

  UserData() async {
    await CustomerData.doc(firebaseUser?.uid).get().then((value) {
      if (value.exists) {
        customer = UserModel.fromMap(value.data());
        print("customer uid................................");
        print(customer.uid);
        setState(() {});
      }
    });
  }

  void sendMessage() async {
    String message = messageController.text.trim();

    if (messageController.text != "") {
      MessageModel newMessage = MessageModel(
        messageId: uuid.v1(),
        sender: customer.uid,
        createdOn: DateTime.now(),
        text: message,
        seen: false,
      );

      FirebaseFirestore.instance
          .collection('chatrooms')
          .doc(widget.chatroom.chatroomId)
          .collection('messages')
          .doc(newMessage.messageId)
          .set(newMessage.toMap());

      widget.chatroom.lastMessage = message;
      print(widget.chatroom.lastMessage);

      FirebaseFirestore.instance
          .collection('chatrooms')
          .doc(widget.chatroom.chatroomId)
          .set(widget.chatroom.toMap());
      log("Message Sent");
    }
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            widget.targetUser.image != "" && widget.targetUser.image != null
                ? CircleAvatar(
                    backgroundColor: Colors.green[100],
                    backgroundImage:
                        NetworkImage(widget.targetUser.image.toString()),
                  )
                : CircleAvatar(
                    backgroundColor: Colors.green[100],
                    backgroundImage: const AssetImage("assets/aashutosh.jpg"),
                  ),
            Text(widget.targetUser.firstname.toString())
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                  child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("chatrooms")
                      .doc(widget.chatroom.chatroomId)
                      .collection('messages')
                      .orderBy("createdOn", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        QuerySnapshot dataSnapshot =
                            snapshot.data as QuerySnapshot;
                        // print(dataSnapshot.docs.isNotEmpty);

                        if (dataSnapshot.docs.isNotEmpty) {
                          return ListView.builder(
                              reverse: true,
                              itemCount: dataSnapshot.docs.length,
                              itemBuilder: (context, index) {
                                MessageModel currentMessage =
                                    MessageModel.fromMap(
                                        dataSnapshot.docs[index].data()
                                            as Map<String, dynamic>);

                                return Row(
                                  mainAxisAlignment:
                                      (currentMessage.sender == customer.uid)
                                          ? MainAxisAlignment.end
                                          : MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 2),
                                        decoration: BoxDecoration(
                                            color: (currentMessage.sender ==
                                                    customer.uid)
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .secondary
                                                : Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Text(
                                            currentMessage.text.toString())),
                                  ],
                                );
                              });
                        } else {
                          return const Center(child: Text('Say Hi!'));
                        }
                      } else if (snapshot.hasError) {
                        return const Center(
                            child:
                                Text('Please Check yout Internet Connection.'));
                      } else {
                        return const Center(
                          child: Text("Say Hi"),
                        );
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              )),
              Container(
                color: Colors.grey[200],
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  children: [
                    Flexible(
                        child: TextField(
                      controller: messageController,
                      maxLines: null,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: "Enter message"),
                    )),
                    IconButton(
                        onPressed: () {
                          sendMessage();
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.blue,
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
