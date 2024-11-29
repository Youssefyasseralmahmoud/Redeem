// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:redeem/custom_widget/custom_coupon.dart';
// import 'package:redeem/json_db/enum.dart';
// import 'package:redeem/screens/details_coupon/details_coupon.dart';
// import 'package:redeem/screens/home_screen/home_screen_controller.dart';
// import 'package:redeem/screens/offer_details/offer_details.dart';
// import 'package:redeem/theme/colors.dart';
// import 'package:redeem/globals.dart' as globals;

// class CustomCarouselItems extends StatefulWidget {
//     String? title;
//    List<Coupons> coupons;
//   dynamic Function(int, CarouselPageChangedReason)? onPageChanged;
//   void Function()? onPressedview;
//   CustomCarouselItems({super.key,required this.coupons,this.onPageChanged,this.title,this.onPressedview});

//   @override
//   State<CustomCarouselItems> createState() => _CustomCarouselItems();
// }

// class _CustomCarouselItems extends State<CustomCarouselItems> {


//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsetsDirectional.symmetric(horizontal: 8),
//             child: Row(
//               children: [
//                 Text(
//                   "${widget.title}",
//                   style: const TextStyle(
//                       fontSize: 20,
//                       color: CustomColors.primarycolor,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 const Spacer(),
//                 TextButton(
//                   onPressed: widget.onPressedview,
//                   child: Wrap(
//                     crossAxisAlignment: WrapCrossAlignment.center,
//                     children: [
//                       Text(
//                         "see_all".tr,
//                         style: const TextStyle(
//                             color: CustomColors.primarycolor,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       const Icon(
//                         Icons.arrow_right,
//                         size: 30,
//                         color: CustomColors.primarycolor,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           Container(
//             width: double.infinity,
//             height: 240,
//             child: ListView.builder(
//               shrinkWrap: true,
//               scrollDirection: Axis.horizontal,
//               itemCount: widget.coupons.length,
//               itemBuilder: ((context, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.of(context)
//                         .push(MaterialPageRoute(builder: (context) {
//                       return const DetailsCoupon();
//                     }));
//                   },
//                   child: Padding(
//                     padding:
//                         const EdgeInsetsDirectional.symmetric(horizontal: 10),
//                     child: SizedBox(
//                       width: 160,
//                       child: CustomCoupon(

//                           imageurl: "${widget.coupons[index].image}",
//                           old_price: "${widget.coupons[index].priceBeforeDiscount}",
//                           price: "50",
//                           name:
//                               "${widget.coupons[index].getPropertyEffectedByLang("name_${globals.SelectedLang}")}",
//                           valid_date: " 24-2024"),
//                     ),
//                   ),
//                 );
//               }),
//             ),
//           ),
//           const SizedBox(height: 13),
//           // GetBuilder<HomeScreenController>(builder: (_) {
//           //   return Padding(
//           //     padding: const EdgeInsetsDirectional.symmetric(horizontal: 10.0),
//           //     child: Row(
//           //       mainAxisAlignment: MainAxisAlignment.center,
//           //       children: [
//           //         ...List.generate(
//           //             5,
//           //             (index) => AnimatedContainer(
//           //                 curve: Curves.easeInOut,
//           //                 margin: const EdgeInsetsDirectional.only(end: 5),
//           //                 width: controller.current_our_news_page == index
//           //                     ? 15
//           //                     : 5,
//           //                 height: 6,
//           //                 decoration: BoxDecoration(
//           //                     color: controller.current_our_news_page == index
//           //                         ? CustomColors.primarycolor
//           //                         : CustomColors.thirdcolor,
//           //                     borderRadius: BorderRadius.circular(50)),
//           //                 duration: const Duration(microseconds: 700)))
//           //       ],
//           //     ),
//           //   );
//           // }),
//         ],
//       ),
//     );
//   }
// }
