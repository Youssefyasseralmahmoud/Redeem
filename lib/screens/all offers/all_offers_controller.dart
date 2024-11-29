// import 'package:awesome_select/awesome_select.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:redeem/core/function/generic_controller.dart';
// import 'package:redeem/json_db/enum.dart';
// import 'package:redeem/json_db/json_db.dart';
// import 'package:redeem/theme/custom_theme.dart';

// class AllOffersController extends GenericController {
//   String? selectedvalue;
//   int selected_rating = 0;
//   List<Offers> offers = [];
//   List<SimpleProvider> provier_info = [];
//   int totalResults = 0;
//   int? nextPage;
//   ScrollController scrollController = ScrollController();
//   bool loading = true;

//   RangeValues values = const RangeValues(0, 6);

//   List<S2Choice<String>>? offers_category_item = [
//     S2Choice(value: "1", title: "offer 1"),
//     S2Choice(value: "2", title: "offer 2"),
//     S2Choice(value: "3", title: "offers 3"),
//   ];

//   void selectsorting(String value) {
//     selectedvalue = value;
//     update();
//   }

//   void selectrating(int rating) {
//     selected_rating = rating;
//     update();
//   }

//   void change_range_slider(var newvalues) {
//     values = newvalues;

//     update();
//   }

//   @override
//   void onReady() {
//     super.onReady();

//     getData();
//   }

//   void getData({page = 1}) async {
//     // try {
// print("getdata ");
//     await JsonDb().getOffersCollections().then((res) {
//       if (res.success) {
//         nextPage = res.nextPage;
     

//         if (page == 1) {
//           totalResults = res.totalResult!;
//           offers = res.data;
//         } else if (page > 1) {
//           var offer = res.data;
//           offer.forEach((element) {
//             offers.add(element);
//           });
//         }

//         loading = false;

//         update();
//       } else {
//         if (res.has_errors) {
//           ScaffoldMessenger.of(Get.context as BuildContext).showSnackBar(
//             CustomTheme.CustomSnackBar(res.errors[0], "error"),
//           );
//         } else {
//           ScaffoldMessenger.of(Get.context as BuildContext).showSnackBar(
//             CustomTheme.CustomSnackBar(res.message, "error"),
//           );
//         }
//       }
//     });
//     // } catch (e) {
//     //   ScaffoldMessenger.of(Get.context as BuildContext).showSnackBar(
//     //     CustomTheme.CustomSnackBar(S.of(context).Internet_connection_error, "warning"),
//     //   );
//     // }
//   }
// }
