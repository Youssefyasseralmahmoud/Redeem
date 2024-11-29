import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:redeem/app_storage.dart';
import 'package:redeem/custom_widget/CustomAppBar.dart';
import 'package:redeem/custom_widget/CustomMyCoupons.dart';
import 'package:redeem/custom_widget/CustomSearchedCoupons.dart';
import 'package:redeem/custom_widget/Custom_offers.dart';
import 'package:redeem/custom_widget/custom_back_button.dart';
import 'package:redeem/custom_widget/custom_coupon.dart';
import 'package:redeem/custom_widget/custom_preloader.dart';
import 'package:redeem/generated/l10n.dart';
import 'package:redeem/json_db/enum.dart';
import 'package:redeem/json_db/infinite_grid.dart';
import 'package:redeem/json_db/json_db.dart';
import 'package:redeem/json_db/utils.dart';
import 'package:redeem/screens/details_coupon/details_coupon.dart';
import 'package:redeem/screens/details_screen_of_providers/details_screen_of_providers.dart';
import 'package:redeem/screens/offer_details/offer_details.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';
import 'package:redeem/globals.dart' as globals;
import 'package:svg_flutter/svg.dart';

class SearchPage extends StatefulWidget {
  String SearchType = "";
  SearchPage({required this.SearchType});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TabController? controller;
  String isSearch = "false";
  bool loading = true;
  bool finalsearchloading = true;
  bool searchloading = false;
  SearchData? searchData;
  //FinalSearchData? finalseachData;
  TextEditingController searchController = TextEditingController();
  ScrollController CouponsscrollController = ScrollController();
  ScrollController OffersscrollController = ScrollController();
  ScrollController ProvidersscrollController = ScrollController();

  FocusNode focusNode = FocusNode();
  int totalCouonsResults = 0;
  int? nextCouponsPage;
  int totalProvidersResults = 0;
  int? nextProvidersPage;
  int totalOffersResults = 0;
  int? nextOffersPage;
  int CityId = 0;
  List<SimpleCoupon> coupons = [];
  List<SimpleProvider> providers = [];
  List<SimpleOffer> offers = [];
  void checkSearch(val) {
    if (val == "") {
      isSearch = "false";
    }
    setState(() {});
  }

  void onSearch() {
    isSearch = "search";
    setState(() {});
  }

