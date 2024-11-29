import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:redeem/custom_widget/CustomAppBar.dart';

import 'package:redeem/custom_widget/custom_basic_subscribe_package.dart';
import 'package:redeem/custom_widget/custom_preloader.dart';
import 'package:redeem/custom_widget/custom_subscribe_package.dart';
import 'package:redeem/custom_widget/custom_back_button.dart';
import 'package:redeem/generated/l10n.dart';
import 'package:redeem/json_db/enum.dart';
import 'package:redeem/json_db/json_db.dart';
import 'package:redeem/screens/subscription_package/Subscription_package_controller.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/globals.dart' as globals;
import 'package:redeem/theme/custom_theme.dart';

class SubsriptionPackage extends StatefulWidget {
  const SubsriptionPackage({super.key});

  @override
  State<SubsriptionPackage> createState() => _SubsriptionPackage();
}

class _SubsriptionPackage extends State<SubsriptionPackage> {
  List<SubscriptionPackage> subscriptionPackage = [];

  bool loading = true;
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    // try {
    await JsonDb().getSubscriptionPackageCollections().then((res) {
      if (res.success) {
        subscriptionPackage = res.data;
        debugPrint("subscriptionPackage ${res.data}");

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
    //}
    //  catch (e) {
    //   ScaffoldMessenger.of(context as BuildContext).showSnackBar(
    //     CustomTheme.CustomSnackBar( S.of(context).Internet_connection_error, "warning"),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.secondarygroundcolor,
      appBar: CustomAppBar(
        title: Text(
          S.of(context).Subscription_Pacakage,
          style: CustomTheme.text18theme
              .copyWith(color: CustomColors.primarycolor),
        ),
        elevation: 0,
        backgroundColor: CustomColors.appbarbackgroundcolor,
        leading: CustomBackButton(),
      ),
      body: loading == true
          ? CustomPreloader()
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                      start: globals.start_padding, end: globals.end_padding),
                  child: Column(
                    children: [
                      ...subscriptionPackage.map((e) {
                        return CustomSubscribePackage(
                          subscriptionPackage: e,
                          listcontent: e.listFeatured,
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
