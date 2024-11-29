import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redeem/custom_widget/CustomAppBar.dart';
import 'package:redeem/custom_widget/custom_back_button.dart';
import 'package:redeem/custom_widget/custom_preloader.dart';
import 'package:redeem/generated/l10n.dart';
import 'package:redeem/json_db/enum.dart';
import 'package:redeem/json_db/json_db.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';
import 'package:redeem/globals.dart' as globals;

class OrderDetails extends StatefulWidget {
  dynamic orderid;
  OrderDetails({super.key, required this.orderid});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  bool loading = true;
  OrderDetailData? orderDetailData;
  void getData() async {
    // try {
    await JsonDb().getOrderDetailsCollections(widget.orderid).then((res) {
      if (res.success) {
        print("order_id is ${widget.orderid}");
        orderDetailData = res.data;

        loading = false;

        setState(() {});
      } else {
        if (res.has_errors) {
          ScaffoldMessenger.of(context as BuildContext).showSnackBar(
            CustomTheme.CustomSnackBar(res.errors[0], "error"),
          );
        } else {
          ScaffoldMessenger.of(context as BuildContext).showSnackBar(
            CustomTheme.CustomSnackBar(res.message, "error"),
          );
        }
      }
    });
    // } catch (e) {
    //   ScaffoldMessenger.of(context as BuildContext).showSnackBar(
    //     CustomTheme.CustomSnackBar(
    //         S.of(context).Internet_connection_error, "warning"),
    //   );
    // }
  }

