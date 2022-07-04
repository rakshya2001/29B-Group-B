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
  bool showtext = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help"),
      ),
      body: Container(
        padding: const EdgeInsets.all(18.0),
        child: Center(
            child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    showtext = false;
                  },
                  child: Container(
                    height: 50,
                    width: 350,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.black)),
                    child: Row(children: [
                      BigText(
                        text: "Why this app is built? ",
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_downward))
                    ]),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 50,
                    width: 350,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.black)),
                    child: Row(children: [
                      BigText(
                        text: "Why this app is built? ",
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_downward))
                    ]),
                  ),
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}
