import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleSettingsTile(
      title: "Account setting",
      subtitle: 'Change Pasword,Two Step verification ',
      leading: IconButton(icon: Icon(Icons.settings,color: Colors.green,),onPressed: (){},),
    child:
     SettingsScreen(title: "Account Setting ",children: [
      
  SimpleSettingsTile(
    
              title: "Change Password",
              subtitle: "",
              leading: IconButton(
                icon: const Icon(Icons.key_sharp,color: Colors.amber,),
                onPressed: () {},
                
                
              ),
            ),
            
            SimpleSettingsTile(
    
              title: "Two Step Verification ",
              subtitle: "",
              leading: IconButton(
                icon: const Icon(Icons.phone,color: Color.fromARGB(255, 196, 98, 32),),
                onPressed: () {},
                
                
              ),
            ),
            SimpleSettingsTile(
    
              title: "Change Email Address",
              subtitle: "",
              leading: IconButton(
                icon: const Icon(Icons.email,color: Color.fromARGB(73, 24, 5, 5),),
                onPressed: () {},
                
                
              ),
            ),
             SimpleSettingsTile(
    
              title: "Help",
              subtitle: "",
              leading: IconButton(
                icon: const Icon(Icons.question_mark,color: Color.fromARGB(255, 148, 26, 142),),
                onPressed: () {},
                
                
              ),
            ),
             SimpleSettingsTile(
    
              title: "Terms Of Use",
              subtitle: "",
              leading: IconButton(
                icon: const Icon(Icons.text_snippet,color: Color.fromARGB(255, 0, 226, 38),),
                onPressed: () {},
                
                
              ),
            ),

    ]),
    );
  }
}
