import 'dart:async';

import 'package:flutter/material.dart';
import 'package:redeem/app_storage.dart';
import 'package:redeem/custom_widget/CustomAppBar.dart';

import 'package:redeem/custom_widget/custom_back_button.dart';
import 'package:redeem/custom_widget/custom_preloader.dart';
import 'package:redeem/generated/l10n.dart';
import 'package:redeem/json_db/enum.dart';
import 'package:redeem/json_db/jibal_response.dart';
import 'package:redeem/json_db/json_db.dart';
import 'package:redeem/screens/forget_password/forget_password.dart';
import 'package:redeem/screens/main_screen/main_screen.dart';
import 'package:redeem/screens/otpverification/otp_verification.dart';
import 'package:redeem/screens/signup/signup.dart';
import 'package:redeem/size_config.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';
import 'package:svg_flutter/svg.dart';

import '../../core/function/validationinput.dart';
import '../../custom_widget/custom_info_text_in_auth.dart';
import '../../custom_widget/custme_button.dart';
import '../../custom_widget/custom_text_form_field.dart';
import 'login_controller.dart';
import 'package:redeem/globals.dart' as globals;

//Login
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late appStorage storage;
  bool loading = false;
  LoginData? loginData;
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

  checkinput({bool forOtp = false, String otp = ""}) {
    var formdata = formLoginKey.currentState;
    if (forOtp == true || formdata!.validate()) {
      FocusScope.of(context).unfocus();

      String login_type = "";
      var username = emailController.value.text;
      if (forOtp) {
        login_type = "otp";
        final RegExp regexp = new RegExp(r'^0+(?=.)');
        username = username.replaceAll(regexp, '');
        username = "+966" + username;
      } else {
        otp = "";
      }

      JsonDb()
          .getLoginDataCollections(
              username, passwordController.value.text, login_type, otp)
          .then((res) {
        res.data.print("login_data_succes");
        checkResponseLogin(res);
        _dismissPreLoader();
      });
    } else {
      print("الحقول غير صالحة");
      _dismissPreLoader();
      setState(() {});
    }
  }

  Future<void> checkResponseLogin(ResponseGetLoginData res) async {
    if (res.success) {
      // loading = false;
      // setState(() {});
      var data = res.data as LoginData;
      globals.isLogin = true;

      globals.userData = data.user;
      globals.userId = data.userId!;
      globals.token = data.token!;
      globals.userType = data.userType!;
      globals.customer = data.customer!;

      await storage.setIsLogin(true);
      await storage.setUserID(data.userId);
      await storage.setToken(data.token!);
      await storage.setUserData(data.user);
      await storage.setUserType(data.userType!);
      await storage.setCustomer(data.customer);

      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const MainScreen();
      }));

      ScaffoldMessenger.of(context).showSnackBar(
        CustomTheme.CustomSnackBar(res.message, "success"),
      );
    } else {
      if (res.has_errors && res.errors.length > 0) {
        loading = false;
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(
          CustomTheme.CustomSnackBar(res.errors[0], "danger"),
        );
      } else {
        loading = false;
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(
          CustomTheme.CustomSnackBar(res.message, "danger"),
        );
      }
    }
  }

  bool issecure = true;

  final formLoginKey = GlobalKey<FormState>();

  bool login_via_mobile = false;
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void changesecure() {
    issecure = !issecure;
    setState(() {});
  }

  void updatimg() {
    setState(() {});
  }
    @override
  initState() {
    super.initState();
    storage = appStorage();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomColors.primarycolor,
        leading: CustomBackButton(),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.all(15.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return MainScreen();
                  }));
                },
                child: Text(
                  S.of(context).skip,
                  style: CustomTheme.text15theme.copyWith(color: Colors.white),
                )),
          )
        ],
      ),
      backgroundColor: CustomColors.backgroundcolor,
      body: SafeArea(
        child: Center(
          child: Container(
            width: responsive_size(450, asMaxSize: true),
            child: Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 15.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formLoginKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // const SizedBox(
                      //   height: 100,
                      // ),
                      Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 100,
                            height: 100,
                            child: SvgPicture.asset(
                              "assets/images/logo.svg",
                              fit: BoxFit.fill,
                            ),
                          )),
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        S.of(context).login,
                        style: CustomTheme.text_white20theme,
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      // updatimg();
                      if (!login_via_mobile)
                        customtextformfield(
                          prefixtext: Icon(Icons.alternate_email_outlined),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            if (int.tryParse(value) != null) {
                              print("val_is_num");
                              setState(() {
                                login_via_mobile = true;
                              });
                            } else {
                              print("val_is_not_num");
                              setState(() {
                                login_via_mobile = false;
                              });
                            }
                          },
                          hint: S.of(context).email_address,
                          type: "email",
                          controller: emailController,
                          validator: (val) {
                            return login_via_mobile == true
                                ? validinput(context, val!, 9, 10, "phone")
                                : validinput(context, val!, 12, 50, "email");
                          },
                        ),
                      if (login_via_mobile)
                        customtextformfield(
                          prefixtext: Container(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 20, 0, 20),
                            child: Text(
                              "+966",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            if (int.tryParse(value) != null) {
                              print("val_is_num");
                              setState(() {
                                login_via_mobile = true;
                              });
                            } else {
                              print("val_is_not_num");
                              setState(() {
                                login_via_mobile = false;
                              });
                            }
                          },
                          hint: S.of(context).email_address,
                          type: "email",
                          controller: emailController,
                          validator: (val) {
                            return login_via_mobile == true
                                ? validinput(context, val!, 9, 10, "phone")
                                : validinput(context, val!, 12, 50, "email");
                          },
                        ),

                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (val) {
                          return validinput(context, val!, 8, 10, "password");
                        },
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: issecure,
                        controller: passwordController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.red)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.white)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.white)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.red)),
                          hintText: S.of(context).password,
                          suffixIcon: issecure == true
                              ? IconButton(
                                  onPressed: () {
                                    changesecure();
                                  },
                                  icon: const Icon(
                                    Icons.visibility_off,
                                    color: CustomColors.thirdcolor,
                                  ),
                                )
                              : IconButton(
                                  onPressed: () {
                                    changesecure();
                                  },
                                  icon: const Icon(Icons.visibility,
                                      color: CustomColors.thirdcolor),
                                ),
                          hintStyle:
                              const TextStyle(color: CustomColors.thirdcolor),
                          hoverColor: Colors.white,
                          prefixIcon: Icon(Icons.lock_outline),
                          contentPadding: const EdgeInsetsDirectional.symmetric(
                              vertical: 18.5),
                        ),
                      ),

                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                                onPressed: () {
                                  _showPreLoader();

                                  checkinput();
                                },
                                text: S.of(context).login),
                          ),
                          if (login_via_mobile)
                            SizedBox(
                              width: 10,
                            ),
                          if (login_via_mobile)
                            Expanded(
                              child: CustomButton(
                                  primary: CustomColors.thirdcolor,
                                  onPressed: () async {
                                    var mobile = emailController.value.text;
                                    final RegExp regexp =
                                        new RegExp(r'^0+(?=.)');
                                    mobile = mobile.replaceAll(regexp, '');
                                    mobile = "+966" + mobile;
                                    JsonDb()
                                        .checkMobileExists(mobile, "login")
                                        .then((res) async {
                                      if (res.exists) {
                                        send_otp(mobile);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          CustomTheme.CustomSnackBar(
                                              res.message, "danger"),
                                        );
                                      }
                                    });
                                  },
                                  text: S.of(context).send_otp),
                            )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                          onTap: () {
                            // Get.toNamed("/Forget_password",arguments: {});
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return const ForgetPassword();
                            }));
                          },
                          child: Text(
                            S.of(context).forgetpassword +
                                S.of(context).question,
                            style: const TextStyle(
                                color: CustomColors.titlecolor,
                                decoration: TextDecoration.underline),
                          )),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Container(
                            color: Colors.white,
                            width: 50,
                            height: 0.5,
                          )),
                          Text(
                            S.of(context).or,
                            style:
                                const TextStyle(color: CustomColors.titlecolor),
                          ),
                          Expanded(
                              child: Container(
                            color: Colors.white,
                            width: 50,
                            height: 0.5,
                          ))
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomButton(
                        primary: CustomColors.thirdcolor,
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const Signup();
                          }));
                        },
                        text: S.of(context).create_an_account,
                      ),
                      // const SizedBox(
                      //   height: 15,
                      // ),
                      // Text(
                      //   "By continuing you agree to End".tr,
                      //   style: const TextStyle(color: Colors.white),
                      // ),
                      // const SizedBox(
                      //   height: 5,
                      // ),
                      // Row(
                      //   children: [
                      //     Text(
                      //       "user license agreement".tr + " &",
                      //       style: const TextStyle(
                      //           decoration: TextDecoration.underline,
                      //           color: CustomColors.secondarycolor),
                      //     ),
                      //     Text(
                      //       "Privacy policy".tr,
                      //       style: const TextStyle(
                      //           decoration: TextDecoration.underline,
                      //           color: CustomColors.secondarycolor),
                      //     ),
                      //   ],
                      // ),

                      // info_texti_n_auth(
                      //   text:
                      //       "By continuing you agree to End \n user license agreement & Privacy policy",
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void send_otp(String mobile) {
    JsonDb().sendOtp(mobile).then((res2) async {
      if (res2.success) {
        var otp = await Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => OtpVerification(mobile),
          ),
        );
        if (otp != null) {
          if (otp == "resend") {
            send_otp(mobile);
          } else {
            _showPreLoader();
            checkinput(forOtp: true, otp: otp.toString());
          }
        }
      }
    });
  }
}

// Navigator.of(context)
//                         .push(MaterialPageRoute(builder: (context) {
//                       return const OtpVerification();
//                     }));
