import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hire/utils/dimension.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  const ExpandableText({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firsthalf;
  late String secondhalf;

  bool hiddenText = true;

  double textHeight = Dimensions.ScreenHeight / 5.63;
  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firsthalf = widget.text.substring(0, textHeight.toInt());
      secondhalf =
          widget.text.substring(textHeight.toInt()+1, widget.text.length);
    } else {
      firsthalf = widget.text;
      secondhalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondhalf.isEmpty
          ? Text(firsthalf)
          : Column(
              children: [
                Text(hiddenText
                    ? (firsthalf + "....")
                    : (firsthalf + secondhalf)),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  }, 
                  child: Row(children: [
                     const Text(
                      "Show More",
                      style: TextStyle(color: Colors.blue),
                    ),
                    Icon(hiddenText? Icons.arrow_drop_down : Icons.arrow_drop_up,
                      color: Colors.blue,
                    )
                  ]),
                 
                )
              ],
            ),
    );
  }
}
