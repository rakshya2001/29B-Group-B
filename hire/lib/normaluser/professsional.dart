import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class professional extends StatefulWidget {
  const professional({Key? key}) : super(key: key);

  @override
  State<professional> createState() => _professionalState();
}

class _professionalState extends State<professional> {
  List<Object> _professionalis = [];
  final _saved = <professional>{};

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> dataStream =
        FirebaseFirestore.instance.collection("users").snapshots();

    return Scaffold(
      body: Container(
        color: Colors.amber,
        child: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: dataStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    print("error");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final List professional = [];
                  snapshot.data!.docs.map(
                    (DocumentSnapshot document) {
                      Map a = document.data() as Map<String, dynamic>;
                      professional.add(a);
                      a['users'] = document.id;
                    },
                  ).toList();

                  final index = professional.length ~/ 2;

                  final alreadysaved = _saved.contains((professional[index]));
                  return Column(
                      children: List.generate(
                    professional.length,
                    (i) => Container(
                      height: 200,
                      width: 500,
                      color: const Color(0xffFEF6E4),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              color: Color.fromARGB(255, 118, 172, 172),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    leading: const Icon(
                                      Icons.person,
                                      size: 40,
                                    ),
                                    title: Text(
                                      professional[i]["firstname"],
                                      style: const TextStyle(fontSize: 25),
                                    ),
                                    subtitle: Text(
                                      professional[i]["email"],
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(professional[i]["category"],
                                          style:
                                              const TextStyle(fontSize: 20))),
                                  SizedBox(
                                    width: 100,
                                  ),
                                  SizedBox(
                                    width: 250,
                                    child: Row(
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: Material(
                                            elevation: 5,
                                            color: const Color(0xFFF582AE),
                                            child: MaterialButton(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 15, 20, 15),
                                                minWidth: 50,
                                                onPressed: () {},
                                                child: const Text(
                                                  "Hire",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 50,
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if (alreadysaved) {
                                                  _saved.remove(
                                                      professional[index]);
                                                } else {
                                                  _saved
                                                      .add(professional[index]);
                                                }
                                              });
                                            },
                                            icon: Icon(
                                              alreadysaved
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: alreadysaved
                                                  ? Colors.red
                                                  : null,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              elevation: 8,
                              shadowColor: Colors.green,
                              margin: const EdgeInsets.all(20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
