import 'package:flutter/material.dart';
import 'package:redeem/app_storage.dart';
import 'package:redeem/custom_widget/CustomAppBar.dart';
import 'package:redeem/custom_widget/custom_back_button.dart';
import 'package:redeem/generated/l10n.dart';
import 'package:redeem/json_db/json_db.dart';
import 'package:redeem/json_db/utils.dart';
import 'package:redeem/screens/login/login.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';
import 'package:redeem/globals.dart' as globals;

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  bool loading = true;
  bool isDeleted = false;
  void DeleteAccount() async {
    // try {

    await JsonDb().DeleteAccount().then((res) {
      if (res.success) {
        print("success delete Account");

        isDeleted = res.success;

        loading = false;
        globals.isLogin = false;

        globals.userData = null;
        globals.userId = 0;
        globals.token = "";
        globals.userType = "";
        globals.customer = null;
        appStorage().setIsLogin(false);
        appStorage().setUserID(null);
        appStorage().setToken("");
        appStorage().setUserData(null);
        appStorage().setUserType("");
        appStorage().setCustomer(null);

        // setState(() {});

        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return const Login();
        }));

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        elevation: 0,
          leading: CustomBackButton(),
          backgroundColor: CustomColors.appbarbackgroundcolor,
          title: Text(
            S.of(context).delete_account,
            style: TextStyle( color: CustomColors.primarycolor),
          )),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              S.of(context).are_you_sure,
              style: CustomTheme.text18theme
                  .copyWith(color: Colors.black, fontWeight: FontWeight.normal),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              child: Text(
                S.of(context).if_you_delete,
                style: CustomTheme.text16theme.copyWith(
                    height: 1.5,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.normal),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 40,
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () {
                      showConfirmDelete(
                        context,
                        () {
                          showPreLoader(context);
                          DeleteAccount();
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        //  minimumSize: Size(150, 100),
                        primary: CustomColors.DangerColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Center(
                      child: Text(
                        S.of(context).yes_delete,
                        style: const TextStyle(
                            color: CustomColors.titlecolor, fontSize: 13),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: 120,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: OutlinedButton.styleFrom(
                        //  minimumSize: Size(150, 100),
                        primary: Colors.grey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Center(
                      child: Text(
                        S.of(context).cancel,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 13),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
