
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redeem/otp_phone_auth_handler/src/otp_controller.dart';

/// Wrap the [MaterialApp] with [OtpPhoneAuthProvider]
/// to enable your application to support phone authentication.
class OtpPhoneAuthProvider extends StatelessWidget {
  const OtpPhoneAuthProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  /// The child of the widget.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OtpPhoneAuthController>(
      create: (_) => OtpPhoneAuthController(),
      child: child,
    );
  }
}