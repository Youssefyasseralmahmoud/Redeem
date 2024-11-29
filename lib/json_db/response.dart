import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:redeem/json_db/enum.dart';

import 'package:redeem/globals.dart' as globals;

class ResponseAPI {
  late final bool success;

  // ignore: non_constant_identifier_names
  late final bool has_errors;
  late final dynamic errors;
  late final String message;
  String? currencySymbol = "";
  int? nextPage;
  int? totalResult = 0;

  bool? needVerify = false;
  int? tempUser_id;
  String? needVerifyTitle = null;

  ResponseAPI.fromJson(Map<String, dynamic> json) {
    success = json['success'];

    message = json['message'];

    // globals.currencySymbol = currencySymbol;
    // print("xcx ${globals.currencySymbol} ${json['url']}");
    has_errors = json['has_errors'];
    if (json["errors"] != null) {
      errors = json['errors'].cast<String>();
    } else {
      errors = null;
    }

    bool? _need_verify;
    int? _temp_user_id;
    String? _need_verify_title;
    String? _currentSymbol;
    int? _nextPage;
    int? _total_result = 0;

    if (json.containsKey('need_verify') && json['need_verify'] != null) {
      _need_verify = json['need_verify'];
    } else {
      _need_verify = false;
    }
    if (json.containsKey('temp_user_id') && json['temp_user_id'] != null) {
      _temp_user_id = json['temp_user_id'];
    }

    if (json.containsKey('currency_symbol') &&
        json['currency_symbol'] != null) {
      _currentSymbol = json['currency_symbol'];
    } else {
      _currentSymbol = "";
    }
    if (json.containsKey('next_page') && json['next_page'] != null) {
      _nextPage = json['next_page'];
    }
    if (json.containsKey('total_results') && json['total_results'] != null) {
      _total_result = json['total_results'];
    }

    if (json.containsKey('current_subscription_package_id') &&
        json['current_subscription_package_id'] != null) {
      globals.CurrentSubscribePackage = json['current_subscription_package_id'];
    }
    //
    else {
      _temp_user_id = null;
    }
    if (json.containsKey('need_verify_title') &&
        json['need_verify_title'] != null) {
      _need_verify_title = json['need_verify_title'];
    } else {
      _need_verify_title = null;
    }
    tempUser_id = _temp_user_id;
    needVerify = _need_verify;
    needVerifyTitle = _need_verify_title;
    currencySymbol = _currentSymbol;
    nextPage = _nextPage;
    totalResult = _total_result;
  }
}

// class ResponseGetCollections extends ResponseAPI {
//   late final dynamic data;
//   ResponseGetCollections({this.data, Map<String, dynamic>? json})
//       : super.fromJson(json!);
//   factory ResponseGetCollections.fromJson(Map<String, dynamic> parsedJson) {
//     dynamic data;

//     if (parsedJson["success"]) {
//       if (parsedJson['data'] != null) {
//         // ignore: deprecated_member_use
//         var listData = parsedJson['data'] as List;
//         // List<CollectionItem> _data =
//         //     listData.map((i) => CollectionItem.fromJson(i)).toList();
//         // data = _data;
//       } else {
//         data = null;
//       }
//     } else {
//       data = null;
//     }
//     return ResponseGetCollections(
//       data: data,
//       json: parsedJson,
//     );
//   }
// }
//اذا ما كان عندي داتا ل رابط معين فورا بتعامل مع الكلاس الأب
class ResponseGetCities extends ResponseAPI {
  late final dynamic data;
  ResponseGetCities({this.data, Map<String, dynamic>? json})
      : super.fromJson(json!);

  factory ResponseGetCities.fromJson(Map<String, dynamic> parsedJson) {
    dynamic data;

    if (parsedJson["success"]) {
      if (parsedJson['data'] != null) {
        var listData = parsedJson['data'] as List;
        //*****
        List<City> _data = listData.map((i) => City.fromJson(i)).toList();
        //*******

        data = _data;
      } else {
        data = null;
      }
    } else {
      data = null;
    }
    return ResponseGetCities(
      data: data,
      json: parsedJson,
    );
  }
}

class ResponseCheckHasPassord extends ResponseAPI {
  late final dynamic data;
  ResponseCheckHasPassord({this.data, Map<String, dynamic>? json})
      : super.fromJson(json!);

