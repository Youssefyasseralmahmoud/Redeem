// import 'package:flutter/material.dart';
// import 'package:redeem/custom_widget/CustomAppBar.dart';
// import 'package:redeem/custom_widget/custom_preloader.dart';
// import 'package:redeem/json_db/enum.dart';
// import 'package:redeem/json_db/json_db.dart';
// import 'package:redeem/theme/colors.dart';
// import 'package:redeem/theme/custom_theme.dart';
// import 'package:redeem/globals.dart' as globals;

// class ContactUs extends StatefulWidget {
//   const ContactUs({super.key});

//   @override
//   State<ContactUs> createState() => _ContactUsState();
// }

// class _ContactUsState extends State<ContactUs> {
//   bool loading = true;
//   List<FormItemData> listForm = [];
//   void getData() async {
//     // try {
//     await JsonDb().getContactUsFormCollections().then((res) {
//       if (res.success) {
//         print("succes get forms");
//         listForm = res.data;

//         loading = false;

//         setState(() {});
//       } else {
//         if (res.has_errors) {
//           ScaffoldMessenger.of(context as BuildContext).showSnackBar(
//             CustomTheme.CustomSnackBar(res.errors[0], "error"),
//           );
//         } else {
//           ScaffoldMessenger.of(context as BuildContext).showSnackBar(
//             CustomTheme.CustomSnackBar(res.message, "error"),
//           );
//         }
//       }
//     });
//     // } catch (e) {
//     //   ScaffoldMessenger.of(context as BuildContext).showSnackBar(
//     //     CustomTheme.CustomSnackBar(
//     //         S.of(context).Internet_connection_error, "warning"),
//     //   );
//     // }
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//           backgroundColor: CustomColors.appbarbackgroundcolor,
//           title: Text(
//             "Contact Us",
//             style: TextStyle(color: Colors.white),
//           )),
//       body: loading == true
//           ? CustomPreloader()
//           : SafeArea(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     ...listForm.map((e) {
//                       return e.type == "text"
//                           ? TextFormField(
//                               decoration: InputDecoration(
//                                   label: Text(
//                                       "${e.getPropertyEffectedByLang("label_${globals.SelectedLang}")}")),
//                             )
//                           : e.type == "textarea"
//                               ? TextFormField(
//                                   maxLines: 7,
//                                   decoration: InputDecoration(
//                                       label: Text(
//                                           "${e.getPropertyEffectedByLang("label_${globals.SelectedLang}")}")),
//                                 )
//                               : Container();
//                     }).toList()
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }
