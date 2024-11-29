import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:redeem/custom_widget/CustomAppBar.dart';
import 'package:redeem/custom_widget/CustomOfferPointBox.dart';
import 'package:redeem/custom_widget/Custom_offers.dart';
import 'package:redeem/custom_widget/custm_points_box.dart';
import 'package:redeem/custom_widget/custme_button.dart';
import 'package:redeem/custom_widget/custom_back_button.dart';
import 'package:redeem/custom_widget/custom_coupon.dart';
import 'package:redeem/custom_widget/custom_info_box.dart';
import 'package:redeem/custom_widget/custom_preloader.dart';
import 'package:redeem/custom_widget/custom_price_box.dart';
import 'package:redeem/generated/l10n.dart';
import 'package:redeem/json_db/enum.dart';
import 'package:redeem/json_db/infinite_grid.dart';
import 'package:redeem/json_db/json_db.dart';
import 'package:redeem/json_db/utils.dart';
import 'package:redeem/screens/SearchPage/search_page.dart';
import 'package:redeem/screens/details_screen_of_providers/details_screen_of_providers.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:redeem/globals.dart' as globals;
import 'package:url_launcher/url_launcher_string.dart';

// ignore: must_be_immutable
class OfferDetails extends StatefulWidget {
  dynamic offerid;
  OfferDetails({super.key, this.offerid});

  @override
  State<OfferDetails> createState() => _OfferDetails();
}

class _OfferDetails extends State<OfferDetails> {
  List<OfferReview>? offerReview = [];
  OfferData? offerData;
  TextEditingController controller = TextEditingController();
  bool? Reviewisexpansion = false;
  double myRating = 0;
  ScrollController? scrollController = ScrollController();
  bool? locationisexpansion = false;
  bool? termisexpansion = false;
  void change_location_expansion(bool expansion) {
    locationisexpansion = expansion;
    setState(() {});
  }

  void change_term_expansion(bool expansion) {
    termisexpansion = expansion;
    setState(() {});
  }

  void change_Review_expansion(bool expansion) {
    Reviewisexpansion = expansion;
    setState(() {});
  }