  factory ResponseCheckHasPassord.fromJson(Map<String, dynamic> parsedJson) {
    dynamic data;

    if (parsedJson["success"]) {
      if (parsedJson['data'] != null) {
        //*****

        //*******

        data = parsedJson['data'];
      } else {
        data = false;
      }
    } else {
      data = false;
    }
    return ResponseCheckHasPassord(
      data: data,
      json: parsedJson,
    );
  }
}

//////

class ResponseGetCoupons extends ResponseAPI {
  late final dynamic data;
  ResponseGetCoupons({this.data, Map<String, dynamic>? json})
      : super.fromJson(json!);

  factory ResponseGetCoupons.fromJson(Map<String, dynamic> parsedJson) {
    dynamic data;

    if (parsedJson["success"]) {
      if (parsedJson['data'] != null) {
        var listData = parsedJson['data'] as List;
        //*****
        List<SimpleCoupon> _data =
            listData.map((i) => SimpleCoupon.fromJson(i)).toList();
        //*******

        data = _data;
      } else {
        data = null;
      }
    } else {
      data = null;
    }
    return ResponseGetCoupons(
      data: data,
      json: parsedJson,
    );
  }
}

class ResponseGetOffers extends ResponseAPI {
  late final dynamic data;
  ResponseGetOffers({this.data, Map<String, dynamic>? json})
      : super.fromJson(json!);

  factory ResponseGetOffers.fromJson(Map<String, dynamic> parsedJson) {
    dynamic data;

    if (parsedJson["success"]) {
      if (parsedJson['data'] != null) {
        var listData = parsedJson['data'] as List;
        //*****
        List<SimpleOffer> _data =
            listData.map((i) => SimpleOffer.fromJson(i)).toList();

        //*******

        data = _data;
      } else {
        data = null;
      }
    } else {
      data = null;
    }
    return ResponseGetOffers(
      data: data,
      json: parsedJson,
    );
  }
}

class ResponseGetCouponDetails extends ResponseAPI {
  late final dynamic data;
  ResponseGetCouponDetails({this.data, Map<String, dynamic>? json})
      : super.fromJson(json!);

  factory ResponseGetCouponDetails.fromJson(Map<String, dynamic> parsedJson) {
    dynamic data;

    if (parsedJson["success"]) {
      if (parsedJson['data'] != null) {
        data = CouponData.fromJson(parsedJson['data']);

        //*******
      } else {
        data = null;
      }
    } else {
      data = null;
    }
    return ResponseGetCouponDetails(
      data: data,
      json: parsedJson,
    );
  }
}

class ResponseGetOfferDetails extends ResponseAPI {
  late final dynamic data;
  ResponseGetOfferDetails({this.data, Map<String, dynamic>? json})
      : super.fromJson(json!);

  factory ResponseGetOfferDetails.fromJson(Map<String, dynamic> parsedJson) {
    dynamic data;

    if (parsedJson["success"]) {
      if (parsedJson['data'] != null) {
        data = OfferData.fromJson(parsedJson['data']);

        //*******
      } else {
        data = null;
      }
    } else {
      data = null;
    }
    return ResponseGetOfferDetails(
      data: data,
      json: parsedJson,
    );
  }
}

/////////////////
class ResponseGetProviderDetails extends ResponseAPI {
  late final dynamic data;
  ResponseGetProviderDetails({this.data, Map<String, dynamic>? json})
      : super.fromJson(json!);

  factory ResponseGetProviderDetails.fromJson(Map<String, dynamic> parsedJson) {
    dynamic data;

    if (parsedJson["success"]) {
      if (parsedJson['data'] != null) {
        data = ProviderDetail.fromJson(parsedJson['data']);

        //*******
      } else {
        data = null;
      }
    } else {
      data = null;
    }
    return ResponseGetProviderDetails(
      data: data,
      json: parsedJson,
    );
  }
}

//////////////
class ResponseGetProviders extends ResponseAPI {
  late final dynamic data;
  ResponseGetProviders({this.data, Map<String, dynamic>? json})
      : super.fromJson(json!);

  factory ResponseGetProviders.fromJson(Map<String, dynamic> parsedJson) {
    dynamic data;

    if (parsedJson["success"]) {
      if (parsedJson['data'] != null) {
        var listData = parsedJson['data'] as List;
        //*****
        List<SimpleProvider> _data =
            listData.map((i) => SimpleProvider.fromJson(i)).toList();

        //*******

        data = _data;
      } else {
        data = null;
      }
    } else {
      data = null;
    }
    return ResponseGetProviders(
      data: data,
      json: parsedJson,
    );
  }
}

