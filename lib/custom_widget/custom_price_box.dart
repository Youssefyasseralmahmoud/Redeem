import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'package:redeem/generated/l10n.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/globals.dart' as globals;

class CustomPriceBox extends StatefulWidget {
  String? price;
  String? points;
  double? fontSize;
  Color? color;
  Color? bordercolor;
  Color? pointcolor;
  String? oldPrice;
  String? packageName;
  String? earnedPoints;
  int? packageid;
  CustomPriceBox({
    this.pointcolor,
    this.packageName,
    this.bordercolor,
    this.color,
    this.fontSize,
    this.points,
    this.price,
    this.oldPrice,
    this.packageid,
    this.earnedPoints,
    super.key,
  });

  @override
  State<CustomPriceBox> createState() => _CustomPriceBox();
}

class _CustomPriceBox extends State<CustomPriceBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15,right: 10,left: 10),
      child: DottedBorder(
        padding: EdgeInsets.zero,
        radius: Radius.circular(15),
        dashPattern: [4, 2],
        strokeWidth: 2,
        borderType: BorderType.RRect,
        color: widget.bordercolor!,
        child: Container(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 10,),

          // width: 340,
          height: 110,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: globals.CurrentSubscribePackage == widget.packageid
                ? Colors.white
                : CustomColors.backgroundcolor_for_Ticket,
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Text(
                            "${widget.oldPrice}",
                            style: TextStyle(
                                color: Colors.grey.shade400,
                                decoration: TextDecoration.lineThrough),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${widget.price}" + " " + S.of(context).S_R,
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
                    Container(
                      child: Row(
                        children: [
                          Text(
                            "Buy Using Points",
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            "${double.parse(widget.points.toString())}" +
                                " " +
                                S.of(context).points,
                            style: TextStyle(
                                color: widget.pointcolor, fontSize: 15),
                          )
                        ],
                      ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "+ " +
                          "${widget.earnedPoints}" +
                          " " +
                          "${S.of(context).points}",
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    widget.packageid! >
                            int.parse(
                                globals.CurrentSubscribePackage.toString())
                        ? SizedBox(
                            height: 30,
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    primary: widget.bordercolor),
                                child: Text(
                                  "Upgrade",
                                  style: TextStyle(color: Colors.white),
                                )),
                          )
                        : Container()
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
