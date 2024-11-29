import 'package:flutter/material.dart';
import 'package:redeem/custom_widget/custme_button.dart';

import 'package:redeem/generated/l10n.dart';
import 'package:redeem/json_db/enum.dart';
import 'package:redeem/screens/cart_screen/cart_screen.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';
import 'package:redeem/globals.dart' as globals;

class CustomSubscribePackage extends StatefulWidget {
  int? id;
  List<String>? listcontent = [];
  String? package_name;
  Color? color;
  String? price;
  SubscriptionPackage? subscriptionPackage;
  CustomSubscribePackage({
    this.id,
    this.listcontent,
    this.color,
    this.price,
    this.package_name,
    this.subscriptionPackage,
    super.key,
  });

  @override
  State<CustomSubscribePackage> createState() => _CustomSubscribePackage();
}

class _CustomSubscribePackage extends State<CustomSubscribePackage> {
  @override
  Widget build(BuildContext context) {
    return globals.CurrentSubscribePackage! > widget.subscriptionPackage!.id!
        ? Padding(
            padding: const EdgeInsetsDirectional.all(8.0),
            child: Card(
              elevation: 0,
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                width: double.infinity,
                alignment: AlignmentDirectional.topStart,
                padding: const EdgeInsetsDirectional.all(20),
                height: 190,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadiusDirectional.only(
                        bottomStart: Radius.circular(30),
                        bottomEnd: Radius.circular(250)),
                    color: Color(
                      int.parse(
                        "0XFF" +
                            widget.subscriptionPackage!.color!
                                .replaceAll("#", ""),
                      ),
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Text(
                            "${widget.subscriptionPackage!.getPropertyEffectedByLang("package_name_${globals.SelectedLang}")}",
                            style: CustomTheme.text16theme.copyWith(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              ...[1, 2, 3].map((e) {
                                if (widget.subscriptionPackage!.level! >= e)
                                  return const Icon(Icons.star_outline,
                                      color: Colors.yellow, size: 30);
                                else
                                  return Container();
                              })
                            ],
                          )
                        ],
                      )
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    if (widget.subscriptionPackage!.price != "0.00" &&
                        widget.subscriptionPackage!.price != "0")
                      Wrap(
                        spacing: 10,
                        children: [
                          Text(S.of(context).S_R,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20)),
                          Text(
                            "${widget.subscriptionPackage!.price}",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 35),
                          )
                        ],
                      ),
                    if (widget.subscriptionPackage!.price == "0.00" ||
                        widget.subscriptionPackage!.price == "0")
                      Text(
                        "${S.of(context).free}",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 35),
                      ),
                    if (widget.subscriptionPackage!.pointPrice != "0.00" &&
                        widget.subscriptionPackage!.pointPrice != "0")
                      Wrap(
                        spacing: 10,
                        children: [
                          Text(
                            "${widget.subscriptionPackage!.pointPrice} ${S.of(context).points}",
                            style: const TextStyle(
                                color: Colors.yellow, fontSize: 20),
                          )
                        ],
                      ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "${S.of(context).per_year}",
                      style: const TextStyle(color: Colors.white, fontSize: 25),
                    )
                  ],
                ),
              ),

              //ban
              //  Center(
              //   child: Padding(
              //     padding: const EdgeInsetsDirectional.all(20.0),
              //     child: Text(
              //       "${widget.subscriptionPackage!.getPropertyEffectedByLang("package_name_${globals.SelectedLang}")}",
              //       style: CustomTheme.text16theme.copyWith(
              //         color: Color(
              //           int.parse(
              //             "0XFF" +
              //                 widget.subscriptionPackage!.color!
              //                     .replaceAll("#", ""),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ),
          )
        : Padding(
            padding: const EdgeInsetsDirectional.all(8.0),
            child: Card(
              color: Colors.white,
              elevation: 0,
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: const EdgeInsetsDirectional.all(0),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      alignment: AlignmentDirectional.topStart,
                      padding: const EdgeInsetsDirectional.all(20),
                      height: 190,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadiusDirectional.only(
                              bottomStart: Radius.circular(30),
                              bottomEnd: Radius.circular(250)),
                          color: Color(
                            int.parse(
                              "0XFF" +
                                  widget.subscriptionPackage!.color!
                                      .replaceAll("#", ""),
                            ),
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Wrap(
                              alignment: WrapAlignment.center,
                              children: [
                                Text(
                                  "${widget.subscriptionPackage!.getPropertyEffectedByLang("package_name_${globals.SelectedLang}")}",
                                  style: CustomTheme.text16theme.copyWith(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  children: [
                                    ...[1, 2, 3].map((e) {
                                      if (widget.subscriptionPackage!.level! >=
                                          e)
                                        return const Icon(Icons.star_outline,
                                            color: Colors.yellow, size: 30);
                                      else
                                        return Container();
                                    })
                                  ],
                                )
                              ],
                            )
                          ]),
                          const SizedBox(
                            height: 10,
                          ),
                          if (widget.subscriptionPackage!.price != "0.00" &&
                              widget.subscriptionPackage!.price != "0")
                            Wrap(
                              spacing: 10,
                              children: [
                                Text(S.of(context).S_R,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 20)),
                                Text(
                                  "${widget.subscriptionPackage!.price}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 35),
                                )
                              ],
                            ),
                          if (widget.subscriptionPackage!.price == "0.00" ||
                              widget.subscriptionPackage!.price == "0")
                            Text(
                              "${S.of(context).free}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 35),
                            ),
                          if (widget.subscriptionPackage!.pointPrice !=
                                  "0.00" &&
                              widget.subscriptionPackage!.pointPrice != "0")
                            Wrap(
                              spacing: 10,
                              children: [
                                Text(
                                  "${widget.subscriptionPackage!.pointPrice} ${S.of(context).points}",
                                  style: const TextStyle(
                                      color: Colors.yellow, fontSize: 20),
                                )
                              ],
                            ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "${S.of(context).per_year}",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 25),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ListView.builder(
                        padding: EdgeInsetsDirectional.symmetric(
                            horizontal: 30, vertical: 5),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.listcontent!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsetsDirectional.only(bottom: 10),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check,
                                  color: Color(
                                    int.parse(
                                      "0XFF" +
                                          widget.subscriptionPackage!.color!
                                              .replaceAll("#", ""),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child:
                                        Text("${widget.listcontent![index]}"))
                              ],
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    widget.subscriptionPackage!.id ==
                                globals.CurrentSubscribePackage ||
                            widget.subscriptionPackage!.id == 1
                        ? Container(
                            padding: const EdgeInsetsDirectional.all(8),
                            child: const Column(
                              children: [],
                            ),
                          )
                        : Container(
                            child: Column(
                              children: [
                                // Row(
                                //   mainAxisSize: MainAxisSize.min,
                                //   children: [
                                //     Text(
                                //       S.of(context).beforprice + ": ",
                                //       style: CustomTheme.text15theme.copyWith(
                                //         fontWeight: FontWeight.bold,
                                //         color: Colors.black,
                                //       ),
                                //     ),
                                //     Text(
                                //       "${widget.subscriptionPackage!.price}" +
                                //           "S.R",
                                //       style: TextStyle(
                                //           decoration:
                                //               TextDecoration.lineThrough,
                                //           color: Colors.red),
                                //     )
                                //   ],
                                // ),
                                // const SizedBox(
                                //   height: 20,
                                // ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     Text(
                                //       "${widget.subscriptionPackage!.price}" +
                                //           " " +
                                //           "S.R",
                                //       style: CustomTheme.text16theme.copyWith(
                                //           color: Color(
                                //             int.parse(
                                //               "0XFF" +
                                //                   widget.subscriptionPackage!
                                //                       .color!
                                //                       .replaceAll("#", ""),
                                //             ),
                                //           ),
                                //           fontWeight: FontWeight.bold),
                                //     )
                                //   ],
                                // ),
                                // const SizedBox(
                                //   height: 10,
                                // ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     Expanded(
                                //         child: Container(
                                //       color: Colors.grey.shade200,
                                //       width: 50,
                                //       height: 0.5,
                                //     )),
                                //     Text(
                                //       S.of(context).or,
                                //     ),
                                //     Expanded(
                                //         child: Container(
                                //       color: Colors.grey.shade200,
                                //       width: 50,
                                //       height: 0.5,
                                //     ))
                                //   ],
                                // ),
                                // const SizedBox(
                                //   height: 10,
                                // ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     Text(
                                //       "${widget.subscriptionPackage!.pointPrice}" +
                                //           " " +
                                //           S.of(context).points,
                                //       style: CustomTheme.text16theme.copyWith(
                                //           color: Color(
                                //             int.parse(
                                //               "0XFF" +
                                //                   widget.subscriptionPackage!
                                //                       .color!
                                //                       .replaceAll("#", ""),
                                //             ),
                                //           ),
                                //           fontWeight: FontWeight.bold),
                                //     )
                                //   ],
                                // ),
                                // const SizedBox(
                                //   height: 10,
                                // ),

                                SizedBox(
                                  width: 150,
                                  height: 45,
                                  child: CustomButton(
                                    radius: 50,
                                    text: S.of(context).Select_Package,
                                    primary: CustomColors.primarycolor,
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return CartScreen(
                                          id: widget.subscriptionPackage!.id,
                                          ItemType: "SubscriptionPackage",
                                          quickCheckout: "1",
                                        );
                                      }));
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                // SizedBox(
                                //   child: ElevatedButton(
                                //     style: ElevatedButton.styleFrom(
                                //         elevation: 0,
                                //         shape: RoundedRectangleBorder(
                                //             borderRadius:
                                //                 BorderRadius.circular(20)),
                                //         primary: CustomColors.primarycolor),
                                //     onPressed: () {},
                                //     child: Text(S.of(context).Select_Package),
                                //   ),
                                // ),
                                // OutlinedButton(
                                //   style: OutlinedButton.styleFrom(
                                //     side: BorderSide(
                                //       color: Color(
                                //         int.parse(
                                //           "0XFF" +
                                //               widget.subscriptionPackage!.color!
                                //                   .replaceAll("#", ""),
                                //         ),
                                //       ),
                                //     ),
                                //     primary: Color(
                                //       int.parse(
                                //         "0XFF" +
                                //             widget.subscriptionPackage!.color!
                                //                 .replaceAll("#", ""),
                                //       ),
                                //     ),
                                //   ),
                                //   onPressed: () {
                                //     Navigator.of(context).push(
                                //         MaterialPageRoute(builder: (context) {
                                //       return CartScreen(
                                //         id: widget.subscriptionPackage!.id,
                                //         ItemType: "SubscriptionPackage",
                                //         quickCheckout: "1",
                                //       );
                                //     }));
                                //   },
                                //   child: Text("Upgrade"),
                                // )
                              ],
                            ),
                          )
                  ],
                ),
              ),
            ),
          );
  }
}
