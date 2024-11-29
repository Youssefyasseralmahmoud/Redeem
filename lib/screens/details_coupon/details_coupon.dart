import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:pinput/pinput.dart';
import 'package:redeem/app_storage.dart';
import 'package:redeem/custom_widget/CustomAppBar.dart';
import 'package:redeem/custom_widget/Custom_offers.dart';
import 'package:redeem/custom_widget/custm_points_box.dart';
import 'package:redeem/custom_widget/custme_button.dart';
import 'package:redeem/custom_widget/custom_back_button.dart';
import 'package:redeem/custom_widget/custom_coupon.dart';
import 'package:redeem/custom_widget/custom_info_box.dart';
import 'package:redeem/custom_widget/custom_preloader.dart';
import 'package:redeem/custom_widget/custom_price_box.dart';
import 'package:redeem/events.dart';
import 'package:redeem/generated/l10n.dart';
import 'package:redeem/json_db/enum.dart';
import 'package:redeem/json_db/json_db.dart';
import 'package:redeem/json_db/utils.dart';
import 'package:redeem/screens/SearchPage/search_page.dart';
import 'package:redeem/screens/cart_screen/cart_screen.dart';
import 'package:redeem/screens/details_coupon/details_coupon_controller.dart';
import 'package:redeem/screens/details_screen_of_providers/details_screen_of_providers.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:redeem/generated/l10n.dart';
import 'package:redeem/globals.dart' as globals;
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

// ignore: must_be_immutable
class DetailsCoupon extends StatefulWidget {
  dynamic couponid;
  DetailsCoupon(this.couponid, {super.key});

  @override
  State<DetailsCoupon> createState() => _DetailsCoupon();
}

class _DetailsCoupon extends State<DetailsCoupon> {
  TextEditingController controller = TextEditingController();
  var endTime;
  DateTime? now;
  bool? locationisexpansion = false;
  double myRating = 0;
  int min = 1;
  int max = 100;
  String quick_checkout = "0";
  String itemType = "Coupon";
  String returnCart = "false";
  String forCheckOut = "false";
  int qty = 1;
  CartData? cartData;
  bool? termsisexpansion = false;
  bool? Reviewisexpansion = false;
  CouponData? couponData;
  bool loading = true;
  List<CouponReview>? couponReview = [];

  void change_term_expansion(bool expansion) {
    termsisexpansion = expansion;

    setState(() {});
  }

  void change_location_expansion(bool expansion) {
    locationisexpansion = expansion;
    setState(() {});
  }

  void change_Review_expansion(bool expansion) {
    Reviewisexpansion = expansion;
    setState(() {});
  }

