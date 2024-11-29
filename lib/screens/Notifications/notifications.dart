import 'package:flutter/material.dart';
import 'package:redeem/custom_widget/CustomAppBar.dart';
import 'package:redeem/custom_widget/custom_back_button.dart';
import 'package:redeem/custom_widget/custom_preloader.dart';
import 'package:redeem/generated/l10n.dart';
import 'package:redeem/json_db/enum.dart';
import 'package:redeem/json_db/infinite_grid.dart';
import 'package:redeem/json_db/json_db.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';
import 'package:svg_flutter/svg_flutter.dart';

class Notifications extends StatefulWidget {
  const Notifications();

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<LastNotification>? listnotification;
  int? nextpage;
  int? totalResults;
  bool loading = true;
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData({page = 1}) async {
    try {
      await JsonDb().getNotificationsCollections(page: page).then((res) {
        if (res.success) {
          nextpage = res.nextPage;
          if (page == 1) {
            totalResults = res.totalResult!;
            listnotification = res.data;
          } else if (page > 1) {
            var offer = res.data;
            offer.forEach((element) {
              listnotification!.add(element);
            });
          }
          // listnotification = res.data;

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
    } catch (e) {
      /*   ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        CustomTheme.CustomSnackBar("No Notification", "warning"),
      );
      Navigator.of(context).pop(); */
      loading = false;
      listnotification = [];
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.secondarygroundcolor,
      appBar: CustomAppBar(
        leading: CustomBackButton(),
        title: Text(
          S.of(context).notifications,
          style: const TextStyle( color: CustomColors.primarycolor),
        ),
        backgroundColor: CustomColors.appbarbackgroundcolor,
        elevation: 0,
      ),
      body: loading == true
          ? CustomPreloader()
          : SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  await getData(page: 1);
                },
                child: listnotification!.isNotEmpty
                    ? SingleChildScrollView(
                        child: Column(
                          children: [
                            // const SizedBox(
                            //   height: 20,
                            // ),
                            Card(
                              elevation: 0,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.symmetric(
                                    horizontal: 18),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                    
                                      SizedBox(
                                        height: listnotification!.length * 110,
                                        child: InfiniteListView(
                                            nextData: () {
                                              if (nextpage != null) {
                                                getData(page: nextpage);
                                              }
                                            },
                                            hasNext: listnotification!.length <
                                                totalResults!,
                                            itemCount: listnotification!.length,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return Card(
                                                color: Colors.grey.shade100,
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "${listnotification![index].title}",
                                                        style: CustomTheme
                                                            .text16theme
                                                            .copyWith(
                                                                color: CustomColors
                                                                    .primarycolor),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                          "${listnotification![index].message}"),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        "${listnotification![index].notificationDate}",
                                                        style: CustomTheme
                                                            .text15theme
                                                            .copyWith(
                                                                color: Colors
                                                                    .grey
                                                                    .shade400),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      //const Divider()
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: SvgPicture.asset(
                              "assets/images/no-order.svg",
                              width: double.infinity,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              S.of(context).no_notifications,
                              style: TextStyle(
                                  color: CustomColors.primarycolor,
                                  fontSize: 18),
                            ),
                          )
                        ],
                      ),
              ),
            ),
    );
  }
}
