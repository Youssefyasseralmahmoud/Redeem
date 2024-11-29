import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:redeem/core/function/notification_state_controller.dart';
import 'package:redeem/custom_widget/CustomAppBar.dart';
import 'package:redeem/custom_widget/Custom_offers.dart';
import 'package:redeem/custom_widget/custme_button.dart';
import 'package:redeem/custom_widget/custom_back_button.dart';
import 'package:redeem/custom_widget/custom_carousel_items.dart';
import 'package:redeem/custom_widget/custom_coupon.dart';
import 'package:redeem/custom_widget/custom_drawer.dart';
import 'package:redeem/custom_widget/custom_offer_coupon_box.dart';
import 'package:redeem/custom_widget/custom_preloader.dart';
import 'package:redeem/generated/l10n.dart';
import 'package:redeem/json_db/enum.dart';
import 'package:redeem/json_db/infinite_grid.dart';
import 'package:redeem/json_db/json_db.dart';
import 'package:redeem/json_db/utils.dart';
import 'package:redeem/screens/Map/map.dart';
import 'package:redeem/screens/details_coupon/details_coupon.dart';
import 'package:redeem/screens/details_screen_of_providers/details_screen_of_providers_controller.dart';
import 'package:redeem/screens/offer_details/offer_details.dart';
import 'package:redeem/size_config.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';
import 'package:redeem/globals.dart' as globals;
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

// ignore: must_be_immutable
class DetailsScreenOfProviders extends StatefulWidget {
  dynamic id;
  DetailsScreenOfProviders({super.key, this.id});

  @override
  State<DetailsScreenOfProviders> createState() => _DetailsScreenOfProviders();
}

class _DetailsScreenOfProviders extends State<DetailsScreenOfProviders> {
  int currentpage = 0;
  CarouselController pageController = CarouselController();
  TextEditingController controller = TextEditingController();
  double myRating = 0;
  bool? couponisexpansion = true;
  bool? offerisexpansion = false;
  bool? locationisexpansion = false;
  bool? Reviewisexpansion = false;
  ProviderDetail? providerDetail;
  List<ProvidersReview>? providersReview = [];
  bool loading = true;

  void change_coupon_expansion(bool expansion) {
    couponisexpansion = expansion;
    setState(() {});
  }

