import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:provider/provider.dart';

import '../controllers/google_signin.dart';
import 'accountpage.dart';
import 'login.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      
      child: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          
          SettingsGroup(title: "General", children: [
            AccountPage(),
            SimpleSettingsTile(
              title: "Logout",
              subtitle: "",
              leading: IconButton(
                icon: const Icon(Icons.logout_rounded,color: Colors.blue,),
                onPressed: () {},
                
                
              ),
            ),
              SimpleSettingsTile(
              title: "Delete Account",
              subtitle: "",
              leading: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red,),
                onPressed: () {
                  
                },
                
                
              ),
            ),
          ]),
           SettingsGroup(title: "Feedback" , children: [
            
            SimpleSettingsTile(
              title: "Report a Bug ",
              subtitle: "",
              leading: IconButton(
                icon: const Icon(Icons.bug_report,color: Colors.lightGreen,),
                onPressed: () {},
                
                
              ),
            ),
              SimpleSettingsTile(
              title: "Send Feedback",
              subtitle: "",
              leading: IconButton(
                icon: const Icon(Icons.feedback, color: Color.fromARGB(255, 151, 10, 216),),
                onPressed: () {},
                
                
              ),
            ),
          ]),
        ],
      ),
    ));
  }

  Future<void> Logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
