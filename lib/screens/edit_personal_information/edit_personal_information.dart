import 'package:flutter/material.dart';
import 'package:redeem/app_storage.dart';

import 'package:redeem/core/function/validationinput.dart';
import 'package:redeem/custom_widget/CustomAppBar.dart';
import 'package:redeem/custom_widget/custme_button.dart';
import 'package:redeem/custom_widget/custom_back_button.dart';
import 'package:redeem/custom_widget/custom_drawer.dart';
import 'package:redeem/custom_widget/custom_text_form_field.dart';
import 'package:redeem/generated/l10n.dart';
import 'package:redeem/json_db/enum.dart';
import 'package:redeem/json_db/json_db.dart';
import 'package:redeem/json_db/utils.dart';
import 'package:redeem/screens/edit_personal_information/edit_personal_info_controller.dart';
import 'package:redeem/size_config.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';
import 'package:redeem/globals.dart' as globals;

class EditPersonalInfo extends StatefulWidget {
  const EditPersonalInfo({super.key});

  @override
  State<EditPersonalInfo> createState() => _EditPersonalInfo();
}

class _EditPersonalInfo extends State<EditPersonalInfo> {
  final formeditKey = GlobalKey<FormState>();
  late appStorage storage;
  TextEditingController emailController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  List<City> cities = [];
  void checkinput() {
    var formdata = formeditKey.currentState;
    if (formdata!.validate()) {
      JsonDb()
          .updateProfileCollections(
        firstnameController.value.text,
        lastnameController.value.text,
        phoneController.value.text,
        emailController.value.text,
      )
          .then((res) async {
        if (res.success) {
          dismissPreLoader(context);
          var data = res.data as updateProfileData;
          globals.userData = data.user;
          globals.userId = data.userId!;
          globals.customer = data.customer!;
          await storage.setUserID(data.userId);

          await storage.setUserData(data.user);
          await storage.setCustomer(data.customer);
          setState(() {});

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
    storage = appStorage();

    firstnameController.text = "${globals.customer!.firstName}";
    lastnameController.text = "${globals.customer!.lastName}";
    emailController.text = "${globals.customer!.email}";
    phoneController.text = "${globals.customer!.mobile}";
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      // drawer: CustomDrawer(
      //   cities: globals.cities,
      //   choiselangitem: globals.Language2,
      // ),
      appBar: CustomAppBar(
        elevation: 0,
        leading: CustomBackButton(),
        title: Text(S.of(context).edit_your_profile_information,
            style: CustomTheme.text18theme.copyWith( color: CustomColors.primarycolor)),
        backgroundColor: CustomColors.primarycolor,
      ),
      backgroundColor: CustomColors.secondarygroundcolor,
      body: SafeArea(
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
                    key: formeditKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    
                        customtextformfield(
                          prefixtext: Icon(Icons.person_2_outlined),

                          bordercolor: CustomColors.thirdcolor,
                          textcolor: CustomColors.primarycolor,
                          hintcolor: CustomColors.primarycolor,
                          fillcolor: Colors.white,
                          hint: S.of(context).first_name,
                          type: "username",
                          // ignore: unnecessary_null_comparison
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
                          bordercolor: CustomColors.thirdcolor,
                          textcolor: CustomColors.primarycolor,
                          hintcolor: CustomColors.primarycolor,
                          fillcolor: Colors.white,
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
                          prefixtext: Icon(Icons.email_outlined),
                          bordercolor: CustomColors.thirdcolor,
                          textcolor: CustomColors.primarycolor,
                          hintcolor: CustomColors.primarycolor,
                          fillcolor: Colors.white,
                          hint: S.of(context).emailaddres,
                          type: "email",
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          validator: (val) {
                            return validinput(context, val!, 12, 100, "email");
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        customtextformfield(
                          prefixtext: Padding(
                            padding: const EdgeInsetsDirectional.only(
                                top: 14, start: 18),
                            child: Text(
                              "+964 | ",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          bordercolor: CustomColors.thirdcolor,
                          textcolor: CustomColors.primarycolor,
                          hintcolor: CustomColors.primarycolor,
                          fillcolor: Colors.white,
                          hint: S.of(context).phone_number,
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          type: "phone",
                          validator: (val) {
                            return validinput(context, val!, 10, 10, "phone");
                          },
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
