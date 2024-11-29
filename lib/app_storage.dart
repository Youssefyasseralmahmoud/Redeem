//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:redeem/config.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:redeem/json_db/enum.dart';

// ignore: camel_case_types
class storage_kyes {
  static const String perfix_key = "redeem_";
  static const String APP_LANG = perfix_key + "APP_LANG";
  static const String City = perfix_key + "City";
  static const String CityId = perfix_key + "City_Id";
  static const String APP_CUR_ID = perfix_key + "APP_CUR_ID";
  static const String key_is_login = storage_kyes.perfix_key + "is_login";
  static const String key_is_firstTime =
      storage_kyes.perfix_key + "is_firstTime";
  static const String key_token = storage_kyes.perfix_key + "token";
  static const String key_user_id = storage_kyes.perfix_key + "user_id";
  static const String key_user_data = storage_kyes.perfix_key + "user_data";
  static const String key_user_type = storage_kyes.perfix_key + "user_type";
  static const String key_customer = storage_kyes.perfix_key + "customer";
  static const String key_user_office =
      storage_kyes.perfix_key + "key_user_office";
  static const String key_user_dentist =
      storage_kyes.perfix_key + "key_user_dentist";
  static const String key_user_delivery_man =
      storage_kyes.perfix_key + "key_user_delivery_man";
  static const String key_cart_token = storage_kyes.perfix_key + "cartToken";
  static const String key_cart_key = storage_kyes.perfix_key + "cartKey";
  static const String key_recent_search =
      storage_kyes.perfix_key + "key_recent_search";
  static const String key_enable_notification =
      storage_kyes.perfix_key + "enable_notification";
  static const String key_visits_products =
      storage_kyes.perfix_key + "key_visits_products";
  static const String key_last_check_notification =
      storage_kyes.perfix_key + "key_last_check_notification";

  static const String key_dont_view_message_edit_profile =
      storage_kyes.perfix_key + "key_dont_view_message_edit_profile";
}

// ignore: camel_case_types
class appStorage {
  final _accountNameController =
      TextEditingController(text: 'flutter_secure_storage_service');
  late FlutterSecureStorage _storage;
  appStorage() {
    _storage = FlutterSecureStorage();
  }

  Future<void> setLang(String _lang) async {
    return await write(storage_kyes.APP_LANG, _lang);
  }

//get value from shared preferences
  Future<String?> getLang() async {
    var value = await read(storage_kyes.APP_LANG);
    if (value != "" && value != null) {
      return value;
    }
    return null;
  }

  Future<void> setCity(String _city) async {
    return await write(storage_kyes.City, _city);
  }

//get value from shared preferences
  Future<String?> getcity() async {
    var value = await read(storage_kyes.City);
    if (value != "" && value != null) {
      return value;
    }
    return null;
  }

  Future<void> setCityId(int _cityId) async {
    print("will save city id ${_cityId}");
    return await write(storage_kyes.CityId, _cityId.toString());
  }

//get value from shared preferences
  Future<int?> getcityId() async {
    var value = await read(storage_kyes.CityId);
    if (value != "" && value != null) {
      return int.tryParse(value);
    }
    return null;
  }

  Future<void> setCurrencyID(int _cur_id) async {
    return await write(storage_kyes.APP_CUR_ID, _cur_id.toString());
  }

  Future<int?> getCurrencyID() async {
    var value = await read(storage_kyes.APP_CUR_ID);
    return int.tryParse(value!)!;
  }

  IOSOptions _getIOSOptions() => IOSOptions(
        accountName: _getAccountName(),
      );
  AndroidOptions _getAndroidOptions() => AndroidOptions(
      // encryptedSharedPreferences: true,
      );
  LinuxOptions _getWebOptions() => LinuxOptions();

  String? _getAccountName() =>
      _accountNameController.text.isEmpty ? null : _accountNameController.text;

  Future<void> writeMobile(key, value) async {
    return await _storage.write(
      key: key,
      value: value,
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
      lOptions: _getWebOptions(),
    );
  }

