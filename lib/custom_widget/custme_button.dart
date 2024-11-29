import 'package:flutter/material.dart';
import 'package:redeem/theme/custom_theme.dart';

import '../theme/colors.dart';

class CustomButton extends StatefulWidget {
  String? text;
  void Function()? onPressed;
  double? radius;
  Color? primary;
  CustomButton({
    this.primary,
    this.radius,
    required this.onPressed,
    this.text,
    super.key,
  });

  @override
  State<CustomButton> createState() => _CustomButton();
}

class _CustomButton extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: widget.primary ?? CustomColors.secondarycolor,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(widget.radius ?? CustomTheme.radius)),
          //backgroundColor: CustomColors.primarycolor,
          minimumSize: Size(double.infinity, 56.00)),
      onPressed: widget.onPressed,
      child: Center(
          child: Text(
        "${widget.text}",
        style: TextStyle(fontSize: 17),
      )),
    );
  }
}