class ResponseGetProvidersLocation extends ResponseAPI {
  late final dynamic data;
  ResponseGetProvidersLocation({this.data, Map<String, dynamic>? json})
      : super.fromJson(json!);

  factory ResponseGetProvidersLocation.fromJson(Map<String, dynamic> parsedJson) {
    dynamic data;

    if (parsedJson["success"]) {
      if (parsedJson['data'] != null) {
        var listData = parsedJson['data'] as List;
        //*****
        List<SimpleProvider> _data =
            listData.map((i) => SimpleProvider.fromJson(i)).toList();

        //*******

        data = _data;
      } else {
        data = null;
      }
    } else {
      data = null;
    }
    return ResponseGetProvidersLocation(
      data: data,
      json: parsedJson,
    );
  }
}

///////////////
class ResponseGetHomeData extends ResponseAPI {
  late final dynamic data;
  ResponseGetHomeData({this.data, Map<String, dynamic>? json})
      : super.fromJson(json!);

  factory ResponseGetHomeData.fromJson(Map<String, dynamic> parsedJson) {
    dynamic data;

    if (parsedJson["success"]) {
      if (parsedJson['data'] != null) {
        data = HomeData.fromJson(parsedJson['data']);

        //*******
      } else {
        data = null;
      }
    } else {
      data = null;
    }
    return ResponseGetHomeData(
      data: data,
      json: parsedJson,
    );
  }
}

///////////
class ResponseGetLoginData extends ResponseAPI {
  late final dynamic data;
  ResponseGetLoginData({this.data, Map<String, dynamic>? json})
      : super.fromJson(json!);

  factory ResponseGetLoginData.fromJson(Map<String, dynamic> parsedJson) {
    dynamic data;

    if (parsedJson["success"]) {
      if (parsedJson['data'] != null) {
        data = LoginData.fromJson(parsedJson['data']);

        //*******
      } else {
        data = null;
      }
    } else {
      data = null;
    }
    return ResponseGetLoginData(
      data: data,
      json: parsedJson,
    );
  }
}

///////
class ResponseGetSignupData extends ResponseAPI {
  late final dynamic data;
  ResponseGetSignupData({this.data, Map<String, dynamic>? json})
      : super.fromJson(json!);

  factory ResponseGetSignupData.fromJson(Map<String, dynamic> parsedJson) {
    dynamic data;

    if (parsedJson["success"]) {
      if (parsedJson['data'] != null) {
        data = SignupData.fromJson(parsedJson['data']);

        //*******
      } else {
        data = null;
      }
    } else {
      data = null;
    }
    return ResponseGetSignupData(
      data: data,
      json: parsedJson,
    );
  }
}

class ResponseUpdateProfileData extends ResponseAPI {
  late final dynamic data;
  ResponseUpdateProfileData({this.data, Map<String, dynamic>? json})
      : super.fromJson(json!);

  factory ResponseUpdateProfileData.fromJson(Map<String, dynamic> parsedJson) {
    dynamic data;

    if (parsedJson["success"]) {
      if (parsedJson['data'] != null) {
        data = updateProfileData.fromJson(parsedJson['data']);

        //*******
      } else {
        data = null;
      }
    } else {
      data = null;
    }
    return ResponseUpdateProfileData(
      data: data,
      json: parsedJson,
    );
  }
}

///////////
class ResponseGetCartData extends ResponseAPI {
  late final CartData data;

  ResponseGetCartData({required this.data, Map<String, dynamic>? json})
      : super.fromJson(json!);

  factory ResponseGetCartData.fromJson(Map<String, dynamic> parsedJson) {
    dynamic data;

    if (parsedJson["success"]) {
      if (parsedJson['data'] != null) {
        data = CartData.fromJson(parsedJson['data']);

        //*******
      } else {
        data = null;
      }
    } else {
      data = null;
    }
    return ResponseGetCartData(
      data: data,
      json: parsedJson,
    );
  }
}

////////////
class ResponseGetPointPackage extends ResponseAPI {
  late final dynamic data;
  ResponseGetPointPackage({this.data, Map<String, dynamic>? json})
      : super.fromJson(json!);

