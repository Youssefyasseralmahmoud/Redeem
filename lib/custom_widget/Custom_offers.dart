import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:redeem/generated/l10n.dart';
import 'package:redeem/json_db/enum.dart';
import 'package:redeem/screens/List_coupons_page/List_coupons_page.dart';
import 'package:redeem/screens/offer_details/offer_details.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:redeem/globals.dart' as globals;

class CustomOffers extends StatefulWidget {
  SimpleOffer simpleOffer;
  Color? offercolor;
  Color? circulColor;
//  String? imageurl;
//   String? logourl;
//   String? name;
//   String? content;
  CustomOffers(
      {super.key,
      this.offercolor,
      this.circulColor,
      //  this.imageurl,
      //   this.content,
      //    this.name,
      //    this.logourl,
      required this.simpleOffer});

  @override
  State<CustomOffers> createState() => _CustomOffers();
}

class _CustomOffers extends State<CustomOffers> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                width: 120,
                height: 125,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10))),
                child: CachedNetworkImage(
                  imageUrl: "${widget.simpleOffer.image}",
                  fit: BoxFit.cover,
                  width: 120,
                  height: 100,
                ),
              ),
              Expanded(
                flex: 10,
                child: Container(
                  
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
                  height: 127,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: widget.offercolor ?? Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 22,
                              backgroundImage: NetworkImage(
                                  "${widget.simpleOffer.simpleProvider!.logo}")),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                                "${widget.simpleOffer.simpleProvider!.getPropertyEffectedByLang("name_${globals.SelectedLang}")}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: CustomTheme.text15theme
                                    .copyWith(color: Colors.grey, fontSize: 13)),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      // Align(
                      //     alignment: Alignment.center,
                      //     child: Text(
                      //       "${widget.simpleOffer.simpleProvider!.category!.getPropertyEffectedByLang("name_${globals.SelectedLang}")}",
                      //       style: CustomTheme.text15theme
                      //           .copyWith(fontSize: 10, color: Colors.red),
                      //       textAlign: TextAlign.center,
                      //     )),
                      Container(
                        child: Text(
                          "${widget.simpleOffer.getPropertyEffectedByLang("name_${globals.SelectedLang}")}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: CustomTheme.text15theme.copyWith(
                            color: CustomColors.primarycolor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${widget.simpleOffer.points} " +
                                S.of(context).points,
                            style: CustomTheme.text15theme
                                .copyWith(color: Colors.blue, fontSize: 13),
                          ),
                          Container(
                            height: 27,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    maximumSize: Size(70, 27),
                                    minimumSize: Size(70, 27),
                                    padding:
                                        const EdgeInsetsDirectional.symmetric(
                                            horizontal: 5, vertical: 3),
                                    primary: CustomColors.secondarycolor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50))),
                                onPressed: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (context) {
                                    return OfferDetails(
                                      offerid: widget.simpleOffer.id,
                                    );
                                  }));
                                },
                                child: Text(
                                  S.of(context).useoffer,
                                  textAlign: TextAlign.center,
                                  style:  TextStyle(
                                      color: CustomColors.titlecolor,
                                      fontSize:
                                          globals.SelectedLang == "en" ? 10 : 8.5),
                                )),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          PositionedDirectional(
              start: 108,
              top: 0,
              child: Container(
                width: 50,
                height: 100,
                child: Stack(children: [
                  PositionedDirectional(
                      top: -16.5,
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          color: widget.circulColor ??
                              CustomColors.ticket_clip_color,
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ))
                ]),
              )),
          PositionedDirectional(
              start: 108,
              top: 0,
              child: Container(
                width: 50,
                height: 100,
                child: Stack(clipBehavior: Clip.none, children: [
                  PositionedDirectional(
                      bottom: -42.5,
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          color: widget.circulColor ??
                              CustomColors.ticket_clip_color,
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ))
                ]),
              )),
        ],
      ),
    );
  }
}
