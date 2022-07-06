import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hire/models/chatRoomModel.dart';
import 'package:hire/models/user_model.dart';

import 'package:uuid/uuid.dart';

class MessagePageDoctor extends StatefulWidget {
  const MessagePageDoctor({Key? key}) : super(key: key);

  @override
  _MessagePageDoctorState createState() => _MessagePageDoctorState();
}

class _MessagePageDoctorState extends State<MessagePageDoctor> {
  User? user = FirebaseAuth.instance.currentUser;
  var uuid = const Uuid();
  bool isDoctor = false;
  UserModel customer = UserModel();
  User? firebaseUser = FirebaseAuth.instance.currentUser;
  final CollectionReference CustomerUserdata =
      FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('printed1');
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
      appBar: AppBar(
        actions: [
          FlatButton(
              onPressed: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(builder: (context) => const customer()),
                // );
              },
              child: const Text('Search'))
        ],
      ),
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
                                  // DoctorModel customer =
                                  //     userData.data as DoctorModel;

                                  return ListTile(
                                      onTap: () {
                                        // Navigator.push(context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) {
                                        //   return ChatRoomDoctor(
                                        //       targetUser: customer,
                                        //       chatroom: chatRoomModel,
                                        //       username: customer.firstname
                                        //           .toString());
                                        // }));
                                      },
                                      leading: customer.image.toString() == ""
                                          ? CircleAvatar(
                                              backgroundColor:
                                                  Colors.green[100],
                                              backgroundImage: const AssetImage(
                                                  "assets/images/google.png"),
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