  Future<String?> readMobile(key) async {
    return await _storage.read(
      key: key,
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
      lOptions: _getWebOptions(),
    );
  }

  void writeWeb(key, value) async {
    //  if (window != null && window.localStorage != null) {
    //   window.localStorage[key] = value;
    // }
  }

  Future<String?> readWeb(key) async {
    //  if (window != null && window.localStorage != null) {
    //   return window.localStorage[key];
    // }
    // return "";
  }

  Future<void> write(key, value) async {
    if (kIsWeb) {
      print("write " + key + " to web");
      writeWeb(key, value);
    } else {
      print("write " + key + " to mobile");
      writeMobile(key, value);
    }
  }

  Future<String?> read(key) async {
    if (kIsWeb) {
      print("read " + key + " from web");
      return await readWeb(key);
    } else {
      print("read " + key + " from mobile");

      print("contain " + key + " eee from mobile");
      return await readMobile(key);
    }
  }

  Future<void> ClearAll() async {
    /* if (window.localStorage.runtimeType == Storage) {
      return window.localStorage.clear();
    } */
    return await _storage.deleteAll();
  }

  Future<bool> checkIsLogin() async {
    var value = await read(storage_kyes.key_is_login);
    if (value == "true") {
      return true;
    } else {
      return false;
    }
  }

  Future<void> setIsLogin(bool isLogin) async {
    return write(storage_kyes.key_is_login, isLogin ? "true" : "false");
  }

  Future<void> setIsFirstTime(bool isfirstTime) async {
    return write(storage_kyes.key_is_firstTime, isfirstTime ? "true" : "false");
  }

  Future<bool> checkIsFirstTime() async {
    var value = await read(storage_kyes.key_is_firstTime);
    if (value == "true") {
      return false;
    } else {
      return true;
    }
  }

  Future<dynamic> getToken() async {
    var value = await read(storage_kyes.key_token);

    if (value != "" && value != null) {
      return value.toString();
    } else {
      return "";
    }
  }

  Future<void> setToken(String token) async {
    return await write(storage_kyes.key_token, token);
  }

  Future<dynamic> getUserID() async {
    var value = await read(storage_kyes.key_user_id);
    if (value != "" && value != null) {
      return value.toString();
    } else {
      return "";
    }
  }

  Future<void> setUserType(String userType) async {
    return await write(storage_kyes.key_user_type, userType);
  }

  Future<void> setUserID(dynamic user_id) async {
    return await write(storage_kyes.key_user_id, user_id.toString());
  }

  Future<User?> getUserData() async {
    var value = await read(storage_kyes.key_user_data);

    if (value != "" && value != null) {
      var userData = jsonDecode(value);

      return User.fromJson(userData);
    } else {
      return null;
    }
  }

  Future<void> setUserData(User? userData) async {
    return await write(storage_kyes.key_user_data, jsonEncode(userData));
  }

///////
  // Future<void> setCustomer(String customer) async {
  //   return await write(storage_kyes.key_user_type, customer);
  // }
//////////
  Future<Customer?> getCustomer() async {
    var value = await read(storage_kyes.key_customer);

    if (value != "" && value != null) {
      var customer = jsonDecode(value);

      return Customer.fromJson(customer);
    } else {
      return null;
    }
  }

  Future<void> setCustomer(Customer? customer) async {
    return await write(storage_kyes.key_customer, jsonEncode(customer));
  }

