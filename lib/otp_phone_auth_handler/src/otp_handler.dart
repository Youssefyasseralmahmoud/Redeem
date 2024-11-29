import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redeem/otp_phone_auth_handler/src/otp_controller.dart';

class OtpPhoneAuthHandler extends StatefulWidget {
  const OtpPhoneAuthHandler(
      {Key? key,
      required this.phoneNumber,
      required this.builder,
      this.onLoginFailed,
      this.onLoginSuccess,
      this.timeOutDuration = OtpPhoneAuthController.kTimeOutDuration})
      : super(key: key);

  /// {@template phoneNumber}
  ///
  /// The phone number to which the OTP is to be sent.
  ///
  /// The phone number should also contain the country code.
  ///
  /// Example: +919876543210 where +91 is the country code and 9876543210 is the number.
  ///
  /// {@endtemplate}
  final String phoneNumber;

  /// {@template onLoginSuccess}
  ///
  /// This callback is triggered when the phone number is verified and the user is
  /// signed in successfully. The function provides [UserCredential] which contains
  /// essential user information.
  ///
  /// The boolean provided is whether the OTP was auto verified or
  /// verified manually by calling [verifyOTP].
  ///
  /// True if auto verified and false is verified manually.
  ///
  /// {@endtemplate}
  final FutureOr<void> Function(bool)? onLoginSuccess;

  /// {@template onLoginFailed}
  ///
  /// This callback is triggered if the phone verification fails. The callback provides
  /// [FirebaseAuthException] which contains information about the error.
  ///
  /// {@endtemplate}
  final FutureOr<void> Function(String, bool)? onLoginFailed;

  /// {@template timeOutDuration}
  ///
  /// The maximum amount of time you are willing to wait for SMS
  /// auto-retrieval to be completed by the library.
  ///
  /// Maximum allowed value is 2 minutes.
  ///
  /// Defaults to [OtpPhoneAuthController.kTimeOutDuration].
  ///
  /// {@endtemplate}
  final Duration timeOutDuration;

  /// {@template builder}
  ///
  /// The widget returned by the `builder` is rendered on to the screen and
  /// builder is called every time a value changes i.e. either the timerCount or any
  /// other value.
  ///
  /// The builder provides a controller which can be used to render the UI based
  /// on the current state.
  ///
  /// {@endtemplate}
  final Widget Function(BuildContext, OtpPhoneAuthController) builder;

  @override
  _OtpPhoneAuthHandlerState createState() => _OtpPhoneAuthHandlerState();
}

class _OtpPhoneAuthHandlerState extends State<OtpPhoneAuthHandler> {
  @override
  void initState() {
    (() async {
      final _con = OtpPhoneAuthController.of(context, listen: false);

      _con.setData(
        phoneNumber: widget.phoneNumber,
        onLoginSuccess: widget.onLoginSuccess,
        onLoginFailed: widget.onLoginFailed,
        timeOutDuration: widget.timeOutDuration,
      );

      await _con.sendOTP();
    })();
    super.initState();
  }

  @override
  void dispose() {
    try {
      OtpPhoneAuthController.of(context, listen: false).clear();
    } catch (_) {}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OtpPhoneAuthController>(
      builder: (context, controller, _) => widget.builder(context, controller),
    );
  }
}
