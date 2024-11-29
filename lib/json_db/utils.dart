import 'dart:convert';
import 'dart:math';

//import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:redeem/app_storage.dart';
import 'package:redeem/config.dart';
import 'package:redeem/custom_widget/custme_button.dart';
import 'package:redeem/generated/l10n.dart';
import 'package:redeem/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:redeem/screens/login/login.dart';
import 'package:redeem/screens/main_screen/main_screen.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';
import 'package:line_icons/line_icons.dart';
/* import 'package:url_launcher/url_launcher.dart'; */

String fix_image_path(path, {bool forProduct = false}) {
  if (!forProduct) {
    return config_app.PerfixImage + path;
  } else {
    return config_app.PerfixImage + "/images/product/" + path;
  }
}

String parse_price(price, {withCurency = true}) {
  if (withCurency) {
    return config_app.DefaultCurrency +
        double.tryParse(price)!.toStringAsFixed(2);
  } else {
    return double.tryParse(price)!.toStringAsFixed(2);
  }
}

bool check_has_discount(discount) {
  double? myDiscount = double.tryParse(discount);

  if (myDiscount is double && myDiscount > 0) {
    return true;
  }
  return false;
}

bool check_product_avilability(qty) {
  double? myQty = double.tryParse(qty);
  if (myQty is double && myQty > 0) {
    return true;
  }
  return false;
}

String calc_discount_price(price, discount) {
  double? myDiscount = double.tryParse(discount);
  if (myDiscount is double && myDiscount > 0) {
    double? myPrice = double.tryParse(price);
    if (myPrice is double && myPrice > 0) {
      double finalPrice = myPrice - ((myPrice * myDiscount) / 100);
      return finalPrice.toString();
    }
  }

  return price;
}

String getRandomString(int length) {
  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  return String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}

dynamic get_value_by_lang(lang, value_ar, value_en) {
  if (lang == "en") {
    return value_en;
  }
  return value_ar;
}

format_price(dynamic d, {bool withCurrency = false}) {
  /* if (d.runtimeType == String) {
    d = double.tryParse(d);
  } */
  print(globals.currencySymbol);
  var parsed = double.tryParse(d.toString());
  final currencyFormatter = NumberFormat('###,###,###,###.##', 'en_US');
  var _d = currencyFormatter.format(parsed);
  d = _d.toString().replaceAll(".00", "");
  if (globals.currencySymbol != '\$') {
    return d + (withCurrency ? " " + globals.currencySymbol : "");
  }
  return (withCurrency ? globals.currencySymbol + "" : "") + d;
}

mapToJson(Map<dynamic, dynamic> data) {
  Map<dynamic, dynamic> _new_data = {};
  data.forEach((key, value) {
    _new_data.addAll({key.toString(): value});
  });
  return jsonEncode(_new_data);
}

// showNeedLoginDialog(BuildContext context) {
//   // set up the buttons
//   Widget cancelButton = ElevatedButton(
//     style: ElevatedButton.styleFrom(
//         primary: CustomColors.thirdcolor,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
//     child: Text(
//       S.of(context).cancel,
//       style: TextStyle(
//           // fontFamily: globals.SelectedLang == "en"
//           //     ? CustomTheme.fontFamilyEnglish
//           //     : CustomTheme.fontFamilyArabic,
//           fontSize: 14),
//     ),
//     onPressed: () {
//       Navigator.of(context, rootNavigator: true).pop('dialog');
//     },
//   );
//   Widget continueButton = ElevatedButton(
//     style: ElevatedButton.styleFrom(
//         primary: CustomColors.primarycolor,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
//     child: Text(S.of(context).login,
//         style: TextStyle(
//             // fontFamily: globals.SelectedLang == "en"
//             //     ? CustomTheme.fontFamilyEnglish
//             //     : CustomTheme.fontFamilyArabic,
//             fontSize: 14)),
//     onPressed: () {
//       Navigator.of(context, rootNavigator: true).pop('dialog');
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => Login()),
//       );
//     },
//   );
//   // set up the AlertDialog
//   AlertDialog alert = AlertDialog(
//     title: Center(
//         child: Icon(
//       Icons.warning_outlined,
//       color: CustomColors.secondarycolor,
//       size: 50,
//     )),
//     content: Text(
//       S.of(context).please_login_complete,
//       textAlign: TextAlign.center,
//       style: TextStyle(
//         color: CustomColors.primarycolor,
//         fontSize: 16,
//       ),
//     ),
//     actions: [
//       SizedBox(
//         width: 20,
//       ),
//       cancelButton,
//       SizedBox(
//         width: 40,
//       ),
//       continueButton,
//       SizedBox(
//         width: 20,
//       )
//     ],
//   );
//   // show the dialog
//   showDialog(
//     context: context,
//     barrierDismissible: true,
//     builder: (BuildContext context) {
//       return alert;
//     },
//   );
// }