  void setcity(int cityid) async {
    CityId = cityid;
    dismissPreLoader(context);

    if (CityId != 0) {
      globals.cityId = CityId;
      appStorage().setCityId(CityId);

      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      //   return const MainScreen();
      // }));

      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        CustomTheme.CustomSnackBar(S.of(context).city_is_changed, "success"),
      );
    }
  }

  Future<void> getData() async {
    // try {
    await JsonDb()
        .getSearchDataCollections(searchController.value.text)
        .then((res) {
      if (res.success) {
        searchData = res.data;
        searchloading = false;

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

  Future<void> getFinalSearchData({page = 1, String forLoadMore = ""}) async {
    // try {
    await JsonDb()
        .getFinalSearchReaulDataCollections(
            searchController.value.text, forLoadMore)
        .then((res) {
      if (res.success) {
        nextCouponsPage = res.data!.SearchedCoupon!.nextPage;
        nextOffersPage = res.data!.Searchedoffer!.nextPage;
        nextProvidersPage = res.data!.Searchedprovider!.nextPage;
        if (page == 1) {
          totalCouonsResults = res.data!.SearchedCoupon!.totalResults!;
          coupons = res.data!.SearchedCoupon!.listSimpleCoupons!;
        } else if (page > 1) {
          var Coupon = res.data!.SearchedCoupon!.listSimpleCoupons!;
          Coupon.forEach((element) {
            coupons.add(element);
          });
        }
        if (page == 1) {
          totalOffersResults = res.data!.Searchedoffer!.totalResults!;
          offers = res.data!.Searchedoffer!.listSimpleOffer!;
        } else if (page > 1) {
          var offer = res.data!.Searchedoffer!.listSimpleOffer!;
          offer.forEach((element) {
            offers.add(element);
          });
        }
        if (page == 1) {
          totalProvidersResults = res.data!.Searchedprovider!.totalResults!;
          providers = res.data!.Searchedprovider!.listSimpleProvider!;
        } else if (page > 1) {
          var provider = res.data!.Searchedprovider!.listSimpleProvider!;
          provider.forEach((element) {
            providers.add(element);
          });
        }

        finalsearchloading = false;

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          // leading: CustomBackButton(),
          shape: const BorderDirectional(
              top: BorderSide(width: 3, color: Colors.red)),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          // actions: [
          //   SizedBox(
          //     width: 142,
          //     child: Center(
          //       child: SmartSelect<int>.single(
          //         choiceActiveStyle:
          //             const S2ChoiceStyle(color: CustomColors.primarycolor),
          //         selectedValue: globals.cityId,
          //         title: "",
          //         modalHeaderStyle: const S2ModalHeaderStyle(
          //             backgroundColor: CustomColors.primarycolor),
          //         choiceStyle:
          //             const S2ChoiceStyle(color: CustomColors.primarycolor),
          //         placeholder: "",
          //         choiceItems: [
          //           ...globals.cities.map((e) => S2Choice(
          //               title: e.getPropertyEffectedByLang(
          //                   "name_${globals.SelectedLang}"),
          //               value: e.id!))
          //         ],
          //         onChange: (res) {
          //           showPreLoader(context);
          //           setcity(res.value);
          //         },
          //       ),
          //     ),
          //   ),
          // ],
          title: Row(
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
                  child: TextFormField(
                    focusNode: focusNode,
                    controller: searchController,
                    autofocus: true,
                    onEditingComplete: () async {
                      if (searchController.value.text != "") {
                        focusNode.unfocus();
                        showPreLoader(context);
                        await getFinalSearchData();
                        dismissPreLoader(context);

                        isSearch = "search";
                        setState(() {});
                      } else {
                        focusNode.unfocus();
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsetsDirectional.symmetric(
                          vertical: 0, horizontal: 10),
                      hintText: S.of(context).search + "...",
                      hintStyle: CustomTheme.text_grey15theme.copyWith(
                          fontWeight: FontWeight.normal, color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(25)),
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(25)),
                          borderSide: BorderSide(color: Colors.white)),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(10),
                      // )
                    ),
                    onChanged: (value) async {
                      if (value.length > 2) {
                        searchloading = true;
                        setState(() {});
                        // showPreLoader(context);
                        await getData();
                        //  dismissPreLoader(context);
                        isSearch = "true";
                      }

                      checkSearch(value);
                    },
                    onSaved: (newValue) {},
                  ),
                ),
              ),
              // Container(
              //   height: 45,
              //   color: Colors.grey.shade200,
              //   child: Center(
              //       child: Container(
              //     width: 1,
              //     height: 30,
              //     color: Colors.white,
              //   )),
              // ),
              Expanded(
                child: Container(
                  height: 46,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      border: Border.all(color: Colors.white),
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
                          modalHeaderStyle: const S2ModalHeaderStyle(
                              backgroundColor: CustomColors.primarycolor),
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
          )

          //  SizedBox(
          //   width: 130,
          //   height: 40,
          //   child: TextFormField(
          //     focusNode: focusNode,
          //     controller: searchController,
          //     autofocus: true,
          //     onEditingComplete: () async {
          //       if (searchController.value.text != "") {
          //         focusNode.unfocus();
          //         showPreLoader(context);
          //         await getFinalSearchData();
          //         dismissPreLoader(context);

          //         isSearch = "search";
          //         setState(() {});
          //       } else {
          //         focusNode.unfocus();
          //       }
          //     },
          //     decoration: InputDecoration(
          //       contentPadding: const EdgeInsetsDirectional.symmetric(
          //           vertical: 5, horizontal: 5),
          //       hintText: S.of(context).search + "...",
          //       hintStyle: CustomTheme.text_grey15theme.copyWith(
          //           fontWeight: FontWeight.normal, color: Colors.grey.shade500),
          //       enabledBorder: OutlineInputBorder(
          //           borderSide: BorderSide(color: Colors.white)),
          //       focusedBorder: OutlineInputBorder(
          //           borderSide: BorderSide(color: Colors.white)),
          //       filled: true,
          //       fillColor: Colors.white,
          //       // border: OutlineInputBorder(
          //       //   borderRadius: BorderRadius.circular(10),
          //       // )
          //     ),
          //     onChanged: (value) async {
          //       if (value.length > 2) {
          //         searchloading = true;
          //         setState(() {});
          //         // showPreLoader(context);
          //         await getData();
          //         //  dismissPreLoader(context);
          //         isSearch = "true";
          //       }

          //       checkSearch(value);
          //     },
          //     onSaved: (newValue) {},
          //   ),
          // ),
          ),
      body: DefaultTabController(
        length: 3,
        // (coupons.isNotEmpty ? 1 : 0) +
        //     (providers.isNotEmpty ? 1 : 0) +
        //     (offers.isNotEmpty ? 1 : 0),
        child: Scaffold(
            backgroundColor: CustomColors.backgroundcolor_for_Ticket,
            appBar: isSearch == "search"
                ? AppBar(
                    toolbarHeight: 10,
                    backgroundColor: Colors.white,
                    elevation: 0,
                    leading: Container(),
                    bottom: coupons.isNotEmpty ||
                            offers.isNotEmpty ||
                            providers.isNotEmpty
                        ? TabBar(
                            dividerColor: CustomColors.primarycolor,
                            indicatorColor: CustomColors.primarycolor,
                            tabs: [
                              // if (coupons.isNotEmpty)
                              Tab(
                                child: Text(
                                  S.of(context).coupons +
                                      " (${coupons.length})",
                                  style: TextStyle(
                                      color: CustomColors.primarycolor,
                                      fontSize: 15),
                                ),
                                // text: S.of(context).coupons +
                                //     " (${coupons.length})",
                              ),
                              //  if (offers.isNotEmpty)
                              Tab(
                                child: Text(
                                  S.of(context).offers + " (${offers.length})",
                                  style: TextStyle(
                                      color: CustomColors.primarycolor,
                                      fontSize: 15),
                                ),

                                // text: S.of(context).offers +
                                //     " (${offers.length})",
                              ),
                              //if (providers.isNotEmpty)
                              Tab(
                                child: Text(
                                  S.of(context).providers +
                                      " (${providers.length})",
                                  style: TextStyle(
                                      color: CustomColors.primarycolor,
                                      fontSize: 15),
                                ),

                                // text: S.of(context).providers +
                                //     " (${providers.length})",
                              ),
                            ],
                          )
                        : null,
                  )
                : null,
            body: isSearch == "true"
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        // isSearch == "true"
                        //     ?
                        Container(
                          width: double.infinity,
                          child: searchloading == true
                              ? Center(
                                  child: Container(
                                    height: 115,
                                    width: 115,
                                    child: Center(
                                        child: Row(
                                      children: [
                                        const SizedBox(
                                            height: 15,
                                            width: 15,
                                            child: CircularProgressIndicator()),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(S.of(context).searching + " ..."),
                                      ],
                                    )),
                                  ),
                                )
                              : SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      searchData!.listdataTag!.isNotEmpty
                                          //   && widget.SearchType == ""
                                          ? Container(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      S.of(context).tags,
                                                      style: CustomTheme
                                                          .text16theme
                                                          .copyWith(
                                                              color: CustomColors
                                                                  .primarycolor),
                                                    ),
                                                    const Divider(),
                                                    Column(
                                                      children: [
                                                        ...searchData!
                                                            .listdataTag!
                                                            .map((e) {
                                                          return ListTile(
                                                            leading: Text(
                                                                "${e.getPropertyEffectedByLang("name_${globals.SelectedLang}")}"),
                                                          );
                                                        }).toList()
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Container(),
                                      searchData!.listDatacoupon!.isNotEmpty
                                          //  &&  widget.SearchType == "coupon"
                                          ? Container(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      S.of(context).coupons,
                                                      style: CustomTheme
                                                          .text16theme
                                                          .copyWith(
                                                              color: CustomColors
                                                                  .primarycolor),
                                                    ),
                                                    const Divider(),
                                                    Column(
                                                      children: [
                                                        ...searchData!
                                                            .listDatacoupon!
                                                            .map((e) {
                                                          return ListTile(
                                                            onTap: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .push(MaterialPageRoute(
                                                                      builder:
                                                                          (context) {
                                                                return DetailsCoupon(
                                                                    e.id);
                                                              }));
                                                            },
                                                            leading: Text(
                                                                "${e.getPropertyEffectedByLang("name_${globals.SelectedLang}")}"),
                                                          );
                                                        }).toList()
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Container(),
                                      searchData!.listDataoffer!.isNotEmpty
                                          //  &&widget.SearchType == "offer"
                                          ? Container(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      S.of(context).offers,
                                                      style: CustomTheme
                                                          .text16theme
                                                          .copyWith(
                                                              color: CustomColors
                                                                  .primarycolor),
                                                    ),
                                                    const Divider(),
                                                    Column(
                                                      children: [
                                                        ...searchData!
                                                            .listDataoffer!
                                                            .map((e) {
                                                          return ListTile(
                                                            onTap: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .push(MaterialPageRoute(
                                                                      builder:
                                                                          (context) {
                                                                return OfferDetails(
                                                                  offerid: e.id,
                                                                );
                                                              }));
                                                            },
                                                            leading: Text(
                                                                "${e.getPropertyEffectedByLang("name_${globals.SelectedLang}")}"),
                                                          );
                                                        }).toList()
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Container()
                                    ],
                                  ),
                                ),
                        )
                      ],
                    ),
                  )
                : isSearch == "search" &&
                        (coupons.isNotEmpty ||
                            offers.isNotEmpty ||
                            providers.isNotEmpty)
                    ? SafeArea(
                        child: TabBarView(
                          controller: controller,
                          children: [
                            // if (coupons.isNotEmpty)
                            SingleChildScrollView(
                              // controller: CouponsscrollController,
                              child: InfiniteGridView(
                                  // withoutDisposeScrool: true,
                                  // forOffice: false,
                                  // controller: CouponsscrollController,
                                  physics: const NeverScrollableScrollPhysics(),
                                  hasNext: coupons.length < totalCouonsResults,
                                  loadingWidget: const Center(
                                      child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(
                                      color: CustomColors.primarycolor,
                                    ),
                                  )),
                                  nextData: () {
                                    if (nextCouponsPage != null) {
                                      getFinalSearchData(
                                          page: nextCouponsPage,
                                          forLoadMore: "coupons");
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
                                  itemCount: coupons.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return DetailsCoupon(
                                                coupons[index].id);
                                          }));
                                        },
                                        child: CustomCoupon(
                                          simpleCoupon: coupons[index],
                                          //listSoldCoupon[index],
                                        ));
                                  }),
                            ),

                            ///here offer
                            // if (offers.isNotEmpty)
                            SingleChildScrollView(
                              //  controller: OffersscrollController,
                              child: Container(
                                  margin: const EdgeInsetsDirectional.only(
                                      bottom: 8),
                                  child: InfiniteGridView(
                                      // withoutDisposeScrool: true,
                                      // forOffice: true,
                                      //   controller: OffersscrollController,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      hasNext:
                                          offers.length < totalOffersResults,
                                      loadingWidget: const Center(
                                          child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: CircularProgressIndicator(
                                          color: CustomColors.primarycolor,
                                        ),
                                      )),
                                      nextData: () {
                                        if (nextOffersPage != null) {
                                          getFinalSearchData(
                                              page: nextOffersPage,
                                              forLoadMore: "special_offers");
                                        }
                                      },
                                      shrinkWrap: true,
                                      gridDelegate:
                                          const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 600,
                                        mainAxisExtent: 127,
                                        mainAxisSpacing: 5,
                                        //  crossAxisSpacing: 20,
                                      ),
                                      itemCount: offers.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return OfferDetails(
                                                    offerid: offers[index].id);
                                              }));
                                            },
                                            child: CustomOffers(
                                              simpleOffer: offers[index],
                                            ));
                                      })),
                            ),

                            //here providers
                            // if (providers.isNotEmpty)
                            finalsearchloading == true
                                ? CustomPreloader()
                                : SingleChildScrollView(
                                    child: InfiniteGridView(
                                        // withoutDisposeScrool: true,
                                        // forOffice: true,
                                        //controller: ProvidersscrollController,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        hasNext: providers.length <
                                            totalProvidersResults,
                                        loadingWidget: const Center(
                                            child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: CircularProgressIndicator(
                                            color: CustomColors.primarycolor,
                                          ),
                                        )),
                                        nextData: () {
                                          if (nextProvidersPage != null) {
                                            getFinalSearchData(
                                                page: nextProvidersPage,
                                                forLoadMore: "providers");
                                          }
                                        },
                                        shrinkWrap: true,
                                        gridDelegate:
                                            SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 120,
                                                mainAxisExtent: 157,
                                                crossAxisSpacing: 10),
                                        itemCount: providers.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            padding:
                                                EdgeInsetsDirectional.all(8),
                                            child: Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return DetailsScreenOfProviders(
                                                          id: providers[index]
                                                              .id);
                                                    }));
                                                  },
                                                  child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.white,
                                                      radius: 35,
                                                      backgroundImage: NetworkImage(
                                                          "${providers[index].logo}")),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "${providers[index].getPropertyEffectedByLang("name_${globals.SelectedLang}")}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 13),
                                                )
                                              ],
                                            ),
                                          );
                                        }),
                                  )
                          ],
                        ),
                      )
                    : searchController.value.text == ""
                        ? Container()
                        : Center(
                            child: SvgPicture.asset(
                            "assets/images/no-seach_results.svg",
                            width: 200,
                            height: 200,
                          ))),
      ),
    );
  }
}
