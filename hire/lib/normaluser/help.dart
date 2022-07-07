import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:hire/normaluser/bigtext.dart';

class help extends StatefulWidget {
  const help({Key? key}) : super(key: key);

  @override
  State<help> createState() => _helpState();
}

class _helpState extends State<help> {
  @override
  Widget build(BuildContext context) {
    return SimpleSettingsTile(
      title: "Help",
      leading: IconButton(
        icon: const Icon(
          Icons.question_mark,
          color: Color.fromARGB(255, 196, 98, 32),
        ),
        onPressed: () {
          print("object");
        },
      ),
      child: texthelp(),
    );
  }
}

class texthelp extends StatefulWidget {
  const texthelp({Key? key}) : super(key: key);

  @override
  State<texthelp> createState() => _texthelpState();
}

class _texthelpState extends State<texthelp> {
  int value = 0;
  bool showtext = false;
  bool isReadmore = false;
  bool showtext1 = false;
  bool isReadmore1 = false;
  bool showtext2 = false;
  bool isReadmore2 = false;

  @override
  Widget build(BuildContext context) {
    final maxLines = isReadmore ? null : 5;
    final Overflow = isReadmore ? TextOverflow.visible : TextOverflow.ellipsis;
    final maxLines1 = isReadmore1 ? null : 5;
    final Overflow1 =
        isReadmore1 ? TextOverflow.visible : TextOverflow.ellipsis;
    final maxLines2 = isReadmore1 ? null : 5;
    final Overflow2 =
        isReadmore1 ? TextOverflow.visible : TextOverflow.ellipsis;
    return Scaffold(
      appBar: AppBar(
        title: Text("Help"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(18.0),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showtext = !showtext;
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 350,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 2, color: Colors.black)),
                          child: Row(children: [
                            BigText(
                              text: "Why this app is built? ",
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_downward),
                              onPressed: () {
                                setState(() {
                                  showtext = !showtext;
                                });
                              },
                            )
                          ]),
                        ),
                      ),
                    ],
                  ),
                  showtext
                      ? Visibility(
                          visible: showtext,
                          maintainAnimation: true,
                          maintainState: true,
                          maintainSize: true,
                          child: Column(
                            children: [
                              Container(
                                height: 200,
                                width: 350,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2, color: Colors.black)),
                                child: Text(
                                  "This Professional hiring mobile application is a portal where people can register themselves either as user or as professional. User can view, search, and hire professionals to complete any type of task. User can give ratings and feedbacks to system Administrator regarding our application and professionals. This mobile application will be developed with flutter. Flutter is known to develop cross-platform applications. For Back-end development of the project we’ll be integrating firebase with our front-end system ",
                                  maxLines: maxLines,
                                  overflow: Overflow,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () =>
                                    setState(() => isReadmore = !isReadmore),
                                child: Text(
                                    isReadmore ? 'Read less ' : 'Read more'),
                              )
                            ],
                          ),
                        )
                      : SizedBox(),
                ],
              )),
            ),
            Container(
              padding: const EdgeInsets.all(18.0),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            value = 1;
                            showtext1 = !showtext1;
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 350,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 2, color: Colors.black)),
                          child: Row(children: [
                            BigText(
                              text: "How can one hire someone? ",
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_downward),
                              onPressed: () {
                                setState(() {
                                  showtext1 = !showtext1;
                                });
                              },
                            )
                          ]),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  showtext1
                      ? Visibility(
                          visible: showtext1,
                          maintainAnimation: true,
                          maintainState: true,
                          maintainSize: true,
                          child: Column(
                            children: [
                              Container(
                                height: 200,
                                width: 350,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2, color: Colors.black)),
                                child: Text(
                                  "One can hire someone based on their jobs which can be visible to everybody who has registered as normal user or client. In the dashboard or by using search panel. By searching the professsional they can then select the desired professional and hire based on the time and pay through khalti also by knowing the required money  ",
                                  maxLines: maxLines1,
                                  overflow: Overflow1,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () =>
                                    setState(() => isReadmore1 = !isReadmore1),
                                child: Text(
                                    isReadmore2 ? 'Read less ' : 'Read more'),
                              )
                            ],
                          ),
                        )
                      : SizedBox(),
                ],
              )),
            ),
            Container(
              padding: const EdgeInsets.all(18.0),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showtext2 = !showtext2;
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 350,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 2, color: Colors.black)),
                          child: Row(children: [
                            BigText(
                              text: "How to delete acoount? ",
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_downward),
                              onPressed: () {
                                setState(() {
                                  showtext2 = !showtext2;
                                });
                              },
                            )
                          ]),
                        ),
                      ),
                    ],
                  ),
                  showtext2
                      ? Visibility(
                          visible: showtext2,
                          maintainAnimation: true,
                          maintainState: true,
                          maintainSize: true,
                          child: Column(
                            children: [
                              Container(
                                height: 200,
                                width: 350,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2, color: Colors.black)),
                                child: Text(
                                  "This Professional hiring mobile application is a portal where people can register themselves either as user or as professional. User can view, search, and hire professionals to complete any type of task. User can give ratings and feedbacks to system Administrator regarding our application and professionals. This mobile application will be developed with flutter. Flutter is known to develop cross-platform applications. For Back-end development of the project we will be integrating firebase with our front-end system ",
                                  maxLines: maxLines2,
                                  overflow: Overflow2,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () =>
                                    setState(() => isReadmore2 = !isReadmore2),
                                child: Text(
                                    isReadmore2 ? 'Read less ' : 'Read more'),
                              )
                            ],
                          ),
                        )
                      : SizedBox(),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
