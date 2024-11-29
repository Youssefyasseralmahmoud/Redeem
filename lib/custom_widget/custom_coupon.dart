import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:photo_view/photo_view.dart';
import 'package:redeem/custom_widget/CustomDotted.dart';
import 'package:redeem/generated/l10n.dart';
import 'package:redeem/json_db/enum.dart';
import 'package:redeem/screens/List_coupons_page/List_coupons_page.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:redeem/globals.dart' as globals;

//test
// ignore: must_be_immutable
class CustomCoupon extends StatefulWidget {
  SimpleCoupon simpleCoupon;
  Color? couponColor;
  Color? circulColor;
  // String? imageurl;
  // String? old_price;
  // String? price;
  // String? name;
  // String? valid_date;
  CustomCoupon({
    super.key,
    required this.simpleCoupon,
    this.couponColor,
    this.circulColor,
    // required this.imageurl,
    // required this.old_price,
    // required this.price,
    // required this.name,
    // required this.valid_date,
  });

  @override
  State<CustomCoupon> createState() => _CustomCoupon();
}

class _CustomCoupon extends State<CustomCoupon> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              color: widget.couponColor ?? Colors.white,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: CachedNetworkImage(
                  imageUrl: "${widget.simpleCoupon.image}",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 85,
                ),
              ),
              const SizedBox(
                height: 13,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.all(6.0),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    "${widget.simpleCoupon.simpleProvider!.getPropertyEffectedByLang("name_${globals.SelectedLang}")}",
                    style: CustomTheme.text15theme
                        .copyWith(color: Colors.grey.shade400, fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              SizedBox(
                // width: 100,
                height: 62,
                child: Padding(
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 6),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      "${widget.simpleCoupon.getPropertyEffectedByLang("name_${globals.SelectedLang}")}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTheme.text15theme.copyWith(
                        color: CustomColors.primarycolor,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),
              // Container(
              //   //width: 300,
              //   height: 35,
              //   child: Stack(
              //     children: [
              //       PositionedDirectional(
              //           top: 10.1,
              //           start: -10,
              //           child: Container(
              //             width: 25,
              //             height: 25,
              //             decoration: BoxDecoration(
              //               color: CustomColors.ticket_clip_color,
              //               borderRadius: BorderRadius.circular(40),
              //             ),
              //           )),
              //       PositionedDirectional(
              //           top: 10.1,
              //           end: -10,
              //           child: Container(
              //             width: 25,
              //             height: 25,
              //             decoration: BoxDecoration(
              //               color: CustomColors.ticket_clip_color,
              //               borderRadius: BorderRadius.circular(40),
              //             ),
              //           )),
              //       PositionedDirectional(
              //         top: 25.5,
              //         child: Center(
              //           child: CustomPaint(painter: DrawDottedhorizontalline()),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.simpleCoupon.priceBeforeDiscount!=null?
                  Text(
                    "${widget.simpleCoupon.priceBeforeDiscount} ",
                    style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey.shade400),
                  ):Text(""),
                  Text(
                    "${widget.simpleCoupon.price} " + S.of(context).S_R,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        color: CustomColors.SuccessColor),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: CustomColors.secondarycolor,
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                      size: 17,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        PositionedDirectional(
            top: 180.1,
            start: -15,
            child: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: widget.circulColor ?? CustomColors.ticket_clip_color,
                borderRadius: BorderRadius.circular(40),
              ),
            )),
        PositionedDirectional(
            top: 180.1,
            end: -15,
            child: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: widget.circulColor ?? CustomColors.ticket_clip_color,
                borderRadius: BorderRadius.circular(40),
              ),
            )),
        widget.circulColor == null
            ? PositionedDirectional(
                top: 190.5,
                child: Center(
                  child: CustomPaint(painter: DrawDottedhorizontalline()),
                ),
              )
            : PositionedDirectional(
                top: 190.5,
                child: Center(
                  child: CustomPaint(painter: CustomDrawDottedhorizontalline()),
                ),
              ),
        PositionedDirectional(
          top: 74,
          start: 10,
          child: CircleAvatar(
            backgroundImage:
                NetworkImage("${widget.simpleCoupon.simpleProvider!.logo}"),
          ),
        )
      ],
    );
  }
}
