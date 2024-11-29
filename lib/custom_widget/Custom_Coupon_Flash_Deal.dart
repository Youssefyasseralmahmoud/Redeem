import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:redeem/generated/l10n.dart';
import 'package:redeem/json_db/enum.dart';
import 'package:redeem/otp_phone_auth_handler/src/otp_handler.dart';
import 'package:redeem/screens/List_coupons_page/List_coupons_page.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:redeem/globals.dart' as globals;

class CustomCouponFlashDeal extends StatefulWidget {
  FlashDeal flashDeal;
//  String? imageurl;
//   String? logourl;
//   String? name;
//   String? content;
  CustomCouponFlashDeal(
      {super.key,
      //  this.imageurl,
      //   this.content,
      //    this.name,
      //    this.logourl,
      required this.flashDeal});

  @override
  State<CustomCouponFlashDeal> createState() => _CustomCouponFlashDeal();
}

class _CustomCouponFlashDeal extends State<CustomCouponFlashDeal> {
  @override
  Widget build(BuildContext context) {
    DateTime Time =
        DateTime.parse(widget.flashDeal.flashDealEndDate!.toString());
    var endTime = Time.millisecondsSinceEpoch;
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(.0),
          child: Row(
            children: [
              Container(
                width: 125,
                height: 160,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10))),
                child: CachedNetworkImage(
                  imageUrl: "${widget.flashDeal.image}",
                  fit: BoxFit.cover,
                  width: 120,
                  height: 100,
                ),
              ),
              Expanded(
                //flex: 10,
                child: Container(
                  padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 20, vertical: 8),
                  height: 160,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "${widget.flashDeal.simpleProvider!.getPropertyEffectedByLang("name_${globals.SelectedLang}")}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: CustomTheme.text15theme.copyWith(
                            color: Colors.grey,
                            fontSize: 13,
                          )),
                      const SizedBox(
                        height: 3,
                      ),
                      Expanded(
                        child: Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          "${widget.flashDeal.getPropertyEffectedByLang("name_${globals.SelectedLang}")}",
                          style: CustomTheme.text15theme.copyWith(
                            color: CustomColors.primarycolor,
                          ),
                        ),
                      ),

                      CountdownTimer(
                        endTime: endTime,
                        widgetBuilder: (_, CurrentRemainingTime? time) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(end: 10),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                              color:
                                                  CustomColors.secondarycolor)),
                                      child: Center(
                                          child: Text(
                                        "${time!.days != null ? time!.days.toString() : "0"}",
                                        style: TextStyle(fontSize: 12),
                                      )),
                                    ),
                                    Positioned(
                                      right: -7,
                                      top: 5,
                                      child: Container(
                                        width: 18,
                                        height: 18,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: Center(
                                          child: Text("d"),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(end: 10),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                              color:
                                                  CustomColors.secondarycolor)),
                                      child: Center(
                                          child: Text(
                                        "${time.hours != null ? time.hours.toString() : "0"}",
                                        style: TextStyle(fontSize: 12),
                                      )),
                                    ),
                                    Positioned(
                                      right: -7,
                                      top: 5,
                                      child: Container(
                                        width: 18,
                                        height: 18,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: Center(
                                          child: Text("h"),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            color:
                                                CustomColors.secondarycolor)),
                                    child: Center(
                                        child: Text(
                                      "${time!.min != null ? time!.min.toString() : "0"}",
                                      style: TextStyle(fontSize: 12),
                                    )),
                                  ),
                                  Positioned(
                                    right: -7,
                                    top: 5,
                                    child: Container(
                                      width: 18,
                                      height: 18,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: Center(
                                        child: Text("m"),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              // Stack(
                              //   clipBehavior: Clip.none,
                              //   children: [
                              //     Container(
                              //       width: 35,
                              //       height: 35,
                              //       decoration: BoxDecoration(
                              //           borderRadius: BorderRadius.circular(50),
                              //           border: Border.all(
                              //               color:
                              //                   CustomColors.secondarycolor)),
                              //       child: Center(
                              //           child: Text(
                              //         "${time.sec != null ? time!.sec.toString() : "0"}",
                              //         style: TextStyle(fontSize: 12),
                              //       )),
                              //     ),
                              //     Positioned(
                              //       right: -7,
                              //       top: 5,
                              //       child: Container(
                              //         width: 18,
                              //         height: 18,
                              //         decoration: BoxDecoration(
                              //             color: Colors.white,
                              //             borderRadius:
                              //                 BorderRadius.circular(50)),
                              //         child: Center(
                              //           child: Text(
                              //             "s",
                              //             textAlign: TextAlign.left,
                              //           ),
                              //         ),
                              //       ),
                              //     )
                              //   ],
                              // ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // const SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "900",
                                style: TextStyle(
                                    color: Colors.grey.shade400,
                                    decoration: TextDecoration.lineThrough),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "256" + " " + S.of(context).S_R,
                                style: TextStyle(
                                    color: CustomColors.SuccessColor,
                                    fontSize: 16),
                              )
                            ],
                          ),
                          Icon(
                            Icons.shopping_cart_checkout_outlined,
                            color: CustomColors.secondarycolor,
                          )
                          // ElevatedButton(
                          //     style: ElevatedButton.styleFrom(
                          //         padding: const EdgeInsetsDirectional.all(10),
                          //         primary: CustomColors.secondarycolor,
                          //         shape: RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.circular(50))),
                          //     onPressed: () {
                          //       // Navigator.of(context).push(
                          //       //     MaterialPageRoute(
                          //       //         builder: (context) {
                          //       //   return BuyPoints();
                          //       // }));
                          //     },
                          //     child: Center(
                          //       child: Text(
                          //         S.of(context).buy_coupon,
                          //         style: const TextStyle(
                          //             color: CustomColors.titlecolor,
                          //             fontSize: 15),
                          //       ),
                          //     ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        PositionedDirectional(
            start: 115,
            top: 0,
            child: Container(
              width: 50,
              height: 100,
              child: Stack(children: [
                PositionedDirectional(
                    top: -12.5,
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: CustomColors.ticket_clip_color,
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ))
              ]),
            )),
        PositionedDirectional(
            start: 115,
            top: 63,
            child: Container(
              width: 50,
              height: 100,
              child: Stack(children: [
                PositionedDirectional(
                    bottom: -12.5,
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: CustomColors.ticket_clip_color,
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ))
              ]),
            )),
      ],
    );
  }
}
