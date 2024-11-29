import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redeem/custom_widget/CustomAppBar.dart';
import 'package:redeem/custom_widget/custom_back_button.dart';
import 'package:redeem/custom_widget/custom_preloader.dart';
import 'package:redeem/generated/l10n.dart';
import 'package:redeem/json_db/enum.dart';
import 'package:redeem/json_db/infinite_grid.dart';
import 'package:redeem/json_db/json_db.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';

class JoinInvitation extends StatefulWidget {
  const JoinInvitation({super.key});

  @override
  State<JoinInvitation> createState() => _JoinInvitationState();
}

class _JoinInvitationState extends State<JoinInvitation> {
  int? nextpage;
  int? totalResults;
  bool loading = true;
  JoinInvitationData? joinInvitationData;
  Future<void> getData({page = 1}) async {
    // try {
    await JsonDb().getJoinInvitationCollections().then((res) {
      if (res.success) {
        nextpage = res.nextPage;
        if (page == 1) {
          totalResults = res.totalResult!;
          joinInvitationData = res.data;
        } else if (page > 1) {
          var offer = res.data;
          offer.forEach((element) {
            joinInvitationData!.listInvitations!.add(element);
          });
        }
        // joinInvitationData = res.data;

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
    return RefreshIndicator(
      onRefresh: () async {
        await getData();
      },
      child: Scaffold(
        backgroundColor: CustomColors.secondarygroundcolor,
        appBar: CustomAppBar(
          leading: CustomBackButton(),
          title: Text(
            S.of(context).join_invitations,
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
                      // physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                    children: [
                      const SizedBox(
                        height: 100,
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
                                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 18),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        S.of(context).join_invitations,
                                        style: CustomTheme.text16theme.copyWith(
                                            color: CustomColors.primarycolor),
                                      ),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              padding:
                                                  const EdgeInsetsDirectional.all(
                                                      10),
                                              primary: Colors.black,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(50))),
                                          onPressed: () async {
                                            await Clipboard.setData(ClipboardData(
                                                text:
                                                    "${joinInvitationData!.invitationLink}"));
                                            ScaffoldMessenger.of(
                                                    context as BuildContext)
                                                .showSnackBar(
                                              CustomTheme.CustomSnackBar(
                                                  S
                                                      .of(context)
                                                      .link_copied_successfully,
                                                  "success"),
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                S
                                                    .of(context)
                                                    .Copy_invitation_link,
                                                style: const TextStyle(
                                                    color:
                                                        CustomColors.titlecolor),
                                              ),
                                              const Icon(
                                                Icons.copy_all_outlined,
                                                size: 15,
                                                color: CustomColors.titlecolor,
                                              )
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: joinInvitationData!
                                          .listInvitations!.length *
                                      70,
                                  child: Padding(
                                   padding: const EdgeInsetsDirectional.symmetric(horizontal: 8),
                                    child: InfiniteListView(
                                        nextData: () {
                                          if (nextpage != null) {
                                            getData(page: nextpage);
                                          }
                                        },
                                        hasNext: joinInvitationData!
                                                .listInvitations!.length <
                                            totalResults!,
                                        padding:
                                            const EdgeInsetsDirectional.all(8),
                                        itemCount: joinInvitationData!
                                            .listInvitations!.length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return Container(
                                              margin: const EdgeInsetsDirectional
                                                  .only(bottom: 10),
                                              width: double.infinity,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(20)),
                                              child: ListTile(
                                                leading: const Icon(
                                                  Icons.check,
                                                  color:
                                                      CustomColors.SuccessColor,
                                                ),
                                                title: Text(
                                                  "${joinInvitationData!.listInvitations![index].acceptanceInvitationName}",
                                                  style: CustomTheme.text16theme
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.normal),
                                                ),
                                                subtitle: Text(
                                                  "${joinInvitationData!.listInvitations![index].invitationDate}",
                                                  style: CustomTheme.text15theme
                                                      .copyWith(
                                                    color: Colors.grey.shade400,
                                                  ),
                                                ),
                                              ));
                                        }),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Positioned(
                              left: 120,
                              top: -90,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundColor: CustomColors.primarycolor,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "2",
                                      style: CustomTheme.text15theme.copyWith(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      S.of(context).invitation + "(s)",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      )
                    ],
                  )),
                ),
              ),
      ),
    );
  }
}
