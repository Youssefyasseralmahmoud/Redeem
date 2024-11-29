import 'package:flutter/material.dart';
import 'package:redeem/custom_widget/CustomAppBar.dart';

import 'package:redeem/custom_widget/custom_back_button.dart';
import 'package:redeem/custom_widget/custom_buy_points_box.dart';
import 'package:redeem/custom_widget/custom_preloader.dart';
import 'package:redeem/custom_widget/custom_price_box.dart';
import 'package:redeem/generated/l10n.dart';
import 'package:redeem/json_db/enum.dart';
import 'package:redeem/json_db/json_db.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';
import 'package:redeem/globals.dart' as globals;

class BuyPoints extends StatefulWidget {
  const BuyPoints({super.key});

  @override
  State<BuyPoints> createState() => _BuyPoints();
}

class _BuyPoints extends State<BuyPoints> {
  List<PointPackage> pointPackages = [];
  bool loading = true;
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    try {
      await JsonDb().getPointPackageCollections().then((res) {
        if (res.success) {
          debugPrint("pointPackages ${res.data}");
          pointPackages = res.data;

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
    } catch (e) {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        CustomTheme.CustomSnackBar(
            S.of(context).Internet_connection_error, "warning"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.secondarygroundcolor,
      appBar: CustomAppBar(
        leading: CustomBackButton(),
        title: Text(S.of(context).buy_points,style: TextStyle(color: CustomColors.primarycolor,),),
        backgroundColor: CustomColors.appbarbackgroundcolor,
        elevation: 0,
      ),
      body: loading == true
          ? CustomPreloader()
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 18.0, ),
                      child: Text(
                        S
                            .of(context)
                            .Buy_Points_and_Redeemed_it_via_buy_Coupons_or_subscription_packages,
                        style: CustomTheme.text16theme.copyWith(
                            fontWeight: FontWeight.normal,
                            color: CustomColors.primarycolor),
                        // textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: pointPackages.length * 160,
                      child: Padding(
                            padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 10.0,),
                        child: GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsetsDirectional.only(top: 80),
                            itemCount: pointPackages.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisExtent: 200,
                                    mainAxisSpacing: 60
                                    // crossAxisSpacing: 10,
                                    // mainAxisSpacing: 10,
                                    ),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsetsDirectional.all(10.0),
                                child: CustomBuyPointsBox(
                                  pointPackages: pointPackages[index],
                                  bordercolor:
                                      CustomColors.thirdcolor.withOpacity(0.2),
                                  fontSize: 17,
                                  pointcolor: CustomColors.secondarycolor,
                                  pricecolor: Colors.green,
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
