// import 'package:flutter/material.dart';

// class CustomSearchPage extends StatefulWidget {
//   const CustomSearchPage({super.key});

//   @override
//   State<CustomSearchPage> createState() => _CustomSearchPageState();
// }

// class _CustomSearchPageState extends State<CustomSearchPage> {
//   @override
//   Widget build(BuildContext context) {
//     return  DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         appBar: AppBar(
//           bottom: TabBar(tabs:[
//             Tab(text: "Coupons",),
//               Tab(text: "Providers",),
//                 Tab(text: "Offers",),
//           ]),
//         ),
//         body: Container(
//           child: TabBarView(children: [
//             Center(child: Text("Coupons")),
//             Center(child: Text("offers")),
//             Center(child: Text("Providers")),
//           ]),
//         ),
//       ),
//     );
//   }
// }