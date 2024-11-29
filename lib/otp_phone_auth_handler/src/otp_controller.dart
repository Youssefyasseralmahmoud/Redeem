import 'dart:async';


import 'package:redeem/json_db/json_db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';

class OtpPhoneAuthController  extends ChangeNotifier  {
 

  static OtpPhoneAuthController of(
    BuildContext context, {
    bool listen = true,
  }) =>
      Provider.of<OtpPhoneAuthController>(context, listen: listen);

  /// {@macro timeOutDuration}
  static const kTimeOutDuration = Duration(seconds: 5,);

  /// {@macro phoneNumber}
  String? _phoneNumber;

  /// Timer object for SMS auto-retrieval.
  Timer? _timer;

  /// Whether OTP to the given phoneNumber is sent or not.
  bool codeSent = false;

  /// Whether the current platform is web or not;
  bool get isWeb => kIsWeb;

  /// {@macro onLoginSuccess}
  FutureOr<void> Function(bool)? _onLoginSuccess;

  /// {@macro onLoginFailed}
  FutureOr<void> Function(String, bool)? _onLoginFailed;

  /// Set callbacks and other data. (only for internal use)
  ///
  /// Do not call explicitly.
  void setData({
    required String phoneNumber,
    required FutureOr<void> Function(bool)? onLoginSuccess,
    required FutureOr<void> Function(String, bool)? onLoginFailed,
    Duration timeOutDuration = kTimeOutDuration,
  }) {
    _phoneNumber = phoneNumber;
    _onLoginSuccess = onLoginSuccess;
    _onLoginFailed = onLoginFailed;
    _timeoutDuration = timeOutDuration;
  }

  /// After a [Duration] of [timerCount], the library no more waits for SMS auto-retrieval.
  Duration get timerCount =>
      Duration(seconds: _timeoutDuration.inSeconds - (_timer?.tick ?? 0));

  /// Whether the timer is active or not.
  bool get timerIsActive => _timer?.isActive ?? false;

  /// {@macro timeOutDuration}
  static Duration _timeoutDuration = kTimeOutDuration;

  Future<bool> verifyOTP({required String otp}) async {
    bool status = false;
/*     await JsonDb().verify_otp_whatsapp(_phoneNumber ?? "", otp).then((res) {
      if (res.success) {
        status = true;
        _loginUser();
      } else {
        status = false;
        if (_onLoginFailed != null) _onLoginFailed!(res.message, codeSent);
      }
    }); */
    return status;
  }

  Future<bool> sendOTP() async {
    codeSent = false;
    await Future.delayed(Duration.zero, notifyListeners);

    verificationCompletedCallback(bool status) async {
      if (_onLoginSuccess != null) _onLoginSuccess!(status);
    }

    verificationFailedCallback(String errorMessage) {
      if (_onLoginFailed != null) _onLoginFailed!(errorMessage, codeSent);
    }

    codeSentCallback() async {
      codeSent = true;
      print("KKKK");
      notifyListeners();
      _setTimer();
    }

    bool status = false;
    codeSentCallback();
    /* await JsonDb().send_otp_whatsapp(_phoneNumber ?? "").then((res) {
      if (res.success) {
        codeSentCallback();
      } else {
        verificationFailedCallback(res.message);
      }
    }).catchError((err) {
      verificationFailedCallback(err.toString());
    }); */
    return status;
  }

  Future<bool> _loginUser() async {
    if (_onLoginSuccess != null) _onLoginSuccess!(true);
    return true;
  }

  /// Set timer after code sent.
  void _setTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timer.tick == _timeoutDuration.inSeconds) _timer?.cancel();
      notifyListeners();
    });
    notifyListeners();
  }

  /// Clear all data
  void clear() {
    codeSent = false;
    _onLoginSuccess = null;
    _onLoginFailed = null;
    _timer?.cancel();
    _timer = null;
    _phoneNumber = null;
    _timeoutDuration = kTimeOutDuration;
  }
  
  }
  