  /* Future<void> setOfficeLogin(SimpleOffice? office) async {
    return await write(storage_kyes.key_user_office, jsonEncode(office));
  }

  Future<SimpleOffice?> getOfficeLogin() async {
    var value = await read(storage_kyes.key_user_office);

    if (value != "" && value != null) {
      var data = jsonDecode(value);

      return SimpleOffice.fromJson(data);
    } else {
      return null;
    }
  }

  Future<void> setDentistLogin(Dentist? dentist) async {
    return await write(storage_kyes.key_user_dentist, jsonEncode(dentist));
  }

  Future<Dentist?> getDentistLogin() async {
    var value = await read(storage_kyes.key_user_dentist);

    if (value != "" && value != null) {
      var userData = jsonDecode(value);

      return Dentist.fromJson(userData);
    } else {
      return null;
    }
  }

  Future<void> setDeliveryManLogin(DeliveryMan? deliveryMan) async {
    return await write(storage_kyes.key_user_delivery_man, jsonEncode(deliveryMan));
  }

  Future<DeliveryMan?> getDeliveryManLogin() async {
    var value = await read(storage_kyes.key_user_delivery_man);

    if (value != "" && value != null) {
      var userData = jsonDecode(value);

      return DeliveryMan.fromJson(userData);
    } else {
      return null;
    }
  } */

  Future<dynamic> getUserType() async {
    var value = await read(storage_kyes.key_user_type);
    if (value != "" && value != null) {
      return value.toString();
    } else {
      return "";
    }
  }

  Future<bool?> checkIsEnableNotifications() async {
    var value = await read(storage_kyes.key_enable_notification);
    if (value == null) {
      return true;
    }
    if (value == "true") {
      return true;
    } else {
      return false;
    }
  }

  Future<void> setEnableNotifications(bool ischecked) async {
    return write(
        storage_kyes.key_enable_notification, ischecked ? "true" : "false");
  }

  Future<void> setLastUpdateProduct(String key, String date) async {
    return await write("jibal_storage_${key}", date);
  }

  Future<dynamic> getLastUpdateProduct(
    String key,
  ) async {
    var value = await read("jibal_storage_${key}");

    if (value != "" && value != null) {
      return value.toString();
    } else {
      return "";
    }
  }

  Future<void> setProductsVisits(int product_id) async {
    var productIds = await getProductsVisits();
    if (productIds.indexOf(product_id) >= 0) {
      productIds.removeWhere((element) => element == product_id);
    }
    productIds.insert(0, product_id);
    return await write(
        storage_kyes.key_visits_products, jsonEncode(productIds));
  }

  Future<List<int>> getProductsVisits() async {
    var value = await read(storage_kyes.key_visits_products);

    if (value != "" && value != null) {
      var x = jsonDecode(value);
      List<int> z = x.cast<int>();
      return z;
    } else {
      return [];
    }
  }

  Future<List<String>> getRecentSearch() async {
    var value = await read(storage_kyes.key_recent_search);
    if (value != "" && value != null) {
      var decodeList = jsonDecode(value) as List;
      List<String> x = decodeList.map((i) => i.toString()).toList();
      return x;
    } else {
      return [];
    }
  }

  Future<void> setRecentSearch(String text) async {
    List<String> saved = await this.getRecentSearch();
    int searchIndex = saved.indexWhere((element) => element == text);
    if (searchIndex > -1) {
      saved.removeAt(searchIndex);
    }
    saved.add(text);
    var enc = (jsonEncode(saved));
    return await write(storage_kyes.key_recent_search, enc);
  }

  Future<void> clearRecentSearch() async {
    List<String> saved = [];
    var enc = (jsonEncode(saved));
    return await write(storage_kyes.key_recent_search, enc);
  }

  Future<void> setLastCheckNotifications(String date) async {
    return await write(storage_kyes.key_last_check_notification, date);
  }

  Future<dynamic> getLastCheckNotifications() async {
    var value = await read(storage_kyes.key_last_check_notification);
    if (value != "" && value != null) {
      return value.toString();
    } else {
      return "";
    }
  }

  Future<void> setDontShowUpdateProfileAgain(bool st) async {
    return write(
        storage_kyes.key_dont_view_message_edit_profile, st ? "true" : "false");
  }

  Future<bool> getDontShowUpdateProfileAgain() async {
    var value = await read(storage_kyes.key_dont_view_message_edit_profile);

    if (value != "" && value != null) {
      if (value == "true") {
        return true;
      }
    }
    return false;
  }
}
