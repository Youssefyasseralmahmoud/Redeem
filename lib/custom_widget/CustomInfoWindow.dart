import 'package:flutter/material.dart';
import 'package:redeem/json_db/enum.dart';
import 'package:redeem/screens/details_screen_of_providers/details_screen_of_providers.dart';
import 'package:redeem/screens/providers/providers.dart';
import 'package:redeem/size_config.dart';
import 'package:redeem/theme/custom_theme.dart';
import 'package:redeem/globals.dart' as globals;

class MyCustomInfoWindow extends StatelessWidget {
  SimpleProvider provider;
  MyCustomInfoWindow(this.provider);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return DetailsScreenOfProviders(
            id: provider.id,
          );
        }));
      },
      child: Container(
        padding: const EdgeInsetsDirectional.all(8),
        width: responsive_size(330),
        // height: 150,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(provider.logo!),
          ),
          title: Text(
            provider.getPropertyEffectedByLang("name_${globals.SelectedLang}"),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: CustomTheme.text15theme
                .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          subtitle: Column(children: [
            const SizedBox(
              height: 5,
            ),
            Container(
              child: Text(
                provider.getPropertyEffectedByLang(
                    "location_${globals.SelectedLang}"),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  "Coupons(${provider.coupons_count})",
                  style: TextStyle(color: Colors.grey.shade500),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "- Offers(${provider.special_offers_count})",
                  style: TextStyle(color: Colors.grey.shade500),
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
