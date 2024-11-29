import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:redeem/core/function/validationinput.dart';
import 'package:redeem/custom_widget/CustomAppBar.dart';
import 'package:redeem/custom_widget/custme_button.dart';
import 'package:redeem/custom_widget/custom_back_button.dart';
import 'package:redeem/custom_widget/custom_preloader.dart';
import 'package:redeem/generated/l10n.dart';
import 'package:redeem/json_db/enum.dart';
import 'package:redeem/json_db/json_db.dart';
import 'package:redeem/size_config.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';
import 'package:redeem/globals.dart' as globals;

class JoinUs extends StatefulWidget {
  dynamic pagename;
  JoinUs({super.key, this.pagename});

  @override
  State<JoinUs> createState() => _JoinUs();
}

class _JoinUs extends State<JoinUs> {
  final _formLoginKey = GlobalKey<FormState>();
  bool loading = true;
  Map<String, dynamic> body = {};
  List<TextEditingController> controllers = [];
  List<FormItemData> listForm = [];
  void getData() async {
    // try {
    await JsonDb().getjOINuSFormCollections().then((res) {
      if (res.success) {
        print("succes get forms");
        listForm = res.data;
        controllers = res.controllers;
        // int i = 0;
        // listForm.forEach((element) {
        //   element.index = i;
        //   controllers.add(TextEditingController());
        //   i++;
        // });

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

  void getContactData() async {
    // try {
    await JsonDb().getContactUsFormCollections().then((res) {
      if (res.success) {
        print("succes get forms");
        listForm = res.data;
        controllers = res.controllers;
        // int i = 0;
        // listForm.forEach((element) {
        //   element.index = i;
        //   controllers.add(TextEditingController());
        //   i++;
        // });

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
    var formdata = _formLoginKey.currentState;
    if (formdata!.validate()) {
      if (widget.pagename == "contact") {
        SubmitContact();
      } else {
        SubmitJoin();
      }
    } else {
      print("الحقول غير صالحة");

      setState(() {});
    }
  }

  void SubmitContact() async {
    // try {
    // print("paymentLength ${cartData!.cart!.listPaymentMethod!.length}");
    await JsonDb().SubmitContactUs(body).then((res) {
      if (res.success) {
        setState(() {});
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          CustomTheme.CustomSnackBar(res.message, "success"),
        );

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

  void SubmitJoin() async {
    // try {
    // print("paymentLength ${cartData!.cart!.listPaymentMethod!.length}");
    await JsonDb().SubmitJointUs(body).then((res) {
      if (res.success) {
        setState(() {});
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          CustomTheme.CustomSnackBar(res.message, "success"),
        );

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.pagename == "contact" ? getContactData() : getData();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: CustomAppBar(
          leading: CustomBackButton(),
          elevation: 0,
          backgroundColor: CustomColors.appbarbackgroundcolor,
          title: widget.pagename == "contact"
              ? Text(
                  S.of(context).contact_us,
                  style: TextStyle(color: CustomColors.primarycolor),
                )
              : Text(
                  S.of(context).join_us,
                  style: TextStyle(color: CustomColors.primarycolor),
                )),
      body: loading == true
          ? CustomPreloader()
          : SafeArea(
              child: Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 14),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formLoginKey,
                    child: Center(
                      child: Container(
                        width: responsive_size(450, asMaxSize: true),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.all(8.0),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              ...listForm.map((e) {
                                // body.addAll({"${e.name}": "${}"});
                                return e.type == "text"
                                    ? Container(
                                        margin: EdgeInsetsDirectional.only(
                                            bottom: 10),
                                        child: TextFormField(
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          validator: (val) {
                                            return e.subtype == "text"
                                                ? validinput(context, val!, 2,
                                                    50, "name")
                                                : e.subtype == "email"
                                                    ? validinput(context, val!,
                                                        12, 50, "email")
                                                    : e.subtype == "number"
                                                        ? validinput(
                                                            context,
                                                            val!,
                                                            10,
                                                            10,
                                                            "number")
                                                        : e.subtype ==
                                                                "textarea"
                                                            ? validinput(
                                                                context,
                                                                val!,
                                                                2,
                                                                50,
                                                                "name")
                                                            : () {};
                                          },
                                          controller: controllers[e.index],
                                          decoration: InputDecoration(
                                            label: Text(
                                                "${e.getPropertyEffectedByLang("label_${globals.SelectedLang}")}"),
                                            filled: true,
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                borderSide: const BorderSide(
                                                    width: 1,
                                                    color: CustomColors
                                                        .thirdcolor)),
                                            errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                borderSide: const BorderSide(
                                                    width: 1,
                                                    color: Colors.red)),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    borderSide:
                                                        const BorderSide(
                                                            width: 1,
                                                            color: Colors.red)),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                borderSide: const BorderSide(
                                                    width: 1,
                                                    color: CustomColors
                                                        .thirdcolor)),
                                            // hintText: S.of(context).confirm_new_password,
                                            hintStyle: const TextStyle(
                                                color:
                                                    CustomColors.primarycolor),
                                            hoverColor: Colors.white,
                                            fillColor: Colors.white,
                                            contentPadding:
                                                const EdgeInsetsDirectional.all(
                                                    10),
                                          ),
                                        ),
                                      )
                                    : e.type == "textarea"
                                        ? TextFormField(
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (value) {
                                              return validinput(context, value!,
                                                  2, 50, "name");
                                            },
                                            controller: controllers[e.index],
                                            maxLines: 8,
                                            decoration: InputDecoration(
                                              hintText:
                                                  "${e.getPropertyEffectedByLang("label_${globals.SelectedLang}")}",

                                              // label: Text(
                                              //     "${e.getPropertyEffectedByLang("label_${globals.SelectedLang}")}"),
                                              filled: true,
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  borderSide: const BorderSide(
                                                      width: 1,
                                                      color: CustomColors
                                                          .thirdcolor)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  borderSide: const BorderSide(
                                                      width: 1,
                                                      color: Colors.red)),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      borderSide:
                                                          const BorderSide(
                                                              width: 1,
                                                              color:
                                                                  Colors.red)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  borderSide: const BorderSide(
                                                      width: 1,
                                                      color: CustomColors
                                                          .thirdcolor)),
                                              // hintText: S.of(context).confirm_new_password,
                                              hintStyle: TextStyle(
                                                  color: Colors.grey.shade700),
                                              hoverColor: Colors.white,
                                              fillColor: Colors.white,
                                              contentPadding:
                                                  const EdgeInsetsDirectional
                                                      .all(20),
                                            ),
                                          )
                                        : e.type == "select"
                                            ? Container(
                                                margin:
                                                    EdgeInsetsDirectional.only(
                                                        bottom: 10),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: CustomColors
                                                            .thirdcolor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                                child: SmartSelect.single(
                                                  selectedValue: "",
                                                  title:
                                                      "${e.getPropertyEffectedByLang("label_${globals.SelectedLang}")}",
                                                  modalHeaderStyle:
                                                      const S2ModalHeaderStyle(
                                                          backgroundColor:
                                                              CustomColors
                                                                  .primarycolor),
                                                  placeholder:
                                                      S.of(context).select,
                                                  choiceItems: [
                                                    ...e.listvalues.map((e) => S2Choice(
                                                        title: e.getPropertyEffectedByLang(
                                                            "label_${globals.SelectedLang}"),
                                                        value: e.getPropertyEffectedByLang(
                                                            "label_${globals.SelectedLang}")))
                                                  ],
                                                  onChange: (value) {
                                                    controllers[e.index].text =
                                                        value.value;
                                                  },
                                                ),
                                              )
                                            : Container();
                              }).toList(),
                              const SizedBox(
                                height: 30,
                              ),
                              CustomButton(
                                  primary: CustomColors.primarycolor,
                                  onPressed: () {
                                    listForm.forEach((element) {
                                      element.type == "select"
                                          ? element.listvalues.forEach((val) {
                                              body.addAll({
                                                element.name!: val
                                                    .getPropertyEffectedByLang(
                                                        "label_${globals.SelectedLang}")
                                              });
                                            })
                                          : body.addAll({
                                              element.name!:
                                                  controllers[element.index]
                                                      .value
                                                      .text
                                            });
                                    });

                                    print("the final body is ${body}");

                                    checkinput();
                                  },
                                  text: "Send"),
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
