import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:redeem/custom_widget/CustomAppBar.dart';
import 'package:redeem/custom_widget/custom_back_button.dart';
import 'package:redeem/custom_widget/custom_preloader.dart';
import 'package:redeem/json_db/enum.dart';
import 'package:redeem/json_db/json_db.dart';
import 'package:redeem/json_db/utils.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';
import 'package:redeem/globals.dart' as globals;

// ignore: must_be_immutable
class DetailsPage extends StatefulWidget {
  dynamic keyword;
  DetailsPage({super.key, required this.keyword});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  DetailsPageData? detailsPageData;
  bool loading = true;
  void getData() async {
    // try {

    await JsonDb().getDetailPageCollections(widget.keyword).then((res) {
      if (res.success) {
        detailsPageData = res.data;

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
        backgroundColor: CustomColors.appbarbackgroundcolor,
        elevation: 0,
        title: loading
            ? null
            : Text(
                "${detailsPageData!.getPropertyEffectedByLang("title_${globals.SelectedLang}")}",
                style: TextStyle(
                    color: CustomColors.primarycolor,),
              ),
      ),
      body: loading == true
          ? CustomPreloader()
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 18.0, vertical: 12),
                      child: HtmlWidget(
                        "${detailsPageData!.getPropertyEffectedByLang("description_${globals.SelectedLang}")}",
                        textStyle: CustomTheme.text16theme.copyWith(
                            color: Colors.black, fontWeight: FontWeight.normal),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
