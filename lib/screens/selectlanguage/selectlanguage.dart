import 'package:flutter/material.dart';

import 'package:redeem/app_storage.dart';
import 'package:redeem/custom_widget/CustomAppBar.dart';
import 'package:redeem/custom_widget/custme_button.dart';
import 'package:redeem/generated/l10n.dart';
import 'package:redeem/json_db/enum.dart';
import 'package:redeem/json_db/json_db.dart';
import 'package:redeem/main.dart';
import 'package:redeem/screens/Seleted_City/Selected_city.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:redeem/globals.dart' as globals;

class SelectLanguage extends StatefulWidget {
  const SelectLanguage({super.key});

  @override
  State<SelectLanguage> createState() => _SelectLanguage();
}

class _SelectLanguage extends State<SelectLanguage> {
  String selectlanguage = "en";
 

  void setLanguage(String _selectedLang) {
    selectlanguage = _selectedLang;

    setState(() {});
  }

  void saveLanguage() {
    if (!selectlanguage.isEmpty) {
      globals.SelectedLang = selectlanguage;
      print(" lang is ${selectlanguage}");
      appStorage().setLang(selectlanguage);
      // globals.isfirstTime = false;

      appStorage().setIsFirstTime(true);
      MyApp.setLocale(context, selectlanguage);
      //Get.updateLocale(Locale(selectlanguage));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundcolor,
      /*  appBar: CustomAppBar(
        elevation: 0,
        backgroundColor: CustomColors.appbarbackgroundcolor,
      ), */
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 20.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            // SizedBox(height: 30,),
            Container(
              width: 100,
              height: 100,
              child: SvgPicture.asset(
                "assets/images/logo.svg",
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              "Select Your Language",
              style: CustomTheme.text18theme,
            ),
            const SizedBox(
              height: 20,
            ),

            GestureDetector(
              onTap: () {
                setLanguage("en");
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 56,
                padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(CustomTheme.radius),
                    border: Border.all(width: 2, color: Colors.white)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "English",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: selectlanguage == "en"
                                ? CustomColors.primarycolor
                                : Colors.grey.shade400),
                      ),
                      if (selectlanguage == "en")
                        Icon(
                          Icons.check,
                          color: CustomColors.secondarycolor,
                        ),
                    ]),
              ),
            ),

            SizedBox(
              height: 20,
            ),

            GestureDetector(
              onTap: () {
                setLanguage("ar");
              },
              child: Container(
                  clipBehavior: Clip.hardEdge,
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 56,
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(CustomTheme.radius),
                      border: Border.all(width: 2, color: Colors.white)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "العربية",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: selectlanguage == "ar"
                                  ? CustomColors.primarycolor
                                  : Colors.grey.shade400),
                        ),
                        if (selectlanguage == "ar")
                          Icon(
                            Icons.check,
                            color: CustomColors.secondarycolor,
                          ),
                      ])),
            ),
            SizedBox(
              height: 50,
            ),
            CustomButton(
              text: "Continue",
              onPressed: () {
                saveLanguage();

                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return SelectedCity();
                }));
              },
            )
          ]),
        ),
      ),
    );
  }
}
