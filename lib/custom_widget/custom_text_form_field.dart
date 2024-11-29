import 'package:flutter/material.dart';

import 'package:redeem/screens/login/login_controller.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';

import '../core/function/validationinput.dart';

class customtextformfield extends StatefulWidget {
  String? hint;
  String? type;
  Color? fillcolor;
  Color? hintcolor;
  Color? textcolor;
  Color? bordercolor;
  TextInputType? keyboardType;
  Widget? suffix;
  Widget? prefixtext;
  String? Function(String?)? validator;
  double? radius;
  bool? isnum;
  Widget? suffixIcon;

  TextEditingController? controller;

  void Function(String)? onChanged;

  customtextformfield({
    this.onChanged,
    this.fillcolor,
    this.hintcolor,
    this.textcolor,
    this.bordercolor,
    required this.validator,
    this.suffix,
    required this.hint,
    this.type,
    this.keyboardType,
    required this.controller,
    this.radius,
    this.isnum,
    this.suffixIcon,
    this.prefixtext,
    
    super.key,
  });

  @override
  State<customtextformfield> createState() => _customtextformfield();
}

class _customtextformfield extends State<customtextformfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: widget.textcolor ?? Colors.black),
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        suffixIcon: widget.suffixIcon,
        prefixText: widget.isnum == true ? "+964'|" : null,
        prefixIcon: widget.prefixtext,
        prefixStyle: TextStyle(color: Colors.grey),
        filled: true,
        fillColor: widget.fillcolor ?? Colors.white,
        enabledBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(widget.radius ?? CustomTheme.radius),
            borderSide: BorderSide(
                width: 1, color: widget.bordercolor ?? Colors.white)),
        focusedBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(widget.radius ?? CustomTheme.radius),
            borderSide: BorderSide(
                width: 1, color: widget.bordercolor ?? Colors.white)),
        errorBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(widget.radius ?? CustomTheme.radius),
            borderSide: BorderSide(width: 1, color: Colors.red)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(widget.radius ?? CustomTheme.radius),
            borderSide: BorderSide(width: 1, color: Colors.red)),
        hintText: widget.hint,
        suffix: widget.suffix,
        hintStyle:
            TextStyle(color: widget.hintcolor ?? CustomColors.thirdcolor),
        hoverColor: Colors.white,
        contentPadding: EdgeInsetsDirectional.symmetric(vertical: 18.5),
      ),
    );
  }
}
