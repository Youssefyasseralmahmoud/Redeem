import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:redeem/custom_widget/CustomAppBar.dart';

/* import 'package:redeem/core/function/notification_state_dart'; */
import 'package:redeem/custom_widget/custom_back_button.dart';
import 'package:redeem/custom_widget/custom_coupon.dart';
import 'package:redeem/custom_widget/custom_drawer.dart';
import 'package:redeem/custom_widget/custom_preloader.dart';
import 'package:redeem/generated/l10n.dart';
import 'package:redeem/json_db/enum.dart';
import 'package:redeem/json_db/infinite_grid.dart';
import 'package:redeem/json_db/json_db.dart';
import 'package:redeem/json_db/utils.dart';
import 'package:redeem/screens/Map/map.dart';
import 'package:redeem/screens/SearchPage/search_page.dart';
import 'package:redeem/screens/cart_screen/cart_screen.dart';

import 'package:redeem/screens/details_coupon/details_coupon.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';
import 'package:svg_flutter/svg.dart';

import 'package:ticket_widget/ticket_widget.dart';
import 'package:redeem/globals.dart' as globals;

class ListCouponsPage extends StatefulWidget {
  late int? from_categroy_id;
  ListCouponsPage({this.from_categroy_id});
  @override
  ListCouponsPageState createState() {
    return new ListCouponsPageState();
  }
}

