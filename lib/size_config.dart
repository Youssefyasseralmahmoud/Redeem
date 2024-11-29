import 'package:flutter/material.dart';

class SizeConfig {
  
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  static const double current_width = 375;

  static const double min_width = 320;
  static const double max_width = 768;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    orientation = _mediaQueryData!.orientation;
  }
}

// ignore: non_constant_identifier_names
double responsive_size(double current_val, {bool asMaxSize = false}) {
  // ignore: non_constant_identifier_names
  double min_val =
      ((current_val * SizeConfig.min_width) / SizeConfig.current_width);
  // ignore: non_constant_identifier_names
  double max_val =
      ((current_val * SizeConfig.max_width) / SizeConfig.current_width);

  double v = (min_val +
      (max_val - min_val) *
          ((SizeConfig.screenWidth! - SizeConfig.min_width) /
              (SizeConfig.max_width - SizeConfig.min_width)));
  if (asMaxSize) {
    if (v > current_val) {
      return current_val;
    }
  }
  return v;
}

// ignore: non_constant_identifier_names
double? height_container_intro() {
  if (SizeConfig.screenHeight! < SizeConfig.screenWidth!) {
    return SizeConfig.screenWidth;
  }
  return SizeConfig.screenHeight;
}
