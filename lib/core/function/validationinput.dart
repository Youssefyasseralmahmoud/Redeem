
import 'package:flutter/material.dart';
import 'package:redeem/generated/l10n.dart';

validinput(BuildContext context,String val, int min, int max, String type) {
  // if (type == "username") {
  //   if (!GetUtils.isUsername(val)) {
  //     return S.of(context).usernamevalidation;
  //   }
  // }
  if (type == "email") {
    if (!isEmail(val)) {
      return S.of(context).emailvalidation;
    }
  }
  if (type == "phone") {
    if (!isPhone(val)) {
      return S.of(context).phonevalidation;
    }
  }
    if (type == "number") {
    if (!isPhone(val)) {
      return S.of(context).phonevalidation;
    }
  }
  if (val.length < min) {
    return S.of(context).minvaluevalidation+" $min";
  }
  if (val.length > max) {
    return S.of(context).maxvaluevalidation+" $max";
  }
  if (val.isEmpty) {
    return S.of(context).emptyvalidation;
  }
}
bool isEmail(String input) =>
      RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(input);
bool isPhone(String input) => RegExp("(05|5)[0-9]{8}").hasMatch(input);