class ListCouponsPageState extends State<ListCouponsPage>
    with AutomaticKeepAliveClientMixin<ListCouponsPage> {
  @override
  bool get wantKeepAlive => true;

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey = GlobalKey();

  String selectedSort = "default_sorting";
  // int? selected_rating;
  int totalResults = 0;
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

  int? nextPage;
  ScrollController scrollController = ScrollController();

  // RangeValues values = const RangeValues(0, 4);

  // List<S2Choice<String>>? category_item = [
  //   S2Choice(value: "1", title: "category1"),
  //   S2Choice(value: "2", title: "category2"),
  //   S2Choice(value: "3", title: "category3"),
  // ];
  List<SimpleCoupon> coupons = [];
  List<City> cities = [];
  List<Category> all_categories = [];
  bool loading = true;

  void selectsorting(String value) {
    setState(() {
      selectedSort = value;
    });
    Navigator.of(context).pop();
    refreshIndicatorKey.currentState?.show(atTop: true);
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
        .getCouponsCollections(
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
          coupons = res.data;
        } else if (page > 1) {
          var coupon = res.data;
          coupon.forEach((element) {
            coupons.add(element);
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
      backgroundColor: CustomColors.backgroundcolor_for_Ticket,
      appBar: CustomAppBar(
          leadingWidth: Navigator.canPop(context) ? 55 : 0,
          title: Text(
            S.of(context).coupons,
            style: CustomTheme.text20theme.copyWith(
              fontWeight: FontWeight.w400,
              color: CustomColors.primarycolor,
            ),
          ),
          leading: Navigator.canPop(context)
              ? CustomBackButton()
              : Container(
                  width: 0,
                ),
          elevation: 0,
          backgroundColor: CustomColors.appbarbackgroundcolor,
          actions: [
            Row(
              children: [
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
                                contentPadding:
                                    const EdgeInsetsDirectional.all(10),
                                title: Text(
                                  S.of(context).sort_by,
                                ),
                                content: Container(
                                  height: 300,
                                  child: Column(
                                    children: [
                                      RadioListTile(
                                          controlAffinity:
                                              ListTileControlAffinity.trailing,
                                          secondary: Text(
                                              S.of(context).default_sorting),
                                          activeColor:
                                              CustomColors.primarycolor,
                                          value: "default_sorting",
                                          groupValue: selectedSort,
                                          onChanged: (value) {
                                            selectsorting(value!);
                                          }),
                                      RadioListTile(
                                          controlAffinity:
                                              ListTileControlAffinity.trailing,
                                          secondary: Text(
                                              S.of(context).newest_arrivals),
                                          activeColor:
                                              CustomColors.primarycolor,
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
                                          activeColor:
                                              CustomColors.primarycolor,
                                          value: "customers_review",
                                          groupValue: selectedSort,
                                          onChanged: (value) {
                                            selectsorting(value!);
                                          }),
                                      RadioListTile(
                                          controlAffinity:
                                              ListTileControlAffinity.trailing,
                                          secondary: Text(S
                                              .of(context)
                                              .by_price_low_to_high),
                                          activeColor:
                                              CustomColors.primarycolor,
                                          value: "by_price_low_to_high",
                                          groupValue: selectedSort,
                                          onChanged: (value) {
                                            selectsorting(value!);
                                          }),
                                      RadioListTile(
                                          secondary: Text(S
                                              .of(context)
                                              .by_price_high_to_low),
                                          activeColor:
                                              CustomColors.primarycolor,
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
                        // Get.defaultDialog(
                        //   title: S.of(context).sort_by,
                        //   content:
                        // );
                      },
                      icon: const Icon(
                        Icons.sort,
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
                        //     SearchType: "coupon",
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
                          builder: (context) {
                            return FractionallySizedBox(
                              heightFactor: 0.85,
                              child: CustomBottomShett(filters, () {
                                Navigator.of(context).pop();
                                refreshIndicatorKey.currentState
                                    ?.show(atTop: true);
                              }),
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.filter_alt_outlined,
                        color: CustomColors.primarycolor,
                      )),
                ),
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
              ],
            ),
          ]),
      body: loading == true
          ? CustomPreloader()
          : SafeArea(
              child: RefreshIndicator(
                key: refreshIndicatorKey,
                onRefresh: () async {
                  await getData(page: 1);
                },
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Container(
                    padding: const EdgeInsetsDirectional.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
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
                                            color: CustomColors.secondarycolor),
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
                                                globals.categories[index].id) {
                                              categoryy_id = null;
                                              filters['filterCategory'] =
                                                  globals.categories[index].id;
                                              refreshIndicatorKey.currentState
                                                  ?.show(atTop: true);
                                            }
                                            selectCategory(true,
                                                globals.categories[index].id!);
                                            SubCategory_id = null;
                                          },
                                          child: Container(
                                            margin: EdgeInsetsDirectional.only(
                                                end: 5),
                                            padding:
                                                EdgeInsetsDirectional.symmetric(
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
                                                                      "#", ""),
                                                        ),
                                                      )
                                                    : Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(50)),
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
                                              style:
                                                  CustomTheme.text_grey15theme
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
                                                                            globals.categories[categoryy_id! - 1].color!.replaceAll("#",
                                                                                ""),
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
                                                    color: SubCategory_id == id
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
                                                        : Colors.white,
                                                    border: Border.all(
                                                        color:
                                                            SubCategory_id == id
                                                                ? Color(
                                                                    int.parse(
                                                                      "0XFF" +
                                                                          globals
                                                                              .categories[categoryy_id! - 1]
                                                                              .color!
                                                                              .replaceAll("#", ""),
                                                                    ),
                                                                  )
                                                                : Color(
                                                                    int.parse(
                                                                      "0XFF" +
                                                                          globals
                                                                              .categories[categoryy_id! - 1]
                                                                              .color!
                                                                              .replaceAll("#", ""),
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
                                                            orElse: () => Category(
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
                        loading
                            ? const Padding(
                                padding: EdgeInsetsDirectional.only(top: 120),
                                child: CustomPreloader(),
                              )
                            : coupons.isNotEmpty
                                ? InfiniteGridView(
                                    withoutDisposeScrool: true,
                                    forOffice: true,
                                    controller: scrollController,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    hasNext: coupons.length < totalResults,
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
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.only(
                                                start: 3, end: 3),
                                            child: CustomCoupon(
                                              simpleCoupon: coupons[index],
                                            ),
                                          ));
                                    })
                                : Center(
                                    child: SvgPicture.asset(
                                        "assets/images/no-seach_results.svg",height: 300,width: 300,))
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

// for dotted line

class DrawDottedhorizontalline extends CustomPainter {
  Color? painerColor;
  late Paint _paint;
  DrawDottedhorizontalline() {
    {
      this.painerColor;
      _paint = Paint();
      _paint.color =
          painerColor ?? CustomColors.backgroundcolor_for_Ticket; //dots color
      _paint.strokeWidth = 2; //dots thickness
      _paint.strokeCap = StrokeCap.square; //dots corner edges
    }
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

class CustomBottomShett extends StatefulWidget {
  //int? sub_categories_id;
  Function applyFilter;
  Map<String, dynamic> filters = {
    "filterSearch": "",
    "filterCategory": null,
    "filterRating": null,
    "filterMinPrice": null,
    "filterMaxPrice": null
  };
  CustomBottomShett(this.filters, this.applyFilter);
  @override
  State<CustomBottomShett> createState() => _CustomBottomShettState();
}

class _CustomBottomShettState extends State<CustomBottomShett> {
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