showNeedLoginDialog(BuildContext context) {
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
        heightFactor: 0.45,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(
                  child: Icon(
                Icons.login,
                color: CustomColors.primarycolor,
                size: 70,
              )),
              // Container(
              //   width: 100,
              //   height: 100,
              //   child: Image.asset(
              //     "assets/images/need_login.png",
              //     fit: BoxFit.cover,
              //   ),
              // ),
              Text(
                S.of(context).please_login_first,
                style: TextStyle(
                    fontSize: 20,
                    color: CustomColors.primarycolor,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomButton(
                      primary: CustomColors.primarycolor,
                      radius: 50,
                      text: S.of(context).login,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      }),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

showConfirmDelete(BuildContext context, void Function()? onPressed) {
  // set up the buttons
  Widget cancelButton = ElevatedButton(
    style: ElevatedButton.styleFrom(
        primary: CustomColors.thirdcolor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
    child: Text(
      S.of(context).no,
      style: TextStyle(
          // fontFamily: globals.SelectedLang == "en"
          //     ? CustomTheme.fontFamilyEnglish
          //     : CustomTheme.fontFamilyArabic,
          fontSize: 14),
    ),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop('dialog');
    },
  );
  Widget continueButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: CustomColors.DangerColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      child: Text(S.of(context).yes,
          style: TextStyle(
              // fontFamily: globals.SelectedLang == "en"
              //     ? CustomTheme.fontFamilyEnglish
              //     : CustomTheme.fontFamilyArabic,
              fontSize: 14)),
      onPressed: onPressed);
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Center(
      child: Text(
        S.of(context).warning,
        style: TextStyle(
          fontSize: 16,
          color: CustomColors.DangerColor,
          // fontFamily: globals.SelectedLang == "en"
          //     ? CustomTheme.fontFamilyEnglish
          //     : CustomTheme.fontFamilyArabic
        ),
      ),
    ),
    content: Text(
      S.of(context).do_you_want,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 13,
        // fontFamily: globals.SelectedLang == "en"
        //     ? CustomTheme.fontFamilyEnglish
        //     : CustomTheme.fontFamilyArabic
      ),
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          cancelButton,
          continueButton,
        ],
      )
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showSuccess(
    {required BuildContext context,
    void Function()? onPressed,
    required String message}) {
  // set up the buttons
  Widget cancelButton = ElevatedButton(
    style: ElevatedButton.styleFrom(
        primary: CustomColors.SuccessColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
    child: Text(
      S.of(context).close,
      style: TextStyle(
          // fontFamily: globals.SelectedLang == "en"
          //     ? CustomTheme.fontFamilyEnglish
          //     : CustomTheme.fontFamilyArabic,
          fontSize: 14),
    ),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop('dialog');
    },
  );
  Widget continueButton = ElevatedButton(
      style: ElevatedButton.styleFrom(primary: CustomColors.DangerColor),
      child: Text(S.of(context).yes,
          style: TextStyle(
              // fontFamily: globals.SelectedLang == "en"
              //     ? CustomTheme.fontFamilyEnglish
              //     : CustomTheme.fontFamilyArabic,
              fontSize: 14)),
      onPressed: onPressed);
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    icon: Icon(
      Icons.check_circle_outline_outlined,
      color: CustomColors.SuccessColor,
      size: 40,
    ),
    title: Center(
      child: Text(
        message,
        style: TextStyle(
          fontSize: 18,
          color: CustomColors.SuccessColor,
          // fontFamily: globals.SelectedLang == "en"
          //     ? CustomTheme.fontFamilyEnglish
          //     : CustomTheme.fontFamilyArabic
        ),
      ),
    ),
    /* content: Text(
      message,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 13,
        // fontFamily: globals.SelectedLang == "en"
        //     ? CustomTheme.fontFamilyEnglish
        //     : CustomTheme.fontFamilyArabic
      ),
    ), */
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          cancelButton,
        ],
      )
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showRepayment({
  required BuildContext context,
  void Function()? onConfirmPressed,
  void Function()? onFailedPressed,
}) {
  // set up the buttons
  Widget cancelButton = ElevatedButton(
    style: ElevatedButton.styleFrom(
        primary: CustomColors.DangerColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
    child: Text(
      S.of(context).no,
      style: TextStyle(
          // fontFamily: globals.SelectedLang == "en"
          //     ? CustomTheme.fontFamilyEnglish
          //     : CustomTheme.fontFamilyArabic,
          fontSize: 14),
    ),
    onPressed: onFailedPressed,
  );
  Widget continueButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: CustomColors.SuccessColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      child: Text(S.of(context).yes, style: TextStyle(fontSize: 14)),
      onPressed: onConfirmPressed);

  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    icon: Icon(
      Icons.warning_outlined,
      color: CustomColors.WarningColor,
      size: 40,
    ),
    title: Center(
      child: Text(
        S.of(context).do_you_want_to_repayment,
        style: TextStyle(
          fontSize: 18,
          color: CustomColors.thirdcolor,
        ),
      ),
    ),

    /* content: Text(
      message,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 13,
        // fontFamily: globals.SelectedLang == "en"
        //     ? CustomTheme.fontFamilyEnglish
        //     : CustomTheme.fontFamilyArabic
      ),
    ), */
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [cancelButton, continueButton],
      )
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showDanger(
    {required BuildContext context,
    void Function()? onPressed,
    required String message}) {
  // set up the buttons
  Widget cancelButton = ElevatedButton(
    style: ElevatedButton.styleFrom(
        primary: CustomColors.DangerColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
    child: Text(
      S.of(context).close,
      style: TextStyle(
          // fontFamily: globals.SelectedLang == "en"
          //     ? CustomTheme.fontFamilyEnglish
          //     : CustomTheme.fontFamilyArabic,
          fontSize: 14),
    ),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop('dialog');
    },
  );
  Widget continueButton = ElevatedButton(
      style: ElevatedButton.styleFrom(primary: CustomColors.DangerColor),
      child: Text(S.of(context).yes,
          style: TextStyle(
              // fontFamily: globals.SelectedLang == "en"
              //     ? CustomTheme.fontFamilyEnglish
              //     : CustomTheme.fontFamilyArabic,
              fontSize: 14)),
      onPressed: onPressed);
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    icon: Icon(
      Icons.check_circle_outline_outlined,
      color: CustomColors.DangerColor,
      size: 40,
    ),
    title: Center(
      child: Text(
        message,
        style: TextStyle(
          fontSize: 18,
          color: CustomColors.DangerColor,
          // fontFamily: globals.SelectedLang == "en"
          //     ? CustomTheme.fontFamilyEnglish
          //     : CustomTheme.fontFamilyArabic
        ),
      ),
    ),
    /* content: Text(
      message,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 13,
        // fontFamily: globals.SelectedLang == "en"
        //     ? CustomTheme.fontFamilyEnglish
        //     : CustomTheme.fontFamilyArabic
      ),
    ), */
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          cancelButton,
        ],
      )
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

