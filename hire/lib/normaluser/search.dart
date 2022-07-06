import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hire/models/chatRoomModel.dart';
import 'package:hire/models/user_model.dart';
import 'package:hire/normaluser/chatRoom.dart';
import 'package:hire/pages/popular.dart';
import 'package:uuid/uuid.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var uid = const Uuid();

  UserModel customer = UserModel();
  final CollectionReference data =
      FirebaseFirestore.instance.collection('users');

  final TextEditingController _textEditingController = TextEditingController();

  List<UserModel> AllCustomerOnSearch = [];

  List<UserModel> AllCustomer = [];

  @override
  void initState() {
    super.initState();
    data.get().then((value) => {
          value.docs.forEach((element) {
            customer = UserModel.fromMap(element.data());
            setState(() {
              String? id = "Not Specified";
              String? firstName = "Not Specified";
              String? lastName = "Not Specified";
              String? email = "Not Specified";
              String? phone = "Not Specified";
              String? city = "Not Specified";
              String? category = "Not Specified";
              String? image;
              String? time = "Not Specified";
              firstName = customer.firstname;
              lastName = customer.lastname;
              phone = customer.phone;
              email = customer.email;

              if (customer.uid != null) {
                id = customer.uid!;
              }
              if (customer.image != null) {
                image = customer.image!;
              }
              if (customer.city != null) {
                city = customer.city!;
              }
              if (customer.category != null) {
                category = customer.category!;
              }
              if (customer.time != null) {
                time = customer.time!;
              }
              // print('All Id.......');
              // print(id);
              AllCustomer.add(UserModel(
                  uid: id,
                  firstname: firstName,
                  lastname: lastName,
                  email: email,
                  phone: phone,
                  city: city,
                  time: time,
                  category: category,
                  image: image));
            });
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextField(
            onChanged: (value) {
              setState(() {
                AllCustomerOnSearch = AllCustomer.where((element) => element
                    .firstname!
                    .toLowerCase()
                    .contains(value.toLowerCase())).toList();
              });
            },
            controller: _textEditingController,
            decoration: const InputDecoration(
              hintText: 'Search Professional',
              hintStyle: TextStyle(
                fontFamily: 'quicksand',
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
            style: const TextStyle(
              fontFamily: 'quicksand',
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: Icon(Icons.search),
            )
          ],
        ),
        body: Column(children: [
          _textEditingController.text.isEmpty || AllCustomerOnSearch.isEmpty
              ? const Expanded(
                  child: Center(
                    child: Text('No Result found!'),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                      itemCount: _textEditingController.text.isNotEmpty
                          ? AllCustomerOnSearch.length
                          : AllCustomer.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Popular(
                                          firstname: AllCustomerOnSearch[index]
                                              .firstname
                                              .toString(),
                                          email: AllCustomerOnSearch[index]
                                              .email
                                              .toString(),
                                          phone: AllCustomerOnSearch[index]
                                              .phone
                                              .toString(),
                                          city: AllCustomerOnSearch[index]
                                              .city
                                              .toString(),
                                          category: AllCustomerOnSearch[index]
                                              .category
                                              .toString(),
                                          lastname: AllCustomerOnSearch[index]
                                              .lastname
                                              .toString(),
                                          time:
                                              AllCustomerOnSearch[index].time!,
                                          userModel: AllCustomerOnSearch[index],
                                        )));
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                AllCustomerOnSearch[index].image != null
                                    ? CircleAvatar(
                                        backgroundColor: Colors.green[100],
                                        backgroundImage: NetworkImage(
                                            AllCustomerOnSearch[index].image!),
                                      )
                                    : CircleAvatar(
                                        backgroundColor: Colors.green[100],
                                        backgroundImage: const AssetImage(
                                            "assets/aashutosh.jpg"),
                                      ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  _textEditingController.text.isNotEmpty
                                      ? AllCustomerOnSearch[index].firstname!
                                      : AllCustomer[index].firstname!,
                                  style: const TextStyle(fontSize: 20),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 7.0, 0, 0),
                                  child: Text(
                                    "(${AllCustomerOnSearch[index].category})",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
        ]));
  }
}
