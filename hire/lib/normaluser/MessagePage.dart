import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hire/models/chatRoomModel.dart';
import 'package:hire/models/user_model.dart';
import 'package:hire/normaluser/chatRoom.dart';

import 'package:uuid/uuid.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  User? user = FirebaseAuth.instance.currentUser;
  var uuid = const Uuid();
  UserModel customer = UserModel();
  User? firebaseUser = FirebaseAuth.instance.currentUser;
  final CollectionReference CustomerUserdata =
      FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future getCustomerById(String uid) async {
    UserModel? customer;

    DocumentSnapshot docSnap =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();

    customer = UserModel.fromMap(docSnap.data());

    return customer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("chatrooms")
                .where("participants.${user!.uid}", isEqualTo: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  QuerySnapshot chatRoomSnapshot =
                      snapshot.data as QuerySnapshot;

                  return ListView.builder(
                      itemCount: chatRoomSnapshot.docs.length,
                      itemBuilder: (context, index) {
                        ChatRoomModel chatRoomModel = ChatRoomModel.fromMap(
                            chatRoomSnapshot.docs[index].data()
                                as Map<String, dynamic>);

                        Map<String, dynamic> participants =
                            chatRoomModel.participants!;

                        List<String> participantsKeys =
                            participants.keys.toList();

                        participantsKeys.remove(user?.uid);
                        print(
                            "Participants Keys..............................");
                        print(participantsKeys);

                        return FutureBuilder(
                            future: getCustomerById(participantsKeys[0]),
                            builder: (context, userData) {
                              if (userData.connectionState ==
                                  ConnectionState.done) {
                                if (userData.data != null) {
                                  UserModel customer =
                                      userData.data as UserModel;

                                  return ListTile(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return ChatRoom(
                                              targetUser: customer,
                                              chatroom: chatRoomModel,
                                              username: customer.firstname
                                                  .toString());
                                        }));
                                      },
                                      leading: customer.image == null
                                          ? CircleAvatar(
                                              backgroundColor:
                                                  Colors.green[100],
                                              backgroundImage: const AssetImage(
                                                  "assets/aashutosh.jpg"),
                                            )
                                          : CircleAvatar(
                                              backgroundColor:
                                                  Colors.green[100],
                                              backgroundImage: NetworkImage(
                                                  customer.image.toString()),
                                            ),
                                      title:
                                          Text(customer.firstname.toString()),
                                      subtitle: (chatRoomModel.lastMessage
                                                  .toString() !=
                                              "")
                                          ? Text(chatRoomModel.lastMessage
                                              .toString())
                                          : Text(
                                              "Say hi to your new friend!",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary),
                                            ));
                                } else {
                                  return Container();
                                }
                              } else {
                                return Container();
                              }
                            });

                        // retu
                      });
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return const Center(
                    child: Text('No Chats'),
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
