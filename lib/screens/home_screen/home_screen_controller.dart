// import 'package:awesome_select/awesome_select.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:redeem/core/function/generic_controller.dart';
// import 'package:redeem/json_db/enum.dart';
// import 'package:redeem/json_db/json_db.dart';
// import 'package:redeem/theme/custom_theme.dart';

// class HomeScreenController extends GenericController{
//  // List<String> citys=["جدة","الرياض","دبي"];

//     List<S2Choice<String>>? choisecitygitem=[
//       S2Choice(value: "1", title: "Dubai"),
//        S2Choice(value: "2", title: "Riad"),
//         S2Choice(value: "3", title: "Jadah"),
        
//     ];
//     List<Coupons> coupons=[];
//     bool loading =false;
//   String? hintcityselected="اختر المدينة";
//   late var type;
 
//    late PageController pageController;
//    int currentpage = 0;
//    int current_our_news_page = 0;
 

//   changedepartment(String value){
//     hintcityselected=value;
//     update();
//   }

// void onpagechanged(int index) {
//     currentpage = index;
//     update();
//   }

//   void onpage_oure_news_changed(int index) {
//     current_our_news_page = index;
//     update();
//   }
//   @override
//   void onReady() {
//     super.onReady();
//     getData();
//   }

//   void getData() async {
//    // try {
//       await JsonDb().getCouponsCollections().then((res) {
//         if (res.success) {
//           coupons = res.data;

//           loading = false;

//           update();
//         } else {
//           if (res.has_errors) {
//             ScaffoldMessenger.of(Get.context as BuildContext).showSnackBar(
//               CustomTheme.CustomSnackBar(res.errors[0], "error"),
//             );
//           } else {
//             ScaffoldMessenger.of(Get.context as BuildContext).showSnackBar(
//               CustomTheme.CustomSnackBar(res.message, "error"),
//             );
//           }
//         }
//       });
//   //  } 
//     // catch (e) {
//     //   ScaffoldMessenger.of(Get.context as BuildContext).showSnackBar(
//     //     CustomTheme.CustomSnackBar(S.of(context).Internet_connection_error, "warning"),
//     //   );
//     // }
//   }
 

//    @override
//   void onInit() {
//     pageController = new PageController();
//     super.onInit();
//   }

// }