  factory ResponseGetPointPackage.fromJson(Map<String, dynamic> parsedJson) {
    dynamic data;

    if (parsedJson["success"]) {
      if (parsedJson['data'] != null) {
        var listData = parsedJson['data'] as List;
        //*****
        List<PointPackage> _data =
            listData.map((i) => PointPackage.fromJson(i)).toList();
        //*******

        data = _data;
      } else {
        data = null;
      }
    } else {
      data = null;
    }
    return ResponseGetPointPackage(
      data: data,
      json: parsedJson,
    );
  }
}

///////
class ResponseGetSubscriptionPackage extends ResponseAPI {
  late final dynamic data;
  ResponseGetSubscriptionPackage({this.data, Map<String, dynamic>? json})
      : super.fromJson(json!);

  factory ResponseGetSubscriptionPackage.fromJson(
      Map<String, dynamic> parsedJson) {
    dynamic data;

    if (parsedJson["success"]) {
      if (parsedJson['data'] != null) {
        var listData = parsedJson['data'] as List;
        //*****
        List<SubscriptionPackage> _data =
            listData.map((i) => SubscriptionPackage.fromJson(i)).toList();
        //*******

        data = _data;
      } else {
        data = null;
      }
    } else {
      data = null;
    }
    return ResponseGetSubscriptionPackage(
      data: data,
      json: parsedJson,
    );
  }
}

////
class ResponseGetDashboardData extends ResponseAPI {
  late final dynamic data;
  ResponseGetDashboardData({this.data, Map<String, dynamic>? json})
      : super.fromJson(json!);

  factory ResponseGetDashboardData.fromJson(Map<String, dynamic> parsedJson) {
    dynamic data;

    if (parsedJson["success"]) {
      if (parsedJson['data'] != null) {
        data = DashboardCustomerData.fromJson(parsedJson['data']);

        //*******
      } else {
        data = null;
      }
    } else {
      data = null;
    }
    return ResponseGetDashboardData(
      data: data,
      json: parsedJson,
    );
  }
}

/////
class ResponseGetHistoryPoints extends ResponseAPI {
  late final dynamic data;
  ResponseGetHistoryPoints({this.data, Map<String, dynamic>? json})
      : super.fromJson(json!);

  factory ResponseGetHistoryPoints.fromJson(Map<String, dynamic> parsedJson) {
    dynamic data;

    if (parsedJson["success"]) {
      if (parsedJson['data'] != null) {
        data = HistoryPointsData.fromJson(parsedJson['data']);

        //*******
      } else {
        data = null;
      }
    } else {
      data = null;
    }
    return ResponseGetHistoryPoints(
      data: data,
      json: parsedJson,
    );
  }
}

class ResponseGetOrders extends ResponseAPI {
  late final dynamic data;
  ResponseGetOrders({this.data, Map<String, dynamic>? json})
      : super.fromJson(json!);

  factory ResponseGetOrders.fromJson(Map<String, dynamic> parsedJson) {
    dynamic data;

    if (parsedJson["success"]) {
      if (parsedJson['data'] != null) {
        var listData = parsedJson['data'] as List;
        //*****
        List<SimpleOrder> _data =
            listData.map((i) => SimpleOrder.fromJson(i)).toList();
        //*******

        data = _data;
      } else {
        data = null;
      }
    } else {
      data = null;
    }
    return ResponseGetOrders(
      data: data,
      json: parsedJson,
    );
  }
}

class ResponseGetJoinInvitation extends ResponseAPI {
  late final dynamic data;
  ResponseGetJoinInvitation({this.data, Map<String, dynamic>? json})
      : super.fromJson(json!);

  factory ResponseGetJoinInvitation.fromJson(Map<String, dynamic> parsedJson) {
    dynamic data;

    if (parsedJson["success"]) {
      if (parsedJson['data'] != null) {
        data = JoinInvitationData.fromJson(parsedJson['data']);

        //*******
      } else {
        data = null;
      }
    } else {
      data = null;
    }
    return ResponseGetJoinInvitation(
      data: data,
      json: parsedJson,
    );
  }
}

////
class ResponseGetNotifications extends ResponseAPI {
  late final dynamic data;
  ResponseGetNotifications({this.data, Map<String, dynamic>? json})
      : super.fromJson(json!);