dismissPreLoader(BuildContext context) {
  Navigator.of(context).pop();
}

Future<void> showPreLoader(BuildContext context) async {
  return showDialog<void>(
    context: context,
    useSafeArea: false,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: CustomColors.primarycolor,
        contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: CircleBorder(),
        content: Container(
          width: 60,
          height: 60,
          child: Center(
              child: CircularProgressIndicator(
            color: Colors.white,
          )),
        ),
      );
    },
  );
}


// Future<void> logout(BuildContext context) async {
//   globals.isLogin = false;

//   globals.userData = null;
//   globals.userId = 0;
//   globals.token = "";
//   globals.userType = "";
//   globals.customer = null;
//   await appStorage().setIsLogin(false);
//   await appStorage().setUserID(null);
//   await appStorage().setToken("");
//   await appStorage().setUserData(null);
//   await appStorage().setUserType("");
//   await appStorage().setCustomer(null);

 

//   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
//     return const MainScreen();
//   }));
// }


// showNeedUpdateInformation(BuildContext context, String message) {
//   // set up the buttons
//   Widget cancelButton = FlatButton(
//     child: Text(
//       AppLocalizations.of(context)!.dont_show_message_again,
//       style: TextStyle(
//           color: Colors.grey,
//           fontFamily: globals.SelectedLang == "en"
//               ? CustomTheme.fontFamilyEnglish
//               : CustomTheme.fontFamilyArabic,
//           fontSize: 9),
//     ),
//     onPressed: () {
//       appStorage().setDontShowUpdateProfileAgain(true);
//       Navigator.of(context, rootNavigator: true).pop('dialog');
//     },
//   );
//   Widget continueButton = FlatButton(
//     child: Text(AppLocalizations.of(context)!.yes_update_it,
//         style: TextStyle(
//             color: CustomColors.primaryColor,
//             fontFamily: globals.SelectedLang == "en"
//                 ? CustomTheme.fontFamilyEnglish
//                 : CustomTheme.fontFamilyArabic,
//             fontSize: 13)),
//     onPressed: () {
//       Navigator.of(context, rootNavigator: true).pop('dialog');
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => EditProfile()),
//       );
//     },
//   );
//   // set up the AlertDialog
//   AlertDialog alert = AlertDialog(
//     title: Text(
//       AppLocalizations.of(context)!.update_your_information,
//       textAlign: TextAlign.center,
//       style: TextStyle(
//           fontSize: 14,
//           color: CustomColors.primaryColor,
//           fontFamily: globals.SelectedLang == "en"
//               ? CustomTheme.fontFamilyEnglish
//               : CustomTheme.fontFamilyArabic),
//     ),
//     content: Text(
//       message,
//       textAlign: TextAlign.center,
//       style: TextStyle(
//           fontSize: 13,
//           fontFamily: globals.SelectedLang == "en"
//               ? CustomTheme.fontFamilyEnglish
//               : CustomTheme.fontFamilyArabic),
//     ),
//     actions: [
//       Container(
//         width: double.infinity,
//         child: Row(
//           children: [
//             cancelButton,
//             continueButton,
//           ],
//         ),
//       )
//     ],
//   );
//   // show the dialog
//   showDialog(
//     context: context,
//     barrierDismissible: true,
//     builder: (BuildContext context) {
//       return alert;
//     },
//   );
// }

