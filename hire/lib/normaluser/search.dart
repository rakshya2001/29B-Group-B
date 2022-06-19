import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:hire/normaluser/home.dart';
import 'package:hire/pages/popular.dart';

import '../models/datacontroller.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController searchController = new TextEditingController();
  late QuerySnapshot snapshotData;
  bool IsExcecuted = false;

  @override
  Widget build(BuildContext context) {
    Widget searchData() {
      return ListView.builder(
        itemCount: snapshotData.docs.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Get.to(
                Popular(
                  firstname: snapshotData.docs[index]["firstname"],
                  email: snapshotData.docs[index]["email"],
                  phone: snapshotData.docs[index]["phone"],
                  city: snapshotData.docs[index]["city"],
                  category: snapshotData.docs[index]["category"],
                  time: snapshotData.docs[index]["time"],
                  lastname: snapshotData.docs[index]["lastname"],
                  
                ),
                transition: Transition.downToUp,
              );
            },
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("assets/plumber.jpg"),
              ),
              title: Text(snapshotData.docs[index]["firstname"]),
              subtitle: Text(snapshotData.docs[index]["category"]),
            ),
          );
        },
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.clear),
        onPressed: () {
          setState(() {
            IsExcecuted = false;
          });
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) => home()));
        },
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          GetBuilder<DataController>(
              init: DataController(),
              builder: (val) {
                return IconButton(
                    onPressed: () {
                      val.queryData(searchController.text).then((value) {
                        snapshotData = value;
                        setState(() {
                          IsExcecuted = true;
                        });
                      });
                    },
                    icon: Icon(Icons.search));
              })
        ],
        title: TextField(
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
              hintText: "Search Professionals ",
              hintStyle: TextStyle(color: Colors.white)),
          controller: searchController,
        ),
      ),
      body: IsExcecuted
          ? searchData()
          : Container(
              child: Center(
              child: Text(" Search any Professionals "),
            )),
    );
  }
}
