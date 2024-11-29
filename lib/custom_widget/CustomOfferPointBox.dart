import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'package:redeem/generated/l10n.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/globals.dart' as globals;

class CustomOfferPointBox extends StatefulWidget {
  String? points;
  double? fontSize;
  Color? color;
  Color? bordercolor;
  Color? pointcolor;

  String? packageName;

  int? packageid;
  CustomOfferPointBox({
    this.pointcolor,
    this.packageName,
    this.bordercolor,
    this.color,
    this.fontSize,
    this.points,
    this.packageid,
    super.key,
  });

  @override
  State<CustomOfferPointBox> createState() => _CustomOfferPointBox();
}

class _CustomOfferPointBox extends State<CustomOfferPointBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
      child: DottedBorder(
        padding: EdgeInsets.zero,
        radius: Radius.circular(15),
        dashPattern: [4, 2],
        strokeWidth: 2,
        borderType: BorderType.RRect,
        color: widget.bordercolor!,
        child: Container(
          padding: EdgeInsetsDirectional.all(8),
          // width: 340,
          height: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: globals.CurrentSubscribePackage == widget.packageid
                ? Colors.white
                : CustomColors.backgroundcolor_for_Ticket,
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Text(
                            "${widget.points}" + " " + S.of(context).points,
                            style: TextStyle(
                              fontSize: widget.fontSize,
                              color: widget.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${widget.packageName}",
                      style: TextStyle(color: widget.bordercolor, fontSize: 18),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Use This Offer by points",
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    globals.CurrentSubscribePackage == widget.packageid
                        ? Icon(
                            Icons.check_circle_outline,
                            color: widget.bordercolor,
                            size: 30,
                          )
                        : Container()
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
