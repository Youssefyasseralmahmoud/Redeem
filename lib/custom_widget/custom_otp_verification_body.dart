import 'dart:async';

import 'package:flutter/material.dart';

import 'package:pinput/pinput.dart';
import 'package:redeem/generated/l10n.dart';
import 'package:redeem/json_db/json_db.dart';
import 'package:redeem/otp_phone_auth_handler/src/otp_controller.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/otp_phone_auth_handler/otp_phone_auth_handler.dart';
import 'package:redeem/theme/custom_theme.dart';

class OtpVerificationBody extends StatefulWidget {
  String mobile;

  OtpVerificationBody(this.mobile);

  @override
  State<OtpVerificationBody> createState() => _OtpVerificationBodyState();
}

class _OtpVerificationBodyState extends State<OtpVerificationBody>
    with WidgetsBindingObserver {
// @override
//   void initState() {
//   controller.sendOTP();
//     super.initState();
//   }

  final defaultpintheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: const TextStyle(fontSize: 22, color: Colors.white),
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white)));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.all(10.0),
      child: SingleChildScrollView(
        child: OtpPhoneAuthHandler(
            phoneNumber: "",
            onLoginSuccess: (status) async {
              Navigator.of(context).pop(true);
            },
            onLoginFailed: (message, codeSend) {
              print("codeSend ${codeSend}");
            },
            builder: (context, controller) {
              return Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: Icon(Icons.password),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(S.of(context).we_have_Sent_the_Verification_code_to,
                      style: const TextStyle(color: CustomColors.titlecolor)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.mobile,
                        style:
                            const TextStyle(color: CustomColors.secondarycolor),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      /*  Text(
                        S.of(context).via_whatsapp,
                        style: const TextStyle(color: CustomColors.titlecolor),
                      ) */
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    S.of(context).enter_OTP,
                    style: CustomTheme.text_white20theme,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Pinput(
                    onSubmitted: (val) {},
                    closeKeyboardWhenCompleted: true,
                    autofocus: true,
                    length: 6,
                    defaultPinTheme: defaultpintheme.copyWith(
                        textStyle: TextStyle(
                            color: CustomColors.primarycolor, fontSize: 18),
                        decoration: defaultpintheme.decoration!
                            .copyWith(color: Colors.white)),
                    focusedPinTheme: defaultpintheme.copyWith(
                        decoration: defaultpintheme.decoration!.copyWith(
                            border: Border.all(color: Colors.white),
                            color: Colors.white)),
                    onCompleted: (pin) {
                      JsonDb().checkOtp(widget.mobile, pin).then((res) {
                        if (res.success) {
                          Navigator.of(context).pop(pin);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            CustomTheme.CustomSnackBar(res.message, "danger"),
                          );
                        }
                      });
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    S.of(context).dont_received_OTP_code_yet +
                        S.of(context).question,
                    style: const TextStyle(
                        decoration: TextDecoration.underline,
                        color: CustomColors.titlecolor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // if (controller.codeSent &&
                  //     controller.timerIsActive &&
                  //     controller.timerCount.inSeconds > 0)
                  controller.timerCount.inSeconds > 0
                      ? TextButton(
                          child: Text(
                            '${controller.timerCount.inSeconds}s',
                            style: const TextStyle(
                              color: CustomColors.secondarycolor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onPressed: () async {},
                        )
                      :
                      // ElevatedButton(

                      //   style: ElevatedButton.styleFrom(
                      //     padding: EdgeInsetsDirectional.all(8),
                      //     minimumSize: Size(80, 40),
                      //     primary: CustomColors.secondarycolor
                      //   ),
                      //     onPressed: () {},
                      //     child: Text(
                      //       "reset".tr,
                      //       style: CustomTheme.text_white20theme,
                      //     ))
                      TextButton(
                          onPressed: () {
                            _showPreLoader();
                            JsonDb().sendOtp(widget.mobile).then((res) {
                              _dismissPreLoader();
                            });
                          },
                          child: Text(
                            S.of(context).resend_otp,
                            style: TextStyle(
                                fontSize: 18,
                                color: CustomColors.secondarycolor),
                          )),
                ],
              );
            }),
      ),
    );
  }

  _dismissPreLoader() {
    Navigator.of(context).pop();
  }

  Future<void> _showPreLoader() async {
    return showDialog<void>(
      context: context,
      useSafeArea: false,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: CustomColors.primarycolor,
          contentPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: CircleBorder(),
          content: Container(
            width: 60,
            height: 60,
            child: Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            )),
          ),
        );
      },
    );
  }
}
