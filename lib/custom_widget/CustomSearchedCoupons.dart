import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:photo_view/photo_view.dart';
import 'package:redeem/generated/l10n.dart';
import 'package:redeem/json_db/enum.dart';
import 'package:redeem/screens/List_coupons_page/List_coupons_page.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:redeem/globals.dart' as globals;

// ignore: must_be_immutable
class CustomSearchedCoupon extends StatefulWidget {
  SimpleCoupon simpleCoupon;
  // String? imageurl;
  // String? old_price;
  // String? price;
  // String? name;
  // String? valid_date;
  CustomSearchedCoupon({
    super.key,
    required this.simpleCoupon,
    // required this.imageurl,
    // required this.old_price,
    // required this.price,
    // required this.name,
    // required this.valid_date,
  });

  @override
  State<CustomSearchedCoupon> createState() => _CustomSearchedCoupon();
}

class _CustomSearchedCoupon extends State<CustomSearchedCoupon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  height: 81,
                  child: CachedNetworkImage(
                    imageUrl: "${widget.simpleCoupon.image}",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 81,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    // image:  DecorationImage(
                    //     image: NetworkImage("${imageurl}"),
                    //     fit: BoxFit.fill)
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${widget.simpleCoupon.priceBeforeDiscount}",
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.red),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${widget.simpleCoupon.price} " + S.of(context).S_R,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),

                  // Row(
                  //   mainAxisSize: MainAxisSize.min,
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     // CircleAvatar(
                  //     //     backgroundColor: Colors.white,
                  //     //     radius: 22,
                  //     //     backgroundImage:
                  //     //         AssetImage("assets/images/test.jpg")),
                  //     SizedBox(
                  //       width: 10,
                  //     ),
                  //     Expanded(
                  //       child: Text(
                  //         "Small Snicker coffe",
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ),
              ],
            ),
          ),
          Container(
            //width: 300,
            height: 25,
            child: Stack(
              children: [
                PositionedDirectional(
                    top: 0.1,
                    start: -10,
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: CustomColors.ticket_clip_color,
                        borderRadius: BorderRadius.circular(40),
                      ),
                    )),
                PositionedDirectional(
                    top: 0.1,
                    end: -10,
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: CustomColors.ticket_clip_color,
                        borderRadius: BorderRadius.circular(40),
                      ),
                    )),
                PositionedDirectional(
                  top: 13.5,
                  child: Center(
                    child: CustomPaint(painter: DrawDottedhorizontalline()),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding:
                EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 8),
            height: 105,
            width: 400,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "${widget.simpleCoupon.getPropertyEffectedByLang("name_${globals.SelectedLang}")}",
                    textAlign: TextAlign.center,
                    style: CustomTheme.text15theme.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "${widget.simpleCoupon.validTo}",
                  style: TextStyle(
                      color: CustomColors.subtitlecolor, fontSize: 11),
                ),
                const SizedBox(
                  height: 5,
                ),
                // Text(
                //   "SN ",
                //   //+"${widget.soldCoupon.serialNumber}",
                //   style: TextStyle(
                //       color: CustomColors.subtitlecolor, fontSize: 11),
                // )
              ],
            ),
          )
        ],
      ),
    );
  }
}
