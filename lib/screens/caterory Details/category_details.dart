import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:redeem/custom_widget/CustomAppBar.dart';
import 'package:redeem/custom_widget/Custom_Coupon_Flash_Deal.dart';
import 'package:redeem/custom_widget/Custom_offers.dart';
import 'package:redeem/custom_widget/custom_back_button.dart';
import 'package:redeem/custom_widget/custom_coupon.dart';
import 'package:redeem/custom_widget/custom_preloader.dart';
import 'package:redeem/generated/l10n.dart';
import 'package:redeem/json_db/enum.dart';
import 'package:redeem/json_db/json_db.dart';
import 'package:redeem/screens/List_coupons_page/List_coupons_page.dart';
import 'package:redeem/screens/all%20offers/all_offers.dart';
import 'package:redeem/screens/details_coupon/details_coupon.dart';
import 'package:redeem/screens/details_screen_of_providers/details_screen_of_providers.dart';
import 'package:redeem/screens/offer_details/offer_details.dart';
import 'package:redeem/screens/providers/providers.dart';
import 'package:redeem/size_config.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';
import 'package:redeem/globals.dart' as globals;
import 'package:svg_flutter/svg_flutter.dart';

// ignore: must_be_immutable
class CategortDetails extends StatefulWidget {
  dynamic category_id;
  Color? color;
  String? Category_name;
  String? Category_icon;
  CategortDetails(
      {this.color, this.category_id, this.Category_name, this.Category_icon});

  @override
  State<CategortDetails> createState() => _CategortDetailsState();
}