  void getData() async {
    // try {
    await JsonDb().getdetailsCouponCollections(widget.couponid).then((res) {
      if (res.success) {
        print("coupon_id is ${widget.couponid}");
        couponData = res.data;
        now = DateTime.now();

        DateTime Time =
            DateTime.parse(couponData!.detailCoupon!.flashDealEndDate!);

        endTime = Time.millisecondsSinceEpoch;

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
    await JsonDb().getCouponsReviewCollections(widget.couponid).then((res) {
      if (res.success) {
        print("coupons review succres ${res.data}");
        couponReview = res.data;

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
            coupon_id: widget.couponid)
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

  void addToCart(int itemId, int qty) async {
    // try {
    showPreLoader(context);
    await JsonDb()
        .addTocartCollections(
            quick_checkout, itemId, qty, itemType, returnCart, forCheckOut)
        .then((res) {
      if (res.success) {
        dismissPreLoader(context);
        globals.countcart = res.data.countCart!;
        print("count from details is ${res.data.countCart}");
        eventBus.fire(
          AppEvents(
            key_event: "change_cart_count",
          ),
        );
        cartData = res.data;

        loading = false;

        setState(() {});

        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          CustomTheme.CustomSnackBar(res.message, "success"),
        );
        showConfirmCart();
      } else {
        dismissPreLoader(context);
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
    //dismissPreLoader(context);
    //   ScaffoldMessenger.of(context as BuildContext).showSnackBar(
    //     CustomTheme.CustomSnackBar(
    //         S.of(context).Internet_connection_error, "warning"),
    //   );
    // }
  }

  void AddCouponToWish() async {
    // try {
    // print("paymentLength ${cartData!.cart!.listPaymentMethod!.length}");
    await JsonDb().AddCouponToWhishCollections(widget.couponid).then((res) {
      if (res.success) {
        !globals.whichListCoupon.contains(widget.couponid)
            ? globals.whichListCoupon.add(widget.couponid)
            : globals.whichListCoupon.remove(widget.couponid);
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

  Future<dynamic> showConfirmCart() {
    return showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return CartScreen(
                            //  quick_checkout: "0",
                            );
                      }));
                    },
                    child: Text(
                      S.of(context).go_to_cart,
                      style: CustomTheme.text16theme,
                    )),
                Divider(
                  color: Colors.grey.shade200,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      S.of(context).continue_shopping,
                      style: CustomTheme.text16theme,
                    )),
              ],
            ),
          );
        });
  }

  // TextEditingController textEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
    getReview();
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColors.secondarygroundcolor,
      bottomNavigationBar: loading
          ? null
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsetsDirectional.only(bottom: bottom),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 56,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          top: BorderSide(
                              color:
                                  CustomColors.thirdcolor.withOpacity(0.5)))),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.all(8),
                    child: Row(
                      children: [
                        // Container(
                        //   width: 40,
                        //   height: 40,
                        //   child: TextField(
                        //     scrollPadding: const EdgeInsets.all(5),
                        //     controller: textEditingController,
                        //     onChanged: (value) {
                        //       if (int.parse(value) > max) {
                        //         textEditingController.text = "${max}";
                        //         final val = TextSelection.collapsed(
                        //             offset: textEditingController.text.length);
                        //         textEditingController.selection = val;
                        //       } else if (int.parse(value) < min) {
                        //         textEditingController.text = "${min}";
                        //         final val = TextSelection.collapsed(
                        //             offset: textEditingController.text.length);
                        //         textEditingController.selection = val;
                        //       }
                        //     },
                        //     keyboardType: TextInputType.number,
                        //     style: const TextStyle(
                        //       fontSize: 20,
                        //     ),
                        //     decoration: InputDecoration(
                        //       contentPadding:
                        //           const EdgeInsetsDirectional.symmetric(
                        //               vertical: 10, horizontal: 5),
                        //       enabledBorder: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(5),
                        //           borderSide: BorderSide(
                        //               color: CustomColors.thirdcolor
                        //                   .withOpacity(0.5),
                        //               width: 1)),
                        //       focusedBorder: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(5),
                        //           borderSide: BorderSide(
                        //               color: CustomColors.thirdcolor
                        //                   .withOpacity(0.5),
                        //               width: 1)),
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   width: 5,
                        // ),
                        // const Text(
                        //   "X",
                        //   style: TextStyle(
                        //       color: CustomColors.thirdcolor, fontSize: 15),
                        // ),
                        // const SizedBox(
                        //   width: 6,
                        // ),

                        Expanded(
                          child: Wrap(
                            children: [
                              Text(
                                  "${couponData?.detailCoupon!.price}" + " S.R",
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 15)),
                              const Text("  =  ",
                                  style: TextStyle(
                                      color: CustomColors.thirdcolor,
                                      fontSize: 15)),
                              Text(
                                "${couponData?.detailCoupon!.pointPrice}" +
                                    " " +
                                    S.of(context).points,
                                style: const TextStyle(
                                    color: CustomColors.thirdcolor,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 40,
                          width: 110,
                          child: ElevatedButton(
                            onPressed: () {
                              if (globals.isLogin == false) {
                                showNeedLoginDialog(context);
                              } else {
                                addToCart(couponData!.detailCoupon!.id!, qty);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                //  minimumSize: Size(150, 100),
                                primary: CustomColors.primarycolor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
                            child: Center(
                              child: Text(
                                S.of(context).add_to_card,
                                style: const TextStyle(
                                    color: CustomColors.titlecolor,
                                    fontSize: 13),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
      appBar: CustomAppBar(
        actions: [
          SizedBox(
            width: 38,
            child: IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return SearchPage(
                      SearchType: "coupon",
                    );
                  }));
                },
                icon: const Icon(
                  Icons.search,
                  color: CustomColors.primarycolor,
                )),
          ),
          // ignore: unnecessary_null_comparison
          if (globals.whichListCoupon != null)
            SizedBox(
              width: 38,
              child: IconButton(
                  onPressed: () {
                    globals.isLogin == false
                        ? showNeedLoginDialog(context)
                        : AddCouponToWish();
                  },
                  icon: globals.whichListCoupon.contains(widget.couponid)
                      ? Icon(Icons.favorite, color: CustomColors.primarycolor)
                      : Icon(Icons.favorite_border,
                          color: CustomColors.primarycolor)),
            ),
          SizedBox(
            width: 38,
            child: IconButton(
                onPressed: () async {
                  //Share.share('${couponData?.detailCoupon?.shareLink}');
                  final result = await Share.shareWithResult(
                      '${couponData?.detailCoupon?.shareLink}',
                      subject:
                          "${couponData!.detailCoupon!.getPropertyEffectedByLang("name_${globals.SelectedLang}")}");

                  if (result.status == ShareResultStatus.success) {
                    print('Thank you for sharing my website!');
                  }
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
              child: ListView(
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
                                                      "${couponData!.detailCoupon!.image}"));
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
                                    "${couponData?.detailCoupon!.image}"),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.symmetric(horizontal: 18.0),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Padding(
                        padding: const EdgeInsetsDirectional.only(end: 10),
                        child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 28,
                            backgroundImage: NetworkImage(
                                "${couponData?.detailCoupon!.simpleProvider!.logo}")),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Wrap(
                              children: [
                                Text(
                                  "${couponData?.detailCoupon!.simpleProvider!.getPropertyEffectedByLang("name_${globals.SelectedLang}")}",
                                  style: const TextStyle(
                                      color: CustomColors.thirdcolor),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: CustomColors.secondarycolor,
                              ),
                              Text(
                                "${couponData?.detailCoupon!.avgRating!}",
                                style: TextStyle(
                                    color: CustomColors.secondarycolor),
                              )
                            ],
                          ),
                        ],
                      ),
                      trailing: TextButton(
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(0)),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return DetailsScreenOfProviders(
                              id: couponData?.detailCoupon!.providerId,
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
                      //         maximumSize: Size(90, 60),
                      //         padding: const EdgeInsetsDirectional.all(10),
                      //         primary: CustomColors.secondarycolor,
                      //         shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(50))),
                      //     onPressed: () {
                      //       Navigator.of(context)
                      //           .push(MaterialPageRoute(builder: (context) {
                      //         return DetailsScreenOfProviders(
                      //           id: couponData?.detailCoupon!.providerId,
                      //         );
                      //       }));
                      //     },
                      //     child: Text(
                      //       S.of(context).More,
                      //       style:
                      //           const TextStyle(color: CustomColors.titlecolor),
                      //     )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 18, vertical: 8),
                    child: Text(
                        "${couponData?.detailCoupon!.getPropertyEffectedByLang("name_${globals.SelectedLang}")}",
                        style: CustomTheme.text20theme
                            .copyWith(color: CustomColors.primarycolor)),
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.symmetric(horizontal: 18),
                    child: HtmlWidget(
                      "${couponData?.detailCoupon!.getPropertyEffectedByLang("brief_${globals.SelectedLang}")}",
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        start: 10, end: 10, top: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          if (couponData != null)
                            ...couponData!.detailCoupon!.listcouponprice!
                                .map((e) {
                              return CustomPriceBox(
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
                                price: "${e.price}",
                                oldPrice:
                                    "${couponData?.detailCoupon?.priceBeforeDiscount}",
                                packageName:
                                    "${e.subscriptionPackage?.getPropertyEffectedByLang("package_name_${globals.SelectedLang}")}",
                                points: "${e.pointPrice}",
                                earnedPoints: "${e.earnedPoints}",
                                packageid: e.subscriptionPackageId,
                              );
                            })
                        ],
                      ),
                    ),
                  ),
                  couponData?.detailCoupon!.enable_flash_deal == 1 &&
                          now!.isBefore(DateTime.parse(couponData!
                                  .detailCoupon!.flashDealEndDate!)) ==
                              true
                      ? Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: 18, end: 18, bottom: 15, top: 8),
                          child: CountdownTimer(
                            endTime: endTime,
                            widgetBuilder: (_, CurrentRemainingTime? time) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border.all(
                                                color: CustomColors
                                                    .secondarycolor)),
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
                                              color: CustomColors
                                                  .backgroundcolor_for_Ticket,
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: Center(
                                            child: Text("d"),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border.all(
                                                color: CustomColors
                                                    .secondarycolor)),
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
                                              color: CustomColors
                                                  .backgroundcolor_for_Ticket,
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: Center(
                                            child: Text("h"),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border.all(
                                                color: CustomColors
                                                    .secondarycolor)),
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
                                              color: CustomColors
                                                  .backgroundcolor_for_Ticket,
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: Center(
                                            child: Text("m"),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border.all(
                                                color: CustomColors
                                                    .secondarycolor)),
                                        child: Center(
                                            child: Text(
                                          "${time.sec != null ? time!.sec.toString() : "0"}",
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
                                              color: CustomColors
                                                  .backgroundcolor_for_Ticket,
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: Center(
                                            child: Text(
                                              "s",
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        )
                      : Container(),

                  // Padding(
                  //     padding: const EdgeInsetsDirectional.all(8.0),
                  //     child: SizedBox(
                  //       width: double.infinity,
                  //       height: 90,
                  //       child: ListView.builder(
                  //           scrollDirection: Axis.horizontal,
                  //           shrinkWrap: true,
                  //           physics: const NeverScrollableScrollPhysics(),
                  //           itemCount: couponData!
                  //               .detailCoupon!.listcouponprice!.length,
                  //           itemBuilder: (context, index) {
                  //             return CustomPointBox(
                  //               pointcolor: Color(
                  //                 int.parse(
                  //                   "0XFF" +
                  //                       couponData!
                  //                           .detailCoupon!
                  //                           .listcouponprice![index]
                  //                           .subscriptionPackage!
                  //                           .color!
                  //                           .replaceAll("#", ""),
                  //                 ),
                  //               ),
                  //               bordercolor: Color(
                  //                 int.parse(
                  //                   "0XFF" +
                  //                       couponData!
                  //                           .detailCoupon!
                  //                           .listcouponprice![index]
                  //                           .subscriptionPackage!
                  //                           .color!
                  //                           .replaceAll("#", ""),
                  //                 ),
                  //               ),
                  //               fontSize: 15,
                  //               color: Color(
                  //                 int.parse(
                  //                   "0XFF" +
                  //                       couponData!
                  //                           .detailCoupon!
                  //                           .listcouponprice![index]
                  //                           .subscriptionPackage!
                  //                           .color!
                  //                           .replaceAll("#", ""),
                  //                 ),
                  //               ),
                  //               points:
                  //                   "${couponData?.detailCoupon!.listcouponprice![index].earnedPoints}",
                  //             );
                  //           }),
                  //     )

                  //     ),
                  // here error*************
                  // Row(
                  //   mainAxisSize: MainAxisSize.min,
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     ...List.generate(3, (index) {
                  //       return InfoBox(
                  //         // title: "Valid to",
                  //         content: "${couponData?.detailCoupon!.validTo}",
                  //       );
                  //     })
                  //   ],
                  // ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.symmetric(horizontal: 18),
                    child: Container(
                      child: Column(
                        children: [
                          couponData?.detailCoupon!.getPropertyEffectedByLang(
                                      "terms_${globals.SelectedLang}") !=
                                  null
                              ? Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                    // border: Border(
                                    //     bottom: BorderSide(
                                    //         color: Colors.grey.shade200),)
                                  ),
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
                                            color: termsisexpansion == false
                                                ? CustomColors.secondarycolor
                                                : CustomColors.primarycolor,
                                            fontWeight: termsisexpansion == true
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                            fontSize: termsisexpansion == true
                                                ? 18
                                                : 16),
                                      ),
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.only(
                                                  bottom: 8,
                                                  end: 18,
                                                  start: 18),
                                          child: HtmlWidget(
                                              "${couponData?.detailCoupon!.getPropertyEffectedByLang("terms_${globals.SelectedLang}")}"),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 0,
                                ),
                          couponData?.detailCoupon!.getPropertyEffectedByLang(
                                      "terms_${globals.SelectedLang}") !=
                                  null
                              ? Divider(
                                  height: 0,
                                )
                              : Container(
                                  width: 0,
                                ),

                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: couponData?.detailCoupon!
                                            .getPropertyEffectedByLang(
                                                "terms_${globals.SelectedLang}") ==
                                        null
                                    ? BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20))
                                    : null),
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                initiallyExpanded: couponData?.detailCoupon!
                                            .getPropertyEffectedByLang(
                                                "terms_${globals.SelectedLang}") ==
                                        null
                                    ? true
                                    : false,
                                onExpansionChanged: (value) {
                                  change_location_expansion(value);
                                },
                                iconColor: CustomColors.primarycolor,
                                title: Text(
                                  S.of(context).location +
                                      " (${couponData?.detailCoupon?.simpleProvider?.listProviderBranch?.length})",
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
                                  if (couponData != null)
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          bottom: 8, start: 10, end: 10),
                                      child: ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: couponData!
                                              .detailCoupon!
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
                                                    color:
                                                        Colors.grey.shade200),
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${couponData?.detailCoupon!.simpleProvider!.listProviderBranch![index].getPropertyEffectedByLang("name_${globals.SelectedLang}")}",
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
                                                                "${couponData?.detailCoupon!.simpleProvider!.listProviderBranch![index].getPropertyEffectedByLang("location_${globals.SelectedLang}")}"))
                                                      ],
                                                    ),
                                                    couponData
                                                                ?.detailCoupon!
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
                                                                        "tel://${couponData?.detailCoupon!.simpleProvider!.listProviderBranch![index].phone}");
                                                                  },
                                                                  child: Text(
                                                                      "${couponData?.detailCoupon!.simpleProvider!.listProviderBranch![index].phone}")),
                                                            ],
                                                          )
                                                        : Container(width: 0),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          couponData != null &&
                                  couponData!.detailCoupon!.simpleProvider!
                                      .listProviderBranch!.isNotEmpty
                              ? Divider(
                                  height: 0,
                                )
                              : Container(
                                  width: 0,
                                ),
                          //here Review
                          if (couponReview != null)
                            Container(
                              decoration: BoxDecoration(
                                color: Reviewisexpansion == false
                                    ? Colors.white
                                    : Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(25),
                                    bottomRight: Radius.circular(25)),
                                // border: Border(
                                //     bottom:
                                //         BorderSide(color: Colors.grey.shade100)),
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
                                        " (${couponReview!.length})",
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
                                              child: Container(
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
                                                                          initialRating: double.parse(couponData!
                                                                              .detailCoupon!
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
                                            ...couponReview!.map((e) {
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
                  couponData != null && couponData!.listMoreDeals!.isEmpty
                      ? Container()
                      : Padding(
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 18),
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
                  // couponData!.listMoreDeals!.isEmpty ?
                  // Center(child: Text("No data"),) :
                  couponData != null && couponData!.listMoreDeals!.isEmpty
                      ? Container()
                      : Padding(
                          padding: const EdgeInsetsDirectional.only(start: 18),
                          child: Container(
                            margin: EdgeInsetsDirectional.only(top: 10),
                            width: double.infinity,
                            height: 243,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: couponData?.listMoreDeals!.length,
                              itemBuilder: ((context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      // Navigator.of(context)
                                      //     .push(MaterialPageRoute(builder: (context) {
                                      //   return  DetailsCoupon();
                                      // }));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          end: 5),
                                      child: couponData != null
                                          ? SizedBox(
                                              width: 170,
                                              child: CustomCoupon(
                                                simpleCoupon: couponData!
                                                    .listMoreDeals![index],
                                                // imageurl:
                                                //     "${couponData!.listMoreDeals![index].image}",
                                                // name:
                                                //     "${couponData!.listMoreDeals![index].getPropertyEffectedByLang("name_${globals.SelectedLang}")}",
                                                // old_price:
                                                //     "${couponData!.listMoreDeals![index].priceBeforeDiscount}",
                                                // price:
                                                //     "${couponData!.listMoreDeals![index].price}",
                                                // valid_date:
                                                //     "${couponData!.listMoreDeals![index].validTo}",
                                              ),
                                            )
                                          : Container(
                                              width: 0,
                                              height: 0,
                                            ),
                                    ));
                              }),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  couponData != null && couponData!.listSimilarDeal!.isEmpty
                      ? Container()
                      : Padding(
                          padding: const EdgeInsetsDirectional.only(start: 18),
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
                  couponData != null && couponData!.listSimilarDeal!.isEmpty
                      ? Container()
                      : Container(
                          margin: EdgeInsetsDirectional.only(bottom: 10),
                          padding: const EdgeInsetsDirectional.only(start: 18),
                          child: Container(
                            margin: EdgeInsetsDirectional.only(top: 10),
                            width: double.infinity,
                            height: 243,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: couponData?.listSimilarDeal!.length,
                              itemBuilder: ((context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      // Navigator.of(context)
                                      //     .push(MaterialPageRoute(builder: (context) {
                                      //   return  DetailsCoupon();
                                      // }));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          end: 5),
                                      child: SizedBox(
                                        width: 170,
                                        child: CustomCoupon(
                                          simpleCoupon: couponData!
                                              .listSimilarDeal![index],
                                        ),
                                      ),
                                    ));
                              }),
                            ),
                          ),
                        ),
                ],
              ),
            ),
    );
  }
}
