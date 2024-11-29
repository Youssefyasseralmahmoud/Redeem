import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:redeem/screens/home_screen/home_screen_controller.dart';
import 'package:redeem/theme/colors.dart';



class CustomOfferCouponBox extends StatefulWidget {
 String? imageurl;
  String? content;
  String? discount;

  CustomOfferCouponBox({
    this.discount,
    this.content,
    this.imageurl,
    super.key,
    //required this.controller,
  });

  @override
  State<CustomOfferCouponBox> createState() => _CustomOfferCouponBox();
}

class _CustomOfferCouponBox extends State<CustomOfferCouponBox> {
  @override
  Widget build(BuildContext context) {
      return Container(
      child: Column(
        children: [
          Container(
              width: 250,
              height: 110,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("${widget.imageurl}"), fit: BoxFit.fill),
                  borderRadius: BorderRadius.circular(10))),
          const SizedBox(
            height: 5,
          ),
          Text(
            "${widget.content}",
            style: const TextStyle(color: CustomColors.primarycolor),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 20,
                decoration: BoxDecoration(
                    color: CustomColors.primarycolor,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                    child: Text(
                  "${widget.discount}%",
                  style: const TextStyle(color: CustomColors.titlecolor),
                )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
