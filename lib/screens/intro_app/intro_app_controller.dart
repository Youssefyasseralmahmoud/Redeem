// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:redeem/core/function/generic_controller.dart';
// import 'package:redeem/models/onboardingModel.dart';
// import 'package:redeem/screens/login/login.dart';

// class IntroAppController extends GenericController {
//   int currentpage = 0;
//   late PageController pageController;

//   List<OnBoardingModel> onboradinglst = [
//     OnBoardingModel(
//         title: "Enjoy Loads of deals & \n in 1 app,",
//         subtitle: "Explorer you city's  top spots do some thing every day",
//         image: "assets/images/onboarding1.jpg"),
//     OnBoardingModel(
//         title: "we're here to \n help you save ",
//         subtitle: "Explorer you city's  top spots do some thing every day",
//         image: "assets/images/onboarding2.jpg"),
//     OnBoardingModel(
//         title: "Worldwide value \n at your fingertips",
//         subtitle: "Explorer you city's  top spots do some thing every day",
//         image: "assets/images/onboarding1.jpg"),
//     OnBoardingModel(
//         title: "More holidays ,  More meals \n More Pampering",
//         subtitle: "Explorer you city's  top spots do some thing every day",
//         image: "assets/images/onboarding2.jpg"),
//     OnBoardingModel(
//         title: "",
//         subtitle: "",
//         image: ""),
//   ];

//   void onpagechanged(int index) {
//     currentpage = index;
//     update();
//   }

//   void next() {
//     currentpage++;
//     if (currentpage > onboradinglst.length - 1) {
//       Navigator.of(Get.context!)
//           .pushReplacement(MaterialPageRoute(builder: (context) {
//         return Login();
//       }));
//     } else {
//       pageController.animateToPage(currentpage,
//           duration: Duration(microseconds: 700), curve: Curves.easeInOut);
//     }
//   }

//   @override
//   void onInit() {
//     pageController = new PageController();
//     super.onInit();
//   }
// }
