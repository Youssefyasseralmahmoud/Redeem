import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';

import 'package:redeem/core/function/notification_state_controller.dart';
import 'package:redeem/custom_widget/CustomAppBar.dart';
import 'package:redeem/custom_widget/Custom_offers.dart';
import 'package:redeem/custom_widget/custom_back_button.dart';
import 'package:redeem/custom_widget/custom_drawer.dart';
import 'package:redeem/custom_widget/custom_preloader.dart';
import 'package:redeem/generated/l10n.dart';
import 'package:redeem/json_db/enum.dart';
import 'package:redeem/json_db/infinite_grid.dart';
import 'package:redeem/json_db/json_db.dart';
import 'package:redeem/screens/List_coupons_page/List_coupons_page.dart';

import 'package:redeem/screens/List_coupons_page/list_coupons_page_controller.dart';
import 'package:redeem/screens/Map/map.dart';
import 'package:redeem/screens/SearchPage/search_page.dart';
import 'package:redeem/screens/all%20offers/all_offers_controller.dart';
import 'package:redeem/screens/offer_details/offer_details.dart';
import 'package:redeem/size_config.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';
import 'package:redeem/globals.dart' as globals;
import 'package:svg_flutter/svg_flutter.dart';

class AllOffers extends StatefulWidget {
  late int? from_categroy_id;
  AllOffers({this.from_categroy_id});
  @override
  _AllOffersState createState() {
    return new _AllOffersState();
  }
}

