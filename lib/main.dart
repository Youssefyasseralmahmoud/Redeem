import 'package:flutter/material.dart';
import 'package:nitro_flutter_project/app_storage.dart';
import 'package:nitro_flutter_project/json_db/json_db.dart';
import 'package:nitro_flutter_project/screens/main_screen/main_screen.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:redeem/app_storage.dart';
import 'package:redeem/config.dart';
import 'package:redeem/generated/l10n.dart';
import 'package:redeem/json_db/enum.dart';
import 'package:redeem/json_db/json_db.dart';
import 'package:redeem/otp_phone_auth_handler/otp_phone_auth_handler.dart';
import 'package:redeem/screens/List_coupons_page/List_coupons_page.dart';
import 'package:redeem/screens/Order%20Details/order_details.dart';
import 'package:redeem/screens/Profile/profile.dart';
import 'package:redeem/screens/all%20offers/all_offers.dart';
import 'package:redeem/screens/buy_points/buy_points.dart';
import 'package:redeem/screens/cart_screen/cart_screen.dart';
import 'package:redeem/screens/details_screen_of_providers/details_screen_of_providers.dart';
import 'package:redeem/screens/main_screen/main_screen.dart';
import 'package:redeem/screens/offer_details/offer_details.dart';
import 'package:redeem/screens/otpverification/otp_verification.dart';
import 'package:redeem/screens/providers/providers.dart';
import 'package:redeem/screens/subscription_package/subscription_package.dart';
import 'package:redeem/theme/colors.dart';
import 'local/local.dart';
import 'main_controller.dart';
import 'screens/Seleted_City/Selected_city.dart';
import 'screens/change_password/change_password.dart';
import 'screens/details_coupon/details_coupon.dart';
import 'screens/edit_personal_information/edit_personal_information.dart';
import 'screens/forget_password/forget_password.dart';
import 'screens/home_screen/home_screen.dart';
import 'screens/login/login.dart';
import 'screens/intro_app/intro_app.dart';
import 'screens/selectlanguage/selectlanguage.dart';
import 'screens/signup/signup.dart';
import 'package:redeem/globals.dart' as globals;
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String? deviceLocale = null;
  String? locale = await appStorage().getLang() ??
      (deviceLocale != null ? deviceLocale : config_app.DefaultLang);

  globals.SelectedLang = locale;

  bool isLogin = await appStorage().checkIsLogin();
  bool isFirtTime = await appStorage().checkIsFirstTime();
  int? cityid = await appStorage().getcityId();

  await JsonDb().getMainCategories().then((res) {
    if (res.success) {
      globals.categories = res.data;
    }
  });
  await JsonDb().getCityCollections().then((res) {
    if (res.success) {
      globals.cities = res.data;
    }
  });

  if (isLogin) {
    globals.isLogin = isLogin;
    globals.customer = await appStorage().getCustomer();
    globals.userData = await appStorage().getUserData();
    globals.userType = await appStorage().getUserType();
    globals.token = await appStorage().getToken();
    globals.userId = globals.userData!.id!;

    await JsonDb().getWhichListIdCollections().then((res) {
      if (res.success) {
        globals.whichListCoupon = res.data.listcoupon;
        globals.whichListOffers = res.data.listoffer;
        globals.whichListProviders = res.data.listprovider;

        ;
      }
    });

    JsonDb().getIsActiveDataCollections().then((res) {
      if (res.success) {
        print("user is active ${res.success}");
        globals.customer = res.data.customer;
        globals.userType = res.data.userType!;
        globals.userData = res.data.user;
        globals.IsActive = true;

        appStorage().setUserData(res.data.user);
        appStorage().setUserType(res.data.userType!);
        appStorage().setCustomer(res.data.customer);
      } else {
        globals.isLogin = false;
        globals.IsActive = false;
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

        // Navigator.of(context)
        //     .pushReplacement(MaterialPageRoute(builder: (context) {
        //   return const SelectLanguage();
        // }));
      }
    });
  }

  if (!isFirtTime) {
    globals.isfirstTime = isFirtTime;
  }
  if (cityid != null) {
    globals.cityId = cityid;
  }
  var lang = config_app.DefaultLang;
  runApp(
      RestartWidget(child: MyApp(locale, lang, isLogin, isFirtTime, cityid)));
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  String lang;
  String locale;
  bool? isLogin;
  bool? isFirstTime;
  int? cityid;
  MyApp(this.locale, this.lang, this.isLogin, this.isFirstTime, this.cityid,
      {super.key});

  @override
  State<MyApp> createState() => _MyApp(
      lang: this.lang,
      isLogin: this.isLogin,
      isfirstTime: this.isFirstTime,
      cityid: this.cityid);
  static void setLocale(BuildContext context, String lang) {
    _MyApp? state = context.findAncestorStateOfType<_MyApp>();
    state!.setLocale(lang);
  }
}

class _MyApp extends State<MyApp> {
  String lang = "";
  Locale? locale;
  bool? isLogin;
  bool? isfirstTime;
  int? cityid;
  _MyApp(
      {required this.lang,
      this.locale,
      this.isLogin,
      this.isfirstTime,
      this.cityid});
  @override
  void initState() {
    super.initState();

    OneSignal.Debug.setLogLevel(OSLogLevel.debug);
    OneSignal.initialize("43331a72-8ab0-410b-afb2-ed216dda0936");
    OneSignal.Notifications.requestPermission(true);
    if (globals.isLogin && globals.userId != "") {
      OneSignal.login("${globals.userId}");
      OneSignal.User.addTagWithKey("user_id", globals.userId);
      OneSignal.Notifications.addClickListener((event) {
        var data = event.notification.additionalData;
        print("data is ${data!['type']}");
        globals.navigatorKey.currentState?.pushReplacement(
          MaterialPageRoute(
            builder: (context) => ListCouponsPage(),
          ),
        );
        // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        //   return OfferDetails();
        // }));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return OtpPhoneAuthProvider(
      child: MaterialApp(
        theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: CustomColors.primarycolor),
            indicatorColor: CustomColors.DangerColor,
            primaryColor: CustomColors.primarycolor,
            fontFamily: globals.SelectedLang == "ar" ? "Tajawal" : "Roboto"),
        navigatorKey: globals.navigatorKey,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: Locale(globals.SelectedLang),
        //  translations: mylocal(),
        debugShowCheckedModeBanner: false,
        //
        // home: SubsriptionPackage(),
        home: isfirstTime == true
            ? SelectLanguage()
            : isLogin == true
                ? MainScreen()
                : Login(),
        // defaultGlobalState: true
      ),
    );
  }

  setLocale(String lang) {
    setState(() {
      this.lang = lang;
      if (this.lang == "en") {
        this.locale = new Locale("en");
      } else {
        this.locale = new Locale(this.lang);
      }

      globals.SelectedLang = this.lang;
    });
  }
}

class RestartWidget extends StatefulWidget {
  RestartWidget({required this.child});

  final Widget child;

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
