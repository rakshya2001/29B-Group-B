import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  TextOverflow textoverflow;
  BigText({Key? key,  this.color = Colors.black, required this.text, this.size=20,this.textoverflow = TextOverflow.ellipsis}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: textoverflow,
      style: TextStyle(
        fontFamily: 'Roboto',
        color: color,
        fontWeight:FontWeight.w600,
        fontSize: 20,
      ),

    );
  }
}