// showAlertNeedVerify(BuildContext context, String title, String notes) {
//   // set up the buttons
//   Widget cancelButton = ElevatedButton(
//     style: ElevatedButton.styleFrom(primary: CustomColors.primaryColor),
//     child: Text(
//       AppLocalizations.of(context)!.okay,
//       style: TextStyle(
//           fontFamily: globals.SelectedLang == "en"
//               ? CustomTheme.fontFamilyEnglish
//               : CustomTheme.fontFamilyArabic,
//           fontSize: 14),
//     ),
//     onPressed: () {
//       Navigator.of(context, rootNavigator: true).pop('dialog');
//     },
//   );
//   AlertDialog alert = AlertDialog(
//     title: AppBar(
//       backgroundColor: Colors.transparent,
//       shadowColor: Colors.transparent,
//       leading: Container(),
//       leadingWidth: 0,
//       toolbarHeight: 32,
//       centerTitle: true,
//       title: Text(
//         title,
//         style: TextStyle(color: CustomColors.primaryColor, fontSize: 15),
//       ),
//       /*   actions: [
//         InkWell(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Container(
//             height: 32,
//             width: 34,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(4),
//               border: Border.all(
//                 width: 1.0,
//                 color: Colors.black12,
//               ),
//             ),
//             child: IconButton(
//               padding: EdgeInsets.all(2),
//               onPressed: () => {Navigator.pop(context)},
//               icon: Icon(
//                 Icons.close,
//                 color: CustomColors.skipColor,
//                 size: 12,
//               ),
//             ),
//           ),
//         )
//       ], */
//     ),
//     content: Html(data: notes),
//     actions: [
//       Container(
//         child: cancelButton,
//         alignment: AlignmentDirectional.center,
//         width: double.infinity,
//       ),
//     ],
//   );
//   // show the dialog
//   showDialog(
//     context: context,
//     barrierDismissible: true,
//     builder: (BuildContext context) {
//       return alert;
//     },
//   );
// }