  void change_offer_expansion(bool expansion) {
    offerisexpansion = expansion;
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
    await JsonDb().getdetailsProvidersCollections(widget.id).then((res) {
      if (res.success) {
        print("providerDetails succres ${res.data}");
        providerDetail = res.data;

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
    await JsonDb().getProviderReviewCollections(widget.id).then((res) {
      if (res.success) {
        print("id is ${widget.id}");
        print("providers review succres ${res.data}");
        providersReview = res.data;

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
            prvider_id: widget.id)
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

  void AddProviderToWish() async {
    // try {
    // print("paymentLength ${cartData!.cart!.listPaymentMethod!.length}");
    await JsonDb().AddProviderToWhishCollections(widget.id).then((res) {
      if (res.success) {
        !globals.whichListProviders.contains(widget.id)
            ? globals.whichListProviders.add(widget.id)
            : globals.whichListProviders.remove(widget.id);
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

  @override
  void initState() {
    super.initState();
    getData();
    getReview();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      // drawer: CustomDrawer(
      //     choisecitygitem: globals.citys, choiselangitem: globals.Language2),
      backgroundColor: CustomColors.backgroundcolor_for_Ticket,
      appBar: CustomAppBar(
        actions: [
          // ignore: unnecessary_null_comparison
          if (globals.whichListProviders != null)
            SizedBox(
              width: 38,
              child: IconButton(
                  onPressed: () {
                    globals.isLogin == false
                        ? showNeedLoginDialog(context)
                        : AddProviderToWish();
                  },
                  icon: globals.whichListProviders.contains(widget.id)
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
                  Share.share('${providerDetail?.shareLink}',
                      subject:
                          "${providerDetail!.getPropertyEffectedByLang("name_${globals.SelectedLang}")}");
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
          ? CustomPreloader()
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          margin:
                              //i change margin here from 5 to 0
                              EdgeInsetsDirectional.symmetric(horizontal: 0),
                          child: providerDetail != null
                              ? CarouselSlider.builder(
                                  carouselController: pageController,
                                  itemCount: providerDetail!.imagesList!.length,
                                  options: CarouselOptions(
                                    autoPlayAnimationDuration:
                                        const Duration(seconds: 2),
                                    viewportFraction: 1,
                                    autoPlay: true,
                                    animateToClosest: true,
                                    height: responsive_size(210),
                                    onPageChanged: (index, reason) {
                                      currentpage = index;
                                      setState(() {});
                                    },
                                  ),
                                  itemBuilder: ((context, index, realIndex) {
                                    return GestureDetector(
                                      onTap: () {
                                        PageController? _pageController =
                                            PageController(initialPage: index);
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
                                                            padding:
                                                                EdgeInsets.all(
                                                                    0),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            icon: const Icon(
                                                              Icons.close,
                                                              color:
                                                                  Colors.white,
                                                            )),
                                                      ],
                                                    ),
                                                    Expanded(
                                                        child: PhotoViewGallery
                                                            .builder(
                                                                pageController:
                                                                    _pageController,
                                                                itemCount:
                                                                    providerDetail!
                                                                        .imagesList!
                                                                        .length,
                                                                builder:
                                                                    (context,
                                                                        index) {
                                                                  return PhotoViewGalleryPageOptions(
                                                                      imageProvider:
                                                                          NetworkImage(
                                                                              "${providerDetail!.imagesList![index]}"));
                                                                })),
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                      child: Container(
                                        margin: EdgeInsetsDirectional.symmetric(
                                            horizontal: globals.end_padding_17),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    "${providerDetail!.imagesList![index]}"),
                                                fit: BoxFit.cover)),
                                      ),
                                    )
                                        // Image.asset(
                                        //   "assets/images/test.jpg",
                                        //   fit: BoxFit.cover,
                                        // )
                                        ;
                                  }),
                                )
                              : Container(
                                  width: 0,
                                ),
                        ),
                        if (providerDetail != null)
                          Positioned(
                            bottom: 10,
                            left: ((SizeConfig.screenWidth!) -
                                    (23 * providerDetail!.imagesList!.length)) /
                                2,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: CustomColors.backgroundcolor_for_Ticket
                                    .withOpacity(0.5),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for (int i = 0;
                                      i < providerDetail!.imagesList!.length;
                                      i++)
                                    Container(
                                      height: 13,
                                      width: 13,
                                      margin: EdgeInsetsDirectional.all(5),
                                      decoration: BoxDecoration(
                                          color: currentpage == i
                                              ? CustomColors.primarycolor
                                              : Colors.white,
                                          shape: BoxShape.circle),
                                    )
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 30,
                          backgroundImage:
                              NetworkImage("${providerDetail?.logo}")),
                      title: Row(
                        children: [
                          Text(
                            "${providerDetail?.category!.getPropertyEffectedByLang("name_${globals.SelectedLang}")}",
                            style: CustomTheme.text15theme.copyWith(
                                color: CustomColors.secondarycolor,
                                fontSize: 13),
                          ),
                          Icon(
                            Icons.star,
                            color: CustomColors.secondarycolor,
                            size: 18,
                          ),
                          Text(
                            "${providerDetail?.avgRating}",
                            style: TextStyle(
                                color: CustomColors.secondarycolor,
                                fontSize: 18),
                          )
                        ],
                      ),
                      subtitle: Text(
                        "${providerDetail?.getPropertyEffectedByLang("name_${globals.SelectedLang}")}",
                        style: CustomTheme.text15theme.copyWith(
                            color: CustomColors.primarycolor, fontSize: 17),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    providerDetail?.overviewAr == null &&
                            providerDetail?.overviewEn == null
                        ? Padding(
                            padding: EdgeInsetsDirectional.all(18.0),
                            child: HtmlWidget(
                              "${providerDetail?.getPropertyEffectedByLang("overview_${globals.SelectedLang}")}",
                            ),
                          )
                        : Container(),
                    if (providerDetail != null)
                      Padding(
                        padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 18),
                        child: Column(
                          children: [
                            providerDetail!.listSimpleCoupons!.isEmpty
                                ? Container()
                                : Container(
                                    margin:
                                        EdgeInsetsDirectional.only(bottom: 0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20)),
                                      // border: Border(
                                      //     bottom: BorderSide(
                                      //         color: Colors.grey.shade100)),
                                    ),
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                          dividerColor: Colors.transparent),
                                      child: ExpansionTile(
                                        initiallyExpanded: true,
                                        onExpansionChanged: (value) {
                                          change_coupon_expansion(value);
                                        },
                                        backgroundColor: Colors.white,
                                        iconColor: CustomColors.primarycolor,
                                        title: Text(
                                          S.of(context).coupons +
                                              " (${"${providerDetail!.listSimpleCoupons!.length}"})",
                                          style: TextStyle(
                                              color: couponisexpansion == false
                                                  ? CustomColors.secondarycolor
                                                  : CustomColors.primarycolor,
                                              fontWeight:
                                                  couponisexpansion == true
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                              fontSize:
                                                  couponisexpansion == true
                                                      ? 18
                                                      : 16),
                                        ),
                                        children: [
                                          Container(
                                              margin:
                                                  EdgeInsetsDirectional.only(
                                                      bottom: 8,
                                                      end: 2,
                                                      start: 2),
                                              width: double.infinity,
                                              child: GridView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  gridDelegate:
                                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                                    maxCrossAxisExtent: 300,
                                                    mainAxisExtent: 243,
                                                    mainAxisSpacing: 20,
                                                    crossAxisSpacing: 3,
                                                  ),
                                                  itemCount: providerDetail!
                                                      .listSimpleCoupons!
                                                      .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                          return DetailsCoupon(
                                                              providerDetail!
                                                                  .listSimpleCoupons![
                                                                      index]
                                                                  .id);
                                                        }));
                                                      },
                                                      child: CustomCoupon(
                                                        couponColor: CustomColors
                                                            .backgroundcolor_for_Ticket,
                                                        circulColor:
                                                            Colors.white,
                                                        simpleCoupon:
                                                            providerDetail!
                                                                    .listSimpleCoupons![
                                                                index],
                                                      ),
                                                    );
                                                  })),
                                        ],
                                      ),
                                    ),
                                  ),
                            providerDetail!.listSimpleCoupons!.isNotEmpty
                                ? Divider(
                                    height: 0,
                                  )
                                : Container(
                                    width: 0,
                                  ),

