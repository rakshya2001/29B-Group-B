import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedItemIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Row(
      children: [
        buildNavbar(Icons.home, 0),
        buildNavbar(Icons.notifications, 1),
        buildNavbar(Icons.pie_chart, 2),
        buildNavbar(Icons.mail, 3),
        buildNavbar(Icons.person, 4),
      ],
    ),
    body:Center(child: Container(

      child:Text(""),
    ),));
  }

  Widget buildNavbar(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedItemIndex = index;
        });
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width / 5,
        decoration: BoxDecoration(
          color: index == _selectedItemIndex ? Colors.green : Colors.white,
        ),
        child: Icon(icon),
      ),
    );
  }
}
