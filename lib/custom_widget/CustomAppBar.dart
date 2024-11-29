import 'package:flutter/material.dart';
import 'package:redeem/theme/colors.dart';

AppBar CustomAppBar(
    {double? elevation,
    Color? backgroundColor,
    ShapeBorder? shape,
    Widget? title,
    Widget? leading,
    List<Widget>? actions,
    PreferredSizeWidget? bottom,
    double? toolbarHeight,
    double? leadingWidth,
    IconThemeData? iconTheme}) {
  return AppBar(
    
    toolbarHeight: toolbarHeight,
    bottom: bottom,
    elevation: elevation,
    backgroundColor: CustomColors.backgroundcolor_for_Ticket,
    shape: shape,
    title: title,
    leading: leading,
    actions: actions,
    iconTheme: iconTheme,
    leadingWidth: leadingWidth,
  );
}
