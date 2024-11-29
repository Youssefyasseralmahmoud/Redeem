import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:redeem/app_storage.dart';

import 'package:redeem/core/function/generic_controller.dart';
import 'package:redeem/core/function/notification_state_controller.dart';
import 'package:redeem/generated/l10n.dart';
import 'package:redeem/json_db/enum.dart';
import 'package:redeem/json_db/utils.dart';
import 'package:redeem/main.dart';
import 'package:redeem/screens/ContactUs.dart';
import 'package:redeem/screens/DetailsPages/details_pages.dart';
import 'package:redeem/screens/Join%20Invitation/Join_Invitation.dart';
import 'package:redeem/screens/JoinUs.dart';
import 'package:redeem/screens/List_coupons_page/List_coupons_page.dart';
import 'package:redeem/screens/MyCoupons/my_coupons.dart';
import 'package:redeem/screens/Notifications/notifications.dart';
import 'package:redeem/screens/all%20purchases/all_purchases.dart';
import 'package:redeem/screens/buy_points/buy_points.dart';
import 'package:redeem/screens/cart_screen/cart_screen_controller.dart';
import 'package:redeem/screens/change_password/change_password.dart';
import 'package:redeem/screens/edit_personal_information/edit_personal_information.dart';
import 'package:redeem/screens/history%20points/history_Points.dart';
import 'package:redeem/screens/login/login.dart';
import 'package:redeem/screens/main_screen/main_screen.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';
import 'package:svg_flutter/svg.dart';
import 'package:redeem/globals.dart' as globals;

// ignore: must_be_immutable
class CustomDrawer extends StatefulWidget {
  List<City> cities;
  List<S2Choice<String>> choiselangitem;
  // List<S2Choice<String>> choisecitygitem;
  CustomDrawer({super.key, required this.choiselangitem, required this.cities});

  @override
  State<CustomDrawer> createState() => _CustomDrawer();
}

class _CustomDrawer extends State<CustomDrawer> {
  int CityId = 0;