  factory ResponseGetNotifications.fromJson(Map<String, dynamic> parsedJson) {
    dynamic data;

    if (parsedJson["success"]) {
      if (parsedJson['data'] != null) {
        var listData = parsedJson['data'] as List;
        //*****
        List<LastNotification> _data =
            listData.map((i) => LastNotification.fromJson(i)).toList();
        //*******

        data = _data;
      } else {
        data = null;
      }
    } else {
      data = null;
    }
    return ResponseGetNotifications(
      data: data,
      json: parsedJson,
    );
  }
}

///
class ResponseGetMyCoupons extends ResponseAPI {
  late final dynamic data;
  ResponseGetMyCoupons({this.data, Map<String, dynamic>? json})
      : super.fromJson(json!);

  factory ResponseGetMyCoupons.fromJson(Map<String, dynamic> parsedJson) {
    dynamic data;

    if (parsedJson["success"]) {
      if (parsedJson['data'] != null) {
        var listData = parsedJson['data'] as List;
        //*****
        List<SoldCoupon> _data =
            listData.map((i) => SoldCoupon.fromJson(i)).toList();
        print("data my coupons from response is ${_data}");
        //*******

        data = _data;
      } else {
        data = null;
      }
    } else {
      data = null;
    }
    return ResponseGetMyCoupons(
      data: data,
      json: parsedJson,
    );
  }
}

class ResponseMainCategories extends ResponseAPI {
  late final List<Category> data;
  ResponseMainCategories({required this.data, Map<String, dynamic>? json})
      : super.fromJson(json!);

  factory ResponseMainCategories.fromJson(Map<String, dynamic> parsedJson) {
    dynamic data;

    if (parsedJson["success"]) {
      if (parsedJson['data'] != null) {
        var listData = parsedJson['data'] as List;
        //*****
        List<Category> _data =
            listData.map((i) => Category.fromJson(i)).toList();
        print("data my coupons from response is ${_data}");
        //*******

        data = _data;
      } else {
        data = null;
      }
    } else {
      data = null;
    }
    return ResponseMainCategories(
      data: data,
      json: parsedJson,
    );
  }
}

class ResponseMobileEmailExists extends ResponseAPI {
  late final dynamic data;
  late final bool exists;
  ResponseMobileEmailExists(
      {this.data, required this.exists, Map<String, dynamic>? json})
      : super.fromJson(json!);

  factory ResponseMobileEmailExists.fromJson(Map<String, dynamic> parsedJson) {
    return ResponseMobileEmailExists(
      data: null,
      exists: parsedJson['exists'],
      json: parsedJson,
    );
  }
}

class ResponseCreateOrder extends ResponseAPI {
  late final dynamic data;
  late final String redirect_link;
  ResponseCreateOrder(
      {this.data, required this.redirect_link, Map<String, dynamic>? json})
      : super.fromJson(json!);

  factory ResponseCreateOrder.fromJson(Map<String, dynamic> parsedJson) {
    return ResponseCreateOrder(
      data: null,
      redirect_link: parsedJson['redirect_link'] ?? "",
      json: parsedJson,
    );
  }
}

class ResponseGetOrderDetails extends ResponseAPI {
  late final dynamic data;
  ResponseGetOrderDetails({this.data, Map<String, dynamic>? json})
      : super.fromJson(json!);

  factory ResponseGetOrderDetails.fromJson(Map<String, dynamic> parsedJson) {
    dynamic data;

    if (parsedJson["success"]) {
      if (parsedJson['data'] != null) {
        data = OrderDetailData.fromJson(parsedJson['data']);

        //*******
      } else {
        data = null;
      }
    } else {
      data = null;
    }
    return ResponseGetOrderDetails(
      data: data,
      json: parsedJson,
    );
  }
}

class ResponseGetDetailsPage extends ResponseAPI {
  late final dynamic data;
  ResponseGetDetailsPage({this.data, Map<String, dynamic>? json})
      : super.fromJson(json!);

  factory ResponseGetDetailsPage.fromJson(Map<String, dynamic> parsedJson) {
    dynamic data;

    if (parsedJson["success"]) {
      if (parsedJson['data'] != null) {
        data = DetailsPageData.fromJson(parsedJson['data']);

        //*******
      } else {
        data = null;
      }
    } else {
      data = null;
    }
    return ResponseGetDetailsPage(
      data: data,
      json: parsedJson,
    );
  }
}

class ResponseGetSearchAuto extends ResponseAPI {
  late final dynamic data;
  ResponseGetSearchAuto({this.data, Map<String, dynamic>? json})
      : super.fromJson(json!);

