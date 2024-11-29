
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:redeem_merchant/theme/custom_theme.dart';
// import 'package:redeem_merchant/widgets/app_bar_custom.dart';
// import 'package:redeem_merchant/widgets/custom_back.dart';
// import 'package:redeem_merchant/widgets/custom_loading.dart';
// import 'package:redeem_merchant/widgets/infinte_list_view.dart';

// import '../../json_db/enums.dart';
// import '../../json_db/json_db.dart';

// class Reviews extends StatefulWidget {
//   const Reviews({super.key});

//   @override
//   State<Reviews> createState() => _ReviewsState();
// }

// class _ReviewsState extends State<Reviews> {
//   List<ReviewsData> data = [];
//   int? nextPage;
//   int totalResults = 0;
//   bool isLoading = true;
//   @override
//   void initState() {
//     _reviewsData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator(
//       onRefresh: () async {
//         await _reviewsData();
//       },
//       child: Scaffold(
//           appBar: customAppBarBack(
//               Text(
//                 "Reviews",
//                 style: CustomTheme.whiteRugular,
//               ),
//               leading: CustomBackButton()),
//           body: isLoading == true
//               ? const CustomLoading()
//               : InfiniteListView(
//                   physics: const AlwaysScrollableScrollPhysics(),
//                   hasNext: data.length < totalResults,
//                   nextData: () {
//                     if (nextPage != null) {
//                       _reviewsData(page: nextPage);
//                     }
//                   },
//                   itemBuilder: (context, index) {
//                     return Container(
//                       margin: EdgeInsetsDirectional.symmetric(
//                           horizontal: 15.w, vertical: 5.h),
//                       decoration: const BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.all(Radius.circular(10))),
//                       child: ListTile(
//                         title: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 5),
//                                 child: Text(
//                                   data[index].customer!.fullName!,
//                                   style: CustomTheme.Black18,
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.symmetric(vertical: 5.h),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     RatingBar.builder(
//                                       itemSize: 15,
//                                       initialRating:
//                                           data[index].rating!.toDouble(),
//                                       minRating: 1,
//                                       direction: Axis.horizontal,
//                                       itemCount: 5,
//                                       itemPadding: EdgeInsets.symmetric(
//                                           horizontal: 1.0.w),
//                                       itemBuilder: (context, _) => const Icon(
//                                         Icons.star,
//                                         color: Colors.amber,
//                                       ),
//                                       onRatingUpdate: (rating) {},
//                                     ),
//                                     Row(children: [
//                                       Padding(
//                                         padding: EdgeInsetsDirectional.only(
//                                             end: 5.w),
//                                         child: const Icon(
//                                           Icons.access_time_rounded,
//                                           size: 20,
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding:
//                                             const EdgeInsets.only(top: 2.0),
//                                         child: Text(
//                                           data[index].createdAtFormatted!,
//                                           style: TextStyle(
//                                               color: Colors.grey,
//                                               fontSize: 13.sp),
//                                         ),
//                                       )
//                                     ]),
//                                   ],
//                                 ),
//                               ),
//                             ]),
//                         subtitle: Text(
//                           data[index].review!,
//                           style: CustomTheme.greyNameUsedCouponTheme,
//                         ),
//                       ),
//                     );
//                   },
//                   itemCount: data.length,
//                 )),
//     );
//   }

//   _reviewsData({page = 1}) async {
//     await JsonDb().reviewsGet(page).then((res) {
//       nextPage = res.nextPage;
//       if (res.success) {
//         if (page == 1) {
//           totalResults = res.total_results!;
//           data = res.data!;
//         } else if (page > 1) {
//           var soldCoupon = res.data;
//           soldCoupon?.forEach((element) {
//             data.add(element);
//           });
//         }

//         isLoading = false;
//         setState(() {});
//       }
//     });
//   }
// }
