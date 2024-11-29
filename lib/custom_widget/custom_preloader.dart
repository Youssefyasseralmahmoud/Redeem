import 'package:flutter/material.dart';
import 'package:redeem/theme/colors.dart';

class CustomPreloader extends StatefulWidget {
  const CustomPreloader({super.key});

  @override
  State<CustomPreloader> createState() => _CustomPreloader();
}

class _CustomPreloader extends State<CustomPreloader> {
  @override
  Widget build(BuildContext context) {
        return AlertDialog(
        backgroundColor: CustomColors.secondarygroundcolor,
        contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: CircleBorder(),
        content: Container(
          width: 60,
          height: 60,
          padding: EdgeInsets.all(10),
          child: Center(child: CircularProgressIndicator(color: CustomColors.primarycolor,)),
        ),
      );
  }
}