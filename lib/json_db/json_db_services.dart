import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:redeem/config.dart';
import 'package:redeem/json_db/enum.dart';

import 'package:redeem/json_db/utils.dart';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:redeem/json_db/jibal_response.dart';
import "package:redeem/globals.dart" as globals;

import 'package:retry/retry.dart';
import 'package:dio/dio.dart';

class JsonDb {
  int maxAttempts = 8;
  int timeout = 30;
  Map<String, String> getHeaders() {
    Map<String, String> headers;
    headers = {
      "Accept": "application/json",
      "x-api-key": config_app.X_API_KEY,
      "locale": globals.SelectedLang != ""
          ? globals.SelectedLang
          : config_app.DefaultLang,
    };

    if (globals.isLogin) {
      headers["Authorization"] = "Bearer ${globals.token}";
      headers["user-id"] = globals.userId.toString();
      headers["city-id"] = globals.cityId.toString();
      print("tokkeeeeeeeeeeen ${headers["Authorization"]}");
    }
    return headers;
  }

  Future<ResponseGetCities> getCityCollections() async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http
          .get(
            Uri.parse(
              config_app.apiGetAllCitys(),
            ),
            headers: this.getHeaders(),
          )
          .timeout(
            Duration(seconds: timeout),
          ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseGetCities.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load citys collections");
      throw Exception('Failed to load citys collections');
    }
  }
  ////////////////////

  Future<ResponseGetCoupons> getCouponsCollections(
      {int page = 1,
      String sorting = "",
      String filterSearch = "",
      dynamic filterCategory,
      dynamic filterRating,
      dynamic filterMinPrice,
      dynamic filterMaxPrice}) async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http
          .get(
            Uri.parse(
              config_app.apiGetCoupons(
                  page: page,
                  sorting: sorting,
                  filterSearch: filterSearch,
                  filterCategory: filterCategory,
                  filterRating: filterRating,
                  filterMinPrice: filterMinPrice,
                  filterMaxPrice: filterMaxPrice),
            ),
            headers: this.getHeaders(),
          )
          .timeout(
            Duration(seconds: timeout),
          ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    print(
        "statuse is ${response.statusCode}  page is ${page}, sorting is ${sorting}, filtersearch is ${filterSearch},filterCategory ${filterCategory}, filterRating ${filterRating},minprice ${filterMinPrice}, maxprice ${filterMaxPrice}");

    if (response.statusCode == 200) {
      return ResponseGetCoupons.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load coupons collections");
      throw Exception('Failed to load coupons collections');
    }
  }

  /////////
  Future<ResponseGetOffers> getOffersCollections(
      {int page = 1,
      String sorting = "",
      String filterSearch = "",
      dynamic filterCategory,
      dynamic filterRating,
      dynamic filterMinPrice,
      dynamic filterMaxPrice}) async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http
          .get(
            Uri.parse(
              config_app.apiGetOffers(
                  page: page,
                  sorting: sorting,
                  filterSearch: filterSearch,
                  filterCategory: filterCategory,
                  filterRating: filterRating,
                  filterMinPrice: filterMinPrice,
                  filterMaxPrice: filterMaxPrice),
            ),
            headers: this.getHeaders(),
          )
          .timeout(
            Duration(seconds: timeout),
          ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseGetOffers.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load citys collections");
      throw Exception('Failed to load citys collections');
    }
  }

  ///////////
  Future<ResponseGetCouponDetails> getdetailsCouponCollections(
      dynamic couponid) async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http
          .get(
            Uri.parse(
              config_app.apiGetCouponDetails(couponid),
            ),
            headers: this.getHeaders(),
          )
          .timeout(
            Duration(seconds: timeout),
          ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseGetCouponDetails.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load citys collections");
      throw Exception('Failed to load citys collections');
    }
  }

  Future<ResponseGetOfferDetails> getdetailsOfferCollections(
      dynamic offerid) async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http
          .get(
            Uri.parse(
              config_app.apiGetOfferDetails(offerid),
            ),
            headers: this.getHeaders(),
          )
          .timeout(
            Duration(seconds: timeout),
          ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseGetOfferDetails.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load citys collections");
      throw Exception('Failed to load citys collections');
    }
  }

  Future<ResponseGetProviderDetails> getdetailsProvidersCollections(
      dynamic id) async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http
          .get(
            Uri.parse(
              config_app.apiGetProvidersDetails(id),
            ),
            headers: this.getHeaders(),
          )
          .timeout(
            Duration(seconds: timeout),
          ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseGetProviderDetails.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load provider collections");
      throw Exception('Failed to load provider collections');
    }
  }

  Future<ResponseGetProviders> getProvidersCollections() async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http
          .get(
            Uri.parse(
              config_app.apiGetProviders(),
            ),
            headers: this.getHeaders(),
          )
          .timeout(
            Duration(seconds: timeout),
          ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseGetProviders.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load providers collections");
      throw Exception('Failed to load providers collections');
    }
  }

  Future<ResponseGetProvidersLocation> getProviderByLocation(
      lattitude, longtude,category_id
      )
       async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http
          .get(
            Uri.parse(
              config_app.apiGetProvidersLocation(
                lattitude,
                 longtude,
                 category_id
                 ),
            ),
            headers: this.getHeaders(),
          )
          .timeout(
            Duration(seconds: timeout),
          ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseGetProvidersLocation.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load providers collections");
      throw Exception('Failed to load providers collections');
    }
  }

  /////////
  Future<ResponseGetHomeData> getHomeDataCollections() async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http
          .get(
            Uri.parse(
              config_app.apiGetHomeData(),
            ),
            headers: this.getHeaders(),
          )
          .timeout(
            Duration(seconds: timeout),
          ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseGetHomeData.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load home Data collections");
      throw Exception('Failed to load home Data collections');
    }
  }

  Future<ResponseMainCategories> getMainCategories() async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http
          .get(
            Uri.parse(
              config_app.apiGetCategories(),
            ),
            headers: this.getHeaders(),
          )
          .timeout(
            Duration(seconds: timeout),
          ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseMainCategories.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load getMainCategories");
      throw Exception('Failed to load getMainCategories');
    }
  }

  /////
  Future<ResponseGetLoginData> getLoginDataCollections(
      String email, String password, String login_type, String otp) async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */
    print({
      "email": "${email.toString()}",
      "password": "${password.toString()}",
      "login_type": login_type,
      "otp": otp
    });
    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http.post(
          Uri.parse(
            config_app.apiLogin(),
          ),
          headers: this.getHeaders(),
          body: {
            "email": "${email.toString()}",
            "password": "${password.toString()}",
            "login_type": login_type,
            "otp": otp
          }).timeout(
        Duration(seconds: timeout),
      ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseGetLoginData.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load login Data collections");
      throw Exception('Failed to load login Data collections');
    }
  }

  Future<ResponseMobileEmailExists> checkMobileExists(
      String mobile, String type) async {
    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http.post(
          Uri.parse(
            config_app.apiCheckMobileEsists(),
          ),
          headers: this.getHeaders(),
          body: {
            "mobile": "${mobile.toString()}",
            "type": "${type.toString()}"
          }).timeout(
        Duration(seconds: timeout),
      ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseMobileEmailExists.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load login Data collections");
      throw Exception('Failed to load login Data collections');
    }
  }

  Future<ResponseMobileEmailExists> checkEmailExists(
      String email, String type) async {
    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http.post(
          Uri.parse(
            config_app.apiCheckEmailEsists(),
          ),
          headers: this.getHeaders(),
          body: {
            "email": "${email.toString()}",
            "type": "${type.toString()}"
          }).timeout(
        Duration(seconds: timeout),
      ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseMobileEmailExists.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load login Data collections");
      throw Exception('Failed to load login Data collections');
    }
  }

  Future<ResponseAPI> sendOtp(String mobile) async {
    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http.post(
          Uri.parse(
            config_app.apiSendOtp(),
          ),
          headers: this.getHeaders(),
          body: {
            "mobile": "${mobile.toString()}",
          }).timeout(
        Duration(seconds: timeout),
      ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    print(response.body);
    if (response.statusCode == 200) {
      return ResponseAPI.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load login Data collections");
      throw Exception('Failed to load login Data collections');
    }
  }

  Future<ResponseAPI> checkOtp(String mobile, String otp) async {
    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http.post(
          Uri.parse(
            config_app.apiCheckOtp(),
          ),
          headers: this.getHeaders(),
          body: {
            "mobile": "${mobile.toString()}",
            "otp": "${otp.toString()}",
          }).timeout(
        Duration(seconds: timeout),
      ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    print(response.body);
    if (response.statusCode == 200) {
      return ResponseAPI.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load login Data collections");
      throw Exception('Failed to load login Data collections');
    }
  }

  //////////
  Future<ResponseGetSignupData> getSignupDataCollections(
      String firstname,
      String lastname,
      String mobile,
      String email,
      String password,
      String confirmPasssword,
      String otp) async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http.post(
          Uri.parse(
            config_app.apiSignup(),
          ),
          headers: this.getHeaders(),
          body: {
            "first_name": "${firstname.toString()}",
            "last_name": "${lastname.toString()}",
            "email": "${email.toString()}",
            "mobile": "${mobile.toString()}",
            "password": "${password.toString()}",
            "password_confirmation": "${confirmPasssword.toString()}",
            "otp": otp
          }).timeout(
        Duration(seconds: timeout),
      ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseGetSignupData.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load Signup Data collections");
      throw Exception('Failed to load Signup Data collections');
    }
  }

  /////////
  Future<ResponseGetCartData> getCartDataCollections(
      String quick_checkout, String forCheckOut) async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http.post(
          Uri.parse(
            config_app.apiGetCart(),
          ),
          headers: getHeaders(),
          body: {
            "quick_checkout": "${quick_checkout.toString()}",
            "for_check_out": "${forCheckOut.toString()}"
          }).timeout(
        Duration(seconds: timeout),
      ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseGetCartData.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load Cart Data collections");
      throw Exception('Failed to load Cart Data collections');
    }
  }

  //////
  Future<ResponseGetCartData> addTocartCollections(
      String quickCheckout,
      int id,
      int quantity,
      String itemType,
      String returnCart,
      String forCheckOut) async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */
    var ress = {
      "id": "${id}",
      "quantity": "${quantity}",
      "item_type": "${itemType.toString()}",
      "quick_checkout": "${quickCheckout.toString()}",
      "return_cart": "${returnCart.toString()}",
      "for_check_out": "${forCheckOut.toString()}"
    };
    debugPrint("ress_now ${ress}");
    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http.post(
          Uri.parse(
            config_app.apiAddToCart(),
          ),
          headers: this.getHeaders(),
          body: {
            "id": "${id.toString()}",
            "quantity": "${quantity.toString()}",
            "item_type": "${itemType.toString()}",
            "quick_checkout": "${quickCheckout.toString()}",
            "return_cart": "${returnCart.toString()}",
            "for_check_out": "${forCheckOut.toString()}"
          }).timeout(
        Duration(seconds: timeout),
      ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    //print("status is ${response.statusCode} and token is ${globals.token}");
    if (response.statusCode == 200) {
      // print(" token_is ${globals.token}");
      print("resboseBody ${response.body}");
      return ResponseGetCartData.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load add to cart Data collections");
      throw Exception('Failed to load add to cart Data collections');
    }
  }

  //////////
  Future<ResponseGetCartData> removeFromcartCollections(int id, String itemType,
      String quickCheckout, String returnCart, String forCheckOut) async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);

    http.Response response = await r.retry(
      () => http.post(
          Uri.parse(
            config_app.apiRemoveFromCart(),
          ),
          headers: this.getHeaders(),
          body: {
            "id": "${id.toString()}",
            "item_type": "${itemType.toString()}",
            "quick_checkout": "${quickCheckout.toString()}",
            "return_cart": "${returnCart.toString()}",
            "for_check_out": "${forCheckOut.toString()}"
          }).timeout(
        Duration(seconds: timeout),
      ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    print("resbonseRemove ${response.body}");
    if (response.statusCode == 200) {
      print(" token_is ${globals.token}");
      return ResponseGetCartData.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load remove from cart Data collections");
      throw Exception('Failed to load remove from cart Data collections');
    }
  }

  Future<ResponseCreateOrder> submitOrderCollections(
      double paymentAmount, String pmtMethod, String whatsappNumber) async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);

    http.Response response = await r.retry(
      () => http.post(
          Uri.parse(
            config_app.apiSubmitOrder(),
          ),
          headers: this.getHeaders(),
          body: {
            "payment_amount": "${paymentAmount.toString()}",
            "pmt_method": "${pmtMethod.toString()}",
            "whatsapp_number": "${whatsappNumber.toString()}"
          }).timeout(
        Duration(seconds: timeout),
      ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    print(response.body);
    if (response.statusCode == 200) {
      return ResponseCreateOrder.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load submit order  Data collections");
      throw Exception('Failed to load submit order Data collections');
    }
  }

  Future<ResponseAPI> submitReviewCollections(
      {int? prvider_id,
      int? coupon_id,
      int? special_offer_id,
      required String review,
      required double rating}) async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */
    final r = RetryOptions(maxAttempts: maxAttempts);
    print({
      "provider_id": "${prvider_id ?? ""}",
      "coupon_id": "${coupon_id ?? ""}",
      "special_offer_id": "${special_offer_id ?? ""}",
      "review": "${review}",
      "rating": "${rating}"
    });
    http.Response response = await r.retry(
      () => http.post(
          Uri.parse(
            config_app.SubmitReview(),
          ),
          headers: this.getHeaders(),
          body: {
            if (prvider_id != null) "provider_id": "${prvider_id}",
            if (coupon_id != null) "coupon_id": "${coupon_id}",
            if (special_offer_id != null)
              "special_offer_id": "${special_offer_id}",
            "review": "${review}",
            "rating": "${rating}"
          }).timeout(
        Duration(seconds: timeout),
      ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    print(" headers is${response.headers}");
    print("my review status is ${response.statusCode}");
    if (response.statusCode == 200) {
      print("my review body is ${response.body}");
      return ResponseAPI.fromJson(
        json.decode(response.body),
      );
    } else {
      print("my review body is ${response.body}");

      print("Failed to load submit review  Data collections");
      throw Exception('Failed to load submit review Data collections');
    }
  }

/////////////
  Future<ResponseCreateOrder> submitOrderQuickCheckoutCollections(
      int id,
      int qty,
      String itemType,
      String quickCkeckout,
      double paymentAmount,
      String pmtMethod,
      String whatsappNumber) async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);

    http.Response response = await r.retry(
      () => http.post(
          Uri.parse(
            config_app.apiSubmitOrderQuick(),
          ),
          headers: this.getHeaders(),
          body: {
            "id": "${id.toString()}",
            "quantity": "${qty.toString()}",
            "item_type": "${itemType.toString()}",
            "quick_checkout": "${quickCkeckout.toString()}",
            "payment_amount": "${paymentAmount.toString()}",
            "pmt_method": "${pmtMethod.toString()}",
            "whatsapp_number": "${whatsappNumber.toString()}"
          }).timeout(
        Duration(seconds: timeout),
      ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseCreateOrder.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load submit order  Data collections");
      throw Exception('Failed to load submit order Data collections');
    }
  }

  Future<ResponseGetPointPackage> getPointPackageCollections() async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http
          .get(
            Uri.parse(
              config_app.apiGetAllPointPackage(),
            ),
            headers: this.getHeaders(),
          )
          .timeout(
            Duration(seconds: timeout),
          ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseGetPointPackage.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load point Package collections");
      throw Exception('Failed to load point Package collections');
    }
  }

  Future<ResponseGetSubscriptionPackage>
      getSubscriptionPackageCollections() async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http
          .get(
            Uri.parse(
              config_app.apigetSubscriptionPackage(),
            ),
            headers: this.getHeaders(),
          )
          .timeout(
            Duration(seconds: timeout),
          ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseGetSubscriptionPackage.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load subscription package collections");
      throw Exception('Failed to load subscription package collections');
    }
  }

  Future<ResponseGetDashboardData> getDashboardDataCollections() async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http
          .get(
            Uri.parse(
              config_app.apigetDashboardData(),
            ),
            headers: this.getHeaders(),
          )
          .timeout(
            Duration(seconds: timeout),
          ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseGetDashboardData.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load Dashboard data collections");
      throw Exception('Failed to load  Dashboard data collections');
    }
  }

  ///
  Future<ResponseGetHistoryPoints> getHistoryPointsCollections() async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http
          .get(
            Uri.parse(
              config_app.apigetHistoryPoints(),
            ),
            headers: this.getHeaders(),
          )
          .timeout(
            Duration(seconds: timeout),
          ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseGetHistoryPoints.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load history points data collections");
      throw Exception('Failed to load  points  data collections');
    }
  }

  ///
  Future<ResponseGetOrders> getOrdersCollections() async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http
          .get(
            Uri.parse(
              config_app.apigetOrders(),
            ),
            headers: this.getHeaders(),
          )
          .timeout(
            Duration(seconds: timeout),
          ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseGetOrders.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load orders  data collections");
      throw Exception('Failed to orders    data collections');
    }
  }

  Future<ResponseGetJoinInvitation> getJoinInvitationCollections() async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http
          .get(
            Uri.parse(
              config_app.apigetJoinInvitation(),
            ),
            headers: this.getHeaders(),
          )
          .timeout(
            Duration(seconds: timeout),
          ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseGetJoinInvitation.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load join invitation  data collections");
      throw Exception(
          'Failed to load apigetJoinInvitation    data collections');
    }
  }

  ////
  Future<ResponseGetNotifications> getNotificationsCollections(
      {int page = 1}) async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http
          .get(
            Uri.parse(
              config_app.apigetNotifications(),
            ),
            headers: this.getHeaders(),
          )
          .timeout(
            Duration(seconds: timeout),
          ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseGetNotifications.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load notifications  data collections");
      throw Exception('Failed to load notifications    data collections');
    }
  }

  ///
  Future<ResponseGetMyCoupons> getMyCouponsCollections() async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http
          .get(
            Uri.parse(
              config_app.apigetMyCoupons(),
            ),
            headers: this.getHeaders(),
          )
          .timeout(
            Duration(seconds: timeout),
          ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    print("resbonse_body_my_coupons_is ${response.body}");
    if (response.statusCode == 200) {
      return ResponseGetMyCoupons.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load my_Coupons  data collections");
      throw Exception('Failed to load my_Coupons    data collections');
    }
  }

  /////////////
  Future<ResponseCheckHasPassord> checkHasPasswordCollections() async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);

    http.Response response = await r.retry(
      () => http.get(
        Uri.parse(
          config_app.checkHasPassword(),
        ),
        headers: this.getHeaders(),
      ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    print("respons chech has password is ${response.statusCode}");
    if (response.statusCode == 200) {
      return ResponseCheckHasPassord.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load check has password   Data collections");
      throw Exception('Failed to load check has password Data collections');
    }
  }

  /////
  Future<ResponseAPI> changePasswordCollections(
    String CurrentPassword,
    String password,
    String passwordConfirmation,
  ) async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);

    http.Response response = await r.retry(
      () => http.post(
          Uri.parse(
            config_app.changePassword(),
          ),
          headers: this.getHeaders(),
          body: {
            "current_password": "${CurrentPassword.toString()}",
            "password": "${password.toString()}",
            "password_confirmation": "${passwordConfirmation.toString()}",
          }).timeout(
        Duration(seconds: timeout),
      ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseAPI.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load change password  Data collections");
      throw Exception('Failed to load change password Data collections');
    }
  }

  ////
  Future<ResponseAPI> forgetPasswordCollections(
    String email,
  ) async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);

    http.Response response = await r.retry(
      () => http.post(
          Uri.parse(
            config_app.forgetPassword(),
          ),
          headers: this.getHeaders(),
          body: {
            "email": "${email.toString()}",
          }).timeout(
        Duration(seconds: timeout),
      ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseAPI.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load forgot password  Data collections");
      throw Exception('Failed to load forgot password Data collections');
    }
  }

  ///
  Future<ResponseUpdateProfileData> updateProfileCollections(
    String firstname,
    String lastname,
    String mobile,
    String email,
  ) async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http.post(
          Uri.parse(
            config_app.updateProfile(),
          ),
          headers: this.getHeaders(),
          body: {
            "first_name": "${firstname.toString()}",
            "last_name": "${lastname.toString()}",
            "email": "${email.toString()}",
            "mobile": "${mobile.toString()}",
          }).timeout(
        Duration(seconds: timeout),
      ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseUpdateProfileData.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load update profile Data collections");
      throw Exception('Failed to load profile Data Data collections');
    }
  }

  //
  Future<ResponseGetOrderDetails> getOrderDetailsCollections(
      dynamic orderid) async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http
          .get(
            Uri.parse(
              config_app.apiGetOrderDetails(orderid),
            ),
            headers: this.getHeaders(),
          )
          .timeout(
            Duration(seconds: timeout),
          ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseGetOrderDetails.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load order details collections");
      throw Exception('Failed to load order details collections');
    }
  }

  ///
  Future<ResponseGetDetailsPage> getDetailPageCollections(dynamic key) async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http
          .get(
            Uri.parse(
              config_app.apiGetDetilsPage(key),
            ),
            headers: this.getHeaders(),
          )
          .timeout(
            Duration(seconds: timeout),
          ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseGetDetailsPage.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load  details page collections");
      throw Exception('Failed to load  details page collections');
    }
  }

  Future<ResponseGetSearchAuto> getSearchDataCollections(
      String searchKey) async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http.get(
        Uri.parse(
          config_app.apiGetSearchData(searchKey),
        ),
        headers: this.getHeaders(),
      ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseGetSearchAuto.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load search Data collections");
      throw Exception('Failed to load search Data collections');
    }
  }

  Future<ResponseGetFinalSearchResault> getFinalSearchReaulDataCollections(
      String searchKey, String forLoadMore) async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */
    print(
        "url ${config_app.apiGetFinalSearchResaultData(searchKey, forLoadMore)}");
    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http.get(
        Uri.parse(
          config_app.apiGetFinalSearchResaultData(searchKey, forLoadMore),
        ),
        headers: this.getHeaders(),
      ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseGetFinalSearchResault.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load Final search Data collections");
      throw Exception('Failed to load  Final search Data collections');
    }
  }

  Future<ResponseDeleteAccount> DeleteAccount() async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);

    http.Response response = await r.retry(
      () => http.delete(
        Uri.parse(
          config_app.Deleteaccount(),
        ),
        headers: this.getHeaders(),
      ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseDeleteAccount.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to delete account");
      throw Exception('Failed to delete account');
    }
  }

  Future<ResponseGetIsActiveData> getIsActiveDataCollections() async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http
          .get(
            Uri.parse(
              config_app.UserIsActive(),
            ),
            headers: this.getHeaders(),
          )
          .timeout(
            Duration(seconds: timeout),
          ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseGetIsActiveData.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to is active Data collections");
      throw Exception('Failed to load is active Data collections');
    }
  }

  Future<ResponseGetCategoryDetails> getCategoryDataCollections(
      dynamic category_id) async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http
          .get(
            Uri.parse(
              config_app.apiGetCategoryDetails(category_id),
            ),
            headers: this.getHeaders(),
          )
          .timeout(
            Duration(seconds: timeout),
          ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseGetCategoryDetails.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load category details Data collections");
      throw Exception('Failed to load category details Data collections');
    }
  }

  Future<ResponseGetProviderReview> getProviderReviewCollections(
      dynamic provider_id) async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http
          .get(
            Uri.parse(
              config_app.apiGetProviderReview(provider_id),
            ),
            headers: this.getHeaders(),
          )
          .timeout(
            Duration(seconds: timeout),
          ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseGetProviderReview.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load providers review Data collections");
      throw Exception('Failed to load providers review Data collections');
    }
  }

  Future<ResponseGetCouponReview> getCouponsReviewCollections(
      dynamic coupon_id) async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http
          .get(
            Uri.parse(
              config_app.apiGetCouponReview(coupon_id),
            ),
            headers: this.getHeaders(),
          )
          .timeout(
            Duration(seconds: timeout),
          ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseGetCouponReview.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load coupon review Data collections");
      throw Exception('Failed to load coupon review Data collections');
    }
  }

  Future<ResponseGetOfferReview> getOfferReviewCollections(
      dynamic offer_id) async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http
          .get(
            Uri.parse(
              config_app.apiGetOfferReview(offer_id),
            ),
            headers: this.getHeaders(),
          )
          .timeout(
            Duration(seconds: timeout),
          ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseGetOfferReview.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load offer review Data collections");
      throw Exception('Failed to load offer review Data collections');
    }
  }

  Future<ResponseGetWhicjListId> getWhichListIdCollections() async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http
          .get(
            Uri.parse(
              config_app.apigetWhichListId(),
            ),
            headers: this.getHeaders(),
          )
          .timeout(
            Duration(seconds: timeout),
          ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseGetWhicjListId.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load whichList Id collections ${response.body}");
      throw Exception('Failed to loadwhichList Id  collections');
    }
  }

  Future<ResponseGetWhicjListData> getWhichListCollections() async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http
          .get(
            Uri.parse(
              config_app.apigetWhichList(),
            ),
            headers: this.getHeaders(),
          )
          .timeout(
            Duration(seconds: timeout),
          ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseGetWhicjListData.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load whichList  collections");
      throw Exception('Failed to load whichList   collections');
    }
  }

  Future<ResponseAPI> AddCouponToWhishCollections(dynamic coupon_id) async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);

    http.Response response = await r.retry(
      () => http
          .get(
            Uri.parse(
              config_app.apiAddCouponToWish(coupon_id),
            ),
            headers: this.getHeaders(),
          )
          .timeout(
            Duration(seconds: timeout),
          ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseAPI.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to add coupon to wish list");
      throw Exception('Failed to add coupon to wish list');
    }
  }

  Future<ResponseAPI> AddProviderToWhishCollections(dynamic provider_id) async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);

    http.Response response = await r.retry(
      () => http
          .get(
            Uri.parse(
              config_app.apiAddCProviderToWish(provider_id),
            ),
            headers: this.getHeaders(),
          )
          .timeout(
            Duration(seconds: timeout),
          ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseAPI.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to add provider to wish list");
      throw Exception('Failed to add provider to wish list');
    }
  }

  Future<ResponseAPI> AddOfferToWhishCollections(dynamic offer_id) async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);

    http.Response response = await r.retry(
      () => http
          .get(
            Uri.parse(
              config_app.apiAddOfferToWish(offer_id),
            ),
            headers: this.getHeaders(),
          )
          .timeout(
            Duration(seconds: timeout),
          ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseAPI.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to add offer to wish list");
      throw Exception('Failed to add offer to wish list');
    }
  }

  Future<ResponseGetContactUsForm> getContactUsFormCollections() async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http
          .get(
            Uri.parse(
              config_app.apigetContactUsForm(),
            ),
            headers: this.getHeaders(),
          )
          .timeout(
            Duration(seconds: timeout),
          ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseGetContactUsForm.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load form contact us  collections");
      throw Exception('Failed to load form contatc us   collections');
    }
  }

  Future<ResponseGetContactUsForm> getjOINuSFormCollections() async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http
          .get(
            Uri.parse(
              config_app.apigetjOINUsForm(),
            ),
            headers: this.getHeaders(),
          )
          .timeout(
            Duration(seconds: timeout),
          ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseGetContactUsForm.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load form jOIN us  collections");
      throw Exception('Failed to load form JOIN us   collections');
    }
  }

  Future<ResponseAPI> SubmitContactUs(dynamic body) async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);

    http.Response response = await r.retry(
      () => http
          .post(
              Uri.parse(
                config_app.SubmitContactUs(),
              ),
              headers: this.getHeaders(),
              body: body)
          .timeout(
            Duration(seconds: timeout),
          ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      print(response.body);
      return ResponseAPI.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to submit Contact us");
      throw Exception('Failed to submit contact us');
    }
  }

  Future<ResponseAPI> SubmitJointUs(dynamic body) async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);

    http.Response response = await r.retry(
      () => http
          .post(
              Uri.parse(
                config_app.SubmitJointUs(),
              ),
              headers: this.getHeaders(),
              body: body)
          .timeout(
            Duration(seconds: timeout),
          ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      print(response.body);
      return ResponseAPI.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to submit join us");
      throw Exception('Failed to submit join us');
    }
  }

  Future<ResponseGetIntroData> getIntroCollections() async {
    /* http.Response response = await http.get(
      Uri.parse(
        config_app.apiMenuCollections(collectionId),
      ),
      headers: this.getHeaders(withAuth: false),
    ); */

    final r = RetryOptions(maxAttempts: maxAttempts);
    http.Response response = await r.retry(
      () => http
          .get(
            Uri.parse(
              config_app.apigetIntroData(),
            ),
            headers: this.getHeaders(),
          )
          .timeout(
            Duration(seconds: timeout),
          ),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (response.statusCode == 200) {
      return ResponseGetIntroData.fromJson(
        json.decode(response.body),
      );
    } else {
      print("Failed to load citys collections");
      throw Exception('Failed to load citys collections');
    }
  }
}

class httpErrorExeption {
  String? message = "";
  int? statusCode;
  httpErrorExeption({this.statusCode}) {
    if (globals.SelectedLang == "ar") {
      this.message = "خطأ في الاتصال بالانترنت";
    } else if (globals.SelectedLang == "ku") {
      this.message = "Internet connection error";
    } else {
      this.message = "Internet connection error";
    }
  }
}