  void setcity(int cityid) {
    CityId = cityid;
    // setState(() {});
    if (CityId != 0) {
      globals.cityId = CityId;

      appStorage().setCityId(CityId);

      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return const MainScreen();
      }));
      // setState(() {});
      /*  ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        CustomTheme.CustomSnackBar("city is changed", "success"),
      ); */
    }
  }

  String selectlanguage = "";
  void setLanguage(String _selectedLang) {
    selectlanguage = _selectedLang;
    setState(() {});
    if (!selectlanguage.isEmpty) {
      globals.SelectedLang = selectlanguage;
      print(" lang is ${selectlanguage}");
      appStorage().setLang(selectlanguage);
      MyApp.setLocale(context, selectlanguage);
      setState(() {});
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return const MainScreen();
      }));
    }
  }

  // void saveLanguage() {
  //   if (!selectlanguage.isEmpty) {
  //     globals.SelectedLang = selectlanguage;
  //     print(" lang is ${selectlanguage}");
  //     appStorage().setLang(selectlanguage);
  //     MyApp.setLocale(context, selectlanguage);
  //     //Get.updateLocale(Locale(selectlanguage));
  //   }
  // }
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool is_switched = false;

  change_switch_case(bool val) {
    is_switched = val;
    // showPreLoader();
    // await new Timer(2.seconds, () {
    //   dismissPreLoader();
    // });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      surfaceTintColor: Colors.black,
      shadowColor: Colors.black,
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              elevation: 0,
              leading: Container(width: 0),
              leadingWidth: 0,
              backgroundColor: CustomColors.primarycolor,
              title: SizedBox(
                width: 100,
                child: SvgPicture.asset(
                    "assets/images/logo-text-redeem-white.svg"),
              ),
              actions: [
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(end: 10),
                      child: Icon(Icons.close, color: Colors.white),
                    )),
              ],
            ),
            ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsetsDirectional.only(
                      start: 25, end: 15, bottom: 0, top: 0),
                  child: SmartSelect.single(
                    modalType: S2ModalType.popupDialog,
                    modalConfig: S2ModalConfig(
                        style: S2ModalStyle(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            elevation: 0),
                        title: S.of(context).change_language,
                        headerStyle: S2ModalHeaderStyle(
                            textStyle: TextStyle(
                                color: CustomColors.primarycolor,
                                fontSize: 16))),

                    selectedValue: globals.SelectedLang,
                    title: "",
                    tileBuilder: (context, value) {
                      return GestureDetector(
                        onTap: () {
                          value.showModal();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.of(context).change_language,
                              style: TextStyle(
                                  color: CustomColors.primarycolor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            ),
                            Spacer(),
                            Text(value.selected.title ?? ""),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      );
                    },
                    //  modalHeader: false,

                    placeholder: S.of(context).select,
                    choiceItems: globals.Language2,
                    onChange: (value) {
                      setLanguage(value.value.toString());
                    },
                  ),
                ),
                const Divider(
                  height: 0,
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsetsDirectional.only(
                      start: 25, end: 15, bottom: 0, top: 0),
                  child: SmartSelect.single(
                    modalHeaderStyle: S2ModalHeaderStyle(
                        iconTheme:
                            IconThemeData(color: CustomColors.primarycolor),
                        textStyle: TextStyle(color: CustomColors.primarycolor),
                        backgroundColor:
                            CustomColors.backgroundcolor_for_Ticket),
                    selectedValue: globals.cityId,
                    title: "",
                    tileBuilder: (context, value) {
                      return GestureDetector(
                        onTap: () {
                          value.showModal();
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.of(context).city,
                                style: TextStyle(
                                    color: CustomColors.primarycolor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                              Spacer(),
                              Text(value.selected.title ?? ""),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    placeholder: "",
                    choiceItems: [
                      ...globals.cities.map((e) => S2Choice(
                          title: e.getPropertyEffectedByLang(
                              "name_${globals.SelectedLang}"),
                          value: e.id!))
                    ],
                    onChange: (res) {
                      setcity(res.value);
                    },
                  ),
                ),
                const Divider(
                  height: 0,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                      start: 25, end: 20, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).notifications,
                        style: CustomTheme.text16theme.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: CustomColors.primarycolor),
                      ),
                      Transform.scale(
                        scale: 1.4,
                        child: Switch(
                            value: is_switched,
                            activeColor: CustomColors.secondarycolor,
                            onChanged: (value) {
                              change_switch_case(value);
                            }),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 0,
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return DetailsPage(
                        keyword: "about-us",
                      );
                    }));
                  },
                  leading: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return DetailsPage(
                            keyword: "about-us",
                          );
                        }));
                      },
                      child: Text(
                        S.of(context).about_app,
                        style: CustomTheme.text16theme.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: CustomColors.primarycolor),
                      )),
                  trailing: const Icon(Icons.info_outline),
                ),
                Divider(
                  height: 0,
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return DetailsPage(
                        keyword: "privacy-policy",
                      );
                    }));
                  },
                  leading: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return DetailsPage(
                            keyword: "privacy-policy",
                          );
                        }));
                      },
                      child: Text(
                        S.of(context).Privacy,
                        style: CustomTheme.text16theme.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: CustomColors.primarycolor),
                      )),
                  trailing: const Icon(Icons.info_outline),
                ),
                Divider(
                  height: 0,
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return JoinUs(
                        pagename: "contact",
                      );
                    }));
                  },
                  leading: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return JoinUs(
                            pagename: "contact",
                          );
                        }));
                      },
                      child: Text(
                        S.of(context).contact_us,
                        style: CustomTheme.text16theme.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: CustomColors.primarycolor),
                      )),
                  trailing: const Icon(Icons.contact_phone_outlined),
                ),
                Divider(
                  height: 0,
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return JoinUs(
                        pagename: "join",
                      );
                    }));
                  },
                  leading: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return JoinUs(
                            pagename: "join",
                          );
                        }));
                      },
                      child: Text(
                        S.of(context).join_us,
                        style: CustomTheme.text16theme.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: CustomColors.primarycolor),
                      )),
                  trailing: const Icon(Icons.person_2_outlined),
                ),
                Divider(
                  height: 0,
                )
              ],
            ),
            Container(
              margin: EdgeInsetsDirectional.only(top: 50),
              decoration: BoxDecoration(),
              padding: const EdgeInsetsDirectional.symmetric(vertical: 15),
              width: double.infinity,
              child: const Column(children: [
                Text(
                  "Redeem",
                  style:
                      TextStyle(fontSize: 13, color: CustomColors.thirdcolor),
                ),
                SizedBox(
                  height: 5,
                ),
                Text("Version 1.0",
                    style: TextStyle(
                        fontSize: 13, color: CustomColors.thirdcolor)),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
