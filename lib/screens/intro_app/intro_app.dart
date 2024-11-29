//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:redeem/generated/l10n.dart';
import 'package:redeem/models/onboardingModel.dart';
import 'package:redeem/screens/login/login.dart';
import 'package:redeem/screens/intro_app/intro_app_controller.dart';
import 'package:redeem/size_config.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';
import 'package:redeem/globals.dart' as globals;
import 'package:svg_flutter/svg_flutter.dart';
//class IntroApp extends GetView<IntroAppController>

class IntroApp extends StatefulWidget {
  const IntroApp({super.key});

  @override
  State<IntroApp> createState() => _IntroApp();
}

class _IntroApp extends State<IntroApp> {
  int currentpage = 0;
  PageController pageController = PageController();

  // List<OnBoardingModel> onboradinglst = [
  //   OnBoardingModel(
  //       title: "Enjoy Loads of deals & \n in 1 app,",
  //       subtitle: "Explorer you city's  top spots do some thing every day",
  //       image: "assets/images/onboarding1.jpg"),
  //   OnBoardingModel(
  //       title: "we're here to \n help you save ",
  //       subtitle: "Explorer you city's  top spots do some thing every day",
  //       image: "assets/images/onboarding2.jpg"),
  //   OnBoardingModel(
  //       title: "Worldwide value \n at your fingertips",
  //       subtitle: "Explorer you city's  top spots do some thing every day",
  //       image: "assets/images/onboarding1.jpg"),
  //   OnBoardingModel(
  //       title: "More holidays ,  More meals \n More Pampering",
  //       subtitle: "Explorer you city's  top spots do some thing every day",
  //       image: "assets/images/onboarding2.jpg"),
  //   OnBoardingModel(title: "", subtitle: "", image: ""),
  // ];

  void onpagechanged(int index) {
    currentpage = index;
    setState(() {});
  }

  void next() {
    currentpage++;
    if (currentpage > globals.listInreoData.length - 1) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return Login();
      }));
    } else {
      pageController.animateToPage(currentpage,
          duration: Duration(microseconds: 700), curve: Curves.easeInOut);
    }
  }

  @override
  void initstate() {
    super.initState();
    // pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Container(
            height: double.infinity,
          ),
          Container(
            padding: EdgeInsetsDirectional.only(top: 56),
            height: SizeConfig.screenHeight! - 56 - 220,
            alignment: Alignment.center,
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (value) {
                onpagechanged(value);

                if (value > globals.listInreoData.length) {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return Login();
                  }));
                }
              },
              itemCount: globals.listInreoData.length,
              itemBuilder: (context, index) {
                if (currentpage == globals.listInreoData.length) {
                  return Container(
                    color: CustomColors.backgroundcolor,
                  );
                }
                return Container(
                  margin: EdgeInsetsDirectional.all(30),

                  child: SvgPicture.network(
                    "${globals.listInreoData[index].image}",
                  ),
                  // decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //         image:
                  //         // NetworkImage(
                  //         //     "${globals.listInreoData[index].image}"),
                  //         fit: BoxFit.cover)),
                );
              },
            ),
          ),
          if (currentpage == globals.listInreoData.length)
            Container()
          else
            PositionedDirectional(
                bottom: 0,
                child: Container(
                  padding: const EdgeInsetsDirectional.all(30),
                  width: MediaQuery.of(context).size.width,
                  height: 220,
                  decoration: const BoxDecoration(
                      color: CustomColors.primarycolor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${globals.listInreoData[currentpage].title}",
                          style: CustomTheme.text20theme
                              .copyWith(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "${globals.listInreoData[currentpage].brief}",
                          style: CustomTheme.text15theme
                              .copyWith(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ...List.generate(
                                    globals.listInreoData.length,
                                    (index) => AnimatedContainer(
                                        curve: Curves.easeInOut,
                                        margin:
                                            EdgeInsetsDirectional.only(end: 5),
                                        width: currentpage == index ? 25 : 5,
                                        height: 6,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        duration:
                                            const Duration(microseconds: 700)))
                              ],
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(
                                onPressed: () {
                                  next();
                                },
                                icon: const Icon(
                                  Icons.arrow_forward_sharp,
                                  color: CustomColors.primarycolor,
                                ),
                              ),
                            )
                          ],
                        )
                      ]),
                )),
          PositionedDirectional(
              end: 10,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context!)
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return Login();
                  }));
                },
                // ignore: prefer_const_constructors
                child: Text(
                  S.of(context).skip,
                  style: CustomTheme.text15theme
                      .copyWith(color: CustomColors.primarycolor),
                ),
              ))
        ]),
      ),
    );
  }
}
