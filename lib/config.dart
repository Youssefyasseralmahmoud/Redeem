// import 'package:redeem/json_db/enum.dart';
// import 'package:redeem/json_db/jibal_enums.dart';
import 'package:redeem/globals.dart' as globals;
import 'package:redeem/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class config_app {
    static String PerfixAPI = "https://test.innovi.biz/redeem/public/app_api";
  static String PerfixImage = "https://test.innovi.biz/redeem/public/"; 
  // static String PerfixAPI = "http://192.168.1.200:8110/redeem/public/app_api";
  // static String PerfixImage = "http://192.168.1.200:8110/redeem/public/";
  static String DefaultCurrency = "\$";
  static String X_API_KEY = "REDEEM_XPEGAW6584FSAE654EWQE";
  static String DefaultLang = "en";
  static List<String> AvilableLang = ["ar", "en"];
  static String oneSignalAPPID = "7abd9774-effb-41df-863b-52add5ca5b13";

  static double current_android_version = 3;
  static double current_ios_version = 1;

  static String apiMenuCollections(dynamic collectionId) {
    if (collectionId == null) {
      collectionId = "";
    }
    return config_app.PerfixAPI + '/collections/menu/${collectionId}';
  }

//      *****************   here to add api route ***********

  static String apiGetAllCitys() {
    return config_app.PerfixAPI + '/all-cities';
  }

  static String apiGetCoupons(
      {int page = 1,
      String sorting = "",
      String filterSearch = "",
      dynamic filterCategory,
      dynamic filterRating,
      dynamic filterMinPrice,
      dynamic filterMaxPrice}) {
    String url = config_app.PerfixAPI + '/coupons?page=${page}';
    if (sorting != null) {
      url += '&sort_by=${sorting}';
    }
    if (filterSearch != "") {
      url += '&filter_search=${filterSearch}';
    }
    if (filterCategory != null) {
      url += '&filter_category=${filterCategory}';
    }
    if (filterRating != null) {
      url += '&filter_rating=${filterRating}';
    }

    if (filterMinPrice != null) {
      url += '&filter_min_price=${filterMinPrice}';
    }
    if (filterMaxPrice != null) {
      url += '&filter_max_price=${filterMaxPrice}';
    }
    print("url ${url}");
    return url;
  }

  static String apiGetOffers(
      {int page = 1,
      String sorting = "",
      String filterSearch = "",
      dynamic filterCategory,
      dynamic filterRating,
      dynamic filterMinPrice,
      dynamic filterMaxPrice}) {
    String url = config_app.PerfixAPI + '/special-offers?page=${page}';
    if (sorting != null) {
      url += '&sort_by=${sorting}';
    }
    if (filterSearch != "") {
      url += '&filter_search=${filterSearch}';
    }
    if (filterCategory != null) {
      url += '&filter_category=${filterCategory}';
    }
    if (filterRating != null) {
      url += '&filter_rating=${filterRating}';
    }

    if (filterMinPrice != null) {
      url += '&filter_min_price=${filterMinPrice}';
    }
    if (filterMaxPrice != null) {
      url += '&filter_max_price=${filterMaxPrice}';
    }
    print("url ${url}");
    return url;
  }

  static String apiGetCouponDetails(dynamic couponid) {
    return config_app.PerfixAPI + '/coupon/${couponid}';
  }

  static String apiGetOfferDetails(dynamic offerid) {
    return config_app.PerfixAPI + '/special-offer/${offerid}';
  }

  static String apiGetProvidersDetails(dynamic id) {
    return config_app.PerfixAPI + '/provider/${id}';
  }

  static String apiGetProviders() {
    return config_app.PerfixAPI + '/providers';
  }

  static String apiGetProvidersLocation(lattitude, longtude, category_id) {
    var url = config_app.PerfixAPI +
        '/providers-by-locations?lattitude=${lattitude}&longtude=${longtude}&category_id=${category_id ?? ""}';
    print("url ${url}");
    return config_app.PerfixAPI +
        '/providers-by-locations?lattitude=${lattitude}&longtude=${longtude}&category_id=${category_id ?? ""}';
  }

  static String apiGetHomeData() {
    return config_app.PerfixAPI + '/home';
  }

  static String apiGetCategories() {
    return config_app.PerfixAPI + '/main-categories';
  }

  static String apiLogin() {
    return config_app.PerfixAPI + '/login';
  }

  static String apiCheckMobileEsists() {
    return config_app.PerfixAPI + '/mobile-exists';
  }

  static String apiCheckEmailEsists() {
    return config_app.PerfixAPI + '/email-exists';
  }

  static String apiSendOtp() {
    return config_app.PerfixAPI + '/send-otp';
  }

  static String apiCheckOtp() {
    return config_app.PerfixAPI + '/check-otp';
  }

  static String apiSignup() {
    return config_app.PerfixAPI + '/register';
  }

  static String apiGetCart() {
    return config_app.PerfixAPI + '/get-cart';
  }

  static String apiAddToCart() {
    return config_app.PerfixAPI + '/add-to-cart';
  }

  static String apiRemoveFromCart() {
    return config_app.PerfixAPI + '/remove-from-cart';
  }

  static String apiSubmitOrder() {
    return config_app.PerfixAPI + '/submit-order';
  }

  static String apiGetAllPointPackage() {
    return config_app.PerfixAPI + '/all-points-packages';
  }

  static String apiSubmitOrderQuick() {
    return config_app.PerfixAPI + '/submit-order-quick-checkout';
  }

  static String apigetSubscriptionPackage() {
    return config_app.PerfixAPI + '/all-subscription-packages';
  }

  static String apigetDashboardData() {
    return config_app.PerfixAPI + '/dashboard';
  }

  static String apigetHistoryPoints() {
    return config_app.PerfixAPI + '/history-points';
  }

  static String apigetOrders() {
    return config_app.PerfixAPI + '/list-orders';
  }

  static String apigetJoinInvitation() {
    return config_app.PerfixAPI + '/join-invitations';
  }

  static String apigetNotifications({int page = 1}) {
    return config_app.PerfixAPI + '/user-notifications?page=${page}';
  }

  static String apigetMyCoupons() {
    return config_app.PerfixAPI + '/my-coupons';
  }

  static String checkHasPassword() {
    return config_app.PerfixAPI + '/user/has-password';
  }

  static String changePassword() {
    return config_app.PerfixAPI + '/change-password';
  }

  static String forgetPassword() {
    return config_app.PerfixAPI + '/forgot-password';
  }

  static String updateProfile() {
    return config_app.PerfixAPI + '/update-profile';
  }

  static String apiGetOrderDetails(dynamic id) {
    return config_app.PerfixAPI + '/order/${id}';
  }

  static String apiGetDetilsPage(dynamic key) {
    return config_app.PerfixAPI + '/page/${key}';
  }

  static String apiGetSearchData(dynamic searchKey) {
    return config_app.PerfixAPI + '/search-tag?search_key=${searchKey}';
  }

  static String apiGetFinalSearchResaultData(
      dynamic searchKey, dynamic forLoadMore) {
    return config_app.PerfixAPI +
        '/search?search_key=${searchKey}&for_load_more=${forLoadMore}';
  }

  static String Deleteaccount() {
    return config_app.PerfixAPI + '/delete-account';
  }

  static String UserIsActive() {
    return config_app.PerfixAPI + '/user/is-active';
  }

  static String apiGetCategoryDetails(dynamic id) {
    return config_app.PerfixAPI + '/data-category/${id}';
  }

  static String apiGetProviderReview(dynamic id) {
    return config_app.PerfixAPI + '/provider/${id}/reviews';
  }

  static String apiGetCouponReview(dynamic id) {
    return config_app.PerfixAPI + '/coupon/${id}/reviews';
  }

  static String apiGetOfferReview(dynamic id) {
    return config_app.PerfixAPI + '/special-offer/${id}/reviews';
  }

  static String SubmitReview() {
    return config_app.PerfixAPI + '/provider/submit-review';
  }

  static String apigetWhichListId() {
    return config_app.PerfixAPI + '/wishlist-ids';
  }

  static String apigetWhichList() {
    return config_app.PerfixAPI + '/wishlists';
  }

  static String apiAddCouponToWish(dynamic id) {
    return config_app.PerfixAPI + '/coupon/${id}/wishlist';
  }

  static String apiAddCProviderToWish(dynamic id) {
    return config_app.PerfixAPI + '/provider/${id}/wishlist';
  }

  static String apiAddOfferToWish(dynamic id) {
    return config_app.PerfixAPI + '/special-offer/${id}/wishlist';
  }

  static String apigetContactUsForm() {
    return config_app.PerfixAPI + '/form/contact-us';
  }

  static String apigetjOINUsForm() {
    return config_app.PerfixAPI + '/form/join-us';
  }

  static String SubmitContactUs() {
    return config_app.PerfixAPI + '/form/contact-us';
  }

  static String SubmitJointUs() {
    return config_app.PerfixAPI + '/form/join-us';
  }

  static String apigetIntroData() {
    return config_app.PerfixAPI + '/intro-app';
  }
}
