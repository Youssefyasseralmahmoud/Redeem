import 'package:flutter/material.dart';
import 'package:redeem/custom_widget/CustomAppBar.dart';

import 'package:redeem/custom_widget/custom_back_button.dart';
import 'package:redeem/generated/l10n.dart';
import 'package:redeem/json_db/utils.dart';
import 'package:redeem/screens/main_screen/main_screen.dart';
import 'package:redeem/size_config.dart';

import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';

import '../../custom_widget/custom_forgot_password_body.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPassword();
}

class _ForgetPassword extends State<ForgetPassword> {
  @override
  void initState() {
    super.initState();
  }

  // final formLoginKey = GlobalKey<FormState>();
//  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: CustomColors.backgroundcolor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomColors.primarycolor,
        leading: CustomBackButton(),
        title: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return MainScreen();
              }));
            },
            child: Text(
              S.of(context).skip,
              style: CustomTheme.text15theme,
            ),
          )
        ]),
      ),
      body: Center(
        child: Container(
          width: responsive_size(450, asMaxSize: true),
          child: forgotpassword_body()),
      ),
    );
  }
}