  factory ResponseGetSearchAuto.fromJson(Map<String, dynamic> parsedJson) {
    dynamic data;

    if (parsedJson["success"]) {
      if (parsedJson['data'] != null) {
        data = SearchData.fromJson(parsedJson['data']);

        //*******
      } else {
        data = null;
      }
    } else {
      data = null;
    }
    return ResponseGetSearchAuto(
      data: data,
      json: parsedJson,
    );
  }
}

class ResponseGetFinalSearchResault extends ResponseAPI {
  late final FinalSearchData? data;
  ResponseGetFinalSearchResault({this.data, Map<String, dynamic>? json})
      : super.fromJson(json!);

  factory ResponseGetFinalSearchResault.fromJson(
      Map<String, dynamic> parsedJson) {
    FinalSearchData? data;

    if (parsedJson["success"]) {
      if (parsedJson['data'] != null) {
        data = FinalSearchData.fromJson(parsedJson['data']);

        //*******
      } else {
        data = null;
      }
    } else {
      data = null;
    }
    return ResponseGetFinalSearchResault(
      data: data,
      json: parsedJson,
    );
  }
}

class ResponseDeleteAccount extends ResponseAPI {
  late final dynamic data;
  ResponseDeleteAccount({this.data, Map<String, dynamic>? json})
      : super.fromJson(json!);

  factory ResponseDeleteAccount.fromJson(Map<String, dynamic> parsedJson) {
    dynamic data;

    if (parsedJson["success"]) {
      if (parsedJson['data'] != null) {
        //*****

        //*******

        data = parsedJson['data'];
      } else {
        data = false;
      }
    } else {
      data = false;
    }
    return ResponseDeleteAccount(
      data: data,
      json: parsedJson,
    );
  }
}

class ResponseGetIsActiveData extends ResponseAPI {
  late final IsActiveData data;
  ResponseGetIsActiveData({required this.data, Map<String, dynamic>? json})
      : super.fromJson(json!);

  factory ResponseGetIsActiveData.fromJson(Map<String, dynamic> parsedJson) {
    dynamic data;

    if (parsedJson["success"]) {
      if (parsedJson['data'] != null) {
        data = IsActiveData.fromJson(parsedJson['data']);

        //*******
      } else {
        data = null;
      }
    } else {
      data = null;
    }
    return ResponseGetIsActiveData(
      data: data,
      json: parsedJson,
    );
  }
}

class ResponseGetCategoryDetails extends ResponseAPI {
  late final dynamic data;
  ResponseGetCategoryDetails({this.data, Map<String, dynamic>? json})
      : super.fromJson(json!);

  factory ResponseGetCategoryDetails.fromJson(Map<String, dynamic> parsedJson) {
    dynamic data;

    if (parsedJson["success"]) {
      if (parsedJson['data'] != null) {
        data = CategoryDetailsData.fromJson(parsedJson['data']);

        //*******
      } else {
        data = null;
      }
    } else {
      data = null;
    }
    return ResponseGetCategoryDetails(
      data: data,
      json: parsedJson,
    );
  }
}

class ResponseGetProviderReview extends ResponseAPI {
  late final dynamic data;
  ResponseGetProviderReview({this.data, Map<String, dynamic>? json})
      : super.fromJson(json!);

  factory ResponseGetProviderReview.fromJson(Map<String, dynamic> parsedJson) {
    dynamic data;

    if (parsedJson["success"]) {
      if (parsedJson['data'] != null) {
        var listData = parsedJson['data'] as List;
        //*****
        List<ProvidersReview> _data =
            listData.map((i) => ProvidersReview.fromJson(i)).toList();
        //*******

        data = _data;
      } else {
        data = null;
      }
    } else {
      data = null;
    }
    return ResponseGetProviderReview(
      data: data,
      json: parsedJson,
    );
  }
}

class ResponseGetCouponReview extends ResponseAPI {
  late final dynamic data;
  ResponseGetCouponReview({this.data, Map<String, dynamic>? json})
      : super.fromJson(json!);

  factory ResponseGetCouponReview.fromJson(Map<String, dynamic> parsedJson) {
    dynamic data;

    if (parsedJson["success"]) {
      if (parsedJson['data'] != null) {
        var listData = parsedJson['data'] as List;
        //*****
        List<CouponReview> _data =
            listData.map((i) => CouponReview.fromJson(i)).toList();
        //*******

        data = _data;
      } else {
        data = null;
      }
    } else {
      data = null;
    }
    return ResponseGetCouponReview(
      data: data,
      json: parsedJson,
    );
  }
}