class _CategortDetailsState extends State<CategortDetails> {
  CategoryDetailsData? categoryDetailsData;
  bool loading = true;
  void getData() async {
    // try {
    await JsonDb().getCategoryDataCollections(widget.category_id).then((res) {
      if (res.success) {
        print("success category details");
        categoryDetailsData = res.data;

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
    //  }
    // catch (e) {
    //   ScaffoldMessenger.of(Get.context as BuildContext).showSnackBar(
    //     CustomTheme.CustomSnackBar(S.of(context).Internet_connection_error, "warning"),
    //   );
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: CustomAppBar(
          elevation: 0,
          leading: CustomBackButton(),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${widget.Category_name}",
                style: TextStyle(color: widget.color),
              ),
              Container(
                margin: EdgeInsetsDirectional.only(start: 40),
                width: 30,
                height: 30,
                child: SvgPicture.network(
                  "${widget.Category_icon}",
                  fit: BoxFit.fill,
                  color: widget.color,
                ),
              )
            ],
          ),
          backgroundColor: widget.color,
          // actions: [
          //   Container(
          //     child: SvgPicture.network(
          //       "${widget.Category_icon}",
          //       fit: BoxFit.cover,
          //       width: 10,
          //       height: 10,
          //     ),
          //   ),
          // ]
        ),
        backgroundColor: CustomColors.backgroundcolor_for_Ticket,
        body: loading == true
            ? const CustomPreloader()
            : SafeArea(
                child: categoryDetailsData!.listBestcoupon!.isNotEmpty ||
                        categoryDetailsData!.listBestoffer!.isNotEmpty ||
                        categoryDetailsData!.listBestprovider!.isNotEmpty ||
                        categoryDetailsData!.listFlashDeal!.isNotEmpty ||
                        categoryDetailsData!.listSubCategory!.isNotEmpty
                    ? SingleChildScrollView(
                        child: Column(
                          children: [
                            categoryDetailsData!.listSubCategory!.isNotEmpty
                                ? Container(
                                    padding: EdgeInsetsDirectional.only(
                                        start: globals.start_padding,
                                        end: globals.end_padding),
                                    margin: EdgeInsetsDirectional.only(top: 5),
                                    width: double.infinity,
                                    height: 30,
                                    child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: categoryDetailsData!
                                            .listSubCategory!.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            padding:
                                                EdgeInsetsDirectional.all(6),
                                            margin:
                                                EdgeInsetsDirectional.symmetric(
                                                    horizontal: 8),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: widget.color!),
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Center(
                                                child: Text(
                                              "${categoryDetailsData!.listSubCategory![index].getPropertyEffectedByLang("name_${globals.SelectedLang}")}",
                                              style: TextStyle(
                                                  color: widget.color),
                                            )),
                                          );
                                        }),
                                  )
                                : Container(
                                    width: 0,
                                  ),
                            Container(
                              child: Column(
                                children: [
                                  ...categoryDetailsData!.listCategorirsSection!
                                      .map((e) {
                                    return Container(
                                      padding: EdgeInsetsDirectional.only(
                                        start: globals.start_padding,
                                      ),
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: Column(
                                        children: [
                                          e.listsimpleCoupon!.isNotEmpty ||
                                                  e.listsimpleOffer!.isNotEmpty
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .only(start: 8),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "${e.getPropertyEffectedByLang("name_${globals.SelectedLang}")}",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: widget.color,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const Spacer(),
                                                      TextButton(
                                                        onPressed: () {
                                                          e.type == "coupons"
                                                              ? Navigator.of(
                                                                      context)
                                                                  .push(MaterialPageRoute(
                                                                      builder:
                                                                          (context) {
                                                                  return ListCouponsPage(
                                                                    from_categroy_id:
                                                                        widget
                                                                            .category_id,
                                                                  );
                                                                }))
                                                              : Navigator.of(
                                                                      context)
                                                                  .push(MaterialPageRoute(
                                                                      builder:
                                                                          (context) {
                                                                  return AllOffers(
                                                                    from_categroy_id:
                                                                        widget
                                                                            .category_id,
                                                                  );
                                                                }));
                                                        },
                                                        child: Wrap(
                                                          crossAxisAlignment:
                                                              WrapCrossAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              S
                                                                  .of(context)
                                                                  .see_all,
                                                              style: TextStyle(
                                                                  color: widget
                                                                      .color,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Icon(
                                                              Icons.arrow_right,
                                                              size: 30,
                                                              color:
                                                                  widget.color,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Container(),
                                          e.type == "coupons" &&
                                                  e.listsimpleCoupon!.isNotEmpty
                                              ? Container(
                                                  width: double.infinity,
                                                  height: 240,
                                                  padding: EdgeInsetsDirectional
                                                      .only(start: 7),
                                                  child: SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Row(
                                                      children: [
                                                        ...categoryDetailsData!
                                                            .listCategorirsSection!
                                                            .map((e) {
                                                          return ListView
                                                              .builder(
                                                                  shrinkWrap:
                                                                      true,
                                                                  scrollDirection:
                                                                      Axis
                                                                          .horizontal,
                                                                  itemCount: e
                                                                      .listsimpleCoupon!
                                                                      .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          i) {
                                                                    return GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          Navigator.of(context).push(MaterialPageRoute(builder:
                                                                              (context) {
                                                                            return DetailsCoupon(e.listsimpleCoupon![i].id);
                                                                          }));
                                                                        },
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsetsDirectional.symmetric(horizontal: 3),
                                                                          child:
                                                                              SizedBox(
                                                                            width:
                                                                                170,
                                                                            child: e.listsimpleCoupon!.isNotEmpty
                                                                                ? CustomCoupon(
                                                                                    simpleCoupon: e.listsimpleCoupon![i],
                                                                                  )
                                                                                : Container(),
                                                                          ),
                                                                        ));
                                                                  });
                                                        }).toList()
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : SizedBox(
                                                  width: double.infinity,
                                                  child: Column(
                                                    children: [
                                                      ...categoryDetailsData!
                                                          .listCategorirsSection!
                                                          .map((e) {
                                                        return ListView.builder(
                                                            shrinkWrap: true,
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            itemCount: e
                                                                .listsimpleOffer!
                                                                .length,
                                                            itemBuilder:
                                                                (context, i) {
                                                              return GestureDetector(
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .push(MaterialPageRoute(builder:
                                                                            (context) {
                                                                      return OfferDetails(
                                                                        offerid: e
                                                                            .listsimpleOffer![i]
                                                                            .id,
                                                                      );
                                                                    }));
                                                                  },
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsetsDirectional
                                                                            .symmetric(
                                                                        horizontal:
                                                                            10),
                                                                    child:
                                                                        SizedBox(
                                                                      width:
                                                                          170,
                                                                      child: e.listsimpleOffer!
                                                                              .isNotEmpty
                                                                          ? Container(
                                                                              margin: EdgeInsetsDirectional.only(bottom: 5),
                                                                              child: CustomOffers(
                                                                                simpleOffer: e.listsimpleOffer![i],
                                                                              ),
                                                                            )
                                                                          : Container(),
                                                                    ),
                                                                  ));
                                                            });
                                                      })
                                                    ],
                                                  ),
                                                ),
                                        ],
                                      ),
                                    );
                                  }).toList()
                                ],
                              ),
                            ),
                            categoryDetailsData!.listFlashDeal!.isNotEmpty
                                ? Padding(
                                    padding: EdgeInsetsDirectional.only(
                                      start: 20,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          S.of(context).flashdeals,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: widget.color,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
                                        TextButton(
                                          onPressed: () {},
                                          child: Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            children: [
                                              Text(
                                                S.of(context).see_all,
                                                style: TextStyle(
                                                    color: widget.color,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Icon(
                                                Icons.arrow_right,
                                                size: 30,
                                                color: widget.color,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                            categoryDetailsData!.listFlashDeal!.isNotEmpty
                                ? Padding(
                                    padding: EdgeInsetsDirectional.only(
                                      start: 20,
                                    ),
                                    child: Container(
                                      child: CarouselSlider.builder(
                                        itemCount: categoryDetailsData!
                                            .listFlashDeal!.length,
                                        itemBuilder:
                                            (context, index, realindex) {
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return DetailsCoupon(
                                                    categoryDetailsData!
                                                        .listFlashDeal![index]
                                                        .id);
                                              }));
                                            },
                                            child: CustomCouponFlashDeal(
                                              flashDeal: categoryDetailsData!
                                                  .listFlashDeal![index],
                                            ),
                                          );
                                        },
                                        options: CarouselOptions(
                                          viewportFraction: 1,
                                          autoPlay: true,
                                          animateToClosest: true,
                                          height: 166.0,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                            categoryDetailsData!.listBestcoupon!.isNotEmpty
                                ? Padding(
                                    padding: EdgeInsetsDirectional.only(
                                      start: 20,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          S.of(context).coupons,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: widget.color,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                              padding: EdgeInsets.all(0)),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return ListCouponsPage(
                                                from_categroy_id:
                                                    widget.category_id,
                                              );
                                            }));
                                          },
                                          child: Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            children: [
                                              Text(
                                                S.of(context).see_all,
                                                style: TextStyle(
                                                    color: widget.color,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Icon(
                                                Icons.arrow_right,
                                                size: 30,
                                                color: widget.color,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                            categoryDetailsData!.listBestcoupon!.isNotEmpty
                                ? Padding(
                                    padding: EdgeInsetsDirectional.only(
                                      start: 20,
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      height: 243,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: categoryDetailsData!
                                            .listBestcoupon!.length,
                                        itemBuilder: ((context, index) {
                                          return GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return DetailsCoupon(
                                                      categoryDetailsData!
                                                          .listBestcoupon![
                                                              index]
                                                          .id);
                                                }));
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                            .symmetric(
                                                        horizontal: 10),
                                                child: SizedBox(
                                                  width: 170,
                                                  child: CustomCoupon(
                                                    simpleCoupon:
                                                        categoryDetailsData!
                                                                .listBestcoupon![
                                                            index],
                                                  ),
                                                ),
                                              ));
                                        }),
                                      ),
                                    ),
                                  )
                                : Container(),
                            categoryDetailsData!.listBestoffer!.isNotEmpty
                                ? Padding(
                                    padding: EdgeInsetsDirectional.only(
                                      start: 20,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          S.of(context).offers,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: widget.color,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                              padding: EdgeInsets.all(0)),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return AllOffers(
                                                from_categroy_id:
                                                    widget.category_id,
                                              );
                                            }));
                                          },
                                          child: Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            children: [
                                              Text(
                                                S.of(context).see_all,
                                                style: TextStyle(
                                                    color: widget.color,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Icon(
                                                Icons.arrow_right,
                                                size: 30,
                                                color: widget.color,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                            categoryDetailsData!.listBestoffer!.isNotEmpty
                                ? Padding(
                                    padding: EdgeInsetsDirectional.only(
                                      start: 20,
                                    ),
                                    child: Container(
                                      margin: const EdgeInsetsDirectional.only(
                                          bottom: 8),
                                      child: GridView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          gridDelegate:
                                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 360,
                                            mainAxisExtent: 127,
                                            mainAxisSpacing: 20,
                                            //  crossAxisSpacing: 20,
                                          ),
                                          itemCount: categoryDetailsData!
                                              .listBestoffer!.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .symmetric(horizontal: 8),
                                              child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return OfferDetails(
                                                        offerid:
                                                            categoryDetailsData!
                                                                .listBestoffer![
                                                                    index]
                                                                .id,
                                                      );
                                                    }));
                                                  },
                                                  child: CustomOffers(
                                                    simpleOffer:
                                                        categoryDetailsData!
                                                                .listBestoffer![
                                                            index],
                                                  )),
                                            );
                                          }),
                                    ),
                                  )
                                : Container(),
                            categoryDetailsData!.listBestprovider!.isNotEmpty
                                ? Padding(
                                    padding: EdgeInsetsDirectional.only(
                                        start: 20, end: globals.end_padding),
                                    child: Row(
                                      children: [
                                        Text(
                                          S.of(context).providers,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: widget.color,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                              padding: EdgeInsets.all(0)),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return const Providers();
                                            }));
                                          },
                                          child: Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            children: [
                                              Text(
                                                S.of(context).see_all,
                                                style: TextStyle(
                                                    color: widget.color,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Icon(
                                                Icons.arrow_right,
                                                size: 30,
                                                color: widget.color,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                            categoryDetailsData!.listBestprovider!.isNotEmpty
                                ? Padding(
                                    padding: EdgeInsetsDirectional.only(
                                      start: 20,
                                    ),
                                    child: Container(
                                        width: double.infinity,
                                        height: 60,
                                        // margin:
                                        //     const EdgeInsetsDirectional.only(bottom: 20),
                                        child: CarouselSlider.builder(
                                          itemCount: categoryDetailsData!
                                              .listBestprovider!.length,
                                          options: CarouselOptions(
                                            reverse: true,
                                            autoPlayAnimationDuration:
                                                const Duration(
                                                    milliseconds: 500),
                                            autoPlayInterval: const Duration(
                                                milliseconds: 1000),
                                            viewportFraction: 80 /
                                                MediaQuery.of(context)
                                                    .size
                                                    .width,
                                            disableCenter: true,
                                            autoPlay: true,
                                            animateToClosest: true,
                                            height: responsive_size(240),
                                          ),
                                          itemBuilder:
                                              ((context, index, realIndex) {
                                            return Container(
                                              margin:
                                                  const EdgeInsetsDirectional
                                                      .symmetric(horizontal: 8),
                                              child: Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                        return DetailsScreenOfProviders(
                                                          id: categoryDetailsData!
                                                              .listBestprovider![
                                                                  index]
                                                              .id,
                                                        );
                                                      }));
                                                    },
                                                    child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.white,
                                                        radius: 30,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                "${categoryDetailsData!.listBestprovider![index].logo}")),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                        )

                                        //  ListView.builder(
                                        //     scrollDirection: Axis.horizontal,
                                        //     shrinkWrap: true,
                                        //     itemCount: categoryDetailsData!
                                        //         .listBestprovider!.length,
                                        //     itemBuilder: (context, index) {
                                        //       return Container(
                                        //         margin:
                                        //             const EdgeInsetsDirectional.symmetric(
                                        //                 horizontal: 8),
                                        //         child: Column(
                                        //           children: [
                                        //             GestureDetector(
                                        //               onTap: () {
                                        //                 Navigator.of(context).push(
                                        //                     MaterialPageRoute(
                                        //                         builder: (context) {
                                        //                   return DetailsScreenOfProviders(
                                        //                     id: categoryDetailsData!
                                        //                         .listBestprovider![index]
                                        //                         .id,
                                        //                   );
                                        //                 }));
                                        //               },
                                        //               child: CircleAvatar(
                                        //                   backgroundColor: Colors.white,
                                        //                   radius: 30,
                                        //                   backgroundImage: NetworkImage(
                                        //                       "${categoryDetailsData!.listBestprovider![index].logo}")),
                                        //             ),
                                        //             const SizedBox(
                                        //               height: 5,
                                        //             ),
                                        //             Container(
                                        //                 width: 70,
                                        //                 child: Center(
                                        //                   child: Text(
                                        //                     "${categoryDetailsData!.listBestprovider![index].getPropertyEffectedByLang("name_${globals.SelectedLang}")}",
                                        //                     style: TextStyle(
                                        //                         fontWeight:
                                        //                             FontWeight.w400,
                                        //                         fontSize: 13),
                                        //                     maxLines: 1,
                                        //                     overflow:
                                        //                         TextOverflow.ellipsis,
                                        //                   ),
                                        //                 ))
                                        //           ],
                                        //         ),
                                        //       );
                                        //     }),
                                        ),
                                  )
                                : Container(),
                          ],
                        ),
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.network(
                              "${widget.Category_icon}",
                              fit: BoxFit.cover,
                              width: 60,
                              height: 60,
                              color: widget.color,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              S.of(context).no_data,
                              style:
                                  TextStyle(color: widget.color, fontSize: 20),
                            )
                          ],
                        ),
                      ),
              ));
  }
}