class _AllOffersState extends State<AllOffers>
    with AutomaticKeepAliveClientMixin<AllOffers> {
  int selected_rating = 0;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey = GlobalKey();
  List<SimpleOffer> offers = [];
  List<SimpleProvider> provier_info = [];
  List<City> cities = [];
  String selectedSort = "default_sorting";
  int totalResults = 0;
  int? nextPage;
  ScrollController scrollController = ScrollController();
  bool loading = true;

  RangeValues values = const RangeValues(0, 6);

  List<S2Choice<String>> offers_category_item = [
    S2Choice(value: "1", title: "offer 1"),
    S2Choice(value: "2", title: "offer 2"),
    S2Choice(value: "3", title: "offers 3"),
  ];
  bool Catrgory_is_pressed = false;
  int? categoryy_id;
  int? SubCategory_id;
  Map<String, dynamic> filters = {
    "filterSearch": "",
    "filterCategory": null,
    "filterRating": null,
    "filterMinPrice": null,
    "filterMaxPrice": null
  };

  void selectsorting(String value) {
    selectedSort = value;
    setState(() {});
    Navigator.of(context).pop();
    refreshIndicatorKey.currentState?.show(atTop: true);
  }

  void selectrating(int rating) {
    selected_rating = rating;
    setState(() {});
  }

  void change_range_slider(var newvalues) {
    values = newvalues;

    setState(() {});
  }

  void selectCategory(bool select, int category_id) {
    setState(() {
      Catrgory_is_pressed = select;
      categoryy_id = category_id;
      print("category id ${category_id}");
    });
  }

  void selectSubCategory(int Subcategory_id) {
    setState(() {
      SubCategory_id = Subcategory_id;
    });
  }

  @override
  void initState() {
    super.initState();
    categoryy_id = widget.from_categroy_id;
    filters['filterCategory'] = widget.from_categroy_id;
    getData();
  }

  Future<void> getData({page = 1}) async {
    // try {

    await JsonDb()
        .getOffersCollections(
      page: page,
      sorting: selectedSort,
      filterCategory: filters['filterCategory'],
      filterSearch: filters['filterSearch'],
      filterMinPrice: filters['filterMinPrice'],
      filterMaxPrice: filters['filterMaxPrice'],
      filterRating: filters['filterRating'],
    )
        .then((res) {
      if (res.success) {
        nextPage = res.nextPage;

        if (page == 1) {
          totalResults = res.totalResult!;
          offers = res.data;
        } else if (page > 1) {
          var offer = res.data;
          offer.forEach((element) {
            offers.add(element);
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
        drawer: Navigator.canPop(context)
            ? null
            : CustomDrawer(
                cities: globals.cities, choiselangitem: globals.Language2),
        resizeToAvoidBottomInset: false,
        // backgroundColor: CustomColors.secondarygroundcolor,
        backgroundColor: CustomColors.backgroundcolor_for_Ticket,
        appBar: CustomAppBar(
            leadingWidth: Navigator.canPop(context) ? 55 : 0,
            leading: Navigator.canPop(context)
                ? CustomBackButton()
                : Container(
                    width: 0,
                  ),
            title: Text(
              S.of(context).offers,
              style: CustomTheme.text_white20theme.copyWith(
                color: CustomColors.primarycolor,
                fontWeight: FontWeight.w400,
              ),
            ),
            elevation: 0,
            backgroundColor: CustomColors.appbarbackgroundcolor,
            actions: [
              SizedBox(
                width: 38,
                child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return MapScreen();
                      }));
                    },
                    icon: Icon(
                      Icons.location_on_outlined,
                      color: CustomColors.primarycolor,
                    )),
              ),
              SizedBox(
                width: 38,
                child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (builder) {
                            return AlertDialog(
                              contentPadding: EdgeInsetsDirectional.all(10),
                              title: Text(
                                S.of(context).sort_by,
                              ),
                              content: Container(
                                height: 350,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    RadioListTile(
                                        controlAffinity:
                                            ListTileControlAffinity.trailing,
                                        secondary:
                                            Text(S.of(context).default_sorting),
                                        activeColor: CustomColors.primarycolor,
                                        value: "default_sorting",
                                        groupValue: selectedSort,
                                        onChanged: (value) {
                                          selectsorting(value!);
                                        }),
                                    RadioListTile(
                                        controlAffinity:
                                            ListTileControlAffinity.trailing,
                                        secondary:
                                            Text(S.of(context).newest_arrivals),
                                        activeColor: CustomColors.primarycolor,
                                        value: "newest_arrivals",
                                        groupValue: selectedSort,
                                        onChanged: (value) {
                                          selectsorting(value!);
                                        }),
                                    RadioListTile(
                                        controlAffinity:
                                            ListTileControlAffinity.trailing,
                                        secondary: Text(
                                            S.of(context).customers_review),
                                        activeColor: CustomColors.primarycolor,
                                        value: "customers_review",
                                        groupValue: selectedSort,
                                        onChanged: (value) {
                                          selectsorting(value!);
                                        }),
                                    RadioListTile(
                                        controlAffinity:
                                            ListTileControlAffinity.trailing,
                                        secondary: Text(
                                            S.of(context).by_price_low_to_high),
                                        activeColor: CustomColors.primarycolor,
                                        value: "by_price_low_to_high",
                                        groupValue: selectedSort,
                                        onChanged: (value) {
                                          selectsorting(value!);
                                        }),
                                    RadioListTile(
                                        secondary: Text(
                                            S.of(context).by_price_high_to_low),
                                        activeColor: CustomColors.primarycolor,
                                        controlAffinity:
                                            ListTileControlAffinity.trailing,
                                        value: "by_price_high_to_low",
                                        groupValue: selectedSort,
                                        onChanged: (value) {
                                          selectsorting(value!);
                                        }),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    icon: Icon(
                      Icons.sort_sharp,
                      color: CustomColors.primarycolor,
                    )),
              ),
              SizedBox(
                width: 38,
                child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      // Navigator.of(context)
                      //     .push(MaterialPageRoute(builder: (context) {
                      //   return SearchPage(
                      //     SearchType: "offer",
                      //   );
                      // }));
                      showModalBottomSheet(
                          isScrollControlled: true,
                          useRootNavigator: true,
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25),
                            ),
                          ),
                          builder: (builder) {
                            return FractionallySizedBox(
                                heightFactor: 0.85,
                                child: CustomOfferBottomShett(filters, () {
                                  Navigator.of(context).pop();
                                  refreshIndicatorKey.currentState
                                      ?.show(atTop: true);
                                }));
                          });
                    },
                    icon: const Icon(
                      Icons.filter_alt_outlined,
                      color: CustomColors.primarycolor,
                    )),
              ),
              Navigator.canPop(context)
                  ? Container(
                      width: 0,
                    )
                  : Builder(builder: (context) {
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
            ]),
        body: loading == true
            ? CustomPreloader()
            : SafeArea(
                child: RefreshIndicator(
                  key: refreshIndicatorKey,
                  onRefresh: () async {
                    await getData();
                  },
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Container(
                      padding: EdgeInsetsDirectional.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsetsDirectional.only(start: 6),
                            width: double.infinity,
                            height: 35,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  //here all button
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (categoryy_id != null) {
                                          categoryy_id = null;
                                          filters['filterCategory'] = null;
                                          refreshIndicatorKey.currentState
                                              ?.show(atTop: true);
                                        }
                                      });
                                    },
                                    child: Container(
                                      padding:
                                          const EdgeInsetsDirectional.symmetric(
                                              horizontal: 20, vertical: 8),
                                      margin:
                                          const EdgeInsetsDirectional.symmetric(
                                              horizontal: 4),
                                      decoration: BoxDecoration(
                                          color: categoryy_id == null
                                              ? CustomColors.secondarycolor
                                              : Colors.white,
                                          border: Border.all(
                                              color:
                                                  CustomColors.secondarycolor),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Center(
                                        child: Text(
                                          S.of(context).all,
                                          style: CustomTheme.text_grey15theme
                                              .copyWith(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 13,
                                                  color: categoryy_id == null
                                                      ? Colors.white
                                                      : CustomColors
                                                          .secondarycolor),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: globals.categories.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                            onTap: () {
                                              if (categoryy_id !=
                                                  globals
                                                      .categories[index].id) {
                                                categoryy_id = null;
                                                filters['filterCategory'] =
                                                    globals
                                                        .categories[index].id;
                                                refreshIndicatorKey.currentState
                                                    ?.show(atTop: true);
                                              }
                                              selectCategory(
                                                  true,
                                                  globals
                                                      .categories[index].id!);
                                              SubCategory_id = null;
                                            },
                                            child: Container(
                                              margin:
                                                  EdgeInsetsDirectional.only(
                                                      end: 5),
                                              padding: EdgeInsetsDirectional
                                                  .symmetric(
                                                      horizontal: 13,
                                                      vertical: 5),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: categoryy_id ==
                                                              globals
                                                                  .categories[
                                                                      index]
                                                                  .id
                                                          ? Color(
                                                              int.parse(
                                                                "0XFF" +
                                                                    globals
                                                                        .categories[
                                                                            index]
                                                                        .color!
                                                                        .replaceAll(
                                                                            "#",
                                                                            ""),
                                                              ),
                                                            )
                                                          : Color(
                                                              int.parse(
                                                                "0XFF" +
                                                                    globals
                                                                        .categories[
                                                                            index]
                                                                        .color!
                                                                        .replaceAll(
                                                                            "#",
                                                                            ""),
                                                              ),
                                                            )),
                                                  color: categoryy_id ==
                                                          globals
                                                              .categories[index]
                                                              .id
                                                      ? Color(
                                                          int.parse(
                                                            "0XFF" +
                                                                globals
                                                                    .categories[
                                                                        index]
                                                                    .color!
                                                                    .replaceAll(
                                                                        "#",
                                                                        ""),
                                                          ),
                                                        )
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    width: 25,
                                                    height: 25,
                                                    child: SvgPicture.network(
                                                      "${globals.categories[index].icon}",
                                                      fit: BoxFit.cover,
                                                      width: 30,
                                                      height: 30,
                                                      color: categoryy_id ==
                                                              globals
                                                                  .categories[
                                                                      index]
                                                                  .id
                                                          ? Colors.white
                                                          : Color(
                                                              int.parse(
                                                                "0XFF" +
                                                                    globals
                                                                        .categories[
                                                                            index]
                                                                        .color!
                                                                        .replaceAll(
                                                                            "#",
                                                                            ""),
                                                              ),
                                                            ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  Text(
                                                    "${globals.categories[index].getPropertyEffectedByLang("name_${globals.SelectedLang}")}",
                                                    style: TextStyle(
                                                      color: categoryy_id ==
                                                              globals
                                                                  .categories[
                                                                      index]
                                                                  .id
                                                          ? Colors.white
                                                          : Color(
                                                              int.parse(
                                                                "0XFF" +
                                                                    globals
                                                                        .categories[
                                                                            index]
                                                                        .color!
                                                                        .replaceAll(
                                                                            "#",
                                                                            ""),
                                                              ),
                                                            ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ));
                                      }),
                                ],
                              ),
                            ),
                          ),
                          Catrgory_is_pressed == true &&
                                  globals.categories
                                      .singleWhere(
                                          (element) =>
                                              element.id! == categoryy_id,
                                          orElse: () =>
                                              Category(listSubCategories: []))
                                      .listSubCategories!
                                      .isNotEmpty
                              ? Container(
                                  padding: EdgeInsetsDirectional.only(start: 6),
                                  margin: EdgeInsetsDirectional.only(top: 10),
                                  width: double.infinity,
                                  height: 30,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        //here all sub
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (SubCategory_id != null) {
                                                SubCategory_id = null;
                                                filters['filterCategory'] =
                                                    categoryy_id;
                                                refreshIndicatorKey.currentState
                                                    ?.show(atTop: true);
                                              }
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsetsDirectional
                                                    .symmetric(
                                                horizontal: 20, vertical: 8),
                                            margin: const EdgeInsetsDirectional
                                                .symmetric(horizontal: 4),
                                            decoration: BoxDecoration(
                                                color: SubCategory_id == null
                                                    ? Color(
                                                        int.parse(
                                                          "0XFF" +
                                                              globals
                                                                  .categories[
                                                                      categoryy_id! -
                                                                          1]
                                                                  .color!
                                                                  .replaceAll(
                                                                      "#", ""),
                                                        ),
                                                      )
                                                    : Colors.white,
                                                border: Border.all(
                                                    color: SubCategory_id ==
                                                            null
                                                        ? Color(
                                                            int.parse(
                                                              "0XFF" +
                                                                  globals
                                                                      .categories[
                                                                          categoryy_id! -
                                                                              1]
                                                                      .color!
                                                                      .replaceAll(
                                                                          "#",
                                                                          ""),
                                                            ),
                                                          )
                                                        : Color(
                                                            int.parse(
                                                              "0XFF" +
                                                                  globals
                                                                      .categories[
                                                                          categoryy_id! -
                                                                              1]
                                                                      .color!
                                                                      .replaceAll(
                                                                          "#",
                                                                          ""),
                                                            ),
                                                          ).withOpacity(0.5)),
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Center(
                                              child: Text(
                                                S.of(context).all,
                                                style: CustomTheme
                                                    .text_grey15theme
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 13,
                                                        color:
                                                            SubCategory_id ==
                                                                    null
                                                                ? Colors.white
                                                                : Color(
                                                                    int.parse(
                                                                      "0XFF" +
                                                                          globals
                                                                              .categories[categoryy_id! - 1]
                                                                              .color!
                                                                              .replaceAll("#", ""),
                                                                    ),
                                                                  )),
                                              ),
                                            ),
                                          ),
                                        ),
                                        ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: globals.categories
                                                .singleWhere(
                                                    (element) =>
                                                        element.id! ==
                                                        categoryy_id,
                                                    orElse: () => Category(
                                                        listSubCategories: []))
                                                .listSubCategories!
                                                .length,
                                            itemBuilder: (context, index) {
                                              int? id = globals.categories
                                                  .singleWhere(
                                                      (element) =>
                                                          element.id! ==
                                                          categoryy_id,
                                                      orElse: () => Category(
                                                          listSubCategories: []))
                                                  .listSubCategories![index]
                                                  .id;
                                              return GestureDetector(
                                                onTap: () {
                                                  int? id = globals.categories
                                                      .singleWhere(
                                                          (element) =>
                                                              element.id! ==
                                                              categoryy_id,
                                                          orElse: () => Category(
                                                              listSubCategories: []))
                                                      .listSubCategories![index]
                                                      .id;
                                                  if (SubCategory_id != id) {
                                                    filters['filterCategory'] =
                                                        id;
                                                    refreshIndicatorKey
                                                        .currentState
                                                        ?.show(atTop: true);
                                                  }
                                                  selectSubCategory(id!);
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .symmetric(
                                                          horizontal: 8),
                                                  margin:
                                                      const EdgeInsetsDirectional
                                                              .symmetric(
                                                          horizontal: 4),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          SubCategory_id == id
                                                              ? Color(
                                                                  int.parse(
                                                                    "0XFF" +
                                                                        globals
                                                                            .categories[categoryy_id! -
                                                                                1]
                                                                            .color!
                                                                            .replaceAll("#",
                                                                                ""),
                                                                  ),
                                                                )
                                                              : Colors.white,
                                                      border: Border.all(
                                                          color:
                                                              SubCategory_id ==
                                                                      id
                                                                  ? Color(
                                                                      int.parse(
                                                                        "0XFF" +
                                                                            globals.categories[categoryy_id! - 1].color!.replaceAll("#",
                                                                                ""),
                                                                      ),
                                                                    )
                                                                  : Color(
                                                                      int.parse(
                                                                        "0XFF" +
                                                                            globals.categories[categoryy_id! - 1].color!.replaceAll("#",
                                                                                ""),
                                                                      ),
                                                                    )),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                                  child: Center(
                                                    child: Text(
                                                      globals.categories
                                                          .singleWhere(
                                                              (element) =>
                                                                  element.id! ==
                                                                  categoryy_id,
                                                              orElse: () =>
                                                                  Category(
                                                                      listSubCategories: []))
                                                          .listSubCategories![
                                                              index]
                                                          .getPropertyEffectedByLang(
                                                              "name_${globals.SelectedLang}"),
                                                      style: CustomTheme
                                                          .text_grey15theme
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 13,
                                                              color:
                                                                  SubCategory_id ==
                                                                          id
                                                                      ? Colors
                                                                          .white
                                                                      : Color(
                                                                          int.parse(
                                                                            "0XFF" +
                                                                                globals.categories[categoryy_id! - 1].color!.replaceAll("#", ""),
                                                                          ),
                                                                        )),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 0,
                                ),
                          const SizedBox(
                            height: 10,
                          ),
                          // SizedBox(
                          //   width: double.infinity,
                          //   height: 35,
                          //   child: ListView.builder(
                          //       scrollDirection: Axis.horizontal,
                          //       shrinkWrap: true,
                          //       itemCount: offers.length,
                          //       itemBuilder: (context, index) {
                          //         return Container(
                          //           padding: EdgeInsetsDirectional.all(6),
                          //           margin: EdgeInsetsDirectional.symmetric(
                          //               horizontal: 8),
                          //           decoration: BoxDecoration(
                          //               border: Border.all(
                          //                   color: CustomColors.thirdcolor
                          //                       .withOpacity(0.5)),
                          //               borderRadius:
                          //                   BorderRadius.circular(30)),
                          //           child: Center(
                          //             child: Text(
                          //               "${offers[index].simpleProvider!.category!.getPropertyEffectedByLang("name_${globals.SelectedLang}")}",
                          //               style: CustomTheme.text_grey15theme
                          //                   .copyWith(
                          //                       fontWeight: FontWeight.normal),
                          //             ),
                          //           ),
                          //         );
                          //       }),
                          // ),
                          // const SizedBox(
                          //   height: 20,
                          // ),
                          loading == true
                              ? Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      top: 120),
                                  child: CustomPreloader(),
                                )
                              : 
                              offers.isNotEmpty?
                              InfiniteGridView(
                                  withoutDisposeScrool: true,
                                  forOffice: true,
                                  controller: scrollController,
                                  physics: NeverScrollableScrollPhysics(),
                                  hasNext: offers.length < totalResults,
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
                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 600,
                                    mainAxisExtent: 127,
                                    mainAxisSpacing: 5,

                                    //  crossAxisSpacing: 20,
                                  ),
                                  itemCount: offers.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return OfferDetails(
                                              offerid: offers[index].id,
                                            );
                                          }));
                                        },
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.only(
                                              start: globals.start_padding,
                                              end: globals.end_padding),
                                          child: CustomOffers(
                                            simpleOffer: offers[index],
                                            // imageurl: "${offers[index].image}",
                                            // name:
                                            //     "${offers[index].simpleProvider!.getPropertyEffectedByLang("name_${globals.SelectedLang}")}",
                                            // content:
                                            //     "${offers[index].getPropertyEffectedByLang("name_${globals.SelectedLang}")}",
                                            // logourl:
                                            //     "${offers[index].simpleProvider!.logo}",
                                          ),
                                        ));
                                  }):Center(
                                    child: SvgPicture.asset(
                                        "assets/images/no-seach_results.svg",height: 300,width: 300,))
                        ],
                      ),
                    ),
                  ),
                ),
              ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class CustomOfferBottomShett extends StatefulWidget {
  //int? sub_categories_id;
  Function applyFilter;
  Map<String, dynamic> filters = {
    "filterSearch": "",
    "filterCategory": null,
    "filterRating": null,
    "filterMinPrice": null,
    "filterMaxPrice": null
  };
  CustomOfferBottomShett(this.filters, this.applyFilter);
  @override
  State<CustomOfferBottomShett> createState() => _CustomOfferBottomShett();
}

