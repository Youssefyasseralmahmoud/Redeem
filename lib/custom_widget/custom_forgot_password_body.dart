import 'package:flutter/material.dart';

import 'package:redeem/generated/l10n.dart';
import 'package:redeem/globals.dart';
import 'package:redeem/json_db/json_db.dart';
import 'package:redeem/json_db/utils.dart';
import 'package:redeem/screens/forget_password/forgetpasswordcontroller.dart';
import 'package:redeem/screens/login/login.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';

import '../core/function/validationinput.dart';
import 'custom_text_form_field.dart';
import 'custme_button.dart';

class forgotpassword_body extends StatefulWidget {
  //TextEditingController emailController = TextEditingController();
  forgotpassword_body({
    // required this.emailController,
    super.key,
  });

  @override
  State<forgotpassword_body> createState() => _forgotpassword_body();
}

class _forgotpassword_body extends State<forgotpassword_body> {
  TextEditingController emailController = TextEditingController();
  final formForgetPasswordKey = GlobalKey<FormState>();
  checkinput() {
    var formdata = formForgetPasswordKey.currentState;
    if (formdata!.validate()) {
      JsonDb()
          .forgetPasswordCollections(
        emailController.value.text,
      )
          .then((res) {
        if (res.success) {
          dismissPreLoader(context);
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          //   return const Login();
          // }));
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
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.all(8.0),
      child: SingleChildScrollView(
        child: Form(
          key: formForgetPasswordKey,
          child: Padding(
            padding: EdgeInsetsDirectional.all(4.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        S.of(context).forgetpassword + S.of(context).question,
                        style: CustomTheme.text_white20theme,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    S.of(context).enter_your_email_addres_to_reset_your,
                    style: CustomTheme.text15theme,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        S.of(context).password,
                        style: CustomTheme.text15theme,
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  // Align(
                  //     alignment:AlignmentDirectional.centerStart,
                  //     child: Text(
                  //       "emailaddres".tr,
                  //       style: CustomTheme.text15theme.copyWith(fontWeight: FontWeight.bold),
                  //     )),
                  const SizedBox(
                    height: 10,
                  ),
                  customtextformfield(
                    prefixtext: Icon(Icons.alternate_email_outlined),
                    controller: emailController,
                    hint: S.of(context).email_address,
                    type: "email",
                    validator: (val) {
                      return validinput(context, val!, 12, 50, "email");
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                      onPressed: () {
                        showPreLoader(context);

                        checkinput();
                      },
                      text: S.of(context).Submit),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).back_to,
                        style: TextStyle(color: CustomColors.titlecolor),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return Login();
                            }));
                            ;
                          },
                          child: Text(
                            S.of(context).loginpage,
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: CustomColors.titlecolor),
                          ))
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