  void getData() async {
    // try {
    await JsonDb().getdetailsOfferCollections(widget.offerid).then((res) {
      if (res.success) {
        offerData = res.data;
        print("details_done ${offerData}");

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

  void getReview() async {
    // try {
    await JsonDb().getOfferReviewCollections(widget.offerid).then((res) {
      if (res.success) {
        print("offer review succres ${res.data}");
        offerReview = res.data;

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

  void AddOfferToWish() async {
    // try {
    // print("paymentLength ${cartData!.cart!.listPaymentMethod!.length}");
    await JsonDb().AddOfferToWhishCollections(widget.offerid).then((res) {
      if (res.success) {
        !globals.whichListOffers.contains(widget.offerid)
            ? globals.whichListOffers.add(widget.offerid)
            : globals.whichListOffers.remove(widget.offerid);
        setState(() {});
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          CustomTheme.CustomSnackBar(res.message, "success"),
        );

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

  void submitReview() async {
    // try {
    // print("paymentLength ${cartData!.cart!.listPaymentMethod!.length}");
    await JsonDb()
        .submitReviewCollections(
            rating: myRating,
            review: controller.value.text,
            special_offer_id: widget.offerid)
        .then((res) {
      if (res.success) {
        print("submitOrder ${res.success}");
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          CustomTheme.CustomSnackBar(res.message, "success"),
        );

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

  bool loading = true;
  @override
  void initState() {
    super.initState();
    getData();
    getReview();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.secondarygroundcolor,
      bottomNavigationBar: loading
          ? null
          : Container(
              margin: const EdgeInsetsDirectional.all(8),
              decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: CustomColors.secondarygroundcolor))),
              padding: const EdgeInsetsDirectional.all(5),

              // margin: const EdgeInsetsDirectional.symmetric(
              //     horizontal: 10, vertical: 10),
              width: double.infinity,
              height: 60,
              child: CustomButton(
                  primary: CustomColors.primarycolor,
                  onPressed: () {
                    bool valid_balance = ((offerData!.offerDetail!.balance ??
                                0) >=
                            (int.tryParse(
                                    offerData!.offerDetail!.points ?? "0") ??
                                0))
                        ? true
                        : false;
                    if (globals.isLogin == false) {
                      showNeedLoginDialog(context);
                    } else {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        useRootNavigator: true,
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25),
                          ),
                        ),
                        builder: (context) {
                          return FractionallySizedBox(
                              heightFactor: 0.75,
                              child: Container(
                                color: CustomColors.backgroundcolor_for_Ticket,
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                IconButton(
                                                    iconSize: 30,
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    icon: const Icon(
                                                      Icons.close,
                                                      color: CustomColors
                                                          .primarycolor,
                                                    )),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .only(start: 0),
                                              child: Text(
                                                  "${offerData?.offerDetail!.simpleProvider!.getPropertyEffectedByLang("name_${globals.SelectedLang}")}",
                                                  style: CustomTheme.text20theme
                                                      .copyWith(
                                                          color: CustomColors
                                                              .secondarytitlecolor)),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                          .symmetric(
                                                      horizontal: 16),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  // CircleAvatar(
                                                  //     backgroundColor: Colors.white,
                                                  //     radius: 24,
                                                  //     backgroundImage: NetworkImage(
                                                  //         "${offerDetails!.simpleProvider!.logo}")),

                                                  Expanded(
                                                    child: Text(
                                                      "${offerData?.offerDetail!.getPropertyEffectedByLang("name_${globals.SelectedLang}")}",
                                                      style: const TextStyle(
                                                          color: CustomColors
                                                              .thirdcolor),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              offerData!.offerDetail!.points
                                                      .toString() +
                                                  " " +
                                                  S
                                                      .of(context)
                                                      .points_will_consumed_from_your_points,
                                              style: CustomTheme.text16theme
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.normal),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            if (!valid_balance)
                                              Text(
                                                S
                                                        .of(context)
                                                        .your_balance_of_points_is +
                                                    " ${offerData!.offerDetail!.balance} " +
                                                    S.of(context).points,
                                                style: CustomTheme.text16theme
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.red),
                                              ),
                                            if (!valid_balance)
                                              Text(
                                                S
                                                    .of(context)
                                                    .and_you_can_not_use_this_offer,
                                                style: CustomTheme.text16theme
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.red),
                                              ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                          color: CustomColors.ticket_clip_color,
                                          child: TicketWidget(
                                            width: 350,
                                            height: 50,
                                            child: Container(
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                                width: double.infinity,
                                                clipBehavior: Clip.hardEdge,
                                                alignment: Alignment.center,
                                                height: 50,
                                                child: Center(
                                                  child: CustomPaint(
                                                      painter:
                                                          DrawDottedhorizontalline()),
                                                  //drawing horizontal dotted/dash line
                                                )),
                                          )),
                                      Container(
                                        child: Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                showModalBottomSheet(
                                                    backgroundColor:
                                                        Colors.black,
                                                    isScrollControlled: true,
                                                    useRootNavigator: true,
                                                    context: context,
                                                    builder: (context) {
                                                      return FractionallySizedBox(
                                                        heightFactor: 0.9,
                                                        child: Container(
                                                          color: Colors.white,
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  IconButton(
                                                                      iconSize:
                                                                          30,
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              0),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      icon:
                                                                          const Icon(
                                                                        Icons
                                                                            .close,
                                                                        color: CustomColors
                                                                            .primarycolor,
                                                                      )),
                                                                ],
                                                              ),
                                                              Expanded(
                                                                  child: PhotoView(
                                                                      backgroundDecoration: const BoxDecoration(color: Colors.white),
                                                                      imageProvider: MemoryImage(
                                                                        Uri.parse("${offerData!.offerDetail!.qrcode}")
                                                                            .data!
                                                                            .contentAsBytes(),
                                                                      )
                                                                      //imageProvider: NetworkImage("${listSoldCoupon[index].qrcode!}"),
                                                                      )),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              },
                                              child: Container(
                                                width: 110,
                                                height: 110,
                                                decoration: const BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                          "assets/images/Qr.png",
                                                        ),
                                                        fit: BoxFit.fill),
                                                    color: Colors.white),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              S
                                                  .of(context)
                                                  .please_show_this_page_to_the_cachier,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ));
                        },
                      );
                    }
                  },
                  text: (S.of(context).useoffer))),
      appBar: CustomAppBar(
        actions: [
          SizedBox(
            width: 38,
            child: IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return SearchPage(
                      SearchType: "offer",
                    );
                  }));
                },
                icon: Icon(Icons.search, color: CustomColors.primarycolor)),
          ),
          if (globals.whichListOffers != null)
            SizedBox(
              width: 38,
              child: IconButton(
                  onPressed: () {
                    globals.isLogin == false
                        ? showNeedLoginDialog(context)
                        : AddOfferToWish();
                  },
                  icon: globals.whichListOffers.contains(widget.offerid)
                      ? Icon(Icons.favorite, color: CustomColors.primarycolor)
                      : Icon(
                          Icons.favorite_border,
                          color: CustomColors.primarycolor,
                        )),
            ),
          SizedBox(
            width: 38,
            child: IconButton(
                onPressed: () {
                  Share.share('${offerData?.offerDetail?.shareLink}',
                      subject:
                          "${offerData?.offerDetail!.getPropertyEffectedByLang("name_${globals.SelectedLang}")}");
                },
                icon: const Icon(Icons.ios_share_outlined,
                    color: CustomColors.primarycolor)),
          ),
        ],
        leading: CustomBackButton(),
        backgroundColor: CustomColors.appbarbackgroundcolor,
        elevation: 0,
      ),
      body: loading == true
          ? const CustomPreloader()
          : SafeArea(
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 18.0,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              backgroundColor: Colors.black,
                              isScrollControlled: true,
                              useRootNavigator: true,
                              context: context,
                              builder: (builder) {
                                return Container(
                                  color: Colors.black,
                                  height: double.infinity,
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                              iconSize: 30,
                                              padding: const EdgeInsets.all(0),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              icon: const Icon(
                                                Icons.close,
                                                color: Colors.white,
                                              )),
                                        ],
                                      ),
                                      Expanded(
                                          child: PhotoViewGallery.builder(
                                              itemCount: 4,
                                              builder: (context, index) {
                                                return PhotoViewGalleryPageOptions(
                                                    imageProvider: NetworkImage(
                                                        "${offerData?.offerDetail!.image}"));
                                              })),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "${offerData?.offerDetail!.image}"),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 18.0),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Padding(
                          padding: const EdgeInsetsDirectional.only(end: 5),
                          child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 28,
                              backgroundImage: NetworkImage(
                                  "${offerData?.offerDetail!.simpleProvider!.logo}")),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Wrap(
                                children: [
                                  Text(
                                    "${offerData?.offerDetail!.simpleProvider!.getPropertyEffectedByLang("name_${globals.SelectedLang}")}",
                                    style: const TextStyle(
                                        color: CustomColors.thirdcolor,
                                        fontSize: 13.5),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: CustomColors.secondarycolor,
                                  size: 15,
                                ),
                                Text(
                                  "${offerData?.offerDetail!.avgRating!}",
                                  style: TextStyle(
                                      color: CustomColors.secondarycolor),
                                )
                              ],
                            )
                          ],
                        ),
                        trailing: TextButton(
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(0)),
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return DetailsScreenOfProviders(
                                id: offerData?.offerDetail!.providerId,
                              );
                            }));
                          },
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                S.of(context).More,
                                style: const TextStyle(
                                    color: CustomColors.primarycolor,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Icon(
                                Icons.arrow_right,
                                size: 30,
                                color: CustomColors.primarycolor,
                              ),
                            ],
                          ),
                        ),
                        // ElevatedButton(
                        //     style: ElevatedButton.styleFrom(
                        //         elevation: 0,
                        //         padding: const EdgeInsetsDirectional.all(10),
                        //         primary: CustomColors.secondarycolor,
                        //         shape: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(50))),
                        //     onPressed: () {
                        //       Navigator.of(context)
                        //           .push(MaterialPageRoute(builder: (context) {
                        //         return DetailsScreenOfProviders(
                        //           id: offerData?.offerDetail!.providerId,
                        //         );
                        //       }));
                        //     },
                        //     child: Text(
                        //       S.of(context).More,
                        //       style: const TextStyle(
                        //           color: CustomColors.titlecolor),
                        //     )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 18.0, vertical: 10),
                      child: Text(
                        "${offerData?.offerDetail!.getPropertyEffectedByLang("name_${globals.SelectedLang}")}",
                        style: CustomTheme.text20theme
                            .copyWith(color: CustomColors.primarycolor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                          bottom: 10, end: 18, start: 18),
                      child: HtmlWidget(
                        "${offerData?.offerDetail!.getPropertyEffectedByLang("brief_${globals.SelectedLang}")}",
                      ),
                    ),
                    SingleChildScrollView(
                      // width: double.infinity,
                      // height: 90,
                      child: Padding(
                        padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 8),
                        child: Column(
                          children: [
                            if (offerData != null)
                              ...offerData!.offerDetail!.listOfferPrice!
                                  .map((e) {
                                return CustomOfferPointBox(
                                  pointcolor: Color(
                                    int.parse(
                                      "0XFF" +
                                          e.subscriptionPackage!.color!
                                              .replaceAll("#", ""),
                                    ),
                                  ),
                                  bordercolor: Color(
                                    int.parse(
                                      "0XFF" +
                                          e.subscriptionPackage!.color!
                                              .replaceAll("#", ""),
                                    ),
                                  ),
                                  fontSize: 20,
                                  color: Color(
                                    int.parse(
                                      "0XFF" +
                                          e.subscriptionPackage!.color!
                                              .replaceAll("#", ""),
                                    ),
                                  ),
                                  packageName:
                                      "${e.subscriptionPackage?.getPropertyEffectedByLang("package_name_${globals.SelectedLang}")}",
                                  points: "${e.points}",
                                  packageid: e.subscriptionPackageId,
                                );
                              })
                          ],
                        ),
                      ),
                    ),
                    // Padding(
                    //     padding: const EdgeInsetsDirectional.all(4.0),
                    //     child: Container(
                    //       width: double.infinity,
                    //       height: 90,
                    //       child: ListView.builder(
                    //           shrinkWrap: true,
                    //           physics: const NeverScrollableScrollPhysics(),
                    //           scrollDirection: Axis.horizontal,
                    //           itemCount: 3,
                    //           itemBuilder: ((context, index) {
                    //             return CustomPointBox(
                    //               pointcolor: Color(
                    //                 int.parse(
                    //                   "0XFF" +
                    //                       offerData!
                    //                           .offerDetail!
                    //                           .listOfferPrice![index]
                    //                           .subscriptionPackage!
                    //                           .color!
                    //                           .replaceAll("#", ""),
                    //                 ),
                    //               ),
                    //               bordercolor: Color(
                    //                 int.parse(
                    //                   "0XFF" +
                    //                       offerData!
                    //                           .offerDetail!
                    //                           .listOfferPrice![index]
                    //                           .subscriptionPackage!
                    //                           .color!
                    //                           .replaceAll("#", ""),
                    //                 ),
                    //               ),
                    //               fontSize: 21,
                    //               color: Color(
                    //                 int.parse(
                    //                   "0XFF" +
                    //                       offerData!
                    //                           .offerDetail!
                    //                           .listOfferPrice![index]
                    //                           .subscriptionPackage!
                    //                           .color!
                    //                           .replaceAll("#", ""),
                    //                 ),
                    //               ),
                    //               points:
                    //                   "${offerData?.offerDetail!.listOfferPrice![index].points}",
                    //             );
                    //           })),
                    //     )),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.symmetric(horizontal: 18),
                      child: Container(
                        child: Column(
                          children: [
                            offerData?.offerDetail?.getPropertyEffectedByLang(
                                        "terms_${globals.SelectedLang}") !=
                                    null
                                ? Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20)),
                                        // border: Border.all(
                                        //     color: Colors.black.withAlpha(15)),
                                        color: Colors.white),
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                          dividerColor: Colors.transparent),
                                      child: ExpansionTile(
                                        initiallyExpanded: true,
                                        onExpansionChanged: (value) {
                                          change_term_expansion(value);
                                        },
                                        iconColor: CustomColors.primarycolor,
                                        title: Text(
                                          S.of(context).terms,
                                          style: TextStyle(
                                              color: termisexpansion == false
                                                  ? CustomColors.secondarycolor
                                                  : CustomColors.primarycolor,
                                              fontWeight:
                                                  termisexpansion == true
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                              fontSize: termisexpansion == true
                                                  ? 18
                                                  : 16),
                                        ),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                    .only(
                                                bottom: 8, start: 10, end: 10),
                                            child: HtmlWidget(
                                              "${offerData?.offerDetail!.getPropertyEffectedByLang("terms_${globals.SelectedLang}")}",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: 0,
                                  ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: offerData?.offerDetail
                                              ?.getPropertyEffectedByLang(
                                                  "terms_${globals.SelectedLang}") ==
                                          null
                                      ? BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20))
                                      : null,
                                  // border: Border(
                                  //     bottom: BorderSide(
                                  //         color: Colors.grey.shade200),
                                  //     top: BorderSide(
                                  //         color: Colors.grey.shade200)),
                                  color: Colors.white),
                              child: Theme(
                                data: Theme.of(context)
                                    .copyWith(dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                      initiallyExpanded: offerData?.offerDetail!
                                        .getPropertyEffectedByLang(
                                            "terms_${globals.SelectedLang}") ==
                                    null?true:false,
                                  onExpansionChanged: (value) {
                                    change_location_expansion(value);
                                  },
                                  iconColor: CustomColors.primarycolor,
                                  title: Text(
                                    S.of(context).location +
                                        " (${offerData?.offerDetail?.simpleProvider?.listProviderBranch?.length})",
                                    style: TextStyle(
                                        color: locationisexpansion == false
                                            ? CustomColors.secondarycolor
                                            : CustomColors.primarycolor,
                                        fontWeight: locationisexpansion == true
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        fontSize: locationisexpansion == true
                                            ? 18
                                            : 16),
                                  ),
                                  children: [
                                    if (offerData != null)
                                      Container(
                                        //height: MediaQuery.of(context).size.height * 0.4,
                                        // height: 10 * 200,
                                        child: Padding(
                                          padding:
                                              const EdgeInsetsDirectional.only(
                                                  bottom: 8,
                                                  start: 10,
                                                  end: 10),
                                          child: ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: offerData!
                                                  .offerDetail!
                                                  .simpleProvider!
                                                  .listProviderBranch!
                                                  .length,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  margin:
                                                      const EdgeInsetsDirectional
                                                          .all(5),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black
                                                            .withAlpha(30)),
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .all(8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "${offerData?.offerDetail!.simpleProvider!.listProviderBranch![index].getPropertyEffectedByLang("name_${globals.SelectedLang}")}",
                                                          style: CustomTheme
                                                              .text16theme,
                                                        ),
                                                        const Divider(
                                                          endIndent: 5,
                                                        ),
                                                        Row(
                                                          children: [
                                                            const Icon(
                                                              Icons
                                                                  .location_on_outlined,
                                                              color: CustomColors
                                                                  .primarycolor,
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                  "${offerData?.offerDetail!.simpleProvider!.listProviderBranch![index].getPropertyEffectedByLang("location_${globals.SelectedLang}")}"),
                                                            )
                                                          ],
                                                        ),
                                                        offerData
                                                                    ?.offerDetail!
                                                                    .simpleProvider!
                                                                    .listProviderBranch![
                                                                        index]
                                                                    .phone !=
                                                                null
                                                            ? Row(
                                                                children: [
                                                                  const Icon(
                                                                    Icons.phone,
                                                                    color: CustomColors
                                                                        .primarycolor,
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        launchUrlString(
                                                                            "tel://${offerData?.offerDetail!.simpleProvider!.listProviderBranch![index].phone}");
                                                                      },
                                                                      child: Text(
                                                                          "${offerData?.offerDetail!.simpleProvider!.listProviderBranch![index].phone}")),
                                                                ],
                                                              )
                                                            : Container(),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                      )
                                  ],
                                ),
                              ),
                            ),
                          offerData!=null&& offerData!.offerDetail!.simpleProvider!
                                    .listProviderBranch!.isNotEmpty
                                ? Divider(
                                    height: 0,
                                  )
                                : Container(
                                    width: 0,
                                  ),
                            // Here review
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(25),
                                    bottomRight: Radius.circular(25)),
                                color: Reviewisexpansion == false
                                    ? Colors.white
                                    : Colors.white,
                              ),
                              child: Theme(
                                data: Theme.of(context)
                                    .copyWith(dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                  // initiallyExpanded:
                                  //     providerDetail!.listSimpleCoupons!.isEmpty
                                  //         ? true
                                  //         : false,
                                  iconColor: CustomColors.primarycolor,
                                  title: Text(
                                    S.of(context).Reviews +
                                        " (${offerReview!.length})",
                                    style: TextStyle(
                                        color: Reviewisexpansion == false
                                            ? CustomColors.secondarycolor
                                            : CustomColors.primarycolor,
                                        fontWeight: Reviewisexpansion == true
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        fontSize: Reviewisexpansion == true
                                            ? 18
                                            : 16),
                                  ),
                                  onExpansionChanged: (value) {
                                    change_Review_expansion(value);
                                  },
                                  children: [
                                    Container(
                                        margin: EdgeInsetsDirectional.only(
                                            bottom: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                          .symmetric(
                                                      horizontal: 13),
                                              child: SizedBox(
                                                child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        elevation: 0,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25)),
                                                        primary: CustomColors
                                                            .secondarycolor),
                                                    onPressed: () {
                                                      globals.isLogin == true
                                                          ? showModalBottomSheet(
                                                              backgroundColor:
                                                                  Colors.white,
                                                              isScrollControlled:
                                                                  true,
                                                              useRootNavigator:
                                                                  true,
                                                              context: context,
                                                              builder:
                                                                  (builder) {
                                                                return Container(
                                                                  color: Colors
                                                                      .white,
                                                                  height: double
                                                                      .infinity,
                                                                  child: Column(
                                                                    children: [
                                                                      const SizedBox(
                                                                        height:
                                                                            30,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
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
                                                                      Text(
                                                                        S
                                                                            .of(context)
                                                                            .Add_Your_Review,
                                                                        style: CustomTheme
                                                                            .text20theme
                                                                            .copyWith(color: CustomColors.primarycolor),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            30,
                                                                      ),
                                                                      Container(
                                                                        padding:
                                                                            const EdgeInsetsDirectional.all(5),
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.white.withAlpha(150),
                                                                            borderRadius: BorderRadius.circular(5)),
                                                                        child: RatingBar
                                                                            .builder(
                                                                          itemSize:
                                                                              28,
                                                                          initialRating: double.parse(offerData!
                                                                              .offerDetail!
                                                                              .avgRating!),
                                                                          minRating:
                                                                              1,
                                                                          direction:
                                                                              Axis.horizontal,
                                                                          allowHalfRating:
                                                                              false,
                                                                          itemCount:
                                                                              5,
                                                                          itemPadding:
                                                                              const EdgeInsets.symmetric(horizontal: 0.5),
                                                                          itemBuilder: (context, _) =>
                                                                              const Icon(
                                                                            Icons.star,
                                                                            color:
                                                                                Colors.amber,
                                                                          ),
                                                                          onRatingUpdate:
                                                                              (rating) {
                                                                            print("the rating is" +
                                                                                "${rating}");
                                                                            myRating =
                                                                                rating;
                                                                            setState(() {});
                                                                          },
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            30,
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsetsDirectional.all(8.0),
                                                                        child:
                                                                            TextFormField(
                                                                          maxLines:
                                                                              7,
                                                                          controller:
                                                                              controller,
                                                                          keyboardType:
                                                                              TextInputType.multiline,
                                                                          decoration: InputDecoration(
                                                                              contentPadding: const EdgeInsetsDirectional.symmetric(vertical: 10, horizontal: 10),
                                                                              hintText: S.of(context).Review,
                                                                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.grey.shade300)),
                                                                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.grey.shade300))),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            30,
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsetsDirectional.all(5),
                                                                        child: CustomButton(
                                                                            primary: CustomColors.primarycolor,
                                                                            onPressed: () {
                                                                              submitReview();
                                                                            },
                                                                            text: S.of(context).save),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              })
                                                          : showNeedLoginDialog(
                                                              context);
                                                    },
                                                    child: Text(
                                                      S
                                                          .of(context)
                                                          .Add_Your_Review,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )),
                                              ),
                                            ),
                                            ...offerReview!.map((e) {
                                              return Column(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25)
                                                        // border: Border(
                                                        //     bottom: BorderSide(
                                                        //         color: Colors
                                                        //             .grey.shade200)),
                                                        ),
                                                    child: ListTile(
                                                      title: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 5,
                                                                      bottom: 5,
                                                                      right: 8),
                                                                  child: Text(
                                                                    e.customer!
                                                                        .fullName!,
                                                                    style: CustomTheme
                                                                        .text16theme,
                                                                  ),
                                                                ),
                                                                RatingBar
                                                                    .builder(
                                                                  ignoreGestures:
                                                                      true,
                                                                  allowHalfRating:
                                                                      true,
                                                                  itemSize: 15,
                                                                  initialRating: e
                                                                      .rating!
                                                                      .toDouble(),
                                                                  minRating: 1,
                                                                  direction: Axis
                                                                      .horizontal,
                                                                  itemCount: 5,
                                                                  itemPadding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              1.0),
                                                                  itemBuilder:
                                                                      (context,
                                                                              _) =>
                                                                          const Icon(
                                                                    Icons.star,
                                                                    color: Colors
                                                                        .amber,
                                                                  ),
                                                                  onRatingUpdate:
                                                                      (rating) {},
                                                                ),
                                                              ],
                                                            ),
                                                            Row(children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .only(
                                                                            end:
                                                                                5),
                                                                child:
                                                                    const Icon(
                                                                  Icons
                                                                      .access_time_rounded,
                                                                  size: 15,
                                                                ),
                                                              ),
                                                              Text(
                                                                e.createdAtFormatted!,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        12),
                                                              )
                                                            ]),
                                                          ]),
                                                      subtitle: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom: 5,
                                                                    top: 4),
                                                            child: Text(
                                                              e.review!,
                                                              style: CustomTheme
                                                                  .text15theme
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .black),
                                                            ),
                                                          ),

                                                          // (data[index].isReply == 0)
                                                          //     ? Padding(
                                                          //         padding: EdgeInsetsDirectional.only(
                                                          //             start: MediaQuery.of(
                                                          //                         context)
                                                          //                     .size
                                                          //                     .width -
                                                          //                 150),
                                                          //         child: SizedBox(
                                                          //             width: 70,
                                                          //             child:
                                                          //                 CustomButton(
                                                          //               height: 25,
                                                          //               onPressed:
                                                          //                   () {
                                                          //                 sizeText =
                                                          //                     false;

                                                          //                 _showModelSheet(
                                                          //                     index);
                                                          //               },
                                                          //               title: AppLocalizations.of(
                                                          //                       context)!
                                                          //                   .reply,
                                                          //               textStyle:
                                                          //                   CustomTheme
                                                          //                       .whiteTekZoneRugular,
                                                          //               color: CustomColors
                                                          //                   .secondarycolor,
                                                          //             )),
                                                          //       )
                                                          //     : Padding(
                                                          //         padding:
                                                          //             const EdgeInsets
                                                          //                     .symmetric(
                                                          //                 vertical:
                                                          //                     5),
                                                          //         child: Row(
                                                          //           children: [
                                                          //             const Icon(Icons
                                                          //                 .subdirectory_arrow_right),
                                                          //             Text(
                                                          //               data[index]
                                                          //                   .reply!,
                                                          //               style: CustomTheme
                                                          //                   .Black15,
                                                          //             ),
                                                          //           ],
                                                          //         ),
                                                          //       )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Divider(
                                                    height: 0,
                                                    color: CustomColors
                                                        .backgroundcolor_for_Ticket,
                                                  )
                                                ],
                                              );
                                            })
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    offerData != null && offerData!.listMoredealsOffer!.isEmpty
                        ? Container()
                        : Padding(
                            padding:
                                const EdgeInsetsDirectional.only(start: 18),
                            child: Container(
                              margin: EdgeInsetsDirectional.only(bottom: 10),
                              child: Row(
                                children: [
                                  Text(
                                    S.of(context).moredeals,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: CustomColors.primarycolor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    loading == true
                        ? const CustomPreloader()
                        : offerData != null &&
                                offerData!.listMoredealsOffer!.isEmpty
                            ? Container()
                            : Padding(
                                padding: const EdgeInsetsDirectional.symmetric(
                                    horizontal: 10),
                                child: Container(
                                  margin: const EdgeInsetsDirectional.only(
                                      bottom: 8),
                                  child: offerData != null
                                      ? GridView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 600,
                                            mainAxisExtent: 127,
                                            mainAxisSpacing: 5,
                                          ),
                                          itemCount: offerData
                                              ?.listMoredealsOffer!.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .symmetric(horizontal: 8),
                                              child: CustomOffers(
                                                simpleOffer: offerData!
                                                    .listMoredealsOffer![index],
                                              ),
                                            );
                                          })
                                      : Container(
                                          width: 0,
                                          height: 0,
                                        ),
                                ),
                              ),
                    const SizedBox(
                      height: 20,
                    ),
                    offerData != null &&
                            offerData!.listsimilarDealsOffer!.isEmpty
                        ? Container()
                        : Padding(
                            padding:
                                const EdgeInsetsDirectional.only(start: 18),
                            child: Container(
                              margin: EdgeInsetsDirectional.only(bottom: 10),
                              child: Row(
                                children: [
                                  Text(
                                    S.of(context).similardeals,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: CustomColors.primarycolor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    // ignore: unnecessary_null_comparison
                    offerData != null &&
                            offerData!.listsimilarDealsOffer!.isEmpty
                        ? Container()
                        : Padding(
                            padding: const EdgeInsetsDirectional.symmetric(
                                horizontal: 10),
                            child: Container(
                              margin:
                                  const EdgeInsetsDirectional.only(bottom: 8),
                              child: offerData != null
                                  ? GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 600,
                                        mainAxisExtent: 127,
                                        mainAxisSpacing: 5,
                                      ),
                                      itemCount: offerData
                                          ?.listsimilarDealsOffer!.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsetsDirectional
                                              .symmetric(horizontal: 8),
                                          child: CustomOffers(
                                            simpleOffer: offerData!
                                                .listsimilarDealsOffer![index],
                                          ),
                                        );
                                      })
                                  : Container(
                                      width: 0,
                                      height: 0,
                                    ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
    );
  }
}

class DrawDottedhorizontalline extends CustomPainter {
  late Paint _paint;
  DrawDottedhorizontalline() {
    _paint = Paint();
    _paint.color = Colors.grey.shade200; //dots color
    _paint.strokeWidth = 2; //dots thickness
    _paint.strokeCap = StrokeCap.square; //dots corner edges
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (double i = -300; i < 300; i = i + 15) {
      // 15 is space between dots
      if (i % 3 == 0)
        canvas.drawLine(Offset(i, 0.0), Offset(i + 10, 0.0), _paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