  @override
  void initState() {
    super.initState();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.secondarygroundcolor,
      appBar: CustomAppBar(
        title: Text(
          S.of(context).order_details,
          style: CustomTheme.text16theme
              .copyWith(color: CustomColors.primarycolor),
        ),
        leading: CustomBackButton(),
        backgroundColor: CustomColors.appbarbackgroundcolor,
        elevation: 0,
      ),
      body: loading == true
          ? const CustomPreloader()
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsetsDirectional.symmetric(
                      horizontal: globals.end_padding_17),
                  child: Column(
                    children: [
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsetsDirectional.symmetric(
                              horizontal: globals.end_padding_17, vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).order_information,
                                style: CustomTheme.text16theme
                                    .copyWith(color: CustomColors.primarycolor),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    S.of(context).order_ref + "  ",
                                    style: CustomTheme.text15theme
                                        .copyWith(color: Colors.black),
                                  ),
                                  Text(
                                    "${orderDetailData!.orderRef}",
                                    style: CustomTheme.text15theme
                                        .copyWith(color: Colors.grey.shade500),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    S.of(context).order_date + "  ",
                                    style: CustomTheme.text15theme
                                        .copyWith(color: Colors.black),
                                  ),
                                  Text(
                                    "${orderDetailData!.orderDate}",
                                    style: CustomTheme.text15theme
                                        .copyWith(color: Colors.grey.shade500),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    S.of(context).payment_method + "  ",
                                    style: CustomTheme.text15theme
                                        .copyWith(color: Colors.black),
                                  ),
                                  Text(
                                    "${orderDetailData!.paymentMethodName}",
                                    style: CustomTheme.text15theme
                                        .copyWith(color: Colors.grey.shade500),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      orderDetailData!.listorderitems!.isNotEmpty
                          ? Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.grey.shade200),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.of(context).order_details,
                                      style: CustomTheme.text16theme.copyWith(
                                          color: CustomColors.primarycolor),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Column(
                                      children: [
                                        ...orderDetailData!.listorderitems!
                                            .map((e) {
                                          return orderDetailData!.orderType ==
                                                  "coupons"
                                              ? Container(
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              color: Colors.grey
                                                                  .shade200))),
                                                  margin:
                                                      const EdgeInsetsDirectional
                                                          .only(bottom: 10),
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .all(8),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        width: 100,
                                                        height: 100,
                                                        decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                                    "${e.couponOrder!.image}"),
                                                                fit: BoxFit
                                                                    .cover)),
                                                      ),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        // mainAxisAlignment:
                                                        //     MainAxisAlignment
                                                        //         .spaceBetween,
                                                        children: [
                                                          SizedBox(
                                                            width: 200,
                                                            child: Text(
                                                              "${e.couponOrder!.getPropertyEffectedByLang("provider_name_${globals.SelectedLang}")}",
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                              style: CustomTheme
                                                                  .text16theme
                                                                  .copyWith(
                                                                      color: CustomColors
                                                                          .primarycolor),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          SizedBox(
                                                            width: 180,
                                                            child: Text(
                                                              "${e.couponOrder!.getPropertyEffectedByLang("name_${globals.SelectedLang}")}",
                                                              style: CustomTheme
                                                                  .text15theme
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .black),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 30,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                S
                                                                        .of(context)
                                                                        .total +
                                                                    " ",
                                                                style: CustomTheme
                                                                    .text16theme
                                                                    .copyWith(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.normal),
                                                              ),
                                                              Text(
                                                                "${e.qty}",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade500),
                                                              ),
                                                              Text(
                                                                  " x " +
                                                                      "${e.price}",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade500)),
                                                              Text(
                                                                  " = " +
                                                                      "${e.totalPrice}"
                                                                          " " +
                                                                      S
                                                                          .of(
                                                                              context)
                                                                          .S_R,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade500)),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                S
                                                                        .of(context)
                                                                        .quantity +
                                                                    " ",
                                                                style: CustomTheme
                                                                    .text15theme
                                                                    .copyWith(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.normal),
                                                              ),
                                                              const SizedBox(
                                                                width: 20,
                                                              ),
                                                              Text(
                                                                "${e.qty}",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade500),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : orderDetailData!.orderType ==
                                                      "subsciption_package"
                                                  ? Container(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .all(8),
                                                      width: double.infinity,
                                                      height: 65,
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                            bottom: BorderSide(
                                                                color: Colors
                                                                    .grey
                                                                    .shade200)),
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              "${e.itemTitle}"),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                S
                                                                        .of(context)
                                                                        .total +
                                                                    " ",
                                                                style: CustomTheme
                                                                    .text16theme
                                                                    .copyWith(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.normal),
                                                              ),
                                                              Text(
                                                                "${e.qty}",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade500),
                                                              ),
                                                              Text(
                                                                  " x " +
                                                                      "${e.price}",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade500)),
                                                              Text(
                                                                  " = " +
                                                                      "${e.totalPrice}"
                                                                          " " +
                                                                      S
                                                                          .of(
                                                                              context)
                                                                          .S_R,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade500)),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : orderDetailData!
                                                              .orderType ==
                                                          "points_package"
                                                      ? Container(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .all(8),
                                                          width:
                                                              double.infinity,
                                                          height: 65,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border(
                                                                bottom: BorderSide(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade200)),
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  "${e.itemTitle}"),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    S.of(context).total +
                                                                        " ",
                                                                    style: CustomTheme
                                                                        .text16theme
                                                                        .copyWith(
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight: FontWeight.normal),
                                                                  ),
                                                                  Text(
                                                                    "${e.qty}",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey
                                                                            .shade500),
                                                                  ),
                                                                  Text(
                                                                      " x " +
                                                                          "${e.price}",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .grey
                                                                              .shade500)),
                                                                  Text(
                                                                      " = " +
                                                                          "${e.totalPrice}"
                                                                              " " +
                                                                          S
                                                                              .of(
                                                                                  context)
                                                                              .S_R,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .grey
                                                                              .shade500)),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      : Container();
                                        }).toList()
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).order_summary,
                                style: CustomTheme.text16theme
                                    .copyWith(color: CustomColors.primarycolor),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Divider(
                                endIndent: 10,
                                indent: 10,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    S.of(context).sub_total,
                                  ),
                                  Text(
                                    "${orderDetailData!.subTotalAmountFormatted}" +
                                        " " +
                                        S.of(context).S_R,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Divider(
                                endIndent: 10,
                                indent: 10,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    S.of(context).discount,
                                    style:
                                        TextStyle(color: Colors.red.shade900),
                                  ),
                                  Text(
                                    "${orderDetailData!.discountAmountFormatted}" +
                                        " " +
                                        S.of(context).S_R,
                                    style:
                                        TextStyle(color: Colors.red.shade900),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Divider(
                                endIndent: 10,
                                indent: 10,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    S.of(context).total,
                                    style: CustomTheme.text18theme
                                        .copyWith(color: Colors.black),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${orderDetailData!.totalFormatterd}" +
                                              " ",
                                          style: CustomTheme.text18theme
                                              .copyWith(color: Colors.black),
                                        ),
                                        Text(
                                          S.of(context).S_R,
                                          style: CustomTheme.text16theme
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                S
                                    .of(context)
                                    .all_prices_shown_are_inclusive_of_VAT_where_applicable,
                                textAlign: TextAlign.center,
                                style: CustomTheme.text15theme.copyWith(
                                    color: Colors.black, fontSize: 13),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).payment_info,
                                style: CustomTheme.text16theme
                                    .copyWith(color: CustomColors.primarycolor),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              orderDetailData!.paymentDate != null
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          S.of(context).payment_date,
                                          style: CustomTheme.text15theme
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          "${orderDetailData!.paymentDate}",
                                          style: CustomTheme.text15theme
                                              .copyWith(
                                                  color: Colors.grey.shade500),
                                        ),
                                      ],
                                    )
                                  : Container(),
                              const SizedBox(
                                height: 10,
                              ),
                              orderDetailData!.paymentRef != null
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          S.of(context).payment_referance,
                                          style: CustomTheme.text15theme
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          "${orderDetailData!.paymentRef}",
                                          style: CustomTheme.text15theme
                                              .copyWith(
                                                  color: Colors.grey.shade500),
                                        ),
                                      ],
                                    )
                                  : Container(),
                              const SizedBox(
                                height: 10,
                              ),
                              orderDetailData!.paymentMethodName != null
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          S.of(context).payment_method,
                                          style: CustomTheme.text15theme
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          "${orderDetailData!.paymentMethodName}",
                                          style: CustomTheme.text15theme
                                              .copyWith(
                                                  color: Colors.grey.shade500),
                                        ),
                                      ],
                                    )
                                  : Container(),
                              const SizedBox(
                                height: 10,
                              ),
                              orderDetailData!.paymentAmount != null
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          S.of(context).payment_amount,
                                          style: CustomTheme.text15theme
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          "${orderDetailData!.paymentAmount}",
                                          style: CustomTheme.text15theme
                                              .copyWith(
                                                  color: Colors.grey.shade500),
                                        ),
                                      ],
                                    )
                                  : Container(),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                      ),
                      orderDetailData!.redeemedPointsAmount != null &&
                              orderDetailData!.redeemedPointsDate != null
                          ? Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.grey.shade200),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.of(context).redeem_points,
                                      style: CustomTheme.text16theme.copyWith(
                                          color: CustomColors.primarycolor),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          S.of(context).date,
                                          style: CustomTheme.text15theme
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          "${orderDetailData!.redeemedPointsDate}",
                                          style: CustomTheme.text15theme
                                              .copyWith(
                                                  color: Colors.grey.shade500),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          S.of(context).points,
                                          style: CustomTheme.text15theme
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          "-" +
                                              " ${orderDetailData!.redeemedPointsAmount}" +
                                              "  (points)",
                                          style: CustomTheme.text15theme
                                              .copyWith(
                                                  color:
                                                      CustomColors.DangerColor),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),

                                    // Text(
                                    //   S.of(context).rewarded_points,
                                    //   style: CustomTheme.text16theme
                                    //       .copyWith(color: CustomColors.primarycolor),
                                    // ),
                                    // const SizedBox(
                                    //   height: 20,
                                    // ),
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.start,
                                    //   children: [
                                    //     Text(
                                    //       S.of(context).date,
                                    //       style: CustomTheme.text15theme.copyWith(
                                    //           color: Colors.black,
                                    //           fontWeight: FontWeight.normal),
                                    //     ),
                                    //     const SizedBox(
                                    //       width: 20,
                                    //     ),
                                    //     Text(
                                    //       "mar 2024-2-12",
                                    //       style: CustomTheme.text15theme
                                    //           .copyWith(color: Colors.grey.shade500),
                                    //     ),
                                    //   ],
                                    // ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                      orderDetailData!.rewardedPointsDate != null &&
                              orderDetailData!.rewardedPointsAmount != null
                          ? Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.grey.shade200),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.of(context).rewarded_points,
                                      style: CustomTheme.text16theme.copyWith(
                                          color: CustomColors.primarycolor),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          S.of(context).date,
                                          style: CustomTheme.text15theme
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          "${orderDetailData!.rewardedPointsDate}",
                                          style: CustomTheme.text15theme
                                              .copyWith(
                                                  color: Colors.grey.shade500),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          S.of(context).points,
                                          style: CustomTheme.text15theme
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          "+" +
                                              "${orderDetailData!.rewardedPointsAmount} " +
                                              " (points)",
                                          style: CustomTheme.text15theme
                                              .copyWith(
                                                  color: CustomColors
                                                      .SuccessColor),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
