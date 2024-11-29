// import 'package:awesome_select/awesome_select.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:redeem/core/function/generic_controller.dart';
// import 'package:redeem/json_db/enum.dart';
// import 'package:redeem/json_db/json_db.dart';
// import 'package:redeem/theme/custom_theme.dart';

// class ListCouponsPageController extends GenericController {
//   String? selectedvalue;
//   int? selected_rating;
//   int totalResults = 0;
//   int? nextPage;
//   ScrollController scrollController = ScrollController();

//   RangeValues values = const RangeValues(0, 4);

//   List<S2Choice<String>>? category_item = [
//     S2Choice(value: "1", title: "category1"),
//     S2Choice(value: "2", title: "category2"),
//     S2Choice(value: "3", title: "category3"),
//   ];
//   List<Coupons> coupons = [];
//   bool loading = true;
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
//   print("getdata ");
//     await JsonDb().getCouponsCollections().then((res) {
//       if (res.success) {
//         nextPage = res.nextPage;

//         print("prooooo ${res.nextPage}");
//         if (page == 1) {
//           totalResults = res.totalResult!;
//           coupons = res.data;
//         } else if (page > 1) {
//           var coupon = res.data;
//           coupon.forEach((element) {
//             coupons.add(element);
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
