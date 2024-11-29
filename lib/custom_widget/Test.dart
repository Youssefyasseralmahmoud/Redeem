
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:redeem_merchant/core/constant/colors.dart';
// import 'package:redeem_merchant/theme/custom_theme.dart';
// import 'package:redeem_merchant/util/loader.dart';
// import 'package:redeem_merchant/widgets/app_bar_custom.dart';
// import 'package:redeem_merchant/widgets/custom_back.dart';
// import 'package:redeem_merchant/widgets/custom_button.dart';
// import 'package:redeem_merchant/widgets/custom_loading.dart';
// import 'package:redeem_merchant/widgets/custom_text_form_feild.dart';
// import 'package:redeem_merchant/widgets/infinte_list_view.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import '../../json_db/enums.dart';
// import '../../json_db/json_db.dart';

// class Reviews extends StatefulWidget {
//   const Reviews({super.key});

//   @override
//   State<Reviews> createState() => _ReviewsState();
// }

// class _ReviewsState extends State<Reviews> {
//   bool isLoadingReply = true;
//   bool isSuccesReply = false;
//   bool sizeText = false;
//   List<ReviewsData> data = [];
//   int? nextPage;
//   int totalResults = 0;
//   bool isLoading = true;
//   TextEditingController replyController = TextEditingController();
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
//                               Row(
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                         top: 5, bottom: 5, right: 8),
//                                     child: Text(
//                                       data[index].customer!.fullName!,
//                                       style: CustomTheme.Black18,
//                                     ),
//                                   ),
//                                   RatingBar.builder(
//                                     ignoreGestures: true,
//                                     allowHalfRating: true,
//                                     itemSize: 15,
//                                     initialRating:
//                                         data[index].rating!.toDouble(),
//                                     minRating: 1,
//                                     direction: Axis.horizontal,
//                                     itemCount: 5,
//                                     itemPadding:
//                                         EdgeInsets.symmetric(horizontal: 1.0.w),
//                                     itemBuilder: (context, _) => const Icon(
//                                       Icons.star,
//                                       color: Colors.amber,
//                                     ),
//                                     onRatingUpdate: (rating) {},
//                                   ),
//                                 ],
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.symmetric(vertical: 4.h),
//                                 child: Row(children: [
//                                   Padding(
//                                     padding:
//                                         EdgeInsetsDirectional.only(end: 5.w),
//                                     child: const Icon(
//                                       Icons.access_time_rounded,
//                                       size: 15,
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding:
//                                         EdgeInsets.symmetric(vertical: 0.h),
//                                     child: Text(
//                                       data[index].createdAtFormatted!,
//                                       style: TextStyle(
//                                           color: Colors.grey, fontSize: 12.sp),
//                                     ),
//                                   )
//                                 ]),
//                               ),
//                             ]),
//                         subtitle: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.only(bottom: 5.h, top: 4.h),
//                               child: Text(
//                                 data[index].review!,
//                                 style: CustomTheme.greyNameUsedCouponTheme,
//                               ),
//                             ),
//                             const Divider(
//                               height: 4,
//                             ),
//                             (data[index].isReply == 0)
//                                 ? Padding(
//                                     padding: EdgeInsetsDirectional.only(
//                                         start:
//                                             MediaQuery.of(context).size.width -
//                                                 150),
//                                     child: SizedBox(
//                                         width: 70.w,
//                                         child: CustomButton(
//                                           height: 25,
//                                           onPressed: () {
//                                             sizeText = false;

//                                             _showModelSheet(index);
//                                           },
//                                           title: AppLocalizations.of(context)!
//                                               .reply,
//                                           textStyle:
//                                               CustomTheme.whiteTekZoneRugular,
//                                           color: CustomColors.secondarycolor,
//                                         )),
//                                   )
//                                 : Padding(
//                                     padding:
//                                         const EdgeInsets.symmetric(vertical: 5),
//                                     child: Row(
//                                       children: [
//                                         const Icon(
//                                             Icons.subdirectory_arrow_right),
//                                         Text(
//                                           data[index].reply!,
//                                           style: CustomTheme.Black15,
//                                         ),
//                                       ],
//                                     ),
//                                   )
//                           ],
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

//   _showModelSheet(int index) {
//     return showModalBottomSheet(
//         context: context,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         isScrollControlled: true,
//         constraints: sizeText == true
//             ? BoxConstraints.tight(Size(MediaQuery.of(context).size.width,
//                 MediaQuery.of(context).size.height * .8))
//             : null,
//         builder: (context) {
//           return SingleChildScrollView(
//             physics: const AlwaysScrollableScrollPhysics(),
//             child: Column(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                         child: Text(
//                           AppLocalizations.of(context)!.replyToReview,
//                           style: CustomTheme.primarycolor22Bold,
//                         ),
//                       ),
//                       Align(
//                         alignment: Alignment.topRight,
//                         child: InkWell(
//                           onTap: () {
//                             Navigator.of(context).pop();
//                           },
//                           child: Container(
//                             padding: EdgeInsets.all(5.w),
//                             margin: EdgeInsetsDirectional.only(
//                                 top: 20.h, end: 20, bottom: 15, start: 20),
//                             decoration: BoxDecoration(
//                                 border: Border.all(color: Colors.grey),
//                                 borderRadius: BorderRadius.circular(5)),
//                             child: const Icon(
//                               Icons.close,
//                               color: Colors.grey,
//                               size: 15,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(bottom: 20.h),
//                   child: CustomTextFormField(
//                       autofocus: sizeText == true ? true : false,
//                       onTapText: () {
//                         if (!sizeText) {
//                           sizeText = true;
//                           Navigator.of(context).pop();
//                           _showModelSheet(index);
//                           setState(() {});
//                         }
//                       },
//                       maxLines: 7,
//                       hintText: AppLocalizations.of(context)!.yourReply,
//                       mycontroller: replyController),
//                 ),
//                 CustomButton(
//                   onPressed: () async {
//                     sizeText = false;
//                     if (isLoadingReply) {
//                       showPreLoader(context);
//                     }
//                     await _replyReviews(
//                         replyController.text, data[index].id!, index);

//                     ///  _showModelSheet();
//                   },
//                   textStyle: CustomTheme.whiteRugular,
//                   color: CustomColors.primarycolor,
//                   title: AppLocalizations.of(context)!.save,
//                 ),
//                 SizedBox(
//                   height: 20.h,
//                 ),
//               ],
//             ),
//           );
//         });
//   }

//   _replyReviews(String reply, int id, int index) async {
//     await JsonDb().replyReviews(reply, id).then((res) {
//       if (res.success) {
//         setState(() {
//           isLoadingReply = false;
//           isSuccesReply = true;
//         });
//         data[index].isReply = 1;
//         data[index].reply = reply;
//         Navigator.of(context).pop();
//         Navigator.of(context).pop();
//         ScaffoldMessenger.of(context).showSnackBar(
//           CustomTheme.CustomSnackBar(res.message, "success"),
//         );
//       } //else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         CustomTheme.CustomSnackBar(res.message, "Error"),
//       );
//       isLoadingReply = false;
//       setState(() {});
//     });
//   }
// }
