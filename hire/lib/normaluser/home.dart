

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hire/normaluser/contact.dart';
import 'package:hire/normaluser/dashboard.dart';
import 'package:hire/normaluser/favourite.dart';
import 'package:hire/normaluser/professsional.dart';
import 'package:hire/normaluser/profile.dart';

import 'NavBar.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  //properties

  int currentTab = 0;
  final List<Widget> screens = [
    const dashboard(),
    const professional(),
    const favourite(),
    const profile(),
    const Navbar(),
  ];

  // active tab
  Widget currentScreen = const dashboard(); // initial screen of viewport

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Navbar(),
      appBar: AppBar(
       
      ),
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      //floating button
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search),
        backgroundColor: Colors.orangeAccent,
        
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      
      //bottom app bar
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.green,
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             IconButton( onPressed: () {
                  setState(
                    () {
                      currentScreen = const dashboard();
                      currentTab = 0;
                    },
                  );
                }, 
                  icon: Icon(
                    Icons.dashboard,
                    color: currentTab == 0 ? Colors.white : Colors.black,
                  ),
                
                ),
              
              IconButton( onPressed: () {
                  setState(
                    () {
                      currentScreen = const favourite();
                      currentTab = 1;
                    },
                  );
                }, 
                  icon: Icon(
                    Icons.favorite,
                    color: currentTab == 1 ? Colors.white : Colors.black,
                  ),
                
                ),
               
             IconButton( onPressed: () {
                  setState(
                    () {
                      currentScreen = const professional();
                      currentTab = 2;
                    },
                  );
                }, 
                  icon: Icon(
                    Icons.group,
                    size: 30,
                    color: currentTab == 2
                     ? Colors.white : Colors.black,
                  
                  ),
                
                ),
                IconButton( onPressed: () {
                  setState(
                    () {
                      currentScreen = const profile();
                      currentTab = 3;
                    },
                  );
                }, 
                  icon: Icon(
                    Icons.person,
                    size: 30,
                    color: currentTab == 3
                     ? Colors.white : Colors.black,
                  ),
                
                ),
             
            ],
          ),
        ),
      ),
    );
  }
}
