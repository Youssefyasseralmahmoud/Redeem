import 'package:flutter/material.dart';
import 'package:redeem/app_storage.dart';
import 'package:redeem/custom_widget/CustomDashboardInfo.dart';
import 'package:redeem/custom_widget/custom_back_button.dart';
import 'package:redeem/custom_widget/custom_drawer.dart';
import 'package:redeem/custom_widget/custom_preloader.dart';
import 'package:redeem/generated/l10n.dart';
import 'package:redeem/json_db/enum.dart';
import 'package:redeem/json_db/json_db.dart';
import 'package:redeem/json_db/utils.dart';
import 'package:redeem/screens/DeleteAccount/DeleteAccount.dart';
import 'package:redeem/screens/Join%20Invitation/Join_Invitation.dart';
import 'package:redeem/screens/MyCoupons/my_coupons.dart';
import 'package:redeem/screens/Notifications/notifications.dart';
import 'package:redeem/screens/WhichList.dart';
import 'package:redeem/screens/all%20offers/all_offers.dart';
import 'package:redeem/screens/all%20purchases/all_purchases.dart';
import 'package:redeem/screens/change_password/change_password.dart';
import 'package:redeem/screens/edit_personal_information/edit_personal_information.dart';
import 'package:redeem/screens/history%20points/history_Points.dart';
import 'package:redeem/screens/main_screen/main_screen.dart';
import 'package:redeem/screens/subscription_package/subscription_package.dart';
import 'package:redeem/size_config.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';
import 'package:redeem/globals.dart' as globals;
import 'package:svg_flutter/svg_flutter.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile>
    with AutomaticKeepAliveClientMixin<Profile> {
  @override
  bool get wantKeepAlive => true;
  bool loading = true;
  DashboardCustomerData? dashboardCustomerData;
  List<City> cities = [];
  Future<void> getData() async {
    // try {
    await JsonDb().getDashboardDataCollections().then((res) {
      if (res.success) {
        print("Success dashboard data ${res.data}");
        dashboardCustomerData = res.data;

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
    super.initState();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      drawer: CustomDrawer(
        cities: globals.cities,
        choiselangitem: globals.Language2,
      ),
      backgroundColor: CustomColors.backgroundcolor_for_Ticket,
      body: loading == true
          ? const CustomPreloader()
          : RefreshIndicator(
              onRefresh: () async {
                await getData();
              },
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                              start: globals.start_padding,
                              end: globals.end_padding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsetsDirectional.all(5),
                                    height: 63,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(color: Colors.white),
                                      color: Color(
                                        int.parse(
                                          "0XFF" +
                                              dashboardCustomerData!
                                                  .currentPackage!
                                                  .subscriptionPackage!
                                                  .color!
                                                  .replaceAll("#", ""),
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ...List.generate(
                                                dashboardCustomerData!
                                                    .currentPackage!
                                                    .subscriptionPackage!
                                                    .level!, (index) {
                                              return Icon(
                                                Icons.star_rate,
                                                color: Colors.white,
                                                size: 20,
                                              );
                                            })
                                          ],
                                        ),
                                        Center(
                                          child: Text(
                                            "${dashboardCustomerData!.currentPackage!.subscriptionPackage!.getPropertyEffectedByLang("package_name_${globals.SelectedLang}")}",
                                            style: CustomTheme.text18theme
                                                .copyWith(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.normal),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  dashboardCustomerData!.nextPackage != null
                                      ? SizedBox(
                                          width: 100,
                                          height: 30,
                                          child: OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                  side: BorderSide(
                                                      color:
                                                          Colors.grey.shade400),
                                                  primary: Colors.white),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return const SubsriptionPackage();
                                                }));
                                              },
                                              child: Center(
                                                child: Text(
                                                  S.of(context).Upgrade,
                                                  style: CustomTheme.text16theme
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                ),
                                              )),
                                        )
                                      : Container(),
                                ],
                              ),
                              IconButton(
                                  onPressed: () async {
                                    globals.isLogin = false;

                                    globals.userData = null;
                                    globals.userId = 0;
                                    globals.token = "";
                                    globals.userType = "";
                                    globals.customer = null;
                                    await appStorage().setIsLogin(false);
                                    await appStorage().setUserID(null);
                                    await appStorage().setToken("");
                                    await appStorage().setUserData(null);
                                    await appStorage().setUserType("");
                                    await appStorage().setCustomer(null);

                                    setState(() {});

                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(builder: (context) {
                                      return MainScreen();
                                    }));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      CustomTheme.CustomSnackBar(
                                          "Logout Successfully", "success"),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.logout_outlined,
                                    color: CustomColors.DangerColor,
                                  )),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (globals.customer != null)
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                                start: globals.start_padding,
                                end: globals.end_padding),
                            child: Text(
                              "${globals.customer?.fullName}",
                              style: CustomTheme.text18theme.copyWith(
                                  color: CustomColors.primarycolor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                              start: globals.start_padding,
                              end: globals.end_padding),
                          child: Row(
                            children: [
                              Icon(
                                Icons.phone,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              if (globals.customer != null)
                                Text(
                                  "${globals.customer?.mobile}",
                                  style: const TextStyle(color: Colors.black),
                                )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                              start: globals.start_padding,
                              end: globals.end_padding),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_month_outlined,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                S.of(context).Subscription_end_in +
                                    "${dashboardCustomerData!.currentPackage!.expiryDateFormatted}",
                                style: const TextStyle(color: Colors.black),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                              start: globals.start_padding,
                              end: globals.end_padding),
                          child: Row(
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return const EditPersonalInfo();
                                    }));
                                  },
                                  child: Text(
                                    S.of(context).edit_informations,
                                    style: TextStyle(
                                        decoration: TextDecoration.underline),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return const ChangePassword();
                                    }));
                                  },
                                  child: Text(S.of(context).change_password,
                                      style: TextStyle(
                                          decoration:
                                              TextDecoration.underline)))
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                              start: globals.start_padding,
                              end: globals.end_padding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomDashboardInfo(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return const HistoryPoints();
                                    }));
                                  },
                                  dashboardCustomerData: dashboardCustomerData,
                                  title: S.of(context).points,
                                  color: Colors.white,
                                  // CustomColors.secondarycolor.withOpacity(0.04),
                                  content: "${dashboardCustomerData!.balance}" +
                                      " " +
                                      S.of(context).points,
                                  subContent: "",
                                  icon: Icons.wallet_rounded),
                              CustomDashboardInfo(
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return const MyCoupons();
                                  }));
                                },
                                dashboardCustomerData: dashboardCustomerData,
                                color: Colors.white,
                                // CustomColors.secondarycolor.withOpacity(0.04),
                                title: S.of(context).my_coupons,
                                content:
                                    "${dashboardCustomerData!.countSoldCoupons}" +
                                        " " +
                                        S.of(context).coupons,
                                subContent: "",
                                icon: Icons.confirmation_num_outlined,
                              ),
                              CustomDashboardInfo(
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return const JoinInvitation();
                                  }));
                                },
                                dashboardCustomerData: dashboardCustomerData,
                                title: S.of(context).join_invitations,
                                content:
                                    "${dashboardCustomerData!.countAcceptanceInvitations}" +
                                        " " +
                                        S.of(context).invitation,
                                color: Colors.white,
                                // CustomColors.secondarycolor.withOpacity(0.04),
                                icon: Icons.drafts_outlined,
                                subContent: "",
                              )
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        //  globals.isLogin == true ? const Divider() : Container(),
                        globals.isLogin == true
                            ? Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.only(
                                      start: globals.start_padding,
                                      end: globals.end_padding),
                                  child: Container(
                                    margin:
                                        EdgeInsetsDirectional.only(bottom: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return const HistoryPoints();
                                        }));
                                      },
                                      leading: TextButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return const HistoryPoints();
                                            }));
                                          },
                                          child: Text(
                                            S.of(context).points_wallet,
                                            style: CustomTheme.text16theme
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.normal),
                                          )),
                                      trailing:
                                          const Icon(Icons.wallet_outlined),
                                    ),
                                  ),
                                ))
                            : Container(),

                        //globals.isLogin == true ? const Divider() : Container(),
                        globals.isLogin == true
                            ? Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.only(
                                      start: globals.start_padding,
                                      end: globals.end_padding),
                                  child: Container(
                                    margin:
                                        EdgeInsetsDirectional.only(bottom: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return const AllPurchases();
                                        }));
                                      },
                                      leading: TextButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return const AllPurchases();
                                            }));
                                          },
                                          child: Text(
                                            S.of(context).my_purchases,
                                            style: CustomTheme.text16theme
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.normal),
                                          )),
                                      trailing:
                                          const Icon(Icons.grading_outlined),
                                    ),
                                  ),
                                ))
                            : Container(),

                        //   globals.isLogin == true ? const Divider() : Container(),
                        globals.isLogin == true
                            ? Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.only(
                                      start: globals.start_padding,
                                      end: globals.end_padding),
                                  child: Container(
                                    margin:
                                        EdgeInsetsDirectional.only(bottom: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return const WichList();
                                        }));
                                      },
                                      leading: TextButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return const WichList();
                                            }));
                                          },
                                          child: Text(
                                            S.of(context).WhishList,
                                            style: CustomTheme.text16theme
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.normal),
                                          )),
                                      trailing: const Icon(
                                          Icons.favorite_border_outlined),
                                    ),
                                  ),
                                ))
                            : Container(),
                        // globals.isLogin == true ? const Divider() : Container(),
                        globals.isLogin == true
                            ? Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.only(
                                      start: globals.start_padding,
                                      end: globals.end_padding),
                                  child: Container(
                                    margin:
                                        EdgeInsetsDirectional.only(bottom: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return const Notifications();
                                        }));
                                      },
                                      leading: TextButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return const Notifications();
                                            }));
                                          },
                                          child: Text(
                                            S.of(context).notifications,
                                            style: CustomTheme.text16theme
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.normal),
                                          )),
                                      trailing: const Icon(
                                          Icons.notifications_active_outlined),
                                    ),
                                  ),
                                ))
                            : Container(),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(
                                  start: globals.start_padding,
                                  end: globals.end_padding),
                              child: Container(
                                margin: EdgeInsetsDirectional.only(bottom: 5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return const DeleteAccount();
                                    }));
                                  },
                                  leading: TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return const DeleteAccount();
                                        }));
                                      },
                                      child: Text(
                                        S.of(context).delete_account,
                                        style: CustomTheme.text16theme.copyWith(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.red),
                                      )),
                                  trailing: const Icon(
                                    Icons.remove_circle_outline,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ))
                        // Card(
                        //   color: Colors.white,
                        //   child: SingleChildScrollView(
                        //     child: Padding(
                        //       padding: const EdgeInsetsDirectional.all(5),
                        //       child: Column(
                        //         children: [
                        //           Row(
                        //             mainAxisAlignment:
                        //                 MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               Text(
                        //                 S.of(context).notifications,
                        //                 style: CustomTheme.text18theme.copyWith(
                        //                     color: CustomColors.primarycolor),
                        //               ),
                        //               Row(
                        //                 children: [
                        //                   GestureDetector(
                        //                     onTap: () {
                        //                       Navigator.of(context).push(
                        //                           MaterialPageRoute(
                        //                               builder: (context) {
                        //                         return const Notifications();
                        //                       }));
                        //                     },
                        //                     child: Text(
                        //                       S
                        //                           .of(context)
                        //                           .view_all_notifications,
                        //                     ),
                        //                   ),
                        //                   const Icon(Icons.navigate_next)
                        //                 ],
                        //               )
                        //             ],
                        //           ),
                        //           const SizedBox(
                        //             height: 10,
                        //           ),
                        //           SizedBox(
                        //             height: dashboardCustomerData!
                        //                     .listLastNotifications!.length *
                        //                 100,
                        //             child: ListView.builder(
                        //                 itemCount: 4,
                        //                 physics:
                        //                     const NeverScrollableScrollPhysics(),
                        //                 itemBuilder: (context, index) {
                        //                   return Container(
                        //                     padding:
                        //                         const EdgeInsetsDirectional.all(
                        //                             8),
                        //                     child: Column(
                        //                       mainAxisAlignment:
                        //                           MainAxisAlignment.spaceBetween,
                        //                       crossAxisAlignment:
                        //                           CrossAxisAlignment.start,
                        //                       children: [
                        //                         Text(
                        //                           "${dashboardCustomerData!.listLastNotifications![index].title}",
                        //                           style: CustomTheme.text16theme
                        //                               .copyWith(
                        //                                   color: CustomColors
                        //                                       .primarycolor),
                        //                         ),
                        //                         const SizedBox(
                        //                           height: 5,
                        //                         ),
                        //                         Text(
                        //                             "${dashboardCustomerData!.listLastNotifications![index].message}"),
                        //                         const SizedBox(
                        //                           height: 5,
                        //                         ),
                        //                         Text(
                        //                           "${dashboardCustomerData!.listLastNotifications![index].notificationDate}",
                        //                           style: CustomTheme.text15theme
                        //                               .copyWith(
                        //                                   color: Colors
                        //                                       .grey.shade400),
                        //                         ),
                        //                         const SizedBox(
                        //                           height: 5,
                        //                         ),
                        //                         const Divider()
                        //                       ],
                        //                     ),
                        //                   );
                        //                 }),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
