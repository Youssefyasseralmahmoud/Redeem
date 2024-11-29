// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:redeem/core/function/generic_controller.dart';
// import 'package:redeem/theme/colors.dart';

// class Logincontroller extends GenericController {
 


 
//   @override
//   onInit() {
//     super.onInit();
//     print("oninit login");
//   }

//   bool issecure = true;
//   bool? isnum;

//   final formLoginKey = GlobalKey<FormState>();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController emailController = TextEditingController();

//   void changesecure() {
//     issecure = !issecure;
//     update();
//   }
//   void updatimg(){
// update();
//   }

//   void submit() {
//     showPreLoader();
//     if (formLoginKey.currentState!.validate()) {
//       print(passwordController.value.text);
//     }
//     Timer(Duration(seconds: 5), () {
//       dismissPreLoader();
//     });
//   }
// }
