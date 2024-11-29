import 'package:flutter/material.dart';
import 'package:redeem/custom_widget/CustomAppBar.dart';
import 'package:redeem/custom_widget/CustomSearchedCoupons.dart';
import 'package:redeem/custom_widget/Custom_offers.dart';
import 'package:redeem/custom_widget/custom_back_button.dart';
import 'package:redeem/custom_widget/custom_coupon.dart';
import 'package:redeem/custom_widget/custom_preloader.dart';
import 'package:redeem/generated/l10n.dart';
import 'package:redeem/json_db/enum.dart';
import 'package:redeem/json_db/json_db.dart';
import 'package:redeem/screens/details_coupon/details_coupon.dart';
import 'package:redeem/screens/details_screen_of_providers/details_screen_of_providers.dart';
import 'package:redeem/screens/offer_details/offer_details.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';
import 'package:redeem/globals.dart' as globals;
import 'package:svg_flutter/svg.dart';

class WichList extends StatefulWidget {
  const WichList({super.key});

  @override
  State<WichList> createState() => _WichListState();
}

class _WichListState extends State<WichList> {
  bool loading = true;
  WhishListData? whishListData;
  List<SimpleCoupon> coupons = [];
  List<SimpleOffer> offers = [];
  List<SimpleProvider> providers = [];
  Future<void> getData() async {
    // try {
    await JsonDb().getWhichListCollections().then((res) {
      if (res.success) {
        print("Scucess get which list data");
        whishListData = res.data;
        coupons = whishListData!.listcoupon;
        offers = whishListData!.listoffer;
        providers = whishListData!.listprovider;

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
    return DefaultTabController(
      length: 3,
      //  (coupons.isNotEmpty ? 1 : 0) +
      //     (offers.isNotEmpty ? 1 : 0) +
      //     (providers.isNotEmpty ? 1 : 0),
      child: Scaffold(
        backgroundColor: CustomColors.backgroundcolor_for_Ticket,
        appBar: CustomAppBar(
          elevation: 0,
            title: Text(
              S.of(context).WhishList,
              style: TextStyle( color: CustomColors.primarycolor),
            ),
            leading: CustomBackButton(),
            backgroundColor: CustomColors.primarycolor),
        // appBar: CustomAppBar(
        //     bottom:
        //         coupons.isNotEmpty || offers.isNotEmpty || providers.isNotEmpty
        //             ? TabBar(tabs: [
        //                 if (coupons.isNotEmpty)
        //                   Tab(
        //                     child: Text(
        //                       "Coupons",
        //                       style: TextStyle(color: Colors.white),
        //                     ),
        //                     //text: "Coupons",
        //                   ),
        //                 if (offers.isNotEmpty)
        //                   Tab(
        //                     child: Text(
        //                       "Offers",
        //                       style: TextStyle(color: Colors.white),
        //                     ),
        //                   ),
        //                 if (providers.isNotEmpty)
        //                   Tab(
        //                     child: Text(
        //                       "Providers",
        //                       style: TextStyle(color: Colors.white),
        //                     ),
        //                   )
        //               ])
        //             : null,
        //     leading: CustomBackButton(),
        //     backgroundColor: CustomColors.primarycolor),
        body: loading == true
            ? CustomPreloader()
            : Scaffold(
                backgroundColor: CustomColors.backgroundcolor_for_Ticket,
                appBar: CustomAppBar(
                  elevation: 0,
                  leading: Container(width: 0,),
                    toolbarHeight: 20,
                    bottom: coupons.isNotEmpty ||
                            offers.isNotEmpty ||
                            providers.isNotEmpty
                        ? TabBar(
                            indicatorColor: CustomColors.primarycolor,
                            tabs: [
                                //   if (coupons.isNotEmpty)
                                Tab(
                                  child: Text(
                                    S.of(context).coupons,
                                    style: TextStyle(
                                        color: CustomColors.primarycolor),
                                  ),
                                  //text: "Coupons",
                                ),
                                // if (offers.isNotEmpty)
                                Tab(
                                  child: Text(
                                    S.of(context).offers,
                                    style: TextStyle(
                                        color: CustomColors.primarycolor),
                                  ),
                                ),
                                // if (providers.isNotEmpty)
                                Tab(
                                  child: Text(
                                    S.of(context).providers,
                                    style: TextStyle(
                                        color: CustomColors.primarycolor),
                                  ),
                                )
                              ])
                        : null,
                    backgroundColor: Colors.white),
                body: SafeArea(
                  child:
                  
                  
                   TabBarView(
                    children: [
                      //if (whishListData!.listcoupon.isNotEmpty)
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 8, vertical: 4),
                          child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 300,
                                mainAxisExtent: 243,
                                mainAxisSpacing: 15,
                                crossAxisSpacing: 5,
                              ),
                              itemCount: whishListData!.listcoupon.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return DetailsCoupon(whishListData!
                                            .listcoupon[index].id);
                                      }));
                                    },
                                    child: CustomCoupon(
                                      simpleCoupon:
                                          whishListData!.listcoupon[index],
                                      //listSoldCoupon[index],
                                    ));
                              }),
                        ),
                      ),
                      //  if (whishListData!.listoffer.isNotEmpty)
                      SingleChildScrollView(
                        child: Container(
                            margin: const EdgeInsetsDirectional.only(bottom: 8),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 360,
                                    mainAxisExtent: 127,
                                    mainAxisSpacing: 5,
                                    //  crossAxisSpacing: 20,
                                  ),
                                  itemCount: whishListData!.listoffer.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return OfferDetails(
                                                offerid: whishListData!
                                                    .listoffer[index].id);
                                          }));
                                        },
                                        child: CustomOffers(
                                          simpleOffer:
                                              whishListData!.listoffer[index],
                                        ));
                                  }),
                            )),
                      ),
                      //  if (whishListData!.listprovider.isNotEmpty)
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 8, vertical: 4),
                          child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 120,
                                      mainAxisExtent: 157,
                                      crossAxisSpacing: 10),
                              itemCount: whishListData!.listprovider.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsetsDirectional.all(8),
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return DetailsScreenOfProviders(
                                                id: whishListData!
                                                    .listprovider[index].id);
                                          }));
                                        },
                                        child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 35,
                                            backgroundImage: NetworkImage(
                                                "${whishListData!.listprovider[index].logo}")),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${whishListData!.listprovider[index].getPropertyEffectedByLang("name_${globals.SelectedLang}")}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13),
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),
                      // if (whishListData!.listcoupon.isEmpty &&
                      //     whishListData!.listoffer.isEmpty &&
                      //     whishListData!.listprovider.isEmpty)
                      //   Column(
                      //     children: [
                      //       Expanded(
                      //         flex: 2,
                      //         child: SvgPicture.asset(
                      //           "assets/images/no-order.svg",
                      //           width: double.infinity,
                      //         ),
                      //       ),
                      //       Expanded(
                      //         child: Text(
                      //           S.of(context).no_data,
                      //           style: TextStyle(
                      //               color: CustomColors.primarycolor,
                      //               fontSize: 18),
                      //         ),
                      //       )
                      //     ],
                      //   ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
