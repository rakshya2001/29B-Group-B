 import 'package:flutter/material.dart';

 class profile extends StatefulWidget {
   const profile({ Key? key }) : super(key: key);
 
   @override
   State<profile> createState() => _profileState();
 }
 
 class _profileState extends State<profile> {
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title : Text("Profile"),
       ),
     );
   }
 }