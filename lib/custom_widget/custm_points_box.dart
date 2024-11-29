import 'package:flutter/material.dart';

import 'package:redeem/generated/l10n.dart';
import 'package:redeem/theme/colors.dart';

class CustomPointBox extends StatefulWidget {
  String? points;
  double? fontSize;
  Color? color;
  Color? bordercolor;
  Color? pointcolor;
  CustomPointBox({
    this.pointcolor,
    this.bordercolor,
    this.color,
    this.fontSize,
    this.points,
    super.key,
  });

  @override
  State<CustomPointBox> createState() => _CustomPointBox();
}

class _CustomPointBox extends State<CustomPointBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.symmetric(horizontal: 8),
      padding: EdgeInsetsDirectional.symmetric(horizontal: 13),
      width: 100,
      height: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: widget.bordercolor!)),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: Text(
            textAlign: TextAlign.center,
            "${widget.points} " + S.of(context).points,
            style: TextStyle(
                fontSize: widget.fontSize,
                color: widget.color,
                fontWeight: FontWeight.bold),
          ),
        ),
      ]),
    );
  }
}