class ResponseGetOfferReview extends ResponseAPI {
  late final dynamic data;
  ResponseGetOfferReview({this.data, Map<String, dynamic>? json})
      : super.fromJson(json!);

  factory ResponseGetOfferReview.fromJson(Map<String, dynamic> parsedJson) {
    dynamic data;

    if (parsedJson["success"]) {
      if (parsedJson['data'] != null) {
        var listData = parsedJson['data'] as List;
        //*****
        List<OfferReview> _data =
            listData.map((i) => OfferReview.fromJson(i)).toList();
        //*******

        data = _data;
      } else {
        data = null;
      }
    } else {
      data = null;
    }
    return ResponseGetOfferReview(
      data: data,
      json: parsedJson,
    );
  }
}

class ResponseGetWhicjListId extends ResponseAPI {
  late final WhishListIdData data;
  ResponseGetWhicjListId({required this.data, Map<String, dynamic>? json})
      : super.fromJson(json!);

  factory ResponseGetWhicjListId.fromJson(Map<String, dynamic> parsedJson) {
    dynamic data;
    if (parsedJson["success"]) {
      if (parsedJson['data'] != null) {
        data = WhishListIdData.fromJson(parsedJson['data']);

        //*******
      } else {
        data = null;
      }
    } else {
      data = null;
    }
    return ResponseGetWhicjListId(
      data: data,
      json: parsedJson,
    );
  }
}

class ResponseGetWhicjListData extends ResponseAPI {
  late final dynamic data;
  ResponseGetWhicjListData({this.data, Map<String, dynamic>? json})
      : super.fromJson(json!);

  factory ResponseGetWhicjListData.fromJson(Map<String, dynamic> parsedJson) {
    dynamic data;
    if (parsedJson["success"]) {
      if (parsedJson['data'] != null) {
        data = WhishListData.fromJson(parsedJson['data']);

        //*******
      } else {
        data = null;
      }
    } else {
      data = null;
    }
    return ResponseGetWhicjListData(
      data: data,
      json: parsedJson,
    );
  }
}

class ResponseGetContactUsForm extends ResponseAPI {
  late final dynamic data;
  List<TextEditingController> controllers = [];
  ResponseGetContactUsForm(
      {this.data, Map<String, dynamic>? json, required this.controllers})
      : super.fromJson(json!);

  factory ResponseGetContactUsForm.fromJson(Map<String, dynamic> parsedJson) {
    dynamic data;
    List<TextEditingController> controllers = [];
    if (parsedJson["success"]) {
      if (parsedJson['data'] != null) {
        var listData = parsedJson['data'] as List;
        //*****
        List<FormItemData> _data =
            listData.map((i) => FormItemData.fromJson(i)).toList();
        int i = 0;
        _data.forEach((element) {
          element.index = i;
          controllers.add(TextEditingController());
          i++;
        });

        //*******

        data = _data;
      } else {
        data = null;
      }
    } else {
      data = null;
    }
    return ResponseGetContactUsForm(
        data: data, json: parsedJson, controllers: controllers);
  }
}

class ResponseGetIntroData extends ResponseAPI {
  late final dynamic data;
  ResponseGetIntroData({this.data, Map<String, dynamic>? json})
      : super.fromJson(json!);

  factory ResponseGetIntroData.fromJson(Map<String, dynamic> parsedJson) {
    dynamic data;

    if (parsedJson["success"]) {
      if (parsedJson['data'] != null) {
        var listData = parsedJson['data'] as List;
        //*****
        List<IntroData> _data =
            listData.map((i) => IntroData.fromJson(i)).toList();
        //*******

        data = _data;
      } else {
        data = null;
      }
    } else {
      data = null;
    }
    return ResponseGetIntroData(
      data: data,
      json: parsedJson,
    );
  }
}
       // List<DetailCoupon> _data=[];
        // for(var items in parsedJson['data'] as List){
        //   _data.add(DetailCoupon.fromJson(items));

        // }

        // var listData = parsedJson['data'] as List;

        // print("hibana_is ${listData}");
        // //*****
        // List<DetailCoupon> _data =
        //     listData.map((i) => DetailCoupon.fromJson(i)).toList();