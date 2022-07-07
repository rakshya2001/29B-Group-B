import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hire/models/chatRoomModel.dart';
import 'package:hire/models/user_model.dart';
import 'package:hire/normaluser/chat.dart';
import 'package:hire/normaluser/chatRoom.dart';
import 'package:hire/normaluser/hiredform.dart';
import 'package:hire/normaluser/home.dart';
import 'package:hire/pages/textexpand.dart';
import 'package:uuid/uuid.dart';

import '../normaluser/bigtext.dart';
import '../utils/app_icon.dart';
import '../utils/dimension.dart';
import '../widgets/icontext.dart';

class Popular extends StatefulWidget {
  final String firstname;
  final String lastname;
  final String email;
  final String phone;
  final String city;
  final String category;
  final String time;
  UserModel? userModel;

  Popular(
      {Key? key,
      required this.firstname,
      required this.email,
      required this.phone,
      required this.city,
      required this.category,
      required this.lastname,
      required this.time,
      this.userModel})
      : super(key: key);

  @override
  State<Popular> createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  final User? user = FirebaseAuth.instance.currentUser;
// ------------------ Generate Random Id ------------------------------
  var uid = const Uuid();
  final CollectionReference data =
      FirebaseFirestore.instance.collection('users');

// ---- Create a chatRoom model between Currentuser and targeted user-------
  Future<ChatRoomModel?> getChatRoomModel(UserModel targetUser) async {
    ChatRoomModel? chatRoom;

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('chatrooms')
        .where("participants.${user!.uid}", isEqualTo: true)
        .where("participants.${targetUser.uid}", isEqualTo: true)
        .get();

    if (snapshot.docs.isNotEmpty) {
      // log("Chat Room Exists");
      var docData = snapshot.docs[0].data();
      ChatRoomModel existingChatRoom =
          ChatRoomModel.fromMap(docData as Map<String, dynamic>);
      log('Chat room Exists!');
      print('My id........');
      print(user?.uid);
      print('Targets id......');
      print(targetUser.uid);
      chatRoom = existingChatRoom;
    } else {
      ChatRoomModel newChatRoom = ChatRoomModel(
          chatroomId: uid.v1(),
          lastMessage: "",
          roomCreated: DateTime.now(),
          participants: {
            user!.uid.toString(): true,
            targetUser.uid.toString(): true,
          });

      await FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(newChatRoom.chatroomId)
          .set(newChatRoom.toMap());
      log('New Chat room created!');
      chatRoom = newChatRoom;
    }

    return chatRoom;
  }

  double rating = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: 350,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/plumber.jpg"),
              )),
            ),
          ),
          Positioned(
            top: 45,
            left: 20,
            right: 20,
            child: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => home()));
                    },
                    child: const AppIcons(
                      icon: Icons.arrow_back_ios,
                    ))
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 350,
            bottom: 0,
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        BigText(
                          text: widget.firstname,
                          size: 32,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        BigText(
                          text: widget.lastname,
                          size: 32,
                        ),
                      ]),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      Row(children: [
                        Wrap(
                            children: List.generate(
                                5,
                                (index) => const Icon(Icons.star,
                                    color: Colors.amber, size: 15)))
                      ]),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          icontext(
                              icon: Icons.work,
                              text: widget.category,
                              color: Colors.black,
                              iconColor: Colors.amber),
                          icontext(
                              icon: Icons.mail,
                              text: widget.email,
                              color: Colors.black,
                              iconColor: Colors.redAccent),
                          icontext(
                              icon: Icons.location_on,
                              text: widget.city,
                              color: Colors.black,
                              iconColor: Colors.blue)
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(text: "ABOUT ME"),
                            SingleChildScrollView(
                              child: ExpandableText(
                                  text:
                                      "Hello I am ${widget.firstname} ${widget.lastname} from ${widget.city}. Currently I Prefer working as ${widget.time} as a ${widget.category}. You can reach me through here also can contact me on ${widget.phone} "),
                            ),
                            Row(
                              children: [
                                Text("Rating : $rating",
                                    style: const TextStyle(fontSize: 15)),
                                RatingBar.builder(
                                  minRating: 0,
                                  itemSize: 50,
                                  itemPadding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  updateOnDrag: true,
                                  onRatingUpdate: (rating) => setState(() {
                                    this.rating = rating;
                                  }),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
          height: 90,
          padding:
              const EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: Color.fromARGB(255, 235, 235, 235)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () async {
                  ChatRoomModel? chatRoomModel =
                      await getChatRoomModel(widget.userModel!);

                  if (chatRoomModel != null) {
                    print(widget.userModel!.firstname);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => DoctorProfileScreen(
                    //             doctor: AllPatientOnSearch[index])));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatRoom(
                                  username:
                                      widget.userModel!.firstname.toString(),
                                  targetUser: widget.userModel!,
                                  chatroom: chatRoomModel,
                                )));
                  }
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => Chat(
                  //             firstname: widget.firstname,
                  //             lastname: widget.lastname)));
                },
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: Row(
                      children: [Icon(Icons.chat, size: 30)],
                    )),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => hire(
                                firstName: widget.firstname,
                                lastName: widget.lastname,
                                email: widget.email,
                                phone: widget.phone,
                              )));
                },
                child: Container(
                  height: 500,
                  width: 100,
                  padding: const EdgeInsets.only(
                      top: 5, bottom: 5, left: 30, right: 10),
                  child: BigText(
                    text: "Hire",
                    size: 50,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green),
                ),
              )
            ],
          )),
    );
  }
}
