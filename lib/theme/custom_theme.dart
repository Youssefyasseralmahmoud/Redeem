import 'package:flutter/material.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/globals.dart' as globals;

class CustomTheme {

  

  static TextStyle text15theme = const TextStyle(
    color: Colors.white,
    fontSize: 15,
    fontWeight: FontWeight.normal,
  );
  static TextStyle text_black15theme = const TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );
    static TextStyle text_grey15theme = const TextStyle(
    color: CustomColors.subtitlecolor,
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );

  static TextStyle text16theme = const TextStyle(
    color: CustomColors.secondarytitlecolor,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static TextStyle text18theme = const TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.normal,
  );

  static TextStyle text_white20theme = const TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.normal,
  );

  static TextStyle text20theme = const TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static double radius=50;


  static SnackBar CustomSnackBar(String message, String type) {
    late final Color backgroundColor;
    Color textColor = Colors.white;
    switch (type) {
      case "success":
        {
          backgroundColor = CustomColors.SuccessColor;
          break;
        }
      case "danger":
        {
          backgroundColor = CustomColors.DangerColor;
          break;
        }
      case "warning":
        {
          backgroundColor = CustomColors.WarningColor;
          textColor = Color(0xFF323232);
          break;
        }
      default:
        {
          backgroundColor = Color(0xFF323232);
          textColor = Colors.white;
          break;
        }
    }
    return SnackBar(
      content: Text(
        message,
        style: TextStyle(
            // fontFamily: globals.SelectedLang == "en"
            //     ? CustomTheme.fontFamilyEnglish
            //     : CustomTheme.fontFamilyArabic,
            color: textColor),
      ),
      backgroundColor: backgroundColor,
    );
  }

}