// showAlertNotes(BuildContext context, String title, String notes) {
//   // set up the buttons
//   Widget cancelButton = ElevatedButton(
//     style: ElevatedButton.styleFrom(primary: CustomColors.primaryColor),
//     child: Text(
//       AppLocalizations.of(context)!.close,
//       style: TextStyle(
//           fontFamily: globals.SelectedLang == "en"
//               ? CustomTheme.fontFamilyEnglish
//               : CustomTheme.fontFamilyArabic,
//           fontSize: 14),
//     ),
//     onPressed: () {
//       Navigator.of(context, rootNavigator: true).pop('dialog');
//     },
//   );
//   AlertDialog alert = AlertDialog(
//     title: AppBar(
//       backgroundColor: Colors.transparent,
//       shadowColor: Colors.transparent,
//       leading: Container(),
//       toolbarHeight: 32,
//       centerTitle: true,
//       title: Text(
//         title,
//         style: TextStyle(color: CustomColors.primaryColor, fontSize: 15),
//       ),
//       actions: [
//         InkWell(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Container(
//             height: 32,
//             width: 34,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(4),
//               border: Border.all(
//                 width: 1.0,
//                 color: Colors.black12,
//               ),
//             ),
//             child: IconButton(
//               padding: EdgeInsets.all(2),
//               onPressed: () => {Navigator.pop(context)},
//               icon: Icon(
//                 Icons.close,
//                 color: CustomColors.skipColor,
//                 size: 12,
//               ),
//             ),
//           ),
//         )
//       ],
//     ),
//     content: Html(data: notes),
//     /*    actions: [
//       Container(
//         child: cancelButton,
//         alignment: AlignmentDirectional.center,
//         width: double.infinity,
//       ),
//     ], */
//   );
//   // show the dialog
//   showDialog(
//     context: context,
//     barrierDismissible: true,
//     builder: (BuildContext context) {
//       return alert;
//     },
//   );
// }

// bool check_is_svg(String file) {
//   if (file != "") {
//     var f = file.split(".");
//     if (f.last.toLowerCase() == "svg") {
//       return true;
//     }
//   }
//   return false;
// }

// Widget openMessneger() {
//   return FloatingActionButton(
//     mini: false,
//     onPressed: () async {
//       /* const url = "https://m.me/jibal.Zone";
//       if (await canLaunch(url))
//         await launch(url);
//       else {} */
//     },
//     child: const Icon(
//       LineIcons.facebookMessenger,
//       size: 35,
//     ),
//     backgroundColor: CustomColors.primaryColor,
//   );
// }

// getTagColorLabel(type) {
//   String label = "";
//   Color BgColor = Colors.black;
//   Color TxtColor = Colors.white;
//   double width = 0;
//   switch (type) {
//     case "express":
//       {
//         label = "Express";
//         BgColor = Colors.red;
//         TxtColor = Colors.white;
//         width = 75;
//         break;
//       }
//     case "recently_ordered":
//       {
//         label = "Recently ordered";
//         BgColor = Color(0xfff6d55c);
//         TxtColor = Colors.black;
//         width = 97;
//         break;
//       }
//     case "avialable_again":
//       {
//         label = "Back in Stock";
//         BgColor = CustomColors.primaryColor;
//         TxtColor = Colors.white;
//         width = 77;
//         break;
//       }
//     case "new_arrival":
//       {
//         label = "New Arrival";
//         BgColor = CustomColors.forthColor;
//         TxtColor = Colors.white;
//         width = 68;
//         break;
//       }
//     case "featured":
//       {
//         label = "Featured Item";
//         BgColor = Colors.orange;
//         /* BgColor = Color(0xff173f5f); */
//         TxtColor = Colors.white;
//         width = 81;
//         break;
//       }
//     case "best_selling":
//       {
//         label = "Most Popular";
//         BgColor = Colors.blue;
//         TxtColor = Colors.white;
//         width = 78;
//         break;
//       }
//   }
//   return {
//     "label": label,
//     "BgColor": BgColor,
//     "TxtColor": TxtColor,
//     "width": width
//   };
// }

// Widget getTagWidget(
//     {type,
//     label,
//     BgColor,
//     TxtColor,
//     EdgeInsetsGeometry? padding,
//     EdgeInsetsGeometry? margin,
//     double? height,
//     double? width}) {
//   if (label != "") {
//     return Container(
//       width: width!,
//       padding: padding ?? EdgeInsets.only(right: 4, left: 4),
//       margin: margin ?? EdgeInsets.only(bottom: 4),
//       height: height ?? 18,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(4),
//         color: BgColor,
//       ),
//       child: Row(children: [
//         if (type == 'express')
//           Image.asset(
//             "assets/express.png",
//             width: 22,
//           ),
//         if (type == 'express')
//           const SizedBox(
//             width: 5,
//           ),
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 11,
//             color: TxtColor,
//             fontWeight: FontWeight.w400,
//           ),
//         )
//       ]),
//     );
//   }
//   return Container();
// }