                            // const SizedBox(
                            //   height: 10,
                            // ),
                            providerDetail!.listSimpleOffers!.isEmpty
                                ? Container()
                                : Container(
                                    decoration: BoxDecoration(
                                        color: offerisexpansion == false
                                            ? Colors.white
                                            : Colors.white,
                                        borderRadius: providerDetail!
                                                .listSimpleCoupons!.isEmpty
                                            ? BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20))
                                            : null),
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                          dividerColor: Colors.transparent),
                                      child: ExpansionTile(
                                        initiallyExpanded: providerDetail!
                                                .listSimpleCoupons!.isEmpty
                                            ? true
                                            : false,
                                        // initiallyExpanded:
                                        //     providerDetail!.listSimpleCoupons!.isEmpty
                                        //         ? true
                                        //         : false,
                                        iconColor: CustomColors.primarycolor,
                                        title: Text(
                                          S.of(context).offers +
                                              " (${providerDetail!.listSimpleOffers!.length})",
                                          style: TextStyle(
                                              color: offerisexpansion == false
                                                  ? CustomColors.secondarycolor
                                                  : CustomColors.primarycolor,
                                              fontWeight:
                                                  offerisexpansion == true
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                              fontSize: offerisexpansion == true
                                                  ? 18
                                                  : 16),
                                        ),
                                        onExpansionChanged: (value) {
                                          change_offer_expansion(value);
                                        },
                                        children: [
                                          Container(
                                            margin: EdgeInsetsDirectional.only(
                                                bottom: 8),
                                            child: GridView.builder(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                gridDelegate:
                                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                                  maxCrossAxisExtent: 600,
                                                  mainAxisExtent: 127,
                                                  mainAxisSpacing: 5,
                                                  //  crossAxisSpacing: 20,
                                                ),
                                                itemCount: providerDetail!
                                                    .listSimpleOffers!.length,
                                                itemBuilder: (context, index) {
                                                  print(
                                                      "the offers num is ${providerDetail!.listSimpleOffers!.length}");
                                                  return Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .symmetric(
                                                                horizontal: 5),
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                            return OfferDetails(
                                                              offerid:
                                                                  providerDetail!
                                                                      .listSimpleOffers![
                                                                          index]
                                                                      .id,
                                                            );
                                                          }));
                                                        },
                                                        child: CustomOffers(
                                                          offercolor: CustomColors
                                                              .backgroundcolor_for_Ticket,
                                                          circulColor:
                                                              Colors.white,
                                                          simpleOffer:
                                                              providerDetail!
                                                                      .listSimpleOffers![
                                                                  index],
                                                        )),
                                                  );
                                                }),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                            providerDetail!.listSimpleOffers!.isNotEmpty
                                ? Divider(
                                    height: 0,
                                  )
                                : Container(
                                    width: 0,
                                  ),

                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: providerDetail!
                                              .listSimpleCoupons!.isEmpty &&
                                          providerDetail!
                                              .listSimpleOffers!.isEmpty
                                      ? BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20))
                                      : null
                                  // border: Border(
                                  //     bottom: BorderSide(
                                  //         color: Colors.grey.shade200))
                                  ),
                              child: Theme(
                                data: Theme.of(context)
                                    .copyWith(dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                  iconColor: CustomColors.primarycolor,
                                  title: Text(
                                    S.of(context).location +
                                        " (${providerDetail!.listBranch!.length})",
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
                                  onExpansionChanged: (value) {
                                    change_location_expansion(value);
                                  },
                                  children: [
                                    Container(
                                      child: Padding(
                                        padding:
                                            const EdgeInsetsDirectional.only(
                                                bottom: 8, start: 10, end: 10),
                                        child: ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: providerDetail!
                                                .listBranch!.length,
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
                                                      BorderRadius.circular(10),
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
                                                        "${providerDetail!.listBranch![index].getPropertyEffectedByLang("name_${globals.SelectedLang}")}",
                                                        style: CustomTheme
                                                            .text16theme,
                                                      ),
                                                      const Divider(
                                                        endIndent: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .push(MaterialPageRoute(
                                                                      builder:
                                                                          (context) {
                                                                return MapScreen(
                                                                  providername:
                                                                      providerDetail!
                                                                          .getPropertyEffectedByLang(
                                                                              "name_${globals.SelectedLang}"),
                                                                );
                                                              }));
                                                            },
                                                            child: Icon(
                                                              Icons
                                                                  .location_on_outlined,
                                                              color: CustomColors
                                                                  .primarycolor,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Expanded(
                                                              child: Text(
                                                                  "${providerDetail!.listBranch![index].getPropertyEffectedByLang("location_${globals.SelectedLang}")}"))
                                                        ],
                                                      ),
                                                      providerDetail!
                                                                  .listBranch![
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
                                                                          "tel://${providerDetail!.listBranch![index].phone}");
                                                                    },
                                                                    child: Text(
                                                                        "${providerDetail!.listBranch![index].phone}")),
                                                              ],
                                                            )
                                                          : Container(
                                                              width: 0,
                                                            ),
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
                            Divider(
                              height: 0,
                            ),
                            //here Review
                            Container(
                              margin: EdgeInsetsDirectional.only(bottom: 30),
                              decoration: BoxDecoration(
                                color: Reviewisexpansion == false
                                    ? Colors.white
                                    : Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(25),
                                    bottomRight: Radius.circular(25)),
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
                                        " (${providersReview!.length})",
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
                                                                          initialRating:
                                                                              double.parse(providerDetail!.avgRating!),
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
                                            ...providersReview!.map((e) {
                                              return Column(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadiusDirectional
                                                                .all(Radius
                                                                    .circular(
                                                                        25))
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
                                                                      false,
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
                    Padding(
                      padding: const EdgeInsetsDirectional.only(bottom: 10),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            providerDetail?.facebook != null &&
                                    providerDetail?.facebook != ""
                                ? CustomContact(
                                    onTap: () {
                                      launchUrl(Uri.parse(
                                          "${providerDetail?.facebook}"));
                                    },
                                    child: Icon(
                                      Icons.facebook_outlined,
                                      color: Colors.white,
                                    ),
                                  )
                                : Container(
                                    width: 0,
                                  ),
                            providerDetail?.tiktok != null &&
                                    providerDetail?.tiktok != ""
                                ? CustomContact(
                                    onTap: () {
                                      launchUrl(Uri.parse(
                                          "${providerDetail?.tiktok}"));
                                    },
                                    child: Icon(
                                      Icons.tiktok_outlined,
                                      color: Colors.white,
                                    ),
                                  )
                                : Container(
                                    width: 0,
                                  ),
                            providerDetail?.snapchat != null &&
                                    providerDetail?.snapchat != ""
                                ? CustomContact(
                                    onTap: () {
                                      launchUrl(Uri.parse(
                                          "${providerDetail?.snapchat}"));
                                    },
                                    child: Icon(
                                      Icons.snapchat_outlined,
                                      color: Colors.white,
                                    ),
                                  )
                                : Container(
                                    width: 0,
                                  ),
                            providerDetail?.website != null &&
                                    providerDetail?.website != ""
                                ? CustomContact(
                                    onTap: () {
                                      launchUrl(Uri.parse(
                                          "${providerDetail?.website}"));
                                    },
                                    child: Icon(
                                      Icons.public_outlined,
                                      color: Colors.white,
                                    ),
                                  )
                                : Container(width: 0),
                            // providerDetail?.linkedIn != null &&
                            //         providerDetail?.linkedIn != ""
                            //     ? CustomContact(
                            //         onTap: () {
                            //           launchUrl(Uri.parse(
                            //               "${providerDetail?.linkedIn}"));
                            //         },
                            //         child: Icon(
                            //           Icons.link_off_outlined,
                            //           color: Colors.white,
                            //         ),
                            //       )
                            //     : Container(
                            //         width: 0,
                            //       ),
                            providerDetail?.twitter != null &&
                                    providerDetail?.twitter != ""
                                ? CustomContact(
                                    onTap: () {
                                      launchUrl(Uri.parse(
                                          "${providerDetail?.twitter}"));
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                  )
                                : Container(
                                    width: 0,
                                  ),
                            providerDetail?.instagram != null &&
                                    providerDetail?.instagram != ""
                                ? CustomContact(
                                    onTap: () {
                                      launchUrl(Uri.parse(
                                          "${providerDetail?.instagram}"));
                                    },
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      color: Colors.white,
                                    ),
                                  )
                                : Container(
                                    width: 0,
                                  ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

class CustomContact extends StatelessWidget {
  Widget? child;
  void Function()? onTap;
  ImageProvider<Object>? backgroundImage;
  CustomContact({this.child, this.backgroundImage, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: CircleAvatar(
          backgroundImage: backgroundImage,
          backgroundColor: CustomColors.primarycolor,
          child: child,
          radius: 20,
        ),
      ),
    );
  }
}

// class MyCustomBottomShett extends StatefulWidget {
//   const MyCustomBottomShett({super.key});

//   @override
//   State<MyCustomBottomShett> createState() => _MyCustomBottomShettState();
// }

// class _MyCustomBottomShettState extends State<MyCustomBottomShett> {
//   String? selected = "";
//   // List<S2Choice<String>> category_item = [
//   //   S2Choice(value: "1", title: "category1"),
//   //   S2Choice(value: "2", title: "category2"),
//   //   S2Choice(value: "3", title: "category3"),
//   // ];
//   int? selected_rating;

//   RangeValues values = const RangeValues(0, 4);
//   void selectrating(int rating) {
//     setState(() {
//       selected_rating = rating;
//     });
//   }

//   void change_range_slider(var newvalues) {
//     setState(() {
//       values = newvalues;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.85,
//       padding: const EdgeInsetsDirectional.all(8),
//       decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//               topRight: Radius.circular(10), topLeft: Radius.circular(10))),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: const Icon(Icons.close))
//               ],
//             ),
//             Text(
//               S.of(context).search,
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             TextFormField(
//               decoration: InputDecoration(
//                   contentPadding: const EdgeInsetsDirectional.symmetric(
//                       vertical: 10, horizontal: 10),
//                   hintText: S.of(context).search_for_product,
//                   enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.grey.shade300)),
//                   focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.grey.shade300))),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: Text(S.of(context).reset_filtter),
//                   style: ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10)),
//                       side: const BorderSide(color: CustomColors.thirdcolor),
//                       minimumSize: const Size(100, 50),
//                       padding: const EdgeInsetsDirectional.all(5),
//                       primary: CustomColors.thirdcolor),
//                 ),
//                 const SizedBox(
//                   width: 20,
//                 ),
//                 OutlinedButton(
//                   onPressed: () {},
//                   style: OutlinedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10)),
//                     backgroundColor: CustomColors.primarycolor,
//                     minimumSize: const Size(100, 50),
//                     padding: const EdgeInsetsDirectional.all(5),
//                   ),
//                   child: Text(
//                     S.of(context).apply_filtter,
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
