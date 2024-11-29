import 'package:flutter/material.dart';
import 'package:redeem/json_db/enum.dart';
import 'package:redeem/screens/subscription_package/subscription_package.dart';
import 'package:redeem/size_config.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';

class CustomDashboardInfo extends StatelessWidget {
  String? title;
  Color? color;
  String? content;
  String? subContent;
  IconData? icon;
  void Function()? onTap;
  CustomDashboardInfo(
      {super.key,
      required this.dashboardCustomerData,
      this.title,
      this.color,
      this.subContent,
      this.icon,
      this.onTap,
      this.content});

  final DashboardCustomerData? dashboardCustomerData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: responsive_size(107),
        height: responsive_size(100),
        padding:
            const EdgeInsetsDirectional.symmetric(vertical: 20, horizontal: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: color),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${title}",
              style: CustomTheme.text15theme
                  .copyWith(color: CustomColors.secondarycolor, fontSize: 13),
            ),
            const SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${content}",
                  style: CustomTheme.text15theme
                      .copyWith(color: CustomColors.primarycolor),
                ),
                const SizedBox(
                  width: 5,
                ),
                // Icon(
                //   Icons.arrow_forward_ios_rounded,
                //   color: Colors.grey.shade400,
                // )
              ],
            ),
            // Text(
            //   "${subContent}",
            //   style: CustomTheme.text15theme
            //       .copyWith(fontSize: 12, color: Colors.black),
            // )
          ],
        ),
      ),
    );
  }
}
