import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';

import 'package:marquee/marquee.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:redeem/app_storage.dart';
import 'package:redeem/core/function/notification_state_controller.dart';
import 'package:redeem/custom_widget/CustomAppBar.dart';
import 'package:redeem/custom_widget/Custom_Coupon_Flash_Deal.dart';
import 'package:redeem/custom_widget/Custom_offers.dart';
import 'package:redeem/custom_widget/custom_back_button.dart';
import 'package:redeem/custom_widget/custom_carousel_items.dart';
import 'package:redeem/custom_widget/custom_coupon.dart';
import 'package:redeem/custom_widget/custom_drawer.dart';
import 'package:redeem/custom_widget/custom_preloader.dart';
import 'package:redeem/events.dart';
import 'package:redeem/generated/l10n.dart';
import 'package:redeem/json_db/enum.dart';
import 'package:redeem/json_db/json_db.dart';
import 'package:redeem/json_db/utils.dart';
import 'package:redeem/screens/List_coupons_page/List_coupons_page.dart';
import 'package:redeem/screens/Notifications/notifications.dart';
import 'package:redeem/screens/SearchPage/search_page.dart';
import 'package:redeem/screens/Test/test.dart';
import 'package:redeem/screens/all%20offers/all_offers.dart';
import 'package:redeem/screens/cart_screen/cart_screen.dart';
import 'package:redeem/screens/caterory%20Details/category_details.dart';
import 'package:redeem/screens/details_coupon/details_coupon.dart';
import 'package:redeem/screens/details_screen_of_providers/details_screen_of_providers.dart';

import 'package:redeem/screens/home_screen/home_screen_controller.dart';
import 'package:redeem/screens/main_screen/main_screen.dart';
import 'package:redeem/screens/offer_details/offer_details.dart';
import 'package:redeem/screens/providers/providers.dart';
import 'package:redeem/screens/subscription_package/subscription_package.dart';
import 'package:redeem/size_config.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';
import 'package:redeem/globals.dart' as globals;
import 'package:svg_flutter/svg.dart';

