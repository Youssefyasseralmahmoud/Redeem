import 'package:flutter/material.dart';
import 'package:redeem/theme/colors.dart';

class InfoBox extends StatefulWidget {
  // String? title;
  String? content;
  InfoBox({
    this.content,
    // this.title,
    super.key,
  });

  @override
  State<InfoBox> createState() => _InfoBox();
}

class _InfoBox extends State<InfoBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.all(4),
      margin: const EdgeInsetsDirectional.all(10),
      width: 100,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black.withAlpha(50))),
      child: Center(
        child: Text(
              "${widget.content}",
              style: TextStyle(color: Colors.black),
            ),
      ),
    );
  }
}
