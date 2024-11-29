import 'package:flutter/material.dart';

import 'package:redeem/generated/l10n.dart';
import 'package:redeem/json_db/enum.dart';
import 'package:redeem/screens/cart_screen/cart_screen.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/globals.dart' as globals;
import 'package:redeem/theme/custom_theme.dart';

class CustomBuyPointsBox extends StatefulWidget {
  String? price;
  String? name;
  double? fontSize;
  Color? pointcolor;
  Color? bordercolor;
  Color? pricecolor;
  PointPackage? pointPackages;
  CustomBuyPointsBox({
    this.pointcolor,
    this.bordercolor,
    this.pricecolor,
    this.fontSize,
    this.name,
    this.price,
    this.pointPackages,
    super.key,
  });

  @override
  State<CustomBuyPointsBox> createState() => _CustomBuyPointsBox();
}

class _CustomBuyPointsBox extends State<CustomBuyPointsBox> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: widget.bordercolor!)),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "${widget.pointPackages!.getPropertyEffectedByLang("name_${globals.SelectedLang}")}" +
                  " " +
                  S.of(context).points,
              style: TextStyle(
                  fontSize: widget.fontSize,
                  color: widget.pointcolor,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${widget.pointPackages!.price}" + " " + S.of(context).S_R,
              style: TextStyle(color: widget.pricecolor, fontSize: 15),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 100,
              height: 40,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    side: BorderSide(
                        width: 0.5,
                        color: CustomColors.primarycolor.withOpacity(0.3)),
                    textStyle: TextStyle(fontWeight: FontWeight.bold),
                    primary: CustomColors.primarycolor),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return CartScreen(
                      id: widget.pointPackages!.id,
                      ItemType: "PointsPackage",
                      quickCheckout: "1",
                    );
                  }));
                },
                child: Text(S.of(context).buy),
              ),
            ),
          ]),
        ),
        Positioned(
            left: 40,
            bottom: 155,
            child: Container(
              padding: EdgeInsetsDirectional.all(5),
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(50)),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${widget.pointPackages!.points}",
                    style: CustomTheme.text15theme
                        .copyWith(color: CustomColors.primarycolor),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    S.of(context).points,
                    style: CustomTheme.text15theme
                        .copyWith(color: CustomColors.primarycolor),
                  )
                ],
              )),
            ))
      ],
    );
  }
}
