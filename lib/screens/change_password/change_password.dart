import 'package:flutter/material.dart';

import 'package:redeem/core/function/validationinput.dart';
import 'package:redeem/custom_widget/CustomAppBar.dart';
import 'package:redeem/custom_widget/custme_button.dart';
import 'package:redeem/custom_widget/custom_back_button.dart';
import 'package:redeem/custom_widget/custom_preloader.dart';
import 'package:redeem/custom_widget/custom_text_form_field.dart';
import 'package:redeem/generated/l10n.dart';
import 'package:redeem/json_db/json_db.dart';
import 'package:redeem/json_db/utils.dart';
import 'package:redeem/screens/change_password/change_password_controller.dart';
import 'package:redeem/size_config.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';
import 'package:redeem/globals.dart' as globals;

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword> {
  bool haspassword = false;
  bool loading = true;
  void checkHasPassword() async {
    // try {

    await JsonDb().checkHasPasswordCollections().then((res) {
      if (res.success) {
        haspassword = res.data;

        loading = false;

        setState(() {});
      } else {
        if (res.has_errors) {
          ScaffoldMessenger.of(context as BuildContext).showSnackBar(
            CustomTheme.CustomSnackBar(res.errors[0], "error"),
          );
        } else {
          ScaffoldMessenger.of(context as BuildContext).showSnackBar(
            CustomTheme.CustomSnackBar(res.message, "error"),
          );
        }
      }
    });
    // } catch (e) {
    //   ScaffoldMessenger.of(context as BuildContext).showSnackBar(
    //     CustomTheme.CustomSnackBar(
    //         S.of(context).Internet_connection_error, "warning"),
    //   );
    // }
  }

  checkinput() {
    var formdata = formeditpasswordKey.currentState;
    if (formdata!.validate()) {
      JsonDb()
          .changePasswordCollections(
              oldpasswordController.value.text,
              newpasswordController.value.text,
              confirmpasswordController.value.text)
          .then((res) {
        if (res.success) {
          ScaffoldMessenger.of(context as BuildContext).showSnackBar(
            CustomTheme.CustomSnackBar(res.message, "success"),
          );
        } else {
          if (res.has_errors) {
            ScaffoldMessenger.of(context as BuildContext).showSnackBar(
              CustomTheme.CustomSnackBar(res.errors[0], "error"),
            );
          } else {
            ScaffoldMessenger.of(context as BuildContext).showSnackBar(
              CustomTheme.CustomSnackBar(res.message, "error"),
            );
          }
        }
        dismissPreLoader(context);
      });
    } else {
      print("الحقول غير صالحة");
      dismissPreLoader(context);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    checkHasPassword();
  }

  final formeditpasswordKey = GlobalKey<FormState>();
  TextEditingController oldpasswordController = TextEditingController();
  TextEditingController newpasswordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  bool issecure = true;
  void changesecure() {
    issecure = !issecure;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: CustomAppBar(
        elevation: 0,
        leading: CustomBackButton(),
        title: Text(S.of(context).change_password,
            style: CustomTheme.text18theme
                .copyWith( color: CustomColors.primarycolor)),
        backgroundColor: CustomColors.appbarbackgroundcolor,
      ),
      backgroundColor: CustomColors.secondarygroundcolor,
      body: loading == true
          ? CustomPreloader()
          : SafeArea(
              child: Padding(
                 padding: const EdgeInsetsDirectional.symmetric(horizontal: 8),
                child: SingleChildScrollView(
                  child: Center(
                    child: Container(
                      width: responsive_size(450, asMaxSize: true),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(15.0, 0, 15, 30),
                        child: Form(
                          key: formeditpasswordKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             
                              haspassword == true
                                  ? TextFormField(
                                      style:
                                          TextStyle(color: CustomColors.primarycolor),
                                      controller: oldpasswordController,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (val) {
                                        return validinput(
                                            context, val!, 5, 100, "password");
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
                                            borderSide: const BorderSide(
                                                width: 1,
                                                color: CustomColors.thirdcolor)),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(50),
                                            borderSide: const BorderSide(
                                                width: 1, color: Colors.red)),
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(50),
                                            borderSide: const BorderSide(
                                                width: 1, color: Colors.red)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(50),
                                            borderSide: const BorderSide(
                                                width: 1,
                                                color: CustomColors.thirdcolor)),
                                        hintText: S.of(context).old_password,
                                        suffixIcon: issecure == true
                                            ? IconButton(
                                                onPressed: () {
                                                  changesecure();
                                                },
                                                icon: const Icon(Icons.visibility_off,
                                                    color: CustomColors.thirdcolor),
                                              )
                                            : IconButton(
                                                onPressed: () {
                                                  changesecure();
                                                },
                                                icon: const Icon(Icons.visibility,
                                                    color: CustomColors.thirdcolor),
                                              ),
                                        hintStyle: const TextStyle(
                                            color: CustomColors.primarycolor),
                                        hoverColor: Colors.white,
                                        fillColor: Colors.white,
                                        contentPadding:
                                            const EdgeInsetsDirectional.all(10),
                                      ),
                                    )
                                  : Container(),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                style: TextStyle(color: CustomColors.primarycolor),
                                controller: newpasswordController,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (val) {
                                  return validinput(
                                      context, val!, 5, 100, "password");
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
                                      borderSide: const BorderSide(
                                          width: 1, color: CustomColors.thirdcolor)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.red)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.red)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: const BorderSide(
                                          width: 1, color: CustomColors.thirdcolor)),
                                  hintText: S.of(context).new_password,
                                  suffixIcon: issecure == true
                                      ? IconButton(
                                          onPressed: () {
                                            changesecure();
                                          },
                                          icon: const Icon(Icons.visibility_off,
                                              color: CustomColors.thirdcolor),
                                        )
                                      : IconButton(
                                          onPressed: () {
                                            changesecure();
                                          },
                                          icon: const Icon(Icons.visibility,
                                              color: CustomColors.thirdcolor),
                                        ),
                                  hintStyle: const TextStyle(
                                      color: CustomColors.primarycolor),
                                  hoverColor: Colors.white,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsetsDirectional.all(10),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                style: TextStyle(color: CustomColors.primarycolor),
                                controller: confirmpasswordController,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (val) {
                                  return validinput(
                                      context, val!, 5, 100, "password");
                                },
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: issecure,
                                decoration: InputDecoration(
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: const BorderSide(
                                          width: 1, color: CustomColors.thirdcolor)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.red)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.red)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: const BorderSide(
                                          width: 1, color: CustomColors.thirdcolor)),
                                  hintText: S.of(context).confirm_new_password,
                                  suffixIcon: issecure == true
                                      ? IconButton(
                                          onPressed: () {
                                            changesecure();
                                          },
                                          icon: const Icon(Icons.visibility_off,
                                              color: Colors.grey),
                                        )
                                      : IconButton(
                                          onPressed: () {
                                            changesecure();
                                          },
                                          icon: const Icon(Icons.visibility,
                                              color: CustomColors.thirdcolor),
                                        ),
                                  hintStyle: const TextStyle(
                                      color: CustomColors.primarycolor),
                                  hoverColor: Colors.white,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsetsDirectional.all(10),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomButton(
                                primary: CustomColors.primarycolor,
                                onPressed: () {
                                  showPreLoader(context);
                    
                                  checkinput();
                                },
                                text: S.of(context).save,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
