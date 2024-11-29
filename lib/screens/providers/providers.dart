import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:redeem/custom_widget/CustomAppBar.dart';
import 'package:redeem/custom_widget/custom_back_button.dart';
import 'package:redeem/custom_widget/custom_drawer.dart';
import 'package:redeem/custom_widget/custom_preloader.dart';
import 'package:redeem/generated/l10n.dart';
import 'package:redeem/json_db/enum.dart';
import 'package:redeem/json_db/json_db.dart';
import 'package:redeem/screens/details_screen_of_providers/details_screen_of_providers.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';
import 'package:redeem/globals.dart' as globals;

class Providers extends StatefulWidget {
  const Providers({super.key});

  @override
  State<Providers> createState() => _ProvidersState();
}

class _ProvidersState extends State<Providers> {
  bool loading = true;
  List<SimpleProvider>? simpleProvider;
  List<City> cities = [];
  String? selectedvalue;
  void selectsorting(String value) {
    selectedvalue = value;
    setState(() {});
    Navigator.of(context).pop();
  }

  void getData() async {
    // try {
    await JsonDb().getProvidersCollections().then((res) {
      if (res.success) {
        print("providers succses ${res.data}");
        simpleProvider = res.data;

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
      // drawer: Navigator.canPop(context)
      //     ? null
      //     : CustomDrawer(
      //         cities: globals.cities, choiselangitem: globals.Language2),
      backgroundColor: CustomColors.backgroundcolor_for_Ticket,
      appBar: CustomAppBar(
        //leadingWidth: 0,
        iconTheme: IconThemeData(color: CustomColors.primarycolor),
        leading: Navigator.canPop(context) ? CustomBackButton() : null,
        title: Text(
          S.of(context).providers,
          style: CustomTheme.text_white20theme.copyWith(
            color: CustomColors.primarycolor,
            fontWeight: FontWeight.w400,
          ),
        ),
        // actions: [
        //   IconButton(
        //       padding: EdgeInsets.zero,
        //       onPressed: () {
        //         showDialog(
        //             context: context,
        //             builder: (builder) {
        //               return AlertDialog(
        //                 contentPadding: EdgeInsetsDirectional.all(10),
        //                 title: Text(
        //                   S.of(context).sort_by,
        //                 ),
        //                 content: Container(
        //                   height: 350,
        //                   child: Column(
        //                     children: [
        //                       SizedBox(
        //                         height: 10,
        //                       ),
        //                       RadioListTile(
        //                           controlAffinity:
        //                               ListTileControlAffinity.trailing,
        //                           secondary:
        //                               Text(S.of(context).default_sorting),
        //                           activeColor: CustomColors.primarycolor,
        //                           value: "v",
        //                           groupValue: "${selectedvalue}",
        //                           onChanged: (value) {
        //                             selectsorting(value!);
        //                           }),
        //                       RadioListTile(
        //                           controlAffinity:
        //                               ListTileControlAffinity.trailing,
        //                           secondary:
        //                               Text(S.of(context).newest_arrivals),
        //                           activeColor: CustomColors.primarycolor,
        //                           value: "v1",
        //                           groupValue: "${selectedvalue}",
        //                           onChanged: (value) {
        //                             selectsorting(value!);
        //                           }),
        //                       RadioListTile(
        //                           controlAffinity:
        //                               ListTileControlAffinity.trailing,
        //                           secondary:
        //                               Text(S.of(context).customers_review),
        //                           activeColor: CustomColors.primarycolor,
        //                           value: "v2",
        //                           groupValue: "${selectedvalue}",
        //                           onChanged: (value) {
        //                             selectsorting(value!);
        //                           }),
        //                       RadioListTile(
        //                           controlAffinity:
        //                               ListTileControlAffinity.trailing,
        //                           secondary:
        //                               Text(S.of(context).by_price_low_to_high),
        //                           activeColor: CustomColors.primarycolor,
        //                           value: "v3",
        //                           groupValue: "${selectedvalue}",
        //                           onChanged: (value) {
        //                             selectsorting(value!);
        //                           }),
        //                       RadioListTile(
        //                           secondary:
        //                               Text(S.of(context).by_price_high_to_low),
        //                           activeColor: CustomColors.primarycolor,
        //                           controlAffinity:
        //                               ListTileControlAffinity.trailing,
        //                           value: "v4",
        //                           groupValue: "${selectedvalue}",
        //                           onChanged: (value) {
        //                             selectsorting(value!);
        //                           }),
        //                     ],
        //                   ),
        //                 ),
        //               );
        //             });
        //       },
        //       icon: Icon(Icons.sort)),
        // ],
        backgroundColor: CustomColors.appbarbackgroundcolor,
        elevation: 0,
      ),
      body: loading == true
          ? CustomPreloader()
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      // height:200,
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 120,
                                  mainAxisExtent: 120,
                                  crossAxisSpacing: 0),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: simpleProvider!.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsetsDirectional.all(8),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return DetailsScreenOfProviders(
                                          id: simpleProvider![index].id,
                                        );
                                      }));
                                    },
                                    child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 35,
                                        backgroundImage: NetworkImage(
                                            "${simpleProvider![index].logo}")),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: 70,
                                      child: Center(
                                        child: Marquee(
                                          text:
                                              "${simpleProvider![index].getPropertyEffectedByLang("name_${globals.SelectedLang}")}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13),

                                          scrollAxis: Axis.horizontal,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          blankSpace: 10,
                                          //velocity: 100.0,
                                          pauseAfterRound:
                                              const Duration(seconds: 1),
                                          startPadding: 10.0,
                                          accelerationDuration:
                                              const Duration(seconds: 1),
                                          accelerationCurve: Curves.linear,
                                          decelerationDuration:
                                              const Duration(milliseconds: 100),
                                          decelerationCurve: Curves.easeOut,
                                          numberOfRounds: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Text(
                                  //   "${simpleProvider![index].getPropertyEffectedByLang("name_${globals.SelectedLang}")}",
                                  //   textAlign: TextAlign.center,
                                  //   style: TextStyle(
                                  //       fontWeight: FontWeight.w400,
                                  //       fontSize: 13),
                                  // )
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
