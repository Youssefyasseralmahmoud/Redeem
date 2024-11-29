import 'package:flutter/material.dart';

import 'package:redeem/app_storage.dart';
import 'package:redeem/custom_widget/CustomAppBar.dart';
import 'package:redeem/custom_widget/custme_button.dart';
import 'package:redeem/custom_widget/custom_back_button.dart';
import 'package:redeem/custom_widget/custom_preloader.dart';
import 'package:redeem/generated/l10n.dart';
import 'package:redeem/json_db/enum.dart';
import 'package:redeem/json_db/json_db.dart';
import 'package:redeem/screens/intro_app/intro_app.dart';
import 'package:redeem/size_config.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';
import 'package:redeem/globals.dart' as globals;

class SelectedCity extends StatefulWidget {
  const SelectedCity({super.key});

  @override
  State<SelectedCity> createState() => _SelectedCity();
}

class _SelectedCity extends State<SelectedCity> {
  List<City> cities = [];
   List<IntroData> listIntrData = [];
  String Selected_city = "";

  bool loading = true;
  int cityId = 0;

  // void changecity(int index) {
  //   indexselected = index;
  //   setState(() {});
  // }
  void setCity(String selectedCity, int City_Id) {
    Selected_city = selectedCity;
    cityId = City_Id;
    setState(() {});
  }

  void saveCity() async {
    print("Selected_city ${Selected_city} ${cityId}");
    globals.city = Selected_city;
    globals.cityId = cityId;

    appStorage().setCity(Selected_city);
    setState(() {});

    await appStorage().setCityId(cityId);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return IntroApp();
    }));
  }

  @override
  void initState() {
    super.initState();
    getData();
    getInreo();
  }

  void getData() async {
    try {
      await JsonDb().getCityCollections().then((res) {
        if (res.success) {
          cities = res.data;
          Selected_city = cities[0]
              .getPropertyEffectedByLang("name_${globals.SelectedLang}");

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
    void getInreo() async {
    try {
      await JsonDb().getIntroCollections().then((res) {
        if (res.success) {
          print("getIntroData succes");
          listIntrData = res.data;
          globals.listInreoData = listIntrData;

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
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: CustomColors.backgroundcolor,
      appBar: AppBar(
        elevation: 0,
        leading: CustomBackButton(),
        backgroundColor: CustomColors.primarycolor,
      ),
      bottomNavigationBar: Container(
        height: 76,
        width: double.infinity,
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 15.0, vertical: 10),
          width: responsive_size(450, asMaxSize: true),
          child: CustomButton(
              text: S.of(context).continuee,
              onPressed: () {
                saveCity();
              }),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            width: responsive_size(450, asMaxSize: true),
            child: Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 15.0),
              child: SingleChildScrollView(
                child: Column(children: [
                  Text(
                    S.of(context).select_your_city,
                    style: CustomTheme.text18theme,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ...cities.map((e) {
                    return GestureDetector(
                        onTap: () {
                          setCity(
                              e.getPropertyEffectedByLang(
                                  "name_${globals.SelectedLang}"),
                              e.id!);
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 20),
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 56,
                          padding:
                              EdgeInsetsDirectional.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(CustomTheme.radius),
                              border:
                                  Border.all(width: 2, color: Colors.white)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  e.getPropertyEffectedByLang(
                                      "name_${globals.SelectedLang}"),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Selected_city ==
                                              e.getPropertyEffectedByLang(
                                                  "name_${globals.SelectedLang}")
                                          ? CustomColors.primarycolor
                                          : Colors.grey.shade400),
                                ),
                                if (Selected_city ==
                                    e.getPropertyEffectedByLang(
                                        "name_${globals.SelectedLang}"))
                                  Icon(
                                    Icons.check,
                                    color: CustomColors.secondarycolor,
                                  ),
                              ]),
                        )

                        /*     Container(
                                          margin: EdgeInsetsDirectional.only(
                                              bottom: 15),
                                          width: MediaQuery.of(context).size.width *
                                              0.2,
                                          height:
                                              MediaQuery.of(context).size.height *
                                                  0.07,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                CustomTheme.radius),
                                          ),
                                          child: ListTile(
                                            title: Text(
                                              cities[index].getPropertyEffectedByLang(
                                                  "name_${globals.SelectedLang}"),
                                              style: TextStyle(
                                                  color: Selected_city ==
                                                          cities[index]
                                                              .getPropertyEffectedByLang(
                                                                  "name_${globals.SelectedLang}")
                                                      ? Colors.orange[300]
                                                      : Colors.black),
                                            ),
                                            trailing: Selected_city ==
                                                    cities[index]
                                                        .getPropertyEffectedByLang(
                                                            "name_${globals.SelectedLang}")
                                                ? Icon(
                                                    Icons.check,
                                                    color:
                                                        CustomColors.secondarycolor,
                                                  )
                                                : Container(
                                                    width: 0,
                                                    height: 0,
                                                  ),
                                          ),
                                        ), */
                        );
                  })
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
