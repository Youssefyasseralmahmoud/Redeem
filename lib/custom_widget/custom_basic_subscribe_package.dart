import 'package:flutter/material.dart';
import 'package:redeem/theme/colors.dart';
import 'package:redeem/theme/custom_theme.dart';
import 'package:redeem/globals.dart' as globals;




class CustomBasicSubscribePackage extends StatefulWidget {
  String? basic_content;
   CustomBasicSubscribePackage({
    this.basic_content,
    super.key,
  });

  @override
  State<CustomBasicSubscribePackage> createState() => _CustomBasicSubscribePackage();
}

class _CustomBasicSubscribePackage extends State<CustomBasicSubscribePackage> {
  @override
  Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsetsDirectional.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
              side:
                  BorderSide(color: CustomColors.basic_package,width: 1.5)),
          child: Padding(
            padding: const EdgeInsetsDirectional.all(8.0),
            child: Column(
              children: [
                Text(
                  "Basic",
                  style: CustomTheme.text16theme.copyWith(
                      color: CustomColors.basic_package),
                ),
                const SizedBox(
                  height: 10,
                ),
            ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
              return
                  Padding(
                    padding: const EdgeInsetsDirectional.only(bottom: 10),
                    child: Row(
                    children: [
                      Icon(
                        Icons.check,
                        color: CustomColors.basic_package,
                      ),
                      const SizedBox(width: 10,),
                      Text(
                          "${widget.basic_content}")
                    ],
                                  ),
                  );
            }),
                // Row(
                //   children: [
                //     Icon(
                //       Icons.check_box,
                //       color: CustomColors.basic_package,
                //     ),
                //     const SizedBox(width: 10,),
                //     Text("Collect Points and redeem them")
                //   ],
                // ),
                // Row(
                //   children: [
                //     Icon(
                //       Icons.check_box,
                //       color: CustomColors.basic_package,
                //     ),
                //     const SizedBox(width: 10,),
                //     Text(
                //         "Send Participation Links and Collect Points")
                //   ],
                // ),
                // Row(
                //   children: [
                //     Icon(
                //       Icons.check_box,
                //       color: CustomColors.basic_package,
                //     ),
                //     const SizedBox(width: 10,),
                //     Text("Buy Points in The App")
                //   ],
                // ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text("Number Of Points :" + " "),
                    Text("${globals.PointNumber}")
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Text("expiration date :" + " "),
                    Text("${globals.EndDateSubscribe}")
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  }
}