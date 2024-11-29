library alasaleh.globals;

import 'package:flutter/cupertino.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:nitro_flutter_project/json_db/enum.dart';
import 'package:redeem/json_db/enum.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
String SelectedLang = "";
bool isLogin = false;
bool isfirstTime = true;
String city = "";
String token = "";
int userId = 0;
int cityId = 0;
int categoryid = 0;
String currencySymbol = "";
String PointNumber = "50";
String EndDateSubscribe = "12-2-2024";
int? CurrentSubscribePackage;
User? userData;
Customer? customer;
String userType = "";
bool IsActive = false;

List<S2Choice<String>> Language2 = [
  S2Choice<String>(value: 'en', title: 'English'),
  S2Choice<String>(value: 'ar', title: 'العربية'),
];
List<City> cities = [];
List<IntroData> listInreoData = [];
List<int> whichListCoupon = [];
List<int> whichListOffers = [];
List<int> whichListProviders = [];
List<Category> categories = [];
List<Category> listSubcategories = [];
int countcart = 0;
double start_padding = 8;
double end_padding = 8;

double start_padding_17 = 17;
double end_padding_17 = 17;
Map<int, dynamic> bytesMarkerCatgories = {};