class _CustomOfferBottomShett extends State<CustomOfferBottomShett> {
  TextEditingController search_controller = new TextEditingController();
  int? selected_rating;
  int totalResults = 0;
  int? nextPage;
  List<SimpleCoupon> coupons = [];
  bool loading = true;

  RangeValues values = const RangeValues(0, 4);
  void selectrating(int rating) {
    setState(() {
      selected_rating = rating;
    });
  }

  void change_range_slider(var newvalues) {
    setState(() {
      values = newvalues;
    });
  }

  List<S2Choice> all_categories = [];
  Map<String, String> categories_icons = Map<String, String>();
  Map<String, String> categories_colors = Map<String, String>();
  int? selectedCategory = null;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    search_controller.text = widget.filters['filterSearch'];
    selected_rating = widget.filters['filterRating'];
    selectedCategory = widget.filters['filterCategory'];

    globals.categories.forEach((category) {
      categories_icons[category.getPropertyEffectedByLang(
          "name_${globals.SelectedLang}")] = category.icon!;
      categories_colors[category.getPropertyEffectedByLang(
          "name_${globals.SelectedLang}")] = category.color!;

      if (category.listSubCategories!.isEmpty) {
        all_categories.add(
          S2Choice(
            value: category.id,
            group: category
                .getPropertyEffectedByLang("name_${globals.SelectedLang}"),
            title: category
                .getPropertyEffectedByLang("name_${globals.SelectedLang}"),
            meta: category,
          ),
        );
      } else {
        all_categories.add(S2Choice(
            value: category.id,
            meta: category,
            group: category
                .getPropertyEffectedByLang("name_${globals.SelectedLang}"),
            title: /* S.of(context).all +
                " " + */
                category.getPropertyEffectedByLang(
                    "name_${globals.SelectedLang}")));
        category.listSubCategories!.forEach((subCat) {
          all_categories.add(S2Choice(
              value: subCat.id,
              meta: category,
              group: category
                  .getPropertyEffectedByLang("name_${globals.SelectedLang}"),
              title: /*  S.of(context).all +
                  " " + */
                  subCat.getPropertyEffectedByLang(
                      "name_${globals.SelectedLang}")));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.all(8),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
            Text(
              S.of(context).search,
              style: const TextStyle(
                  fontSize: 18, color: CustomColors.primarycolor),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: search_controller,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsetsDirectional.symmetric(
                      vertical: 10, horizontal: 10),
                  hintText: S.of(context).search_for_product,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade300)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade300))),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300)),
              child: SmartSelect.single(
                groupEnabled: true,
                choiceGrouped: true,
                selectedValue: selectedCategory,
                title: "category",
                modalHeaderStyle: S2ModalHeaderStyle(
                    iconTheme: IconThemeData(color: CustomColors.primarycolor),
                    textStyle: TextStyle(color: CustomColors.primarycolor),
                    backgroundColor: CustomColors.backgroundcolor_for_Ticket),
                choiceStyle:
                    const S2ChoiceStyle(color: CustomColors.primarycolor),
                modalFilter: true,
                modalFilterAuto: true,
                groupHeaderBuilder: (context, state, group) {
                  return ListTile(
                    tileColor: Color(
                      int.parse(
                        "0XFF" +
                            categories_colors[group.name]!.replaceAll("#", ""),
                      ),
                    ),
                    leading: CircleAvatar(
                        backgroundColor: Color(
                          int.parse(
                            "0XFF" +
                                categories_colors[group.name]!
                                    .replaceAll("#", ""),
                          ),
                        ),
                        child:
                            SvgPicture.network(categories_icons[group.name]!)),
                    title: Text(
                      group.name!,
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
                choiceItems: all_categories,
                onChange: (value) {
                  setState(() {
                    selectedCategory = value.value!;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              S.of(context).rating,
              style: const TextStyle(
                  fontSize: 18, color: CustomColors.primarycolor),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 5,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        selectrating(index);
                      },
                      child: Container(
                        margin: const EdgeInsetsDirectional.symmetric(
                            horizontal: 5),
                        width: 60,
                        height: 40,
                        decoration: BoxDecoration(
                            color: selected_rating == index
                                ? CustomColors.primarycolor
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${index + 1}",
                              style: TextStyle(
                                  color: selected_rating == index
                                      ? CustomColors.secondarycolor
                                      : Colors.black),
                            ),
                            Icon(
                              Icons.star_border_rounded,
                              color: selected_rating == index
                                  ? CustomColors.secondarycolor
                                  : Colors.black,
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              S.of(context).price_range,
              style: const TextStyle(
                  fontSize: 18, color: CustomColors.primarycolor),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsetsDirectional.all(8),
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300)),
                    child: Row(
                      children: [
                        Text(
                          S.of(context).S_R,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text("${values.start.toString()}")
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsetsDirectional.all(8),
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300)),
                    child: Row(
                      children: [
                        Text(
                          S.of(context).S_R,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text("${values.end.toString()}")
                      ],
                    ),
                  ),
                )
              ],
            ),
            RangeSlider(
                activeColor: CustomColors.primarycolor,
                divisions: 4,
                min: 0,
                max: 4,
                values: values,
                onChanged: (newvalues) {
                  change_range_slider(newvalues);
                }),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    widget.filters['filterSearch'] = "";
                    widget.filters['filterCategory'] = null;
                    widget.filters['filterRating'] = null;
                    widget.filters['filterMinPrice'] = null;
                    widget.filters['filterMaxPrice'] = null;

                    setState(() {});
                    widget.applyFilter();
                  },
                  child: Text(S.of(context).reset_filtter),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      side: const BorderSide(color: CustomColors.thirdcolor),
                      minimumSize: const Size(100, 50),
                      padding: const EdgeInsetsDirectional.all(5),
                      primary: CustomColors.thirdcolor),
                ),
                const SizedBox(
                  width: 20,
                ),
                OutlinedButton(
                  onPressed: () {
                    //  this.getData();
                    widget.filters['filterSearch'] =
                        search_controller.value.text;
                    widget.filters['filterCategory'] = selectedCategory;
                    widget.filters['filterRating'] = selected_rating;
                    /*   widget.filters['filterMinPrice'] = values.start;
                    widget.filters['filterMaxPrice'] = values.end; */
                    setState(() {});
                    widget.applyFilter();
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    backgroundColor: CustomColors.primarycolor,
                    minimumSize: const Size(100, 50),
                    padding: const EdgeInsetsDirectional.all(5),
                  ),
                  child: Text(
                    S.of(context).apply_filtter,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
