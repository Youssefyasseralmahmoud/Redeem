import 'package:flutter/material.dart';
import 'package:redeem/custom_widget/CustomAppBar.dart';
import 'package:redeem/custom_widget/custom_back_button.dart';
import 'package:redeem/custom_widget/custom_preloader.dart';
import 'package:redeem/generated/l10n.dart';
import 'package:redeem/json_db/enum.dart';
import 'package:redeem/json_db/json_db.dart';
import 'package:redeem/screens/buy_points/buy_points.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';

class HistoryPoints extends StatefulWidget {
  const HistoryPoints({super.key});

  @override
  State<HistoryPoints> createState() => _HistoryPointsState();
}

class _HistoryPointsState extends State<HistoryPoints> {
  HistoryPointsData? historyPointsData;
  bool loading = true;
  Future<void> getData() async {
    // try {
    await JsonDb().getHistoryPointsCollections().then((res) {
      if (res.success) {
        print("Success historyPointsData data ${res.data}");
        historyPointsData = res.data;

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
    return Scaffold(
      backgroundColor: CustomColors.secondarygroundcolor,
      appBar: CustomAppBar(
        leading: CustomBackButton(),
        title: Text(
          S.of(context).history_points,
          style: const TextStyle( color: CustomColors.primarycolor),
        ),
        backgroundColor: CustomColors.appbarbackgroundcolor,
        elevation: 0,
      ),
      body: loading == true
          ? const CustomPreloader()
          : SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  await getData();
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            padding: const EdgeInsetsDirectional.all(8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25)),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsetsDirectional.symmetric(
                                          horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        S.of(context).Points_Wallet,
                                        style: CustomTheme.text16theme.copyWith(
                                            color: CustomColors.primarycolor),
                                      ),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                            padding: const EdgeInsets.all(0)),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return const BuyPoints();
                                          }));
                                        },
                                        child: Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: [
                                            Text(
                                              S.of(context).buy_points,
                                              style: const TextStyle(
                                                  color:
                                                      CustomColors.secondarycolor),
                                            ),
                                            const Icon(
                                              Icons.arrow_right,
                                              size: 30,
                                              color: CustomColors.secondarycolor,
                                            ),
                                          ],
                                        ),
                                      ),
                                      // ElevatedButton(
                                      //     style: ElevatedButton.styleFrom(
                                      //         padding:
                                      //             const EdgeInsetsDirectional
                                      //                 .all(10),
                                      //         primary:
                                      //             CustomColors.secondarycolor,
                                      //         shape: RoundedRectangleBorder(
                                      //             borderRadius:
                                      //                 BorderRadius.circular(
                                      //                     50))),
                                      //     onPressed: () {
                                      //       Navigator.of(context).push(
                                      //           MaterialPageRoute(
                                      //               builder: (context) {
                                      //         return const BuyPoints();
                                      //       }));
                                      //     },
                                      //     child: Row(
                                      //       children: [
                                      //         Text(
                                      //           S.of(context).buy_points,
                                      //           style: const TextStyle(
                                      //               color: CustomColors
                                      //                   .titlecolor),
                                      //         ),
                                      //         const Icon(
                                      //           Icons.arrow_forward_ios_rounded,
                                      //           size: 15,
                                      //           color: CustomColors.titlecolor,
                                      //         )
                                      //       ],
                                      //     ))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsetsDirectional.symmetric(
                                          horizontal: 14),
                                  child: Column(
                                    children: [
                                      ...historyPointsData!.listHistoryPoint!
                                          .map((e) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade200,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          margin:
                                              const EdgeInsetsDirectional.only(
                                                  bottom: 10),
                                          padding:
                                              const EdgeInsetsDirectional.all(
                                                  8),
                                          width: double.infinity,
                                          height: 70,
                                          child: Row(
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                margin:
                                                    const EdgeInsetsDirectional
                                                        .only(start: 8),
                                                width: 5,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius
                                                                .vertical(
                                                            top: Radius
                                                                .circular(10),
                                                            bottom:
                                                                Radius.circular(
                                                                    10)),
                                                    color: e.type == "inc"
                                                        ? CustomColors
                                                            .SuccessColor
                                                        : CustomColors
                                                            .DangerColor),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Text("${e.desc}"),
                                                    ),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          '${e.date}',
                                                          style: CustomTheme
                                                              .text15theme
                                                              .copyWith(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade500),
                                                        ),
                                                        const SizedBox(
                                                          width: 100,
                                                        ),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            e.type == "inc"
                                                                ? Text(
                                                                    "+" +
                                                                        "${e.amount}",
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .green),
                                                                  )
                                                                : Text(
                                                                    "-" +
                                                                        "${e.amount}",
                                                                    style: const TextStyle(
                                                                        color: CustomColors
                                                                            .DangerColor),
                                                                  ),
                                                            e.type == "inc"
                                                                ? Text(
                                                                    (" " +
                                                                        S
                                                                            .of(
                                                                                context)
                                                                            .points),
                                                                    style:
                                                                        const TextStyle(
                                                                      color: CustomColors
                                                                          .SuccessColor,
                                                                    ))
                                                                : Text(
                                                                    (" " +
                                                                        S
                                                                            .of(context)
                                                                            .points),
                                                                    style: const TextStyle(
                                                                        color: CustomColors
                                                                            .DangerColor),
                                                                  ),
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList()
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Positioned(
                              left: 120,
                              top: -60,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundColor: CustomColors.primarycolor,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Your Balance",
                                      style: CustomTheme.text15theme
                                          .copyWith(color: Colors.white),
                                    ),
                                    Text(
                                      "${historyPointsData!.balance}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      S.of(context).points,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    )
                                  ],
                                ),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
