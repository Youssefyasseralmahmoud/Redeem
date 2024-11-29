import 'package:flutter/material.dart';
import 'package:redeem/custom_widget/CustomAppBar.dart';
import 'package:redeem/custom_widget/custom_back_button.dart';

import 'package:redeem/generated/l10n.dart';
import 'package:redeem/otp_phone_auth_handler/src/otp_controller.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/custom_widget/custom_otp_verification_body.dart';

class OtpVerification extends StatefulWidget {
  String mobile;
  OtpVerification(this.mobile);

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  OtpPhoneAuthController controller = OtpPhoneAuthController();
  @override
  void initState() {
    controller.sendOTP();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        elevation: 0,
        backgroundColor: CustomColors.appbarbackgroundcolor,
        leading: CustomBackButton(),
      ),
      backgroundColor: CustomColors.backgroundcolor,
      body: SafeArea(child: OtpVerificationBody(widget.mobile)),
    );
  }
}
