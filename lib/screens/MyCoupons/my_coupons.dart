import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:redeem/custom_widget/CustomAppBar.dart';
import 'package:redeem/custom_widget/CustomMyCoupons.dart';
import 'package:redeem/custom_widget/CustomSoldCoupon.dart';
import 'package:redeem/custom_widget/custom_back_button.dart';
import 'package:redeem/custom_widget/custom_coupon.dart';
import 'package:redeem/custom_widget/custom_preloader.dart';
import 'package:redeem/generated/l10n.dart';
import 'package:redeem/json_db/enum.dart';
import 'package:redeem/json_db/infinite_grid.dart';
import 'package:redeem/json_db/json_db.dart';
import 'package:redeem/screens/List_coupons_page/List_coupons_page.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';
import 'package:redeem/globals.dart' as globals;
import 'package:svg_flutter/svg_flutter.dart';
import 'package:ticket_widget/ticket_widget.dart';

class MyCoupons extends StatefulWidget {
  const MyCoupons({super.key});

  @override
  State<MyCoupons> createState() => _MyCouponsState();
}

class _MyCouponsState extends State<MyCoupons>
    with SingleTickerProviderStateMixin {
  bool get wantKeepAlive => true;
  ScrollController scrollController = ScrollController();
  int totalResults = 0;
  int? nextPage;
  List<SoldCoupon> listSoldCoupon = [];
  bool loading = true;
  @override
  void initState() {
    super.initState();

    getData();
  }

  Future<void> getData({page = 1}) async {
    // try {

    await JsonDb().getMyCouponsCollections().then((res) {
      if (res.success) {
        nextPage = res.nextPage;

        if (page == 1) {
          totalResults = res.totalResult!;
          listSoldCoupon = res.data;
        } else if (page > 1) {
          var soldCoupon = res.data;
          soldCoupon.forEach((element) {
            listSoldCoupon.add(element);
          });
        }

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
    //   ScaffoldMessenger.of(Get.context as BuildContext).showSnackBar(
    //     CustomTheme.CustomSnackBar(S.of(context).Internet_connection_error, "warning"),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundcolor_for_Ticket,
      appBar: CustomAppBar(
        title: Text(
          S.of(context).my_coupons,
          style: CustomTheme.text20theme.copyWith(
              fontWeight: FontWeight.w400,  color: CustomColors.primarycolor),
        ),
        leading: CustomBackButton(),
        elevation: 0,
        backgroundColor: CustomColors.appbarbackgroundcolor,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await getData();
          },
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                loading == true
                    ? Padding(
                        padding: const EdgeInsetsDirectional.only(top: 260),
                        child: CustomPreloader(),
                      )
                    : listSoldCoupon.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsetsDirectional.symmetric(
                                horizontal: 18),
                            child: InfiniteGridView(
                                withoutDisposeScrool: true,
                                forOffice: true,
                                controller: scrollController,
                                physics: const NeverScrollableScrollPhysics(),
                                hasNext: listSoldCoupon.length < totalResults,
                                loadingWidget: const Center(
                                    child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(
                                    color: CustomColors.primarycolor,
                                  ),
                                )),
                                nextData: () {
                                  if (nextPage != null) {
                                    getData(page: nextPage);
                                  }
                                },
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 300,
                                  mainAxisExtent: 243,
                                  mainAxisSpacing: 15,
                                  crossAxisSpacing: 5,
                                ),
                                itemCount: listSoldCoupon.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onTap: () {
                                        listSoldCoupon[index].outOfDate ==
                                                    false &&
                                                listSoldCoupon[index].used == 0
                                            ? showModalBottomSheet(
                                                isScrollControlled: true,
                                                useRootNavigator: true,
                                                context: context,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                    top: Radius.circular(25),
                                                  ),
                                                ),
                                                builder: (context) {
                                                  return FractionallySizedBox(
                                                      heightFactor: 0.75,
                                                      child: Container(
                                                        color: CustomColors
                                                            .backgroundcolor_for_Ticket,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(16.0),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      IconButton(
                                                                          iconSize:
                                                                              30,
                                                                          padding: const EdgeInsets.all(
                                                                              0),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          icon:
                                                                              const Icon(
                                                                            Icons.close,
                                                                            color:
                                                                                CustomColors.primarycolor,
                                                                          )),
                                                                    ],
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsetsDirectional
                                                                            .only(
                                                                        start:
                                                                            16),
                                                                    child: Text(
                                                                        "${listSoldCoupon[index].simpleCoupon!.simpleProvider!.getPropertyEffectedByLang("name_${globals.SelectedLang}")}",
                                                                        style: CustomTheme
                                                                            .text20theme
                                                                            .copyWith(color: CustomColors.secondarytitlecolor)),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsetsDirectional
                                                                            .symmetric(
                                                                        horizontal:
                                                                            16),
                                                                    child: Text(
                                                                      "${listSoldCoupon[index].simpleCoupon!.getPropertyEffectedByLang("name_${globals.SelectedLang}")}",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: const TextStyle(
                                                                          color:
                                                                              CustomColors.thirdcolor),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                ],
                                                              ),
                                                              Container(
                                                                  color: CustomColors
                                                                      .backgroundcolor_for_Ticket,
                                                                  child:
                                                                      TicketWidget(
                                                                    width: 350,
                                                                    height: 50,
                                                                    child: Container(
                                                                        decoration: BoxDecoration(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                        width: double.infinity,
                                                                        clipBehavior: Clip.hardEdge,
                                                                        alignment: Alignment.center,
                                                                        height: 50,
                                                                        child: Center(
                                                                          child:
                                                                              CustomPaint(painter: DrawDottedhorizontalline()),
                                                                          //drawing horizontal dotted/dash line
                                                                        )),
                                                                  )),
                                                              Container(
                                                                child: Column(
                                                                  children: [
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        showModalBottomSheet(
                                                                            backgroundColor: Colors
                                                                                .black,
                                                                            isScrollControlled:
                                                                                true,
                                                                            useRootNavigator:
                                                                                true,
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (context) {
                                                                              return FractionallySizedBox(
                                                                                heightFactor: 0.9,
                                                                                child: Container(
                                                                                  color: Colors.white,
                                                                                  child: Column(
                                                                                    children: [
                                                                                      Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                                                        children: [
                                                                                          IconButton(
                                                                                              iconSize: 30,
                                                                                              padding: const EdgeInsets.all(0),
                                                                                              onPressed: () {
                                                                                                Navigator.of(context).pop();
                                                                                              },
                                                                                              icon: const Icon(
                                                                                                Icons.close,
                                                                                                color: Colors.black,
                                                                                              )),
                                                                                        ],
                                                                                      ),
                                                                                      Expanded(
                                                                                        child: PhotoView(
                                                                                            backgroundDecoration: const BoxDecoration(color: Colors.white),
                                                                                            imageProvider: MemoryImage(
                                                                                              Uri.parse("${listSoldCoupon[index].qrcode}").data!.contentAsBytes(),
                                                                                            )
                                                                                            //imageProvider: NetworkImage("${listSoldCoupon[index].qrcode!}"),
                                                                                            ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            });
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            110,
                                                                        height:
                                                                            110,
                                                                        decoration:
                                                                            const BoxDecoration(),
                                                                        child: Image.memory(Uri.parse("${listSoldCoupon[index].qrcode}")
                                                                            .data!
                                                                            .contentAsBytes()),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    // Text(
                                                                    //   S
                                                                    //       .of(context)
                                                                    //       .please_show_this_page_to_the_cachier,
                                                                    //   style: TextStyle(
                                                                    //       fontWeight:
                                                                    //           FontWeight
                                                                    //               .bold),
                                                                    // )
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ));
                                                },
                                              )
                                            : print("can open bottomsheet !");
                                      },
                                      child: CustomSoldCoupon(
                                        soldCoupon: listSoldCoupon[index],
                                      ));
                                }),
                          )
                        : Column(
                            children: [
                              Expanded(
                                flex: 2,
                                child: SvgPicture.asset(
                                  "assets/images/no-order.svg",
                                  width: double.infinity,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  S.of(context).no_data,
                                  style: TextStyle(
                                      color: CustomColors.primarycolor,
                                      fontSize: 18),
                                ),
                              )
                            ],
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
