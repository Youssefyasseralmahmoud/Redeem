import 'package:flutter/material.dart';
import 'package:redeem/app_storage.dart';
import 'package:redeem/custom_widget/CustomAppBar.dart';

import 'package:redeem/custom_widget/custom_back_button.dart';
import 'package:redeem/generated/l10n.dart';
import 'package:redeem/json_db/enum.dart';
import 'package:redeem/json_db/jibal_response.dart';
import 'package:redeem/json_db/json_db.dart';
import 'package:redeem/screens/DetailsPages/details_pages.dart';
import 'package:redeem/screens/main_screen/main_screen.dart';
import 'package:redeem/screens/otpverification/otp_verification.dart';
import 'package:redeem/screens/signup/signup_controller.dart';
import 'package:redeem/size_config.dart';
import 'package:redeem/theme/custom_theme.dart';

import '../../theme/colors.dart';
import '../../core/function/validationinput.dart';
import '../../custom_widget/custom_text_form_field.dart';
import '../../custom_widget/custom_info_text_in_auth.dart';
import '../../custom_widget/custme_button.dart';
import 'package:redeem/globals.dart' as globals;

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late appStorage storage;
  bool loading = false;
  SignupData? signupData;
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
            checkinput(mobile, otp.toString());
          }
        }
      }
    });
  }

  checkinput(String mobile, String otp) {
    var formdata = formsignupKey.currentState;
    if (formdata!.validate()) {
      JsonDb()
          .getSignupDataCollections(
              firstnameController.value.text,
              lastnameController.value.text,
              mobile,
              emailController.value.text,
              passwordController.value.text,
              confirmpasswordController.value.text,
              otp)
          .then((res) {
        print("Register_data_succes");
        checkResponseSignup(res);
        _dismissPreLoader();
      });
    } else {
      print("الحقول غير صالحة");
      _dismissPreLoader();
      setState(() {});
    }
  }

  Future<void> checkResponseSignup(ResponseGetSignupData res) async {
    if (res.success) {
      print("success Signup");
      var data = res.data as SignupData;
      globals.isLogin = true;
      globals.userData = data.user;
      globals.userId = data.userId!;
      globals.token = data.token!;
      globals.userType = data.userType!;
      globals.customer = data.customer!;

      // if (data.userType == "dentist") {
      //   globals.dentist = data.dentist!;
      // } else if (data.userType == "office") {
      //   globals.office = data.office!;
      //   globals.SelectedCurrencyID = 1;
      // } else if (data.userType == "delivery_man") {
      //   globals.deliveryMan = data.deliveryMan!;
      //   globals.SelectedCurrencyID = 1;
      // }

      // DentalFirebaseAnalytic.setUserLogin(
      //     globals.userId.toString(),
      //     globals.userData!.name,
      //     globals.userData!.email,
      //     globals.userData!.mobile,
      //     globals.userType);

      // await setOneSignalUserID();

      await storage.setIsLogin(true);
      await storage.setUserID(data.userId);
      await storage.setToken(data.token!);
      await storage.setUserData(data.user);
      await storage.setUserType(data.userType!);
      await storage.setCustomer(data.customer);

      // if (data.userType == "delivery_man") {
      //   await _storage.setCurrencyID(1);
      //   await _storage.setDeliveryManLogin(data.deliveryMan!);
      // } else if (data.userType == "office") {
      //   await _storage.setCurrencyID(1);
      //   await _storage.setOfficeLogin(data.office!);
      // } else {
      //   await _storage.setDentistLogin(data.dentist!);
      //   JsonDb().getUserLikes().then((res) {
      //     if (res.success) {
      //       setState(() {
      //         globals.currencySymbol = res.currencySymbol;
      //       });
      //       setState(() {
      //         globals.wishlistProductsIDs = res.data!.wishProductIds;
      //         globals.pinOfficeIds = res.data!.pinOfficeIds;
      //         int totalCart = 0;
      //         if (res.data!.cart!.officesCarts != null &&
      //             res.data!.cart!.officesCarts.length > 0) {
      //           res.data!.cart!.officesCarts.forEach((element) {
      //             totalCart += element.cart.products.length;
      //           });
      //         }

      //         globals.totalCart = totalCart.toString();
      //         eventBus.fire(
      //           AppEvents(
      //             key_event: AppEvents.event_key_total_cart,
      //             value: true,
      //           ),
      //         );
      //       });
      //     }
      //   });
      // }
      /* _dismissPreLoader(); */

      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const MainScreen();
      }));

      ScaffoldMessenger.of(context).showSnackBar(
        CustomTheme.CustomSnackBar(res.message, "success"),
      );

      // FirebaseMessaging.instance.getToken().then((firebaseMessagingToken) {
      //   print("firebaseMessagingTokenInit $firebaseMessagingToken");
      //   setState(() {
      //     globals.firebaseMessagingToken = firebaseMessagingToken;
      //   });
      //   JsonDb().setFirebaseMessagingToken(
      //       firebaseMessagingToken, globals.SelectedLang);
      // }).catchError((onError) {
      //   print("onError ${onError}");
      // });

      // eventBus.fire(
      //   AppEvents(
      //     key_event: "login",
      //   ),
      // );
      // setState(() {});
      // if (widget.withBack) {
      //   WidgetsBinding.instance.addPostFrameCallback((_) {
      //     if (globals.userType == "delivery_man") {
      //       Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(builder: (context) => MainScreenDelivery()),
      //       );
      //     } else if (globals.userType == "office") {
      //       Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(builder: (context) => MainScreenOffice()),
      //       );
      //     } else {
      //       Navigator.of(context).pop();
      //     }
      //   });
      // } else {
      //   WidgetsBinding.instance.addPostFrameCallback((_) {
      //     if (globals.userType == "delivery_man") {
      //       Navigator.of(context).popUntil((route) => route.isFirst);
      //       Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(builder: (context) => MainScreenDelivery()),
      //       );
      //     } else if (globals.userType == "office") {
      //       Navigator.of(context).popUntil((route) => route.isFirst);
      //       Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(builder: (context) => MainScreenOffice()),
      //       );
      //     } else {
      //       Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(builder: (context) => MainScreen()),
      //       );
      //     }
      //   });
      // }
    } else {
      // if (res.need_verify! == true && res.temp_user_id != null) {
      //   print("res.temp_user_id ${res.temp_user_id}");
      //   await OneSignal.shared
      //       .setAppId(config_app.oneSignalAPPID)
      //       .then((value) {});
      //   await OneSignal.shared.requiresUserPrivacyConsent();
      //   OneSignal.shared
      //       .sendTag("temp_dental_user_id", res.temp_user_id.toString())
      //       .then((value) {
      //     print("save tag");
      //   }).catchError((onError) {
      //     print("save tag ${onError}");
      //   });
      //   showAlertNeedVerify(context, res.need_verify_title ?? "", res.message);
      // }

      if (res.has_errors && res.errors.length > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          CustomTheme.CustomSnackBar(res.errors[0], "danger"),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          CustomTheme.CustomSnackBar(res.message, "danger"),
        );
      }
    }
  }

  @override
  initState() {
    super.initState();
    storage = appStorage();
  }

  final formsignupKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool issecure = true;
  void changesecure() {
    issecure = !issecure;
    setState(() {});
  }

  bool mobile_exists = false;
  bool email_exists = false;
  Future<void> checkMobileExists(mobile) async {
    await JsonDb().checkMobileExists(mobile, "signup").then((res) {
      if (res.exists) {
        setState(() {
          mobile_exists = true;
        });
      } else {
        setState(() {
          mobile_exists = false;
        });
      }
    });
  }

  Future<void> checkEmailExists(email) async {
    await JsonDb().checkEmailExists(email, "signup").then((res) {
      print("checkEmailExists ${res.exists}");
      if (res.exists) {
        setState(() {
          email_exists = true;
        });
      } else {
        setState(() {
          email_exists = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
     
        elevation: 0,
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
        backgroundColor: CustomColors.primarycolor,
      ),
      backgroundColor: CustomColors.backgroundcolor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Container(
            width: responsive_size(450, asMaxSize: true),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(15.0, 0, 15, 30),
              child: Form(
                key: formsignupKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                          S.of(context).ready_to_start_saving +
                              S.of(context).question,
                          textAlign: TextAlign.center,
                          style: CustomTheme.text18theme),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(S.of(context).create_an_account,
                          textAlign: TextAlign.center,
                          style: CustomTheme.text18theme),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    customtextformfield(
                      prefixtext: Icon(Icons.person_2_outlined),
                      hint: S.of(context).first_name,
                      type: "username",
                      controller: firstnameController,
                      validator: (val) {
                        return validinput(context, val!, 2, 20, "username");
                      },
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    customtextformfield(
                      prefixtext: Icon(Icons.person_2_outlined),
                      hint: S.of(context).last_name,
                      type: "username",
                      keyboardType: TextInputType.name,
                      controller: lastnameController,
                      validator: (val) {
                        return validinput(context, val!, 2, 20, "username");
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    customtextformfield(
                      prefixtext: Icon(Icons.alternate_email_outlined),
                      hint: S.of(context).email_address,
                      type: "email",
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      onChanged: (val) {
                        setState(() {
                          email_exists = false;
                        });
                      },
                      validator: (val) {
                        if (email_exists) {
                          return S.of(context).email_exists;
                        }
                        return validinput(context, val!, 12, 100, "email");
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    customtextformfield(
                      hint: S.of(context).phone_number,
                      prefixtext: Container(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 20, 0, 20),
                        child: Text(
                          "+966",
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w500),
                        ),
                      ),
                      onChanged: (val) {
                        setState(() {
                          mobile_exists = false;
                        });
                      },
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      type: "phone",
                      validator: (val) {
                        if (mobile_exists) {
                          return S.of(context).mobile_exists;
                        }
                        return validinput(context, val!, 9, 10, "phone");
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: passwordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (val) {
                        return validinput(context, val!, 8, 100, "password");
                      },
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: issecure,
                      onChanged: (val) {
                        // controller.name=val;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                BorderSide(width: 1, color: Colors.red)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                BorderSide(width: 1, color: Colors.red)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                BorderSide(width: 1, color: Colors.red)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                BorderSide(width: 1, color: Colors.white)),
                        hintText: S.of(context).password,
                        suffixIcon: issecure == true
                            ? IconButton(
                                onPressed: () {
                                  changesecure();
                                },
                                icon: const Icon(Icons.visibility_off_outlined,
                                    color: CustomColors.thirdcolor),
                              )
                            : IconButton(
                                onPressed: () {
                                  changesecure();
                                },
                                icon: Icon(Icons.visibility_outlined,
                                    color: CustomColors.thirdcolor),
                              ),
                        hintStyle: TextStyle(color: CustomColors.thirdcolor),
                        hoverColor: Colors.white,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.lock_outline),
                        contentPadding:
                            EdgeInsetsDirectional.symmetric(vertical: 18.5),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: confirmpasswordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (val) {
                        return validinput(context, val!, 8, 100, "password");
                      },
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: issecure,
                      decoration: InputDecoration(
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                BorderSide(width: 1, color: Colors.white)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                BorderSide(width: 1, color: Colors.red)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                BorderSide(width: 1, color: Colors.red)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                BorderSide(width: 1, color: Colors.white)),
                        hintText: S.of(context).confirmpassword,
                        suffixIcon: issecure == true
                            ? IconButton(
                                onPressed: () {
                                  changesecure();
                                },
                                icon: const Icon(Icons.visibility_off_outlined,
                                    color: Colors.grey),
                              )
                            : IconButton(
                                onPressed: () {
                                  changesecure();
                                },
                                icon: Icon(Icons.visibility_outlined,
                                    color: CustomColors.thirdcolor),
                              ),
                        hintStyle: TextStyle(color: CustomColors.thirdcolor),
                        hoverColor: Colors.white,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.lock_outline),
                        contentPadding:
                            EdgeInsetsDirectional.symmetric(vertical: 18.5),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomButton(
                      onPressed: () async {
                        var mobile = phoneController.value.text;
                        final RegExp regexp = new RegExp(r'^0+(?=.)');
                        mobile = mobile.replaceAll(regexp, '');
                        mobile = "+966" + mobile;
                        _showPreLoader();
                        if (emailController.value.text != "") {
                          await checkEmailExists(emailController.value.text);
                        }
                        if (phoneController.value.text != "") {
                          await checkMobileExists(mobile);
                        }
                        if (formsignupKey.currentState!.validate()) {
                          send_otp(mobile);
                        } else {
                          _dismissPreLoader();
                        }
                      },
                      text: S.of(context).create_an_account,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      S.of(context).By_continuing_you_agree_to_End,
                      style: TextStyle(color: CustomColors.titlecolor),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return DetailsPage(
                                keyword: "terms-conditions",
                              );
                            }));
                          },
                          child: Text(
                            S.of(context).user_license_agreement +
                                S.of(context).and,
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: CustomColors.secondarycolor),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return DetailsPage(
                                keyword: "terms-conditions",
                              );
                            }));
                          },
                          child: Text(
                            S.of(context).Privacy_policy,
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: CustomColors.secondarycolor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }
}
