import 'package:floating_bottom_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:redeem/custom_widget/custom_circular_menu.dart';
import 'package:redeem/custom_widget/custom_circular_menu_item.dart';
import 'package:redeem/custom_widget/custom_drawer.dart';

import 'package:redeem/generated/l10n.dart';
import 'package:redeem/screens/List_coupons_page/List_coupons_page.dart';
import 'package:redeem/screens/Profile/profile.dart';
import 'package:redeem/screens/all%20offers/all_offers.dart';
import 'package:redeem/screens/all%20purchases/all_purchases.dart';
import 'package:redeem/screens/buy_points/buy_points.dart';
import 'package:redeem/screens/caterory%20Details/category_details.dart';
import 'package:redeem/screens/details_screen_of_providers/details_screen_of_providers.dart';
import 'package:redeem/screens/edit_personal_information/edit_personal_information.dart';
import 'package:redeem/screens/history%20points/history_Points.dart';
import 'package:redeem/screens/home_screen/home_screen.dart';
import 'package:redeem/screens/login/login.dart';
import 'package:redeem/screens/main_screen/main_screen_controller.dart';
import 'package:redeem/screens/providers/providers.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/globals.dart' as globals;
import 'package:redeem/json_db/utils.dart' as utils;
import 'package:redeem/theme/custom_theme.dart';
import 'package:circular_menu/circular_menu.dart';
import 'package:svg_flutter/svg.dart';

class MainScreen extends StatefulWidget {
  const MainScreen();

  @override
  State<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  int currentpage = 0;
  List<Widget> listpage = [
    HomeScreen(),
    ListCouponsPage(),
    Providers(),
    AllOffers(),
    Profile()
  ];

  late PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController(initialPage: 0, keepPage: true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomCircularMenu(
      alignment: Alignment.bottomCenter,
      toggleButtonSize: 30,
      curve: Curves.linear,
      toggleButtonBoxShadow: [],
      items: [
        ...globals.categories.map(
          (e) {
            return CustomCircularMenuItem(
                padding: 2,
                boxShadow: [
                  BoxShadow(color: Colors.black,offset: Offset(0, 0),blurRadius: 2.5,spreadRadius: 0,blurStyle: BlurStyle.outer)
                ],
                child: CircleAvatar(
                  backgroundColor: Color(
                    int.parse(
                      "0XFF" + e.color!.replaceAll("#", ""),
                    ),
                  ),
                  child: SvgPicture.network(
                    e.icon!,
                    fit: BoxFit.cover,
                    width: 25,
                    height: 25,
                  ),
                ),
                color: Color(
                  int.parse(
                    "0XFF" + e.color!.replaceAll("#", ""),
                  ),
                ),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return CategortDetails(
                      Category_name: e.getPropertyEffectedByLang(
                          "name_${globals.SelectedLang}"),
                      Category_icon: e.icon,
                      category_id: e.id,
                      color: Color(
                        int.parse(
                          "0XFF" + e.color!.replaceAll("#", ""),
                        ),
                      ),
                    );
                  }));
                });
          },
        ).toList(),
      ],
      toggleButtonColor: CustomColors.secondarycolor,
      toggleButtonMargin: 27,
      backgroundWidget: Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(25), topLeft: Radius.circular(25)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black38.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: currentpage,
              backgroundColor: CustomColors.primarycolor,
              selectedItemColor: CustomColors.secondarycolor,
              unselectedItemColor: Colors.white,
              selectedFontSize: 12,
              onTap: (int index) {
                if (index != 2) {
                  if (globals.isLogin == false && index == 4) {
                    utils.showNeedLoginDialog(context);
                  } else {
                    currentpage = index;
                    _pageController.jumpToPage(index);
                    setState(() {});
                  }
                }
              },
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.home_outlined),
                  label: S.of(context).home,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.local_activity_outlined),
                  label: S.of(context).coupons,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.add_circle_outline_outlined,
                    color: Colors.transparent,
                  ),
                  label: S.of(context).category,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.star_border_outlined,
                  ),
                  label: S.of(context).offers,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.person_3_outlined),
                  label: S.of(context).account,
                ),
              ],
            ),
          ),
        ),
        body: /* IndexedStack(
          index: currentpage,
          children: listpage,
        ) */

            PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: listpage,
        ),
      ),
    );
  }
}
