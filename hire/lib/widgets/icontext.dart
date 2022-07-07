import 'package:flutter/material.dart';

class icontext extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final Color iconColor;
  const icontext({Key? key, required this.icon, required this.text, required this.color, required this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,color: iconColor,),
        SizedBox(width: 5,),
        Text(text,
        style: TextStyle(
            color: color,
        ),)
      ],
    );
  }
}
