import 'package:flutter/material.dart';
import 'package:redeem/custom_widget/CustomAppBar.dart';
import 'package:redeem/custom_widget/custom_back_button.dart';
import 'package:redeem/custom_widget/custom_preloader.dart';
import 'package:redeem/generated/l10n.dart';
import 'package:redeem/json_db/enum.dart';
import 'package:redeem/json_db/infinite_grid.dart';
import 'package:redeem/json_db/json_db.dart';
import 'package:redeem/screens/Order%20Details/order_details.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';
import 'package:svg_flutter/svg.dart';

class AllPurchases extends StatefulWidget {
  const AllPurchases();

  @override
  State<AllPurchases> createState() => _AllPurchasesState();
}

class _AllPurchasesState extends State<AllPurchases> {
  int? nextpage;
  int? totalResults;
  List<SimpleOrder> listSimpleOrder = [];
  bool loading = true;
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData({page = 1}) async {
    // try {
    await JsonDb().getOrdersCollections().then((res) {
      if (res.success) {
        nextpage = res.nextPage;
        if (page == 1) {
          totalResults = res.totalResult!;
          listSimpleOrder = res.data;
        } else if (page > 1) {
          var offer = res.data;
          offer.forEach((element) {
            listSimpleOrder.add(element);
          });
        }

        // listSimpleOrder = res.data;

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
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.secondarygroundcolor,
        appBar: CustomAppBar(
          leading: CustomBackButton(),
          title: Text(
            S.of(context).my_purchases,
            style: const TextStyle( color: CustomColors.primarycolor),
          ),
          backgroundColor: CustomColors.appbarbackgroundcolor,
          elevation: 0,
        ),
        body: loading == true
            ? CustomPreloader()
            : SafeArea(
                child: RefreshIndicator(
                    onRefresh: () async {
                      await getData();
                    },
                    child: listSimpleOrder.isNotEmpty
                        ? SingleChildScrollView(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),

                                ...listSimpleOrder.map((e) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return OrderDetails(
                                          orderid: e.id,
                                        );
                                      }));
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.symmetric(
                                              horizontal: 18),
                                      child: Container(
                                        width: double.infinity,
                                        child: Column(
                                          children: [
                                            ...listSimpleOrder.map((e) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.shade200,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                margin:
                                                    const EdgeInsetsDirectional
                                                        .only(bottom: 10),
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .all(8),
                                                width: double.infinity,
                                                height: 70,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsetsDirectional
                                                              .only(start: 8),
                                                      width: 5,
                                                      height: 60,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .vertical(
                                                                  top: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottom: Radius
                                                                      .circular(
                                                                          10)),
                                                          color: e.order_status_id ==
                                                                  1
                                                              ? CustomColors
                                                                  .SuccessColor
                                                              : CustomColors
                                                                  .DangerColor),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                                "${e.orderRef}"),
                                                          ),
                                                          const SizedBox(
                                                            width: 20,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                '${e.orderDate}',
                                                                style: CustomTheme
                                                                    .text15theme
                                                                    .copyWith(
                                                                        color: Colors
                                                                            .grey
                                                                            .shade500),
                                                              ),
                                                              const SizedBox(
                                                                width: 100,
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Text(
                                                                    "${e.totalFormatterd}",
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .green),
                                                                  ),
                                                                  Text(
                                                                      (" " +
                                                                          S.of(context).S_R),
                                                                      style: const TextStyle(
                                                                        color: CustomColors
                                                                            .SuccessColor,
                                                                      ))
                                                                ],
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }).toList()
                                          ],
                                        ),

                                        /////
                                        //  Column(
                                        //   children: [
                                        //     Row(
                                        //       mainAxisAlignment:
                                        //           MainAxisAlignment.spaceBetween,
                                        //       children: [
                                        //         Text(
                                        //             "${listSimpleOrder[index].orderRef}"),
                                        //         Text(
                                        //             "${listSimpleOrder[index].orderDate}")
                                        //       ],
                                        //     ),
                                        //     const SizedBox(
                                        //       height: 20,
                                        //     ),
                                        //     Row(
                                        //       mainAxisAlignment:
                                        //           MainAxisAlignment.spaceBetween,
                                        //       children: [
                                        //         Container(
                                        //           height: 30,
                                        //           width: 130,
                                        //           decoration: BoxDecoration(
                                        //               borderRadius:
                                        //                   BorderRadius.circular(
                                        //                       10),
                                        //               border: Border.all(
                                        //                   color: Colors
                                        //                       .grey.shade300)),
                                        //           child: Center(
                                        //               child: Text(
                                        //             "${listSimpleOrder[index].orderTypeString}",
                                        //             style: CustomTheme.text16theme
                                        //                 .copyWith(
                                        //                     color: CustomColors
                                        //                         .primarycolor),
                                        //           )),
                                        //         ),
                                        //         Container(
                                        //           height: 30,
                                        //           width: 100,
                                        //           decoration: BoxDecoration(
                                        //               borderRadius:
                                        //                   BorderRadius.circular(
                                        //                       10),
                                        //               border: Border.all(
                                        //                   color: Colors
                                        //                       .grey.shade300)),
                                        //           child: Center(
                                        //               child: Text(
                                        //             "${listSimpleOrder[index].status}",
                                        //             style: CustomTheme.text16theme
                                        //                 .copyWith(
                                        //                     color: CustomColors
                                        //                         .SuccessColor),
                                        //           )),
                                        //         ),
                                        //         Container(
                                        //           height: 30,
                                        //           width: 100,
                                        //           decoration: BoxDecoration(
                                        //               borderRadius:
                                        //                   BorderRadius.circular(
                                        //                       10),
                                        //               border: Border.all(
                                        //                   color: Colors
                                        //                       .grey.shade300)),
                                        //           child: Center(
                                        //               child: Text(
                                        //             "${listSimpleOrder[index].totalFormatterd}",
                                        //             style: CustomTheme.text16theme
                                        //                 .copyWith(
                                        //                     color: CustomColors
                                        //                         .secondarycolor),
                                        //           )),
                                        //         )
                                        //       ],
                                        //     ),
                                        //     Divider()
                                        //   ],
                                        // ),
                                      ),
                                    ),
                                  );
                                }),
                                // InfiniteListView(
                                //     nextData: () {
                                //       if (nextpage != null) {
                                //         getData(page: nextpage);
                                //       }
                                //     },
                                //     hasNext: listSimpleOrder.length < totalResults!,
                                //     itemCount: listSimpleOrder.length,
                                //     physics: NeverScrollableScrollPhysics(),
                                //     itemBuilder: (context, index) {
                                //       return

                                //     })
                                // : Center(
                                //     child: SvgPicture.asset(
                                //     "assets/images/no-order.svg",
                                //     width: 200,
                                //     height: 200,
                                //   ))
                              ],
                            ),
                          )
                        : Column(
                          
                            children: [
                              Expanded(
                                  child: SvgPicture.asset(
                                      "assets/images/no-order.svg")),
                              Padding(
                                padding: const EdgeInsetsDirectional.only(bottom: 20),
                                child: Expanded(
                                  child: Text(
                                    S.of(context).no_data,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: CustomColors.primarycolor),
                                  ),
                                ),
                              )
                            ],
                          )),
              ));
  }
}