//HomeScreen
// ignore: use_key_in_widget_constructors
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  FocusNode focusNode = FocusNode();
  TextEditingController searchController = TextEditingController();

  int CityId = 0;
  HomeData? homeData;
  bool loading = true;
  late var type;
  int currentpage = 0;

  void setcity(int cityid) async {
    CityId = cityid;
    dismissPreLoader(context);
    // setState(() {});
    if (CityId != 0) {
      globals.cityId = CityId;
      appStorage().setCityId(CityId);
      // setState(() {});

      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return const MainScreen();
      }));
    }
  }

  void onpagechanged(int page) {
    currentpage = page;
    setState(() {});
  }

  Future<void> getData() async {
    // try {
    await JsonDb().getHomeDataCollections().then((res) {
      if (res.success) {
        homeData = res.data;
        globals.categories = homeData!.listCategory!;

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

  void getCartData() async {
    // try {
    await JsonDb().getCartDataCollections("0", "true").then((res) {
      if (res.success) {
        globals.countcart = res.data.countCart!;

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

  late StreamSubscription? stream;
/*   @override
  void dispose() {
    if (stream != null) {
      stream!.cancel();
    }
    super.dispose();
  } */

  @override
  void initState() {
    super.initState();
    stream = eventBus.on<AppEvents>().listen((AppEvents event) {
      if (event.key_event == "change_cart_count") {
        setState(() {});
      }
    });
    print("init home page");
    getData();
    getCartData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    SizeConfig().init(context);
    return Scaffold(
      drawer: CustomDrawer(
        cities: globals.cities,
        choiselangitem: globals.Language2,
      ),
      backgroundColor: CustomColors.backgroundcolor_for_Ticket,
      appBar: CustomAppBar(
        leadingWidth: 0,
        leading: Container(
          width: 0,
        ),
        iconTheme: IconThemeData(
          color: CustomColors.primarycolor,
        ),
        shape: const BorderDirectional(
            top: BorderSide(width: 3, color: Colors.red)),
        elevation: 0,
        backgroundColor: CustomColors.backgroundcolor_for_Ticket,
        actions: [
          Row(
            children: [
              SizedBox(
                width: 38,
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const Notifications();
                      }));
                    },
                    icon: Icon(
                      Icons.notifications_outlined,
                      color: CustomColors.primarycolor,
                    )),
              ),
              /*  SizedBox(
                width: 5,
              ), */
              Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    width: 38,
                    child: IconButton(
                      onPressed: () {
                        globals.isLogin == true
                            ? Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                                return CartScreen();
                              }))
                            : showNeedLoginDialog(context);
                      },
                      icon: Icon(
                        Icons.shopping_cart_outlined,
                        color: CustomColors.primarycolor,
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    start: 0,
                    top: 3,
                    child: globals.countcart == 0 || globals.isLogin == false
                        ? Container()
                        : CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.red,
                            child: Center(
                              child: Text(
                                "${globals.countcart}",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
              Builder(builder: (context) {
                return SizedBox(
                  width: 38,
                  child: IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Icon(
                      Icons.more_vert,
                      color: CustomColors.primarycolor,
                    ),
                  ),
                );
              })
            ],
          )
        ],
        title: SizedBox(
          width: 100,
          child: SvgPicture.asset("assets/images/logo-text-redeem-blue.svg"),
        ),
      ),
      body: loading == true
          ? const CustomPreloader()
          : SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  await getData();
                },
                child: ListView(children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                        end: globals.end_padding_17,
                        start: globals.start_padding_17,
                        bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return SearchPage(
                                  SearchType: "",
                                );
                              }));
                            },
                            child: Container(
                              padding: EdgeInsetsDirectional.only(start: 10),
                              height: 45,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      bottomLeft: Radius.circular(25))),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.search,
                                    color: Colors.black,
                                  ),
                                  Text(S.of(context).search)
                                ],
                              ),
                              //  TextFormField(
                              //   focusNode: focusNode,
                              //   controller: searchController,
                              //   // autofocus: true,
                              //   // onEditingComplete: () async {
                              //   //   if (searchController.value.text != "") {
                              //   //     focusNode.unfocus();
                              //   //     showPreLoader(context);
                              //   //     await getFinalSearchData();
                              //   //     dismissPreLoader(context);

                              //   //     isSearch = "search";
                              //   //     setState(() {});
                              //   //   } else {
                              //   //     focusNode.unfocus();
                              //   //   }
                              //   // },

                              //   decoration: InputDecoration(
                              //     prefixIcon: Icon(
                              //       Icons.search,
                              //       color: Colors.black,
                              //     ),
                              //     contentPadding:
                              //         const EdgeInsetsDirectional.symmetric(
                              //             vertical: 14, horizontal: 5),
                              //     hintText: S.of(context).search,
                              //     hintStyle: CustomTheme.text_grey15theme
                              //         .copyWith(
                              //             fontWeight: FontWeight.normal,
                              //             color: Colors.grey),
                              //     enabledBorder: OutlineInputBorder(
                              //         borderRadius: BorderRadius.only(
                              //             topLeft: Radius.circular(25),
                              //             bottomLeft: Radius.circular(25)),
                              //         borderSide:
                              //             BorderSide(color: Colors.white)),
                              //     focusedBorder: OutlineInputBorder(
                              //         borderRadius: BorderRadius.only(
                              //             topLeft: Radius.circular(25),
                              //             bottomLeft: Radius.circular(25)),
                              //         borderSide:
                              //             BorderSide(color: Colors.white)),
                              //     filled: true,
                              //     fillColor: Colors.white,
                              //     // border: OutlineInputBorder(
                              //     //   borderRadius: BorderRadius.circular(10),
                              //     // )
                              //   ),
                              //   onChanged: (value) async {
                              //     // if (value.length > 2) {
                              //     //   searchloading = true;
                              //     //   setState(() {});
                              //     //   // showPreLoader(context);
                              //     //   await getData();
                              //     //   //  dismissPreLoader(context);
                              //     //   isSearch = "true";
                              //     // }

                              //     // checkSearch(value);
                              //   },
                              //   onSaved: (newValue) {},
                              // ),
                            ),
                          ),
                        ),
                        Container(
                          height: 45,
                          color: Colors.white,
                          child: Center(
                              child: Container(
                            width: 1,
                            height: 30,
                            color: Colors.grey.shade300,
                          )),
                        ),
                        Expanded(
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(25),
                                    bottomRight: Radius.circular(25))),
                            child: Row(
                              children: [
                                Icon(Icons.location_on_outlined),
                                const SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 70,
                                  child: SmartSelect<int>.single(
                                    choiceActiveStyle: const S2ChoiceStyle(
                                      color: CustomColors.primarycolor,
                                      accentColor: Colors.white,
                                    ),
                                    selectedValue: globals.cityId,
                                    title: "",
                                    tileBuilder: (context, value) {
                                      return InkWell(
                                        onTap: () {
                                          value.showModal();
                                        },
                                        child: value.selected.title != null
                                            ? Text(
                                                value.selected.title!,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              )
                                            : Container(),
                                      );
                                    },
                                    modalHeaderStyle: S2ModalHeaderStyle(
                                        iconTheme: IconThemeData(
                                            color: CustomColors.primarycolor),
                                        textStyle: TextStyle(
                                            color: CustomColors.primarycolor),
                                        backgroundColor: CustomColors
                                            .backgroundcolor_for_Ticket),
                                    choiceStyle: const S2ChoiceStyle(
                                        color: CustomColors.primarycolor),
                                    placeholder: "",
                                    choiceItems: [
                                      ...globals.cities.map((e) => S2Choice(
                                          title: e.getPropertyEffectedByLang(
                                              "name_${globals.SelectedLang}"),
                                          value: e.id!))
                                    ],
                                    onChange: (res) {
                                      showPreLoader(context);
                                      setcity(res.value);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    /*  clipBehavior: Clip.hardEdge,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)), */
                    margin:
                        EdgeInsetsDirectional.only(top: globals.end_padding),
                    // margin:
                    //     const EdgeInsetsDirectional.symmetric(horizontal: 5),
                    child: CarouselSlider.builder(
                      itemCount: homeData!.listBanners!.length,
                      options: CarouselOptions(
                        reverse: false,
                        autoPlayAnimationDuration: const Duration(seconds: 2),
                        viewportFraction: 1,
                        autoPlay: true,
                        animateToClosest: true,
                        height: responsive_size(210),
                      ),
                      itemBuilder: ((context, index, realIndex) {
                        return GestureDetector(
                          onTap: () {
                            /*    PageController? _pageController =
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
                                                pageController: _pageController,
                                                itemCount:
                                                    homeData!.listBanners!.length,
                                                builder: (context, index) {
                                                  return PhotoViewGalleryPageOptions(
                                                      imageProvider: NetworkImage(
                                                          "${homeData!.listBanners![index].mobilePhoto}"));
                                                })),
                                      ],
                                    ),
                                  );
                                });
                           */
                          },
                          child: Container(
                            margin: EdgeInsetsDirectional.symmetric(
                                horizontal: globals.end_padding_17),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "${homeData!.listBanners![index].photo}"),
                                    fit: BoxFit.cover)),
                          ),
                        );
                      }),
                    ),
                  ),
                  globals.isLogin == true
                      ? Container(
                          margin: EdgeInsetsDirectional.only(
                              start: globals.start_padding_17,
                              end: globals.end_padding_17,
                              bottom: 20,
                              top: 20),
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                          decoration: BoxDecoration(
                              color: CustomColors.primarycolor,
                              borderRadius: BorderRadius.circular(15)),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            S.of(context).hello,
                                            style: const TextStyle(
                                                color: CustomColors.titlecolor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            "${globals.customer!.firstName}",
                                            style: const TextStyle(
                                                color: CustomColors.titlecolor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      /*    const Text(
                                        " RS 0 قيمة التوفير لغاية الأن  ",
                                        style: TextStyle(
                                            color: CustomColors.titlecolor,
                                            fontWeight: FontWeight.bold),
                                      ), */
                                    ],
                                  ),
                                  const Spacer(),
                                  const CircleAvatar(
                                    child: Icon(
                                      Icons.person_2_outlined,
                                      color: CustomColors.primarycolor,
                                    ),
                                    backgroundColor: Colors.white,
                                  ),
                                ],
                              ),
                              // if (globals.CurrentSubscribePackage == 1 ||
                              //     globals.CurrentSubscribePackage == 2 ||
                              //     globals.CurrentSubscribePackage == 3)
                              //   Row(
                              //     children: [
                              //       ElevatedButton(
                              //           style: ElevatedButton.styleFrom(
                              //               primary:
                              //                   CustomColors.secondarycolor,
                              //               shape: RoundedRectangleBorder(
                              //                   borderRadius:
                              //                       BorderRadius.circular(20))),
                              //           onPressed: () {
                              //             Navigator.of(context).push(
                              //                 MaterialPageRoute(
                              //                     builder: (context) {
                              //               return const SubsriptionPackage();
                              //             }));
                              //           },
                              //           child: Text(S.of(context).Upgrade)),
                              //       const Spacer()
                              //     ],
                              //   ),
                              Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsetsDirectional.only(
                                        top: 5),
                                    width: double.infinity,
                                    alignment: AlignmentDirectional.topStart,
                                    child: FractionallySizedBox(
                                        widthFactor: (homeData!.balance! /
                                                    homeData!.goal_points!) <
                                                0.2
                                            ? 0.2
                                            : homeData!.balance! /
                                                homeData!.goal_points!,
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional.topEnd,
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Container(
                                                width: 100,
                                                height: 19,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  homeData!.balance!.toString(),
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    20),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    20),
                                                            topRight:
                                                                Radius.circular(
                                                                    20),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    20))),
                                              ),
                                              Positioned(
                                                bottom: -12.1,
                                                left: 20,
                                                child: Transform.rotate(
                                                    angle: -185.3,
                                                    child: const Icon(
                                                      Icons.eject,
                                                      color: Colors.white,
                                                      size: 20,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    clipBehavior: Clip.none,
                                    margin: const EdgeInsets.only(
                                        bottom: 5, top: 12),
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        FractionallySizedBox(
                                          widthFactor: 1,
                                          child: Container(
                                              padding: const EdgeInsets.all(1),
                                              height: 10,
                                              width: double.infinity,
                                              color: Colors.white
                                                  .withOpacity(0.6)),
                                        ),
                                        FractionallySizedBox(
                                          widthFactor: 0.7,
                                          child: Container(
                                              padding: const EdgeInsets.all(1),
                                              height: 10,
                                              width: double.infinity,
                                              color: CustomColors.secondarycolor
                                                  .withOpacity(0.6)),
                                        ),
                                        FractionallySizedBox(
                                          widthFactor: (homeData!.balance! /
                                              homeData!.goal_points!),
                                          // widthFactor:1 /
                                          //     homeData!.goal_points!,
                                          child: Container(
                                            padding: const EdgeInsets.all(1),
                                            height: 10,
                                            width: double.infinity,
                                            color:
                                                Colors.white.withOpacity(0.6),
                                            // child: Text(
                                            //   "${homeData!.balance} ${S.of(context).points}",
                                            //   textAlign: TextAlign.center,
                                            //   style: const TextStyle(
                                            //       color: CustomColors
                                            //           .primarycolor,
                                            //       fontSize: 11),
                                            // )
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Spacer(),
                                      Text(
                                        S.of(context).AVG_Saving +
                                            " : ${homeData!.goal_points ?? 0} ${S.of(context).S_R}",
                                        style: const TextStyle(
                                            color: Colors.yellow, fontSize: 13),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      : Container(),
                  homeData!.listCategory!.isNotEmpty
                      ? Container(
                          padding: EdgeInsetsDirectional.only(
                              start: globals.start_padding_17,
                              end: globals.end_padding_17,
                              bottom: 10,
                              top: 10),
                          child: Row(
                            children: [
                              Text(
                                S.of(context).category,
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: CustomColors.primarycolor,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              // TextButton(
                              //   style: TextButton.styleFrom(
                              //       padding: const EdgeInsets.all(0)),
                              //   onPressed: () {
                              //     // Navigator.of(context)
                              //     //     .push(MaterialPageRoute(builder: (context) {
                              //     //   return ListCouponsPage();
                              //     // }));
                              //   },
                              //   child: Wrap(
                              //     crossAxisAlignment: WrapCrossAlignment.center,
                              //     children: [
                              //       Text(
                              //         S.of(context).see_all,
                              //         style: const TextStyle(
                              //             color: CustomColors.primarycolor,
                              //             fontWeight: FontWeight.bold),
                              //       ),
                              //       const Icon(
                              //         Icons.arrow_right,
                              //         size: 30,
                              //         color: CustomColors.primarycolor,
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        )
                      : Container(
                          width: 0,
                        ),
                  Container(
                    height: 50,
                    margin: EdgeInsetsDirectional.only(bottom: 5),
                    padding: EdgeInsetsDirectional.only(
                        start: globals.start_padding_17),
                    width: double.infinity,
                    child: ListView.builder(
                        itemCount: homeData!.listCategory!.length,
                        padding:
                            const EdgeInsetsDirectional.symmetric(vertical: 5),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsetsDirectional.only(end: 5),
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return CategortDetails(
                                      category_id:
                                          homeData!.listCategory![index].id,
                                      Category_name: homeData!
                                          .listCategory![index]
                                          .getPropertyEffectedByLang(
                                              "name_${globals.SelectedLang}"),
                                      Category_icon:
                                          homeData!.listCategory![index].icon,
                                      color: Color(
                                        int.parse(
                                          "0XFF" +
                                              homeData!
                                                  .listCategory![index].color!
                                                  .replaceAll("#", ""),
                                        ),
                                      ),
                                    );
                                  }));
                                },
                                child: Container(
                                  padding: EdgeInsetsDirectional.symmetric(
                                      horizontal: 13, vertical: 5),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(1.5, 1.5),
                                            spreadRadius: 0.4,
                                            blurStyle: BlurStyle.outer,
                                            blurRadius: 1,
                                            color: Colors.grey.shade300)
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 25,
                                        height: 25,
                                        child: SvgPicture.network(
                                          "${homeData!.listCategory![index].icon}",
                                          fit: BoxFit.cover,
                                          width: 30,
                                          height: 30,
                                          color: Color(
                                            int.parse(
                                              "0XFF" +
                                                  homeData!.listCategory![index]
                                                      .color!
                                                      .replaceAll("#", ""),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "${homeData?.listCategory?[index].getPropertyEffectedByLang("name_${globals.SelectedLang}")}",
                                        style: TextStyle(
                                          color: Color(
                                            int.parse(
                                              "0XFF" +
                                                  homeData!.listCategory![index]
                                                      .color!
                                                      .replaceAll("#", ""),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                          );
                        }),
                  ),

                  homeData!.listFlashDeal!.isNotEmpty
                      ? Container(
                          padding: EdgeInsetsDirectional.only(
                              start: globals.start_padding_17,
                              end: globals.end_padding_17,
                              bottom: 10),
                          child: Row(
                            children: [
                              Text(
                                S.of(context).flashdeals,
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: CustomColors.primarycolor,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              // TextButton(
                              //   style: TextButton.styleFrom(
                              //       padding: const EdgeInsets.all(0)),
                              //   onPressed: () {
                              //     // Navigator.of(context)
                              //     //     .push(MaterialPageRoute(builder: (context) {
                              //     //   return ListCouponsPage();
                              //     // }));
                              //   },
                              //   child: Wrap(
                              //     crossAxisAlignment: WrapCrossAlignment.center,
                              //     children: [
                              //       Text(
                              //         S.of(context).see_all,
                              //         style: const TextStyle(
                              //             color: CustomColors.primarycolor,
                              //             fontWeight: FontWeight.bold),
                              //       ),
                              //       const Icon(
                              //         Icons.arrow_right,
                              //         size: 30,
                              //         color: CustomColors.primarycolor,
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        )
                      : Container(),
                  // loading == true
                  //     ? CustomPreloader()
                  //     :
                  homeData!.listFlashDeal!.isNotEmpty
                      ? Container(
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsetsDirectional.only(
                              start: globals.start_padding_17,
                              end: globals.end_padding_17),
                          child: CarouselSlider.builder(
                            itemCount: homeData!.listFlashDeal!.length,
                            itemBuilder: (context, index, realindex) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return DetailsCoupon(
                                        homeData!.listFlashDeal![index].id);
                                  }));
                                },
                                child: Container(
                                  width: responsive_size(400, asMaxSize: true),
                                  child: CustomCouponFlashDeal(
                                    flashDeal: homeData!.listFlashDeal![index],
                                  ),
                                ),
                              );
                            },
                            options: CarouselOptions(
                              viewportFraction:
                                  responsive_size(400, asMaxSize: true) / MediaQuery.of(context).size.width,
                              autoPlay: true,
                              animateToClosest: true,
                              enlargeCenterPage: true,
                              height: 166.0,
                            ),
                          ),
                        )
                      : Container(),

                  Container(
                    child: Column(
                      children: [
                        ...homeData!.listSections!.map((e) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.only(
                                      start: globals.start_padding_17,
                                      end: globals.end_padding_17),
                                  child: Row(
                                    children: [
                                      Text(
                                        "${e.getPropertyEffectedByLang("name_${globals.SelectedLang}")}",
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: CustomColors.primarycolor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Spacer(),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                            padding: const EdgeInsets.all(0)),
                                        onPressed: () {
                                          e.type == "coupons"
                                              ? Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                  return ListCouponsPage();
                                                }))
                                              : Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                  return AllOffers();
                                                }));
                                        },
                                        child: Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: [
                                            Text(
                                              S.of(context).see_all,
                                              style: const TextStyle(
                                                  color:
                                                      CustomColors.primarycolor,
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
                                    ],
                                  ),
                                ),
                                e.type == "coupons"
                                    ? Container(
                                        width: double.infinity,
                                        height: 240,
                                        padding: EdgeInsetsDirectional.only(
                                            start: globals.start_padding_17),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              ...homeData!.listSections!
                                                  .map((e) {
                                                return ListView.builder(
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: e
                                                        .listsimpleCoupon!
                                                        .length,
                                                    itemBuilder: (context, i) {
                                                      return GestureDetector(
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .push(MaterialPageRoute(
                                                                    builder:
                                                                        (context) {
                                                              return DetailsCoupon(e
                                                                  .listsimpleCoupon![
                                                                      i]
                                                                  .id);
                                                            }));
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                        .only(
                                                                    end: 6),
                                                            child: SizedBox(
                                                              width: 170,
                                                              child: e.listsimpleCoupon!
                                                                      .isNotEmpty
                                                                  ? CustomCoupon(
                                                                      simpleCoupon:
                                                                          e.listsimpleCoupon![
                                                                              i],
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
                                            ...homeData!.listSections!.map((e) {
                                              return ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount:
                                                      e.listsimpleOffer!.length,
                                                  itemBuilder: (context, i) {
                                                    return GestureDetector(
                                                        onTap: () {
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                            return OfferDetails(
                                                              offerid: e
                                                                  .listsimpleOffer![
                                                                      i]
                                                                  .id,
                                                            );
                                                          }));
                                                        },
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.only(
                                                              start: globals
                                                                  .start_padding_17,
                                                              end: globals
                                                                  .end_padding_17),
                                                          child: SizedBox(
                                                            width: 170,
                                                            child: e.listsimpleOffer!
                                                                    .isNotEmpty
                                                                ? Container(
                                                                    margin: const EdgeInsetsDirectional
                                                                            .only(
                                                                        bottom:
                                                                            5),
                                                                    child:
                                                                        CustomOffers(
                                                                      simpleOffer:
                                                                          e.listsimpleOffer![
                                                                              i],
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

                  homeData!.listBestcoupon!.isNotEmpty
                      ? Padding(
                          padding: EdgeInsetsDirectional.only(
                              start: globals.start_padding,
                              end: globals.end_padding),
                          child: Row(
                            children: [
                              Text(
                                S.of(context).coupons,
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: CustomColors.primarycolor,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              TextButton(
                                style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(0)),
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return ListCouponsPage();
                                  }));
                                },
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Text(
                                      S.of(context).see_all,
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
                            ],
                          ),
                        )
                      : Container(),
                  // loading == true
                  //     ? const CustomPreloader()
                  //     :
                  homeData!.listBestcoupon!.isNotEmpty
                      ? Container(
                          padding: EdgeInsetsDirectional.only(
                              start: globals.start_padding),
                          width: double.infinity,
                          height: 243,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: homeData!.listBestcoupon!.length,
                            itemBuilder: ((context, index) {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return DetailsCoupon(
                                          homeData!.listBestcoupon![index].id);
                                    }));
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.symmetric(
                                            horizontal: 10),
                                    child: SizedBox(
                                      width: 170,
                                      child: CustomCoupon(
                                        simpleCoupon:
                                            homeData!.listBestcoupon![index],
                                      ),
                                    ),
                                  ));
                            }),
                          ),
                        )
                      : Container(),
                  homeData!.listBestoffer!.isNotEmpty
                      ? Padding(
                          padding: EdgeInsetsDirectional.only(
                              start: globals.start_padding_17,
                              end: globals.end_padding_17),
                          child: Row(
                            children: [
                              Text(
                                S.of(context).offers,
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: CustomColors.primarycolor,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              TextButton(
                                style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(0)),
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return AllOffers();
                                  }));
                                },
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Text(
                                      S.of(context).see_all,
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
                            ],
                          ),
                        )
                      : Container(),
                  homeData!.listBestoffer!.isNotEmpty
                      ? Container(
                          padding: EdgeInsetsDirectional.only(
                              start: globals.start_padding_17),
                          margin: const EdgeInsetsDirectional.only(bottom: 8),
                          child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 600,
                                mainAxisExtent: 127,
                                mainAxisSpacing: 20,
                                //  crossAxisSpacing: 20,
                              ),
                              itemCount: homeData!.listBestoffer!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsetsDirectional.symmetric(
                                          horizontal: 8),
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return OfferDetails(
                                            offerid: homeData!
                                                .listBestoffer![index].id,
                                          );
                                        }));
                                      },
                                      child: CustomOffers(
                                        simpleOffer:
                                            homeData!.listBestoffer![index],
                                        // imageurl:
                                        //     "${homeData!.listBestoffer![index].image}",
                                        // name:
                                        //     "${homeData!.listBestoffer![index].getPropertyEffectedByLang("name_${globals.SelectedLang}")}",
                                        // logourl:
                                        //     "${homeData!.listBestoffer![index].simpleProvider!.logo}",
                                        // content:
                                        //     "${homeData!.listBestoffer![index].slug}",
                                      )),
                                );
                              }),
                        )
                      : Container(),

                  homeData!.listBestprovider!.isNotEmpty
                      ? Padding(
                          padding: EdgeInsetsDirectional.only(
                              start: globals.start_padding_17,
                              end: globals.end_padding_17),
                          child: Row(
                            children: [
                              Text(
                                S.of(context).providers,
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: CustomColors.primarycolor,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              TextButton(
                                style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(0)),
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return const Providers();
                                  }));
                                },
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Text(
                                      S.of(context).see_all,
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
                            ],
                          ),
                        )
                      : Container(),

                  homeData!.listBestprovider!.isNotEmpty
                      ? Container(
                          width: double.infinity,
                          height: 60,
                          margin: const EdgeInsetsDirectional.only(bottom: 30),
                          padding: EdgeInsetsDirectional.only(
                              start: globals.start_padding_17,
                              end: globals.start_padding_17),
                          child: CarouselSlider.builder(
                            itemCount: homeData!.listBestprovider!.length,
                            options: CarouselOptions(
                              reverse: false,
                              enableInfiniteScroll: true,
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 500),
                              autoPlayInterval:
                                  const Duration(milliseconds: 1000),
                              viewportFraction:
                                  80 / MediaQuery.of(context).size.width,
                              disableCenter: false,
                              autoPlay: true,
                              enlargeCenterPage: true,
                              animateToClosest: true,
                              height: responsive_size(240),
                            ),
                            itemBuilder: ((context, index, realIndex) {
                              return Container(
                                margin: const EdgeInsetsDirectional.symmetric(
                                    horizontal: 8),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return DetailsScreenOfProviders(
                                            id: homeData!
                                                .listBestprovider![index].id,
                                          );
                                        }));
                                      },
                                      child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 30,
                                          backgroundImage: NetworkImage(
                                              "${homeData!.listBestprovider![index].logo}")),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          )

                          /* ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: homeData!.listBestprovider!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsetsDirectional.symmetric(
                                      horizontal: 8),
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return DetailsScreenOfProviders(
                                              id: homeData!
                                                  .listBestprovider![index].id,
                                            );
                                          }));
                                        },
                                        child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 30,
                                            backgroundImage: NetworkImage(
                                                "${homeData!.listBestprovider![index].logo}")),
                                      ),
                                    ],
                                  ),
                                );
                              }),*/
                          )
                      : Container(),
                ]),
              ),
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
