import 'package:flutter/material.dart';
import 'package:redeem/theme/colors.dart';

// ignore: must_be_immutable
class CustomBackButton extends StatefulWidget {
  Color? color;

  Color? arrow_color;
  void Function()? onPressed;
  CustomBackButton({
    this.arrow_color,
    this.color,
    this.onPressed,
    super.key,
  });

  @override
  State<CustomBackButton> createState() => _CustomBackButton();
}

class _CustomBackButton extends State<CustomBackButton> {
  @override
  Widget build(BuildContext context) {
    if (!Navigator.canPop(context)) {
      return Container(
        width: 0,
      );
    }
    return Padding(
      padding: const EdgeInsetsDirectional.all(10.0),
      child: CircleAvatar(
        backgroundColor: widget.color ?? Colors.white,
        child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: widget.onPressed ??
              () {
                Navigator.of(context).pop();
              },
          icon: Icon(
            Icons.chevron_left,
            size: 30,
            color: widget.arrow_color ?? CustomColors.primarycolor,
          ),
        ),
      ),
    );
  }
}