// getTag({id, isMostPopular, isNew, forceTag, bool asArray = false}) {
//   String label = "";
//   Color BgColor = Colors.black;
//   Color TxtColor = Colors.white;
//   double? width = 0;
//   String type = "";
//   if (asArray == false) {
//     if (forceTag != null && forceTag != "") {
//       type = forceTag!;
//     } else if (globals.express_products_ids.indexOf(id) > -1) {
//       type = "express";
//     } else if (globals.recently_ordered_products_ids.indexOf(id) > -1) {
//       type = "recently_ordered";
//     } else if (globals.recently_returned_products_ids.indexOf(id) > -1) {
//       type = "avialable_again";
//     } else if (isNew) {
//       type = "new_arrival";
//     } else if (isMostPopular) {
//       type = "featured";
//     } else if (globals.top_selling_products_ids.indexOf(id) > -1) {
//       type = "best_selling";
//     }
//     var lc = getTagColorLabel(type);
//     label = lc["label"];
//     TxtColor = lc["TxtColor"];
//     BgColor = lc["BgColor"];
//     width = lc["width"];

//     return getTagWidget(
//         type: type,
//         label: label,
//         BgColor: BgColor,
//         TxtColor: TxtColor,
//         width: width);
//   } else {
//     List<Widget> widgets = [];
//     if (globals.express_products_ids.indexOf(id) > -1) {
//       type = "express";
//       var lc = getTagColorLabel(type);
//       label = lc["label"];
//       TxtColor = lc["TxtColor"];
//       BgColor = lc["BgColor"];
//       width = lc["width"];
//       widgets.add(getTagWidget(
//           type: type,
//           label: label,
//           BgColor: BgColor,
//           TxtColor: TxtColor,
//           width: width));
//     }
//     if (globals.recently_ordered_products_ids.indexOf(id) > -1) {
//       type = "recently_ordered";
//       var lc = getTagColorLabel(type);
//       label = lc["label"];
//       TxtColor = lc["TxtColor"];
//       BgColor = lc["BgColor"];
//       width = lc["width"];
//       widgets.add(getTagWidget(
//           type: type,
//           label: label,
//           BgColor: BgColor,
//           TxtColor: TxtColor,
//           width: width));
//     }
//     if (globals.recently_returned_products_ids.indexOf(id) > -1) {
//       type = "avialable_again";
//       var lc = getTagColorLabel(type);
//       label = lc["label"];
//       TxtColor = lc["TxtColor"];
//       BgColor = lc["BgColor"];
//       width = lc["width"];

//       widgets.add(getTagWidget(
//           type: type,
//           label: label,
//           BgColor: BgColor,
//           TxtColor: TxtColor,
//           width: width));
//     }
//     if (isNew) {
//       type = "new_arrival";
//       var lc = getTagColorLabel(type);
//       label = lc["label"];
//       TxtColor = lc["TxtColor"];
//       BgColor = lc["BgColor"];
//       width = lc["width"];

//       widgets.add(getTagWidget(
//           type: type,
//           label: label,
//           BgColor: BgColor,
//           TxtColor: TxtColor,
//           width: width));
//     }
//     if (isMostPopular) {
//       type = "featured";
//       var lc = getTagColorLabel(type);
//       label = lc["label"];
//       TxtColor = lc["TxtColor"];
//       BgColor = lc["BgColor"];
//       width = lc["width"];

//       widgets.add(getTagWidget(
//           type: type,
//           label: label,
//           BgColor: BgColor,
//           TxtColor: TxtColor,
//           width: width));
//     }
//     if (globals.top_selling_products_ids.indexOf(id) > -1) {
//       type = "best_selling";
//       var lc = getTagColorLabel(type);
//       label = lc["label"];
//       TxtColor = lc["TxtColor"];
//       BgColor = lc["BgColor"];
//       width = lc["width"];

//       widgets.add(getTagWidget(
//           type: type,
//           label: label,
//           BgColor: BgColor,
//           TxtColor: TxtColor,
//           width: width));
//     }
//     print("widgets ${widgets.length}");
//     return widgets;
//   }
// }
