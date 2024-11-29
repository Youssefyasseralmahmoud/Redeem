class City {
  int? id;
  String? nameEn;
  int? regionId;
  String? nameAr;
  int? active;
  String? longitude;
  String? latitude;

  City(
      {this.id,
      this.nameEn,
      this.regionId,
      this.nameAr,
      this.active,
      this.longitude,
      this.latitude});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    regionId = json['region_id'];
    nameAr = json['name_ar'];
    active = json['active'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['region_id'] = this.regionId;
    data['name_ar'] = this.nameAr;
    data['active'] = this.active;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    return data;
  }

  Map<String, dynamic> _toMap() {
    return {
      'name_ar': nameAr,
      'name_en': nameEn,
    };
  }

  dynamic getPropertyEffectedByLang(String propertyName) {
    var _mapRep = _toMap();
    if (_mapRep.containsKey(propertyName)) {
      return _mapRep[propertyName];
    }
    throw ArgumentError('propery not found');
  }
}

//////////////////
// class Coupon {
//   int? id;
//   String? nameAr;
//   String? nameEn;
//   String? briefEn;
//   String? briefAr;
//   String? termsAr;
//   String? termsEn;
//   String? image;
//   String? startDate;
//   String? endDate;
//   String? couponReference;
//   int? providerId;
//   int? maxUserUsed;
//   int? maxDailyUsed;
//   int? maxDailyUserUsed;
//   String? perMaxUserUsed;
//   String? saving;
//   int? priority;

//   String? priceBeforeDiscount;
//   String? price;
//   String? valid_to;
//   String? discountPercentage;
//   int? couponContractTypeId;

//   int? countStock;
//   int? totalPurchased;

//   int? enablePromotionCode;
//   int? unifiedPromotionCode;
//   String? promotionCode;
//   int? active;
//   int? featured;
//   int? mostPopular;
//   int? bestDeals;
//   int? enableGeneralTerms;
//   int? enableFlashDeal;
//   String? flashDealStartDate;
//   String? flashDealEndDate;
//   String? slug;
//   // int? createdBy;
//   // int? updatedBy;
//   // String? createdAt;
//   // String? updatedAt;
//   String? imageFull;

//   Coupon(
//       {this.id,
//       this.nameAr,
//       this.nameEn,
//       this.briefEn,
//       this.briefAr,
//       this.termsAr,
//       this.termsEn,
//       this.image,
//       this.startDate,
//       this.endDate,
//       this.couponReference,
//       this.providerId,
//       this.maxUserUsed,
//       this.maxDailyUsed,
//       this.maxDailyUserUsed,
//       this.perMaxUserUsed,
//       this.saving,
//       this.priority,
//       this.priceBeforeDiscount,
//       this.price,
//       this.valid_to,
//       this.discountPercentage,
//       this.couponContractTypeId,
//       this.countStock,
//       this.totalPurchased,
//       this.enablePromotionCode,
//       this.unifiedPromotionCode,
//       this.promotionCode,
//       this.active,
//       this.featured,
//       this.mostPopular,
//       this.bestDeals,
//       this.enableGeneralTerms,
//       this.enableFlashDeal,
//       this.flashDealStartDate,
//       this.flashDealEndDate,
//       this.slug,
//       // this.createdBy,
//       // this.updatedBy,
//       // this.createdAt,
//       // this.updatedAt,
//       this.imageFull});

//   Coupon.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     nameAr = json['name_ar'];
//     nameEn = json['name_en'];
//     briefEn = json['brief_en'];
//     briefAr = json['brief_ar'];
//     termsAr = json['terms_ar'];
//     termsEn = json['terms_en'];
//     image = json['image'];
//     startDate = json['start_date'];
//     endDate = json['end_date'];
//     couponReference = json['coupon_reference'];
//     providerId = json['provider_id'];
//     maxUserUsed = json['max_user_used'];
//     maxDailyUsed = json['max_daily_used'];
//     maxDailyUserUsed = json['max_daily_user_used'];
//     perMaxUserUsed = json['per_max_user_used'];
//     saving = json['saving'];
//     priority = json['priority'];

//     priceBeforeDiscount = json['price_before_discount'];
//     price = json['price'];
//     valid_to = json['valid_to'];
//     discountPercentage = json['discount_percentage'];
//     couponContractTypeId = json['coupon_contract_type_id'];

//     countStock = json['count_stock'];
//     totalPurchased = json['total_purchased'];

//     enablePromotionCode = json['enable_promotion_code'];
//     unifiedPromotionCode = json['unified_promotion_code'];
//     promotionCode = json['promotion_code'];
//     active = json['active'];
//     featured = json['featured'];
//     mostPopular = json['most_popular'];
//     bestDeals = json['best_deals'];
//     enableGeneralTerms = json['enable_general_terms'];
//     enableFlashDeal = json['enable_flash_deal'];
//     flashDealStartDate = json['flash_deal_start_date'];
//     flashDealEndDate = json['flash_deal_end_date'];
//     slug = json['slug'];
//     // createdBy = json['created_by'];
//     // updatedBy = json['updated_by'];
//     // createdAt = json['created_at'];
//     // updatedAt = json['updated_at'];
//     imageFull = json['image_full'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name_ar'] = this.nameAr;
//     data['name_en'] = this.nameEn;
//     data['brief_en'] = this.briefEn;
//     data['brief_ar'] = this.briefAr;
//     data['terms_ar'] = this.termsAr;
//     data['terms_en'] = this.termsEn;
//     data['image'] = this.image;
//     data['start_date'] = this.startDate;
//     data['end_date'] = this.endDate;
//     data['coupon_reference'] = this.couponReference;
//     data['provider_id'] = this.providerId;
//     data['max_user_used'] = this.maxUserUsed;
//     data['max_daily_used'] = this.maxDailyUsed;
//     data['max_daily_user_used'] = this.maxDailyUserUsed;
//     data['per_max_user_used'] = this.perMaxUserUsed;
//     data['saving'] = this.saving;
//     data['priority'] = this.priority;

//     data['price_before_discount'] = this.priceBeforeDiscount;
//     data['price'] = this.price;
//     data['valid_to'] = this.valid_to;
//     data['discount_percentage'] = this.discountPercentage;
//     data['coupon_contract_type_id'] = this.couponContractTypeId;

//     data['count_stock'] = this.countStock;
//     data['total_purchased'] = this.totalPurchased;

//     data['enable_promotion_code'] = this.enablePromotionCode;
//     data['unified_promotion_code'] = this.unifiedPromotionCode;
//     data['promotion_code'] = this.promotionCode;
//     data['active'] = this.active;
//     data['featured'] = this.featured;
//     data['most_popular'] = this.mostPopular;
//     data['best_deals'] = this.bestDeals;
//     data['enable_general_terms'] = this.enableGeneralTerms;
//     data['enable_flash_deal'] = this.enableFlashDeal;
//     data['flash_deal_start_date'] = this.flashDealStartDate;
//     data['flash_deal_end_date'] = this.flashDealEndDate;
//     data['slug'] = this.slug;
//     // data['created_by'] = this.createdBy;
//     // data['updated_by'] = this.updatedBy;
//     // data['created_at'] = this.createdAt;
//     // data['updated_at'] = this.updatedAt;
//     data['image_full'] = this.imageFull;
//     return data;
//   }

//   Map<String, dynamic> _toMap() {
//     return {
//       'name_ar': nameAr,
//       'name_en': nameEn,
//     };
//   }

//   dynamic getPropertyEffectedByLang(String propertyName) {
//     var _mapRep = _toMap();
//     if (_mapRep.containsKey(propertyName)) {
//       return _mapRep[propertyName];
//     }
//     throw ArgumentError('propery not found');
//   }
// }

////////////////
class SimpleCoupon {
  int? id;
  String? nameEn;
  String? nameAr;
  String? image;
  String? priceBeforeDiscount;
  int? providerId;
  String? slug;
  String? price;
  String? pointPrice;
  String? earnedPoints;
  String? validTo;
  String? imageFull;
  String? flash_deal_end_date;

  SimpleProvider? simpleProvider;

  SimpleCoupon(
      {this.id,
      this.nameEn,
      this.nameAr,
      this.image,
      this.priceBeforeDiscount,
      this.providerId,
      this.slug,
      this.price,
      this.pointPrice,
      this.earnedPoints,
      this.validTo,
      this.simpleProvider,
      this.flash_deal_end_date,
      this.imageFull});

  SimpleCoupon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    image = json['image'];
    priceBeforeDiscount = json['price_before_discount'];
    providerId = json['provider_id'];
    slug = json['slug'];
    price = json['price'];
    pointPrice = json['point_price'];
    earnedPoints = json['earned_points'];
    validTo = json['valid_to'];
    imageFull = json['image_full'];
    flash_deal_end_date = json['flash_deal_end_date'];

    if (json.containsKey("provider") && json['provider'] != null) {
      simpleProvider = SimpleProvider.fromJson(json['provider']);
    }
    if (json.containsKey("flash_deal_end_date") &&
        json['flash_deal_end_date'] == null) {
      flash_deal_end_date = "0000-00-00 00:00:00";
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['image'] = this.image;
    data['price_before_discount'] = this.priceBeforeDiscount;
    data['provider_id'] = this.providerId;
    data['slug'] = this.slug;
    data['price'] = this.price;
    data['point_price'] = this.pointPrice;
    data['earned_points'] = this.earnedPoints;
    data['valid_to'] = this.validTo;
    data['image_full'] = this.imageFull;
    return data;
  }

  Map<String, dynamic> _toMap() {
    return {
      'name_ar': nameAr,
      'name_en': nameEn,
    };
  }

  dynamic getPropertyEffectedByLang(String propertyName) {
    var _mapRep = _toMap();
    if (_mapRep.containsKey(propertyName)) {
      return _mapRep[propertyName];
    }
    throw ArgumentError('propery not found');
  }
}

/////
class FlashDeal {
  int? id;
  String? nameEn;
  String? nameAr;
  String? image;
  String? priceBeforeDiscount;
  int? providerId;
  String? slug;
  String? flashDealEndDate;
  String? price;
  String? pointPrice;
  String? earnedPoints;
  String? validTo;
  String? imageFull;
  SimpleProvider? simpleProvider;

  FlashDeal(
      {this.id,
      this.nameEn,
      this.nameAr,
      this.image,
      this.priceBeforeDiscount,
      this.providerId,
      this.slug,
      this.flashDealEndDate,
      this.price,
      this.pointPrice,
      this.earnedPoints,
      this.validTo,
      this.simpleProvider,
      this.imageFull});

  FlashDeal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    image = json['image'];
    priceBeforeDiscount = json['price_before_discount'];
    providerId = json['provider_id'];
    slug = json['slug'];
    flashDealEndDate = json['flash_deal_end_date'];
    price = json['price'];
    pointPrice = json['point_price'];
    earnedPoints = json['earned_points'];
    validTo = json['valid_to'];
    imageFull = json['image_full'];
    if (json.containsKey("provider") && json['provider'] != null) {
      simpleProvider = SimpleProvider.fromJson(json['provider']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['image'] = this.image;
    data['price_before_discount'] = this.priceBeforeDiscount;
    data['provider_id'] = this.providerId;
    data['slug'] = this.slug;
    data['flash_deal_end_date'] = this.flashDealEndDate;
    data['price'] = this.price;
    data['point_price'] = this.pointPrice;
    data['earned_points'] = this.earnedPoints;
    data['valid_to'] = this.validTo;
    data['image_full'] = this.imageFull;
    return data;
  }

  Map<String, dynamic> _toMap() {
    return {
      'name_ar': nameAr,
      'name_en': nameEn,
    };
  }

  dynamic getPropertyEffectedByLang(String propertyName) {
    var _mapRep = _toMap();
    if (_mapRep.containsKey(propertyName)) {
      return _mapRep[propertyName];
    }
    throw ArgumentError('propery not found');
  }
}

///////////////////
class SimpleProvider {
  int? id;
  String? nameEn;
  String? nameAr;
  String? slug;
  String? logo;
  int? providerCategoryId;
  double? lattitude;
  double? longtude;
  int? coupons_count;
  int? special_offers_count;
  String? location_en;
  String? location_ar;

  Category? category;
  List<ProviderBranch>? listProviderBranch;

  SimpleProvider(
      {this.id,
      this.nameEn,
      this.nameAr,
      this.slug,
      this.logo,
      this.category,
      required this.listProviderBranch,
      this.coupons_count,
      this.special_offers_count,
      this.location_en,
      this.location_ar,
      this.providerCategoryId});

  SimpleProvider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    slug = json['slug'];
    logo = json['logo'];
    providerCategoryId = json['provider_category_id'];
    if (json.containsKey("coupons_count") && json['coupons_count'] != null) {
      coupons_count = json['coupons_count'];
    }
    if (json.containsKey("special_offers_count") && json['special_offers_count'] != null) {
      special_offers_count = json['special_offers_count'];
    }
    if (json.containsKey("location_en") && json['location_en'] != null) {
      location_en = json['location_en'];
    }
    if (json.containsKey("location_ar") && json['location_ar'] != null) {
      location_ar = json['location_ar'];
    }

    if (json.containsKey("category") && json['category'] != null) {
      category = Category.fromJson(json['category']);
    }

    if (json.containsKey("lattitude") && json['lattitude'] != null) {
      lattitude = json['lattitude'];
    }

    if (json.containsKey("longtude") && json['longtude'] != null) {
      longtude = json['longtude'];
    }

    if (json.containsKey("branches") && json['branches'] != null) {
      var _list_providerBranch = json['branches'] as List;
      List<ProviderBranch> _listProviderbranch =
          _list_providerBranch.map((i) => ProviderBranch.fromJson(i)).toList();
      listProviderBranch = _listProviderbranch;
    }

    // if (json.containsKey("branches") && json['branches'] != null) {
    //   providerBranch = ProviderBranch.fromJson(json['branches']);
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['slug'] = this.slug;
    data['logo'] = this.logo;
    data['provider_category_id'] = this.providerCategoryId;
    return data;
  }

  Map<String, dynamic> _toMap() {
    return {
      'name_ar': nameAr,
      'name_en': nameEn,
      'location_en': location_en,
      'location_ar': location_ar
    };
  }

  dynamic getPropertyEffectedByLang(String propertyName) {
    var _mapRep = _toMap();
    if (_mapRep.containsKey(propertyName)) {
      return _mapRep[propertyName];
    }
    throw ArgumentError('propery not found');
  }
}

//////////////
class Category {
  int? id;
  String? nameEn;
  String? nameAr;
  String? color;
  String? icon;
  List<Category>? listSubCategories;

  Category(
      {this.id,
      this.nameEn,
      this.nameAr,
      this.color,
      this.icon,
      required this.listSubCategories});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    color = json['color'];
    icon = json['icon'];
    if (json.containsKey("sub_categories") && json['sub_categories'] != null) {
      var _list_subCategories = json['sub_categories'] as List;
      List<Category> _listSubCategories =
          _list_subCategories.map((i) => Category.fromJson(i)).toList();
      listSubCategories = _listSubCategories;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['color'] = this.color;
    data['icon'] = this.icon;
    return data;
  }

  Map<String, dynamic> _toMap() {
    return {
      'name_ar': nameAr,
      'name_en': nameEn,
    };
  }

  dynamic getPropertyEffectedByLang(String propertyName) {
    var _mapRep = _toMap();
    if (_mapRep.containsKey(propertyName)) {
      return _mapRep[propertyName];
    }
    throw ArgumentError('propery not found');
  }
}

////
// class Offer {
//   int? id;
//   String? nameAr;
//   String? nameEn;
//   String? briefEn;
//   String? briefAr;
//   String? termsAr;
//   String? termsEn;
//   String? image;
//   String? startDate;
//   String? endDate;
//   int? countOffers;
//   int? currentOffers;
//   int? specialOfferTypeId;
//   String? specialOfferReference;
//   String? tags;
//   int? providerId;
//   int? maxUserUsed;
//   int? maxDailyUsed;
//   int? maxDailyUserUsed;
//   String? perMaxUserUsed;
//   String? saving;
//   int? priority;
//   String? discountPercentage;
//   int? totalUsed;
//   int? enablePromotionCode;
//   int? unifiedPromotionCode;
//   String? promotionCode;
//   int? active;
//   int? featured;
//   int? mostPopular;
//   int? bestDeals;
//   int? enableGeneralTerms;
//   int? enableFlashDeal;
//   String? flashDealStartDate;
//   String? flashDealEndDate;
//   String? slug;
//   int? createdBy;
//   int? updatedBy;
//   String? createdAt;
//   String? updatedAt;
//   String? price;
//   String? validTo;
//   String? imageFull;
//   SimpleProvider? simpleProvider;

//   Offer(
//       {this.id,
//       this.nameAr,
//       this.nameEn,
//       this.briefEn,
//       this.briefAr,
//       this.termsAr,
//       this.termsEn,
//       this.image,
//       this.startDate,
//       this.endDate,
//       this.countOffers,
//       this.currentOffers,
//       this.specialOfferTypeId,
//       this.specialOfferReference,
//       this.tags,
//       this.providerId,
//       this.maxUserUsed,
//       this.maxDailyUsed,
//       this.maxDailyUserUsed,
//       this.perMaxUserUsed,
//       this.saving,
//       this.priority,
//       this.discountPercentage,
//       this.totalUsed,
//       this.enablePromotionCode,
//       this.unifiedPromotionCode,
//       this.promotionCode,
//       this.active,
//       this.featured,
//       this.mostPopular,
//       this.bestDeals,
//       this.enableGeneralTerms,
//       this.enableFlashDeal,
//       this.flashDealStartDate,
//       this.flashDealEndDate,
//       this.slug,
//       this.createdBy,
//       this.updatedBy,
//       this.createdAt,
//       this.updatedAt,
//       this.price,
//       this.validTo,
//       this.simpleProvider,
//       this.imageFull});

//   Offer.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     nameAr = json['name_ar'];
//     nameEn = json['name_en'];
//     briefEn = json['brief_en'];
//     briefAr = json['brief_ar'];
//     termsAr = json['terms_ar'];
//     termsEn = json['terms_en'];
//     image = json['image'];
//     startDate = json['start_date'];
//     endDate = json['end_date'];
//     countOffers = json['count_offers'];
//     currentOffers = json['current_offers'];
//     specialOfferTypeId = json['special_offer_type_id'];
//     specialOfferReference = json['special_offer_reference'];
//     tags = json['tags'];
//     providerId = json['provider_id'];
//     maxUserUsed = json['max_user_used'];
//     maxDailyUsed = json['max_daily_used'];
//     maxDailyUserUsed = json['max_daily_user_used'];
//     perMaxUserUsed = json['per_max_user_used'];
//     saving = json['saving'];
//     priority = json['priority'];
//     discountPercentage = json['discount_percentage'];
//     totalUsed = json['total_used'];
//     enablePromotionCode = json['enable_promotion_code'];
//     unifiedPromotionCode = json['unified_promotion_code'];
//     promotionCode = json['promotion_code'];
//     active = json['active'];
//     featured = json['featured'];
//     mostPopular = json['most_popular'];
//     bestDeals = json['best_deals'];
//     enableGeneralTerms = json['enable_general_terms'];
//     enableFlashDeal = json['enable_flash_deal'];
//     flashDealStartDate = json['flash_deal_start_date'];
//     flashDealEndDate = json['flash_deal_end_date'];
//     slug = json['slug'];
//     createdBy = json['created_by'];
//     updatedBy = json['updated_by'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     price = json['price'];
//     validTo = json['valid_to'];
//     imageFull = json['image_full'];
//     if (json.containsKey("provider") && json['provider'] != null) {
//       simpleProvider = SimpleProvider.fromJson(json['provider']);
//     }
//   }

//   Map<String, dynamic> _toMap() {
//     return {
//       'name_ar': nameAr,
//       'name_en': nameEn,
//       'brief_ar': briefAr,
//       'brief_en': briefEn,
//       'terms_ar': termsAr,
//       'terms_en': termsEn
//     };
//   }

//   dynamic getPropertyEffectedByLang(String propertyName) {
//     var _mapRep = _toMap();
//     if (_mapRep.containsKey(propertyName)) {
//       return _mapRep[propertyName];
//     }
//     throw ArgumentError('propery not found');
//   }
// }

///////
class SimpleOffer {
  int? id;
  String? nameEn;
  String? nameAr;
  String? image;
  int? providerId;
  String? slug;
  String? points;
  String? validTo;
  String? imageFull;

  SimpleProvider? simpleProvider;

  SimpleOffer(
      {this.id,
      this.nameEn,
      this.nameAr,
      this.image,
      this.providerId,
      this.slug,
      this.points,
      this.validTo,
      this.simpleProvider,
      this.imageFull});

  SimpleOffer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    image = json['image'];
    providerId = json['provider_id'];
    slug = json['slug'];
    points = json['points'];
    validTo = json['valid_to'];
    imageFull = json['image_full'];

    if (json.containsKey("provider") && json['provider'] != null) {
      simpleProvider = SimpleProvider.fromJson(json['provider']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['image'] = this.image;
    data['provider_id'] = this.providerId;
    data['slug'] = this.slug;
    data['points'] = this.points;
    data['valid_to'] = this.validTo;
    data['image_full'] = this.imageFull;
    return data;
  }

  Map<String, dynamic> _toMap() {
    return {
      'name_ar': nameAr,
      'name_en': nameEn,
    };
  }

  dynamic getPropertyEffectedByLang(String propertyName) {
    var _mapRep = _toMap();
    if (_mapRep.containsKey(propertyName)) {
      return _mapRep[propertyName];
    }
    throw ArgumentError('propery not found');
  }
}

class CouponData {
  DetailCoupon? detailCoupon;
  List<SimpleCoupon>? listMoreDeals;
  List<SimpleCoupon>? listSimilarDeal;
  CouponData({
    this.detailCoupon,
    this.listMoreDeals,
    this.listSimilarDeal,
  });
  CouponData.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("coupon") && json['coupon'] != null) {
      detailCoupon = DetailCoupon.fromJson(json['coupon']);
    }

    if (json.containsKey("more_deals_by_same_merchant") &&
        json['more_deals_by_same_merchant'] != null) {
      var _list_moredeals = json['more_deals_by_same_merchant'] as List;
      List<SimpleCoupon> _listmoredeals =
          _list_moredeals.map((i) => SimpleCoupon.fromJson(i)).toList();
      listMoreDeals = _listmoredeals;
    }
    if (json.containsKey("similar_deals") && json['similar_deals'] != null) {
      var _list_similardeals = json['similar_deals'] as List;
      List<SimpleCoupon> _listsimilardeals =
          _list_similardeals.map((i) => SimpleCoupon.fromJson(i)).toList();
      listSimilarDeal = _listsimilardeals;
    }
  }
}

////////////
class DetailCoupon {
  int? id;
  String? nameEn;
  String? nameAr;
  String? briefEn;
  String? briefAr;
  String? termsAr;
  String? termsEn;
  String? image;
  String? priceBeforeDiscount;
  int? providerId;
  String? slug;
  String? price;
  String? pointPrice;
  String? earnedPoints;
  String? validTo;
  String? avgRating;
  int? countRating;
  String? imageFull;
  String? shareLink;
  String? flashDealEndDate;
  int? enable_flash_deal;

  SimpleProvider? simpleProvider;
  List<CouponPrice>? listcouponprice;

  DetailCoupon(
      {this.id,
      this.nameEn,
      this.nameAr,
      this.briefEn,
      this.briefAr,
      this.termsAr,
      this.termsEn,
      this.image,
      this.priceBeforeDiscount,
      this.providerId,
      this.slug,
      this.price,
      this.pointPrice,
      this.earnedPoints,
      this.validTo,
      this.simpleProvider,
      this.avgRating,
      this.countRating,
      required this.listcouponprice,
      this.flashDealEndDate,
      this.enable_flash_deal,
      this.shareLink,
      this.imageFull});

  DetailCoupon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    briefEn = json['brief_en'];
    briefAr = json['brief_ar'];
    termsAr = json['terms_ar'];
    termsEn = json['terms_en'];
    image = json['image'];
    priceBeforeDiscount = json['price_before_discount'];
    providerId = json['provider_id'];
    slug = json['slug'];
    price = json['price'];
    pointPrice = json['point_price'];
    earnedPoints = json['earned_points'];
    validTo = json['valid_to'];
    imageFull = json['image_full'];
    shareLink = json['share_link'];
    avgRating = json['avg_rating'];
    countRating = json['count_rating'];
    flashDealEndDate = json['flash_deal_end_date'];
    enable_flash_deal = json['enable_flash_deal'];
    if (json.containsKey("provider") && json['provider'] != null) {
      simpleProvider = SimpleProvider.fromJson(json['provider']);
    }
    if (json.containsKey("flash_deal_end_date") &&
        json['flash_deal_end_date'] == null) {
      flashDealEndDate = "0000-00-00 00:00:00";
    }

    if (json.containsKey("prices") && json['prices'] != null) {
      var _list_couponPrice = json['prices'] as List;
      List<CouponPrice> _listcouponprice =
          _list_couponPrice.map((i) => CouponPrice.fromJson(i)).toList();
      listcouponprice = _listcouponprice;
    }
    if (json.containsKey("avg_rating") && json['avg_rating'] == null) {
      avgRating = "0";
    }
    if (json.containsKey("count_rating") && json['count_rating'] == null) {
      countRating = 0;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['brief_en'] = this.briefEn;
    data['brief_ar'] = this.briefAr;
    data['terms_ar'] = this.termsAr;
    data['terms_en'] = this.termsEn;
    data['image'] = this.image;
    data['price_before_discount'] = this.priceBeforeDiscount;
    data['provider_id'] = this.providerId;
    data['slug'] = this.slug;
    data['price'] = this.price;
    data['point_price'] = this.pointPrice;
    data['earned_points'] = this.earnedPoints;
    data['valid_to'] = this.validTo;
    data['image_full'] = this.imageFull;
    return data;
  }

  Map<String, dynamic> _toMap() {
    return {
      'name_ar': nameAr,
      'name_en': nameEn,
      'brief_en': briefEn,
      'brief_ar': briefAr,
      'terms_ar': termsAr,
      'terms_en': termsEn,
    };
  }

  dynamic getPropertyEffectedByLang(String propertyName) {
    var _mapRep = _toMap();
    if (_mapRep.containsKey(propertyName)) {
      return _mapRep[propertyName];
    }
    throw ArgumentError('propery not found');
  }
}

////////////////////////
class CouponPrice {
  int? id;
  int? couponId;
  int? subscriptionPackageId;
  String? price;
  String? pointPrice;
  String? earnedPoints;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  SubscriptionPackage? subscriptionPackage;

  CouponPrice(
      {this.id,
      this.couponId,
      this.subscriptionPackageId,
      this.price,
      this.pointPrice,
      this.earnedPoints,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.subscriptionPackage,
      this.updatedAt});

  CouponPrice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    couponId = json['coupon_id'];
    subscriptionPackageId = json['subscription_package_id'];
    price = json['price'];
    pointPrice = json['point_price'];
    earnedPoints = json['earned_points'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json.containsKey("subscription_package") &&
        json['subscription_package'] != null) {
      subscriptionPackage =
          SubscriptionPackage.fromJson(json['subscription_package']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['coupon_id'] = this.couponId;
    data['subscription_package_id'] = this.subscriptionPackageId;
    data['price'] = this.price;
    data['point_price'] = this.pointPrice;
    data['earned_points'] = this.earnedPoints;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

////////////////
class SubscriptionPackage {
  int? id;
  String? packageNameAr;
  String? packageNameEn;
  String? price;
  String? pointPrice;
  String? expiryType;
  int? expiryValue;
  int? level;
  String? color;
  List<String>? listFeatured = [];

  SubscriptionPackage(
      {this.id,
      this.packageNameAr,
      this.packageNameEn,
      this.price,
      this.pointPrice,
      this.expiryType,
      this.expiryValue,
      this.level,
      this.listFeatured,
      this.color});

  SubscriptionPackage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    packageNameAr = json['package_name_ar'];
    packageNameEn = json['package_name_en'];
    price = json['price'];
    pointPrice = json['point_price'];
    expiryType = json['expiry_type'];
    expiryValue = json['expiry_value'];
    level = json['level'];
    color = json['color'];
    if (json.containsKey("featured") && json['featured'] != null) {
      var _list_featured = json['featured'] as List;
      // List<String> _listofferprice =
      //     _list_featured.map((i) => OfferPrice.fromJson(i)).toList();
      listFeatured = _list_featured.cast<String>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['package_name_ar'] = this.packageNameAr;
    data['package_name_en'] = this.packageNameEn;
    data['price'] = this.price;
    data['point_price'] = this.pointPrice;
    data['expiry_type'] = this.expiryType;
    data['expiry_value'] = this.expiryValue;
    data['level'] = this.level;
    data['color'] = this.color;
    return data;
  }

  Map<String, dynamic> _toMap() {
    return {
      'package_name_ar': packageNameAr,
      'package_name_en': packageNameEn,
    };
  }

  dynamic getPropertyEffectedByLang(String propertyName) {
    var _mapRep = _toMap();
    if (_mapRep.containsKey(propertyName)) {
      return _mapRep[propertyName];
    }
    throw ArgumentError('propery not found');
  }
}

////////////////
class ProviderBranch {
  int? id;
  int? providerId;
  String? nameEn;
  String? nameAr;
  String? locationAr;
  String? locationEn;
  String? phone;
  // String? urlMap;
  // String? descriptionAr;
  // String? descriptionEn;
  String? longtude;
  String? lattitude;

  ProviderBranch(
      {this.id,
      this.providerId,
      this.nameEn,
      this.nameAr,
      this.locationAr,
      this.locationEn,
      this.phone,
      // this.urlMap,
      // this.descriptionAr,
      // this.descriptionEn,
      this.longtude,
      this.lattitude});

  ProviderBranch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerId = json['provider_id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    locationAr = json['location_ar'];
    locationEn = json['location_en'];
    phone = json['phone'];
    // urlMap = json['url_map'];
    // descriptionAr = json['description_ar'];
    // descriptionEn = json['description_en'];
    longtude = json['longtude'];
    lattitude = json['lattitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['provider_id'] = this.providerId;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['location_ar'] = this.locationAr;
    data['location_en'] = this.locationEn;
    data['phone'] = this.phone;
    // data['url_map'] = this.urlMap;
    // data['description_ar'] = this.descriptionAr;
    // data['description_en'] = this.descriptionEn;
    data['longtude'] = this.longtude;
    data['lattitude'] = this.lattitude;
    return data;
  }

  Map<String, dynamic> _toMap() {
    return {
      'name_en': nameEn,
      'name_ar': nameAr,
      'location_en': locationEn,
      'location_ar': locationAr,
      // 'description_en': descriptionEn,
      // 'description_ar': descriptionAr,
    };
  }

  dynamic getPropertyEffectedByLang(String propertyName) {
    var _mapRep = _toMap();
    if (_mapRep.containsKey(propertyName)) {
      return _mapRep[propertyName];
    }
    throw ArgumentError('propery not found');
  }
}

class OfferDetail {
  int? id;
  String? nameEn;
  String? nameAr;
  String? briefEn;
  String? briefAr;
  String? termsAr;
  String? termsEn;
  String? image;
  int? providerId;
  String? slug;
  String? points;
  String? validTo;
  String? imageFull;
  String? shareLink;
  String? avgRating;
  int? countRating;
  SimpleProvider? simpleProvider;
  List<OfferPrice>? listOfferPrice;
  String? qrcode = "";
  int? balance = 0;

  OfferDetail(
      {this.id,
      this.nameEn,
      this.nameAr,
      this.briefEn,
      this.briefAr,
      this.termsAr,
      this.termsEn,
      this.image,
      this.providerId,
      this.slug,
      this.points,
      this.validTo,
      this.avgRating,
      this.countRating,
      this.simpleProvider,
      required this.listOfferPrice,
      this.shareLink,
      this.imageFull,
      this.qrcode,
      this.balance});

  OfferDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    briefEn = json['brief_en'];
    briefAr = json['brief_ar'];
    termsAr = json['terms_ar'];
    termsEn = json['terms_en'];
    image = json['image'];
    providerId = json['provider_id'];
    slug = json['slug'];
    points = json['points'];
    validTo = json['valid_to'];
    imageFull = json['image_full'];
    shareLink = json['share_link'];
    avgRating = json['avg_rating'];
    countRating = json['count_rating'];
    if (json.containsKey("provider") && json['provider'] != null) {
      simpleProvider = SimpleProvider.fromJson(json['provider']);
    }
    if (json.containsKey("prices") && json['prices'] != null) {
      var _list_offerPrice = json['prices'] as List;
      List<OfferPrice> _listofferprice =
          _list_offerPrice.map((i) => OfferPrice.fromJson(i)).toList();
      listOfferPrice = _listofferprice;
    }
    if (json.containsKey("avg_rating") && json['avg_rating'] == null) {
      avgRating = "0";
    }
    if (json.containsKey("count_rating") && json['count_rating'] == null) {
      countRating = 0;
    }
    if (json.containsKey('qrcode') && json['qrcode'] != null) {
      qrcode = json['qrcode'];
    } else {
      qrcode = "";
    }

    if (json.containsKey('balance') && json['balance'] != null) {
      balance = json['balance'];
    } else {
      balance = 0;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['brief_en'] = this.briefEn;
    data['brief_ar'] = this.briefAr;
    data['terms_ar'] = this.termsAr;
    data['terms_en'] = this.termsEn;
    data['image'] = this.image;
    data['provider_id'] = this.providerId;
    data['slug'] = this.slug;
    data['points'] = this.points;
    data['valid_to'] = this.validTo;
    data['image_full'] = this.imageFull;
    data['qrcode'] = this.qrcode;
    return data;
  }

  Map<String, dynamic> _toMap() {
    return {
      'name_ar': nameAr,
      'name_en': nameEn,
      'brief_en': briefEn,
      'brief_ar': briefAr,
      'terms_ar': termsAr,
      'terms_en': termsEn,
    };
  }

  dynamic getPropertyEffectedByLang(String propertyName) {
    var _mapRep = _toMap();
    if (_mapRep.containsKey(propertyName)) {
      return _mapRep[propertyName];
    }
    throw ArgumentError('propery not found');
  }
}

class OfferPrice {
  int? id;
  int? specialOfferId;
  int? subscriptionPackageId;
  String? points;
  SubscriptionPackage? subscriptionPackage;

  OfferPrice(
      {this.id,
      this.specialOfferId,
      this.subscriptionPackageId,
      this.points,
      this.subscriptionPackage});

  OfferPrice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    specialOfferId = json['special_offer_id'];
    subscriptionPackageId = json['subscription_package_id'];
    points = json['points'];
    if (json.containsKey("subscription_package") &&
        json['subscription_package'] != null) {
      subscriptionPackage =
          SubscriptionPackage.fromJson(json['subscription_package']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['special_offer_id'] = this.specialOfferId;
    data['subscription_package_id'] = this.subscriptionPackageId;
    data['points'] = this.points;
    return data;
  }
}
///////////////

class MoreDeals {
  int? id;
  String? nameEn;
  String? nameAr;
  String? image;
  String? priceBeforeDiscount;
  int? providerId;
  String? slug;
  String? price;
  String? pointPrice;
  String? earnedPoints;
  String? validTo;
  SimpleProvider? simpleProvider;
  String? imageFull;

  MoreDeals(
      {this.id,
      this.nameEn,
      this.nameAr,
      this.image,
      this.priceBeforeDiscount,
      this.providerId,
      this.slug,
      this.price,
      this.pointPrice,
      this.earnedPoints,
      this.validTo,
      this.simpleProvider,
      this.imageFull});

  MoreDeals.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    image = json['image'];
    priceBeforeDiscount = json['price_before_discount'];
    providerId = json['provider_id'];
    slug = json['slug'];
    price = json['price'];
    pointPrice = json['point_price'];
    earnedPoints = json['earned_points'];
    validTo = json['valid_to'];
    imageFull = json['image_full'];
    if (json.containsKey("provider") && json['provider'] != null) {
      simpleProvider = SimpleProvider.fromJson(json['provider']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['image'] = this.image;
    data['price_before_discount'] = this.priceBeforeDiscount;
    data['provider_id'] = this.providerId;
    data['slug'] = this.slug;
    data['price'] = this.price;
    data['point_price'] = this.pointPrice;
    data['earned_points'] = this.earnedPoints;
    data['valid_to'] = this.validTo;
    data['image_full'] = this.imageFull;
    return data;
  }

  Map<String, dynamic> _toMap() {
    return {
      'name_ar': nameAr,
      'name_en': nameEn,
    };
  }

  dynamic getPropertyEffectedByLang(String propertyName) {
    var _mapRep = _toMap();
    if (_mapRep.containsKey(propertyName)) {
      return _mapRep[propertyName];
    }
    throw ArgumentError('propery not found');
  }
}

///////////////
class SimilarDeals {
  int? id;
  String? nameEn;
  String? nameAr;
  String? image;
  String? priceBeforeDiscount;
  int? providerId;
  String? slug;
  String? price;
  String? pointPrice;
  String? earnedPoints;
  String? validTo;
  String? imageFull;
  SimpleProvider? simpleProvider;

  SimilarDeals(
      {this.id,
      this.nameEn,
      this.nameAr,
      this.image,
      this.priceBeforeDiscount,
      this.providerId,
      this.slug,
      this.price,
      this.pointPrice,
      this.earnedPoints,
      this.validTo,
      this.simpleProvider,
      this.imageFull});

  SimilarDeals.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    image = json['image'];
    priceBeforeDiscount = json['price_before_discount'];
    providerId = json['provider_id'];
    slug = json['slug'];
    price = json['price'];
    pointPrice = json['point_price'];
    earnedPoints = json['earned_points'];
    validTo = json['valid_to'];
    imageFull = json['image_full'];
    if (json.containsKey("provider") && json['provider'] != null) {
      simpleProvider = SimpleProvider.fromJson(json['provider']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['image'] = this.image;
    data['price_before_discount'] = this.priceBeforeDiscount;
    data['provider_id'] = this.providerId;
    data['slug'] = this.slug;
    data['price'] = this.price;
    data['point_price'] = this.pointPrice;
    data['earned_points'] = this.earnedPoints;
    data['valid_to'] = this.validTo;
    data['image_full'] = this.imageFull;
    return data;
  }

  Map<String, dynamic> _toMap() {
    return {
      'name_ar': nameAr,
      'name_en': nameEn,
    };
  }

  dynamic getPropertyEffectedByLang(String propertyName) {
    var _mapRep = _toMap();
    if (_mapRep.containsKey(propertyName)) {
      return _mapRep[propertyName];
    }
    throw ArgumentError('propery not found');
  }
}

//////////////
class MoreDealsOffer {
  int? id;
  String? nameEn;
  String? nameAr;
  String? image;
  int? providerId;
  String? slug;
  String? points;
  String? validTo;
  String? imageFull;
  SimpleProvider? simpleProvider;

  MoreDealsOffer(
      {this.id,
      this.nameEn,
      this.nameAr,
      this.image,
      this.providerId,
      this.slug,
      this.points,
      this.validTo,
      this.simpleProvider,
      this.imageFull});

  MoreDealsOffer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    image = json['image'];
    providerId = json['provider_id'];
    slug = json['slug'];
    points = json['points'];
    validTo = json['valid_to'];
    imageFull = json['image_full'];
    if (json.containsKey("provider") && json['provider'] != null) {
      simpleProvider = SimpleProvider.fromJson(json['provider']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['image'] = this.image;
    data['provider_id'] = this.providerId;
    data['slug'] = this.slug;
    data['points'] = this.points;
    data['valid_to'] = this.validTo;
    data['image_full'] = this.imageFull;
    return data;
  }

  Map<String, dynamic> _toMap() {
    return {
      'name_ar': nameAr,
      'name_en': nameEn,
    };
  }

  dynamic getPropertyEffectedByLang(String propertyName) {
    var _mapRep = _toMap();
    if (_mapRep.containsKey(propertyName)) {
      return _mapRep[propertyName];
    }
    throw ArgumentError('propery not found');
  }
}

//////////////
class SimilarDealsOffer {
  int? id;
  String? nameEn;
  String? nameAr;
  String? image;
  int? providerId;
  String? slug;
  String? points;
  String? validTo;
  String? imageFull;
  SimpleProvider? simpleProvider;

  SimilarDealsOffer(
      {this.id,
      this.nameEn,
      this.nameAr,
      this.image,
      this.providerId,
      this.slug,
      this.points,
      this.validTo,
      this.simpleProvider,
      this.imageFull});

  SimilarDealsOffer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    image = json['image'];
    providerId = json['provider_id'];
    slug = json['slug'];
    points = json['points'];
    validTo = json['valid_to'];
    imageFull = json['image_full'];
    if (json.containsKey("provider") && json['provider'] != null) {
      simpleProvider = SimpleProvider.fromJson(json['provider']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['image'] = this.image;
    data['provider_id'] = this.providerId;
    data['slug'] = this.slug;
    data['points'] = this.points;
    data['valid_to'] = this.validTo;
    data['image_full'] = this.imageFull;
    return data;
  }

  Map<String, dynamic> _toMap() {
    return {
      'name_ar': nameAr,
      'name_en': nameEn,
    };
  }

  dynamic getPropertyEffectedByLang(String propertyName) {
    var _mapRep = _toMap();
    if (_mapRep.containsKey(propertyName)) {
      return _mapRep[propertyName];
    }
    throw ArgumentError('propery not found');
  }
}

class OfferData {
  OfferDetail? offerDetail;
  List<SimpleOffer>? listMoredealsOffer;
  List<SimpleOffer>? listsimilarDealsOffer;
  OfferData(
      {this.listMoredealsOffer, this.offerDetail, this.listsimilarDealsOffer});
  OfferData.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("special_offer") && json['special_offer'] != null) {
      offerDetail = OfferDetail.fromJson(json['special_offer']);
    }

    if (json.containsKey("more_deals_by_same_merchant") &&
        json['more_deals_by_same_merchant'] != null) {
      var _list_moredealsOffer = json['more_deals_by_same_merchant'] as List;
      List<SimpleOffer> _listmoredealsOffer =
          _list_moredealsOffer.map((i) => SimpleOffer.fromJson(i)).toList();
      listMoredealsOffer = _listmoredealsOffer;
    }
    if (json.containsKey("similar_deals") && json['similar_deals'] != null) {
      var _list_similardealsOffer = json['similar_deals'] as List;
      List<SimpleOffer> _listsimilardealsOffer =
          _list_similardealsOffer.map((i) => SimpleOffer.fromJson(i)).toList();
      listsimilarDealsOffer = _listsimilardealsOffer;
    }
  }
}

///////////////
class ProviderDetail {
  int? id;
  String? nameEn;
  String? nameAr;
  String? overviewEn;
  String? overviewAr;
  String? phone;
  String? email;
  String? facebook;
  String? twitter;
  String? linkedIn;
  String? instagram;
  String? snapchat;
  String? tiktok;
  String? website;
  int? providerCategoryId;
  String? logo;
  String? facebookName;
  String? twitterName;
  String? linkedInName;
  String? snapchatName;
  String? instagramName;
  String? tiktokName;
  String? avgRating;
  String? shareLink;
  int? countRating;
  List<SimpleCoupon>? listSimpleCoupons;
  List<SimpleOffer>? listSimpleOffers;
  List<String>? imagesList;
  List<ProviderBranch>? listBranch;
  Category? category;

  ProviderDetail(
      {this.id,
      this.nameEn,
      this.nameAr,
      this.overviewEn,
      this.overviewAr,
      this.phone,
      this.email,
      this.facebook,
      this.twitter,
      this.linkedIn,
      this.instagram,
      this.snapchat,
      this.tiktok,
      this.website,
      this.providerCategoryId,
      this.logo,
      this.facebookName,
      this.twitterName,
      this.linkedInName,
      this.snapchatName,
      this.instagramName,
      this.avgRating,
      this.countRating,
      this.listSimpleCoupons,
      this.listSimpleOffers,
      this.imagesList,
      this.listBranch,
      this.category,
      this.shareLink,
      this.tiktokName});

  ProviderDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    overviewEn = json['overview_en'];
    overviewAr = json['overview_ar'];
    phone = json['phone'];
    email = json['email'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    linkedIn = json['linked_in'];
    instagram = json['instagram'];
    snapchat = json['snapchat'];
    tiktok = json['tiktok'];
    website = json['website'];
    shareLink = json['share_link'];
    providerCategoryId = json['provider_category_id'];
    logo = json['logo'];
    facebookName = json['facebook_name'];
    twitterName = json['twitter_name'];
    linkedInName = json['linked_in_name'];
    snapchatName = json['snapchat_name'];
    instagramName = json['instagram_name'];
    tiktokName = json['tiktok_name'];
    avgRating = json['avg_rating'];
    countRating = json['count_rating'];
    if (json.containsKey("coupons") && json['coupons'] != null) {
      var _list_simpleCoupons = json['coupons'] as List;
      List<SimpleCoupon> _listSimpleCoupon =
          _list_simpleCoupons.map((i) => SimpleCoupon.fromJson(i)).toList();
      listSimpleCoupons = _listSimpleCoupon;
    }
    if (json.containsKey("special_offers") && json['special_offers'] != null) {
      var _list_simpleOffer = json['special_offers'] as List;
      List<SimpleOffer> _listSimpleOffer =
          _list_simpleOffer.map((i) => SimpleOffer.fromJson(i)).toList();
      listSimpleOffers = _listSimpleOffer;
    }
    if (json.containsKey("branches") && json['branches'] != null) {
      var _list_branches = json['branches'] as List;
      List<ProviderBranch> _listbranches =
          _list_branches.map((i) => ProviderBranch.fromJson(i)).toList();
      listBranch = _listbranches;
    }
    if (json.containsKey("category") && json['category'] != null) {
      category = Category.fromJson(json['category']);
    }
    if (json.containsKey("images") && json['images'] != null) {
      var _list_images = json['images'] as List;
      // List<SimpleOffer> _listSimpleOffer=
      //     _list_images.map((i) => SimpleOffer.fromJson(i)).toList();
      imagesList = _list_images.cast<String>();
    }
    if (json.containsKey("avg_rating") && json['avg_rating'] == null) {
      avgRating = "0";
    }
    if (json.containsKey("count_rating") && json['count_rating'] == null) {
      countRating = 0;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['overview_en'] = this.overviewEn;
    data['overview_ar'] = this.overviewAr;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['facebook'] = this.facebook;
    data['twitter'] = this.twitter;
    data['linked_in'] = this.linkedIn;
    data['instagram'] = this.instagram;
    data['snapchat'] = this.snapchat;
    data['tiktok'] = this.tiktok;
    data['website'] = this.website;
    data['provider_category_id'] = this.providerCategoryId;
    data['logo'] = this.logo;
    data['facebook_name'] = this.facebookName;
    data['twitter_name'] = this.twitterName;
    data['linked_in_name'] = this.linkedInName;
    data['snapchat_name'] = this.snapchatName;
    data['instagram_name'] = this.instagramName;
    data['tiktok_name'] = this.tiktokName;
    return data;
  }

  Map<String, dynamic> _toMap() {
    return {
      'name_ar': nameAr,
      'name_en': nameEn,
      'overview_en': overviewEn,
      'overview_ar': overviewAr,
    };
  }

  dynamic getPropertyEffectedByLang(String propertyName) {
    var _mapRep = _toMap();
    if (_mapRep.containsKey(propertyName)) {
      return _mapRep[propertyName];
    }
    throw ArgumentError('propery not found');
  }
}

//////////////
class Banners {
  int? id;
  String? photo;
  String? mobilePhoto;

  Banners({this.id, this.photo, this.mobilePhoto});

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photo = json['photo'];
    mobilePhoto = json['mobile_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['photo'] = this.photo;
    data['mobile_photo'] = this.mobilePhoto;
    return data;
  }
}

class HomeData {
  List<Banners>? listBanners;
  List<SimpleCoupon>? listBestcoupon;
  List<SimpleOffer>? listBestoffer;
  List<SimpleProvider>? listBestprovider;
  List<FlashDeal>? listFlashDeal;
  List<Category>? listCategory;
  List<HomeSection>? listSections;
  List<SubscriptionPackage>? packages;
  int? balance;
  int? goal_points;
  HomeData({
    this.listBanners,
    this.listBestcoupon,
    this.listBestoffer,
    this.listFlashDeal,
    this.listCategory,
    this.listSections,
    this.listBestprovider,
    this.packages,
    this.balance,
    this.goal_points,
  });

  HomeData.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("banners") && json['banners'] != null) {
      var _list_banners = json['banners'] as List;
      List<Banners> _listbanners =
          _list_banners.map((i) => Banners.fromJson(i)).toList();
      listBanners = _listbanners;
    }
    if (json.containsKey("best_coupons") && json['best_coupons'] != null) {
      var _list_bestcoupon = json['best_coupons'] as List;
      List<SimpleCoupon> _listbestCoupon =
          _list_bestcoupon.map((i) => SimpleCoupon.fromJson(i)).toList();
      listBestcoupon = _listbestCoupon;
    }
    if (json.containsKey("best_offers") && json['best_offers'] != null) {
      var _list_bestOffer = json['best_offers'] as List;
      List<SimpleOffer> _listsbestOffer =
          _list_bestOffer.map((i) => SimpleOffer.fromJson(i)).toList();
      listBestoffer = _listsbestOffer;
    }
    if (json.containsKey("best_providers") && json['best_providers'] != null) {
      var _list_bestProvider = json['best_providers'] as List;
      List<SimpleProvider> _listsbestProvider =
          _list_bestProvider.map((i) => SimpleProvider.fromJson(i)).toList();
      listBestprovider = _listsbestProvider;
    }
    if (json.containsKey("flash_deals") && json['flash_deals'] != null) {
      var _list_flashdeal = json['flash_deals'] as List;
      List<FlashDeal> _listflashdeal =
          _list_flashdeal.map((i) => FlashDeal.fromJson(i)).toList();
      listFlashDeal = _listflashdeal;
    }
    if (json.containsKey("categories") && json['categories'] != null) {
      var _list_category = json['categories'] as List;
      List<Category> _listcategory =
          _list_category.map((i) => Category.fromJson(i)).toList();
      listCategory = _listcategory;
    }
    if (json.containsKey("sections") && json['sections'] != null) {
      var _list_sections = json['sections'] as List;
      List<HomeSection> _listsections =
          _list_sections.map((i) => HomeSection.fromJson(i)).toList();
      listSections = _listsections;
    }

    if (json.containsKey("packages") && json['packages'] != null) {
      var _list_packages = json['packages'] as List;
      List<SubscriptionPackage> _packages =
          _list_packages.map((i) => SubscriptionPackage.fromJson(i)).toList();
      packages = _packages;
    }
    balance = json['balance'] ?? 0;
    goal_points = json['goal_points'] ?? 0;
  }
}

/////
class HomeSection {
  int? id;
  String? nameEn;
  String? nameAr;
  String? type;
  List<SimpleCoupon>? listsimpleCoupon;
  List<SimpleOffer>? listsimpleOffer;

  HomeSection(
      {this.id,
      this.nameEn,
      this.nameAr,
      this.type,
      this.listsimpleCoupon,
      this.listsimpleOffer});

  HomeSection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    type = json['type'];
    if (json.containsKey("coupons") && json['coupons'] != null) {
      var _list_coupons = json['coupons'] as List;
      List<SimpleCoupon> _listcoupons =
          _list_coupons.map((i) => SimpleCoupon.fromJson(i)).toList();
      listsimpleCoupon = _listcoupons;
    }
    if (json.containsKey("special_offers") && json['special_offers'] != null) {
      var _list_offers = json['special_offers'] as List;
      List<SimpleOffer> _listoffers =
          _list_offers.map((i) => SimpleOffer.fromJson(i)).toList();
      listsimpleOffer = _listoffers;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['type'] = this.type;
    return data;
  }

  Map<String, dynamic> _toMap() {
    return {
      'name_ar': nameAr,
      'name_en': nameEn,
    };
  }

  dynamic getPropertyEffectedByLang(String propertyName) {
    var _mapRep = _toMap();
    if (_mapRep.containsKey(propertyName)) {
      return _mapRep[propertyName];
    }
    throw ArgumentError('propery not found');
  }
}

class CategorySection {
  int? id;
  String? nameEn;
  String? nameAr;
  String? type;
  List<SimpleCoupon>? listsimpleCoupon;
  List<SimpleOffer>? listsimpleOffer;

  CategorySection(
      {this.id,
      this.nameEn,
      this.nameAr,
      this.type,
      this.listsimpleCoupon,
      this.listsimpleOffer});

  CategorySection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    type = json['type'];
    if (json.containsKey("coupons") && json['coupons'] != null) {
      var _list_coupons = json['coupons'] as List;
      List<SimpleCoupon> _listcoupons =
          _list_coupons.map((i) => SimpleCoupon.fromJson(i)).toList();
      listsimpleCoupon = _listcoupons;
    }
    if (json.containsKey("special_offers") && json['special_offers'] != null) {
      var _list_offers = json['special_offers'] as List;
      List<SimpleOffer> _listoffers =
          _list_offers.map((i) => SimpleOffer.fromJson(i)).toList();
      listsimpleOffer = _listoffers;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['type'] = this.type;
    return data;
  }

  Map<String, dynamic> _toMap() {
    return {
      'name_ar': nameAr,
      'name_en': nameEn,
    };
  }

  dynamic getPropertyEffectedByLang(String propertyName) {
    var _mapRep = _toMap();
    if (_mapRep.containsKey(propertyName)) {
      return _mapRep[propertyName];
    }
    throw ArgumentError('propery not found');
  }
}

/////
class LoginData {
  int? userId;
  String? token;
  String? userType;
  User? user;
  Customer? customer;

  LoginData({this.userId, this.token, this.userType, this.user, this.customer});

  LoginData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    token = json['token'];
    userType = json['user_type'];
    if (json.containsKey("user") && json['user'] != null) {
      user = User.fromJson(json['user']);
    }
    if (json.containsKey("customer") && json['customer'] != null) {
      customer = Customer.fromJson(json['customer']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['token'] = this.token;
    data['user_type'] = this.userType;
    return data;
  }
}

class SignupData {
  int? userId;
  String? token;
  String? userType;
  User? user;
  Customer? customer;

  SignupData(
      {this.userId, this.token, this.userType, this.user, this.customer});

  SignupData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    token = json['token'];
    userType = json['user_type'];
    if (json.containsKey("user") && json['user'] != null) {
      user = User.fromJson(json['user']);
    }
    if (json.containsKey("customer") && json['customer'] != null) {
      customer = Customer.fromJson(json['customer']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['token'] = this.token;
    data['user_type'] = this.userType;
    return data;
  }
}

class updateProfileData {
  int? userId;

  User? user;
  Customer? customer;

  updateProfileData({this.userId, this.user, this.customer});

  updateProfileData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];

    if (json.containsKey("user") && json['user'] != null) {
      user = User.fromJson(json['user']);
    }
    if (json.containsKey("customer") && json['customer'] != null) {
      customer = Customer.fromJson(json['customer']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;

    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? emailVerifiedAt;
  int? active;
  String? memberType;
  int? memberId;
  String? firebaseMessagingLocale;
  String? firebaseMessagingToken;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.name,
      this.email,
      this.mobile,
      this.emailVerifiedAt,
      this.active,
      this.memberType,
      this.memberId,
      this.firebaseMessagingLocale,
      this.firebaseMessagingToken,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    emailVerifiedAt = json['email_verified_at'];
    active = json['active'];
    memberType = json['member_type'];
    memberId = json['member_id'];
    firebaseMessagingLocale = json['firebase_messaging_locale'];
    firebaseMessagingToken = json['firebase_messaging_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['active'] = this.active;
    data['member_type'] = this.memberType;
    data['member_id'] = this.memberId;
    data['firebase_messaging_locale'] = this.firebaseMessagingLocale;
    data['firebase_messaging_token'] = this.firebaseMessagingToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

///
class Member {
  int? id;
  String? fullName;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  int? active;
  int? cityId;
  String? code;
  int? verified;
  String? lastLogin;
  int? countSendSms;
  String? lastSendSms;
  int? hasNewCard;
  String? travelAuthCode;
  String? mloginCode;
  String? affiliate;
  String? invitationKey;
  int? invitedByCustomerId;
  String? customerType;
  String? logo;
  String? companyName;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;

  Member(
      {this.id,
      this.fullName,
      this.firstName,
      this.lastName,
      this.email,
      this.mobile,
      this.active,
      this.cityId,
      this.code,
      this.verified,
      this.lastLogin,
      this.countSendSms,
      this.lastSendSms,
      this.hasNewCard,
      this.travelAuthCode,
      this.mloginCode,
      this.affiliate,
      this.invitationKey,
      this.invitedByCustomerId,
      this.customerType,
      this.logo,
      this.companyName,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});

  Member.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    active = json['active'];
    cityId = json['city_id'];
    code = json['code'];
    verified = json['verified'];
    lastLogin = json['last_login'];
    countSendSms = json['count_send_sms'];
    lastSendSms = json['last_send_sms'];
    hasNewCard = json['has_new_card'];
    travelAuthCode = json['travel_auth_code'];
    mloginCode = json['mlogin_code'];
    affiliate = json['affiliate'];
    invitationKey = json['invitation_key'];
    invitedByCustomerId = json['invited_by_customer_id'];
    customerType = json['customer_type'];
    logo = json['logo'];
    companyName = json['company_name'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['active'] = this.active;
    data['city_id'] = this.cityId;
    data['code'] = this.code;
    data['verified'] = this.verified;
    data['last_login'] = this.lastLogin;
    data['count_send_sms'] = this.countSendSms;
    data['last_send_sms'] = this.lastSendSms;
    data['has_new_card'] = this.hasNewCard;
    data['travel_auth_code'] = this.travelAuthCode;
    data['mlogin_code'] = this.mloginCode;
    data['affiliate'] = this.affiliate;
    data['invitation_key'] = this.invitationKey;
    data['invited_by_customer_id'] = this.invitedByCustomerId;
    data['customer_type'] = this.customerType;
    data['logo'] = this.logo;
    data['company_name'] = this.companyName;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

///
class Customer {
  int? id;
  String? fullName;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  int? active;
  int? cityId;
  String? code;
  int? verified;
  String? lastLogin;
  int? countSendSms;
  String? lastSendSms;
  int? hasNewCard;
  String? travelAuthCode;
  String? mloginCode;
  String? affiliate;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;

  Customer(
      {this.id,
      this.fullName,
      this.firstName,
      this.lastName,
      this.email,
      this.mobile,
      this.active,
      this.cityId,
      this.code,
      this.verified,
      this.lastLogin,
      this.countSendSms,
      this.lastSendSms,
      this.hasNewCard,
      this.travelAuthCode,
      this.mloginCode,
      this.affiliate,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    active = json['active'];
    cityId = json['city_id'];
    code = json['code'];
    verified = json['verified'];
    lastLogin = json['last_login'];
    countSendSms = json['count_send_sms'];
    lastSendSms = json['last_send_sms'];
    hasNewCard = json['has_new_card'];
    travelAuthCode = json['travel_auth_code'];
    mloginCode = json['mlogin_code'];
    affiliate = json['affiliate'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['active'] = this.active;
    data['city_id'] = this.cityId;
    data['code'] = this.code;
    data['verified'] = this.verified;
    data['last_login'] = this.lastLogin;
    data['count_send_sms'] = this.countSendSms;
    data['last_send_sms'] = this.lastSendSms;
    data['has_new_card'] = this.hasNewCard;
    data['travel_auth_code'] = this.travelAuthCode;
    data['mlogin_code'] = this.mloginCode;
    data['affiliate'] = this.affiliate;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

//////
class CartData {
  int? countCart;
  Cart? cart;

  CartData({this.countCart, this.cart});

  CartData.fromJson(Map<String, dynamic> json) {
    countCart = json['count_cart'];

    if (json.containsKey("cart") && json['cart'] != null) {
      cart = Cart.fromJson(json['cart']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count_cart'] = this.countCart;
    return data;
  }
}

////////
class Cart {
  double? subTotalAmount;
  double? discountAmount;
  double? total;
  double? subTotalPointsAmount;
  double? discountPointsAmount;
  double? totalPoints;
  String? promoCode;
  String? cartType;
  int? balance;
  bool? enable_pay_with_points;
  int? total_earned_points;
  bool? enable_change_qty;
  bool? enable_remove_item;
  List<CartItem>? listCartItem;
  List<PaymentMethod>? listPaymentMethod;

  Cart(
      {this.subTotalAmount,
      this.discountAmount,
      this.total,
      this.subTotalPointsAmount,
      this.discountPointsAmount,
      this.totalPoints,
      this.promoCode,
      this.listCartItem,
      this.balance,
      this.enable_pay_with_points,
      this.total_earned_points,
      this.enable_change_qty,
      this.enable_remove_item,
      this.cartType});

  Cart.fromJson(Map<String, dynamic> json) {
    subTotalAmount = double.tryParse(json['sub_total_amount'].toString());
    discountAmount = double.tryParse(json['discount_amount'].toString());
    total = double.tryParse(json['total'].toString());
    subTotalPointsAmount =
        double.tryParse(json['sub_total_points_amount'].toString());
    discountPointsAmount =
        double.tryParse(json['discount_points_amount'].toString());
    totalPoints = double.tryParse(json['total_points'].toString());
    promoCode = json['promo_code'];
    cartType = json['cart_type'];
    balance = json['balance'];
    enable_pay_with_points = json['enable_pay_with_points'];
    total_earned_points = json['total_earned_points'];
    enable_change_qty = json['enable_change_qty'];
    enable_remove_item = json['enable_remove_item'];
    if (json.containsKey("items") && json['items'] != null) {
      var _list_cartItems = json['items'] as List;
      List<CartItem> _listCartItem =
          _list_cartItems.map((i) => CartItem.fromJson(i)).toList();
      listCartItem = _listCartItem;
    }
    if (json.containsKey("payment_methods") &&
        json['payment_methods'] != null) {
      var _list_paymentMethod = json['payment_methods'] as List;
      List<PaymentMethod> _listPaymentMethod =
          _list_paymentMethod.map((i) => PaymentMethod.fromJson(i)).toList();
      listPaymentMethod = _listPaymentMethod;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_total_amount'] = this.subTotalAmount;
    data['discount_amount'] = this.discountAmount;
    data['total'] = this.total;
    data['sub_total_points_amount'] = this.subTotalPointsAmount;
    data['discount_points_amount'] = this.discountPointsAmount;
    data['total_points'] = this.totalPoints;
    data['promo_code'] = this.promoCode;
    data['cart_type'] = this.cartType;
    return data;
  }
}

//////////
class PaymentMethod {
  int? id;
  String? key;
  String? nameEn;
  String? nameAr;
  String? briefEn;
  String? briefAr;
  String? logo;

  PaymentMethod(
      {this.id,
      this.key,
      this.nameEn,
      this.nameAr,
      this.briefEn,
      this.briefAr,
      this.logo});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    briefEn = json['brief_en'];
    briefAr = json['brief_ar'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['brief_en'] = this.briefEn;
    data['brief_ar'] = this.briefAr;
    data['logo'] = this.logo;
    return data;
  }

  Map<String, dynamic> _toMap() {
    return {
      'name_ar': nameAr,
      'name_en': nameEn,
      'brief_ar': briefAr,
      'brief_en': briefEn,
    };
  }

  dynamic getPropertyEffectedByLang(String propertyName) {
    var _mapRep = _toMap();
    if (_mapRep.containsKey(propertyName)) {
      return _mapRep[propertyName];
    }
    throw ArgumentError('propery not found');
  }
}

////////
class CartItem {
  int? id;
  int? customerId;
  int? itemId;
  String? itemType;
  int? qty;
  String? createdAt;
  String? updatedAt;
  bool? isCoupon;
  bool? isSubscriptionPackage;
  bool? isPointsPackage;
  SubscriptionPackage? subscriptionPackage;
  PointPackage? pointsPackage;
  double? total;
  double? totalPoints;
  SimpleCoupon? simpleCoupon;

  CartItem(
      {this.id,
      this.customerId,
      this.itemId,
      this.itemType,
      this.qty,
      this.createdAt,
      this.updatedAt,
      this.isCoupon,
      this.isSubscriptionPackage,
      this.isPointsPackage,
      this.subscriptionPackage,
      this.pointsPackage,
      this.total,
      this.simpleCoupon,
      this.totalPoints});

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    itemId = json['item_id'];
    itemType = json['item_type'];
    qty = json['qty'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isCoupon = json['is_coupon'];
    isSubscriptionPackage = json['is_subscription_package'];
    isPointsPackage = json['is_points_package'];
    // subscriptionPackage = json['subscription_package'];
    //pointsPackage = json['points_package'];
    total = double.tryParse(json['total'].toString());
    totalPoints = double.tryParse(json['total_points'].toString());

    if (json.containsKey("coupon") && json['coupon'] != null) {
      simpleCoupon = SimpleCoupon.fromJson(json['coupon']);
    }
    if (json.containsKey("subscription_package") &&
        json['subscription_package'] != null) {
      subscriptionPackage =
          SubscriptionPackage.fromJson(json['subscription_package']);
    }
    if (json.containsKey("points_package") && json['points_package'] != null) {
      pointsPackage = PointPackage.fromJson(json['points_package']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['item_id'] = this.itemId;
    data['item_type'] = this.itemType;
    data['qty'] = this.qty;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_coupon'] = this.isCoupon;
    data['is_subscription_package'] = this.isSubscriptionPackage;
    data['is_points_package'] = this.isPointsPackage;
    data['subscription_package'] = this.subscriptionPackage;
    data['points_package'] = this.pointsPackage;
    data['total'] = this.total;
    data['total_points'] = this.totalPoints;
    return data;
  }
}

/////////////
class PointPackage {
  int? id;
  String? nameEn;
  String? nameAr;
  int? points;
  String? price;
  String? priceAfterDiscount;
  String? percentDiscount;
  int? active;
  int? itemOrder;
  String? createdAt;
  String? updatedAt;

  PointPackage(
      {this.id,
      this.nameEn,
      this.nameAr,
      this.points,
      this.price,
      this.priceAfterDiscount,
      this.percentDiscount,
      this.active,
      this.itemOrder,
      this.createdAt,
      this.updatedAt});

  PointPackage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    points = json['points'];
    price = json['price'];
    // priceAfterDiscount = json['price_after_discount'];
    // percentDiscount = json['percent_discount'];
    active = json['active'];
    itemOrder = json['item_order'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json.containsKey("price_after_discount") &&
        json['price_after_discount'] == null) {
      priceAfterDiscount = "";
    }
    if (json.containsKey("percent_discount") &&
        json['percent_discount'] == null) {
      percentDiscount = "";
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['points'] = this.points;
    data['price'] = this.price;
    data['price_after_discount'] = this.priceAfterDiscount;
    data['percent_discount'] = this.percentDiscount;
    data['active'] = this.active;
    data['item_order'] = this.itemOrder;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  Map<String, dynamic> _toMap() {
    return {
      'name_ar': nameAr,
      'name_en': nameEn,
    };
  }

  dynamic getPropertyEffectedByLang(String propertyName) {
    var _mapRep = _toMap();
    if (_mapRep.containsKey(propertyName)) {
      return _mapRep[propertyName];
    }
    throw ArgumentError('propery not found');
  }
}

////
class DashboardCustomerData {
  int? countAcceptanceInvitations;
  int? countOrders;
  int? balance;
  String? expiryPoints;
  int? remainingSoldCouponsToUpgrade;
  int? soldCouponPercentage;
  int? countSoldCoupons;
  int? countUsedCoupons;
  CurrentPackage? currentPackage;
  List<LastNotification>? listLastNotifications;
  NextPackage? nextPackage;

  DashboardCustomerData(
      {this.countAcceptanceInvitations,
      this.countOrders,
      this.balance,
      this.expiryPoints,
      this.remainingSoldCouponsToUpgrade,
      this.soldCouponPercentage,
      this.countSoldCoupons,
      this.currentPackage,
      this.listLastNotifications,
      this.nextPackage,
      this.countUsedCoupons});

  DashboardCustomerData.fromJson(Map<String, dynamic> json) {
    countAcceptanceInvitations = json['count_acceptance_invitations'];
    countOrders = json['count_orders'];
    balance = json['balance'];
    expiryPoints = json['expiry_points'];
    remainingSoldCouponsToUpgrade = json['remaining_sold_coupons_to_upgrade'];
    soldCouponPercentage = json['sold_coupon_percentage'];
    countSoldCoupons = json['count_sold_coupons'];
    countUsedCoupons = json['count_used_coupons'];
    if (json.containsKey("current_package") &&
        json['current_package'] != null) {
      currentPackage = CurrentPackage.fromJson(json['current_package']);
    }
    if (json.containsKey("next_package") && json['next_package'] != null) {
      nextPackage = NextPackage.fromJson(json['next_package']);
    }
    if (json.containsKey("latest_notifications") &&
        json['latest_notifications'] != null) {
      var _list_lastNotifications = json['latest_notifications'] as List;
      List<LastNotification> _listLastNotifications = _list_lastNotifications
          .map((i) => LastNotification.fromJson(i))
          .toList();
      listLastNotifications = _listLastNotifications;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count_acceptance_invitations'] = this.countAcceptanceInvitations;
    data['count_orders'] = this.countOrders;
    data['balance'] = this.balance;
    data['expiry_points'] = this.expiryPoints;
    data['remaining_sold_coupons_to_upgrade'] =
        this.remainingSoldCouponsToUpgrade;
    data['sold_coupon_percentage'] = this.soldCouponPercentage;
    data['count_sold_coupons'] = this.countSoldCoupons;
    data['count_used_coupons'] = this.countUsedCoupons;
    return data;
  }
}

class CurrentPackage {
  int? id;
  int? customerId;
  int? subscriptionPackageId;
  String? expiryDate;
  int? countSoldCoupons;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? expiryDateFormatted;
  SubscriptionPackage? subscriptionPackage;

  CurrentPackage(
      {this.id,
      this.customerId,
      this.subscriptionPackageId,
      this.expiryDate,
      this.countSoldCoupons,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.subscriptionPackage,
      this.expiryDateFormatted});

  CurrentPackage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    subscriptionPackageId = json['subscription_package_id'];
    expiryDate = json['expiry_date'];
    countSoldCoupons = json['count_sold_coupons'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    expiryDateFormatted = json['expiry_date_formatted'];
    if (json.containsKey("subscription_package") &&
        json['subscription_package'] != null) {
      subscriptionPackage =
          SubscriptionPackage.fromJson(json['subscription_package']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['subscription_package_id'] = this.subscriptionPackageId;
    data['expiry_date'] = this.expiryDate;
    data['count_sold_coupons'] = this.countSoldCoupons;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['expiry_date_formatted'] = this.expiryDateFormatted;
    return data;
  }
}

/////
class LastNotification {
  int? id;
  int? fromUserId;
  int? toUserId;
  String? title;
  String? message;
  String? type;
  int? refId;
  String? updatedAt;
  String? notificationDate;

  LastNotification(
      {this.id,
      this.fromUserId,
      this.toUserId,
      this.title,
      this.message,
      this.type,
      this.refId,
      this.updatedAt,
      this.notificationDate});

  LastNotification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromUserId = json['from_user_id'];
    toUserId = json['to_user_id'];
    title = json['title'];
    message = json['message'];
    type = json['type'];
    refId = json['ref_id'];
    updatedAt = json['updated_at'];
    notificationDate = json['notification_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['from_user_id'] = this.fromUserId;
    data['to_user_id'] = this.toUserId;
    data['title'] = this.title;
    data['message'] = this.message;
    data['type'] = this.type;
    data['ref_id'] = this.refId;
    data['updated_at'] = this.updatedAt;
    data['notification_date'] = this.notificationDate;
    return data;
  }
}

////////////
class NextPackage {
  int? id;
  String? packageNameAr;
  String? packageNameEn;
  String? price;
  String? pointPrice;
  String? expiryType;
  int? expiryValue;
  int? level;
  String? color;
  int? countSoldCouponsToUpgrade;
  String? percentageEarnedFromInvites;
  int? active;
  String? createdBy;
  String? updatedBy;
  String? deletedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  NextPackage(
      {this.id,
      this.packageNameAr,
      this.packageNameEn,
      this.price,
      this.pointPrice,
      this.expiryType,
      this.expiryValue,
      this.level,
      this.color,
      this.countSoldCouponsToUpgrade,
      this.percentageEarnedFromInvites,
      this.active,
      this.createdBy,
      this.updatedBy,
      this.deletedBy,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  NextPackage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    packageNameAr = json['package_name_ar'];
    packageNameEn = json['package_name_en'];
    price = json['price'];
    pointPrice = json['point_price'];
    expiryType = json['expiry_type'];
    expiryValue = json['expiry_value'];
    level = json['level'];
    color = json['color'];
    countSoldCouponsToUpgrade = json['count_sold_coupons_to_upgrade'];
    percentageEarnedFromInvites = json['percentage_earned_from_invites'];
    active = json['active'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'].toString();
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['package_name_ar'] = this.packageNameAr;
    data['package_name_en'] = this.packageNameEn;
    data['price'] = this.price;
    data['point_price'] = this.pointPrice;
    data['expiry_type'] = this.expiryType;
    data['expiry_value'] = this.expiryValue;
    data['level'] = this.level;
    data['color'] = this.color;
    data['count_sold_coupons_to_upgrade'] = this.countSoldCouponsToUpgrade;
    data['percentage_earned_from_invites'] = this.percentageEarnedFromInvites;
    data['active'] = this.active;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['deleted_by'] = this.deletedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

/////
class HistoryPointsData {
  int? balance;
  String? expiryPoints;
  double? pointsAsSar;
  List<HistoryPoint>? listHistoryPoint;

  HistoryPointsData(
      {this.balance,
      this.expiryPoints,
      this.pointsAsSar,
      this.listHistoryPoint});

  HistoryPointsData.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
    expiryPoints = json['expiry_points'];
    pointsAsSar = json['points_as_sar'];
    if (json.containsKey("history_points") && json['history_points'] != null) {
      var _list_HistoryPoints = json['history_points'] as List;
      List<HistoryPoint> _listHistoryPoint =
          _list_HistoryPoints.map((i) => HistoryPoint.fromJson(i)).toList();
      listHistoryPoint = _listHistoryPoint;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['balance'] = this.balance;
    data['expiry_points'] = this.expiryPoints;
    data['points_as_sar'] = this.pointsAsSar;
    return data;
  }
}

////
class HistoryPoint {
  int? id;
  String? date;
  int? amount;
  String? desc;
  String? type;

  HistoryPoint({this.id, this.date, this.amount, this.desc, this.type});

  HistoryPoint.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    amount = json['amount'];
    desc = json['desc'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['amount'] = this.amount;
    data['desc'] = this.desc;
    data['type'] = this.type;
    return data;
  }
}

//////
class SimpleOrder {
  int? id;
  String? orderRef;
  String? orderDate;
  String? orderTypeString;
  String? totalFormatterd;
  String? status;
  int? order_status_id;

  SimpleOrder(
      {this.id,
      this.orderRef,
      this.orderDate,
      this.orderTypeString,
      this.totalFormatterd,
      this.order_status_id,
      this.status});

  SimpleOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderRef = json['order_ref'];
    orderDate = json['order_date'];
    orderTypeString = json['order_type_string'];
    totalFormatterd = json['total_formatterd'];
    status = json['status'];
    order_status_id = json['order_status_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_ref'] = this.orderRef;
    data['order_date'] = this.orderDate;
    data['order_type_string'] = this.orderTypeString;
    data['total_formatterd'] = this.totalFormatterd;
    data['status'] = this.status;
    data['order_status_id'] = this.status;
    return data;
  }
}

/////
class JoinInvitationData {
  int? countAcceptanceInvitations;
  String? invitationLink;
  List<Invitation>? listInvitations;

  JoinInvitationData(
      {this.countAcceptanceInvitations,
      this.invitationLink,
      this.listInvitations});

  JoinInvitationData.fromJson(Map<String, dynamic> json) {
    countAcceptanceInvitations = json['count_acceptance_invitations'];
    invitationLink = json['invitation_link'];
    if (json.containsKey("invitations") && json['invitations'] != null) {
      var _list_invitations = json['invitations'] as List;
      List<Invitation> _listinvitation =
          _list_invitations.map((i) => Invitation.fromJson(i)).toList();
      listInvitations = _listinvitation;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count_acceptance_invitations'] = this.countAcceptanceInvitations;
    data['invitation_link'] = this.invitationLink;
    return data;
  }
}

///
class Invitation {
  int? id;
  int? acceptanceCustomerId;
  String? invitationDate;
  String? acceptanceInvitationName;

  Invitation(
      {this.id,
      this.acceptanceCustomerId,
      this.invitationDate,
      this.acceptanceInvitationName});

  Invitation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    acceptanceCustomerId = json['acceptance_customer_id'];
    invitationDate = json['invitation_date'];
    acceptanceInvitationName = json['acceptance_invitation_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['acceptance_customer_id'] = this.acceptanceCustomerId;
    data['invitation_date'] = this.invitationDate;
    data['acceptance_invitation_name'] = this.acceptanceInvitationName;
    return data;
  }
}

////
class SoldCoupon {
  int? id;
  int? customerId;
  int? orderId;
  int? providerId;
  int? couponId;
  String? couponCode;
  String? qrcode;
  int? active;
  int? used;
  int? usedInBranchId;
  int? usedByEmployeeId;
  String? usedAt;
  int? isGift;
  String? promotionCode;
  int? isBonus;
  String? createdAt;
  String? updatedAt;
  int? price;
  String? serialNumber;
  String? validTo;
  bool? outOfDate;
  String? couponLink;
  SimpleCoupon? simpleCoupon;

  SoldCoupon(
      {this.id,
      this.customerId,
      this.orderId,
      this.providerId,
      this.couponId,
      this.couponCode,
      this.qrcode,
      this.active,
      this.used,
      this.usedInBranchId,
      this.usedByEmployeeId,
      this.usedAt,
      this.isGift,
      this.promotionCode,
      this.isBonus,
      this.createdAt,
      this.updatedAt,
      this.price,
      this.serialNumber,
      this.validTo,
      this.outOfDate,
      this.simpleCoupon,
      this.couponLink});

  SoldCoupon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    orderId = json['order_id'];
    providerId = json['provider_id'];
    couponId = json['coupon_id'];
    couponCode = json['coupon_code'];
    qrcode = json['qrcode'];
    active = json['active'];
    used = json['used'];
    usedInBranchId = json['used_in_branch_id'];
    usedByEmployeeId = json['used_by_employee_id'];
    usedAt = json['used_at'];
    isGift = json['is_gift'];
    promotionCode = json['promotion_code'];
    isBonus = json['is_bonus'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    price = json['price'];
    serialNumber = json['serial_number'];
    validTo = json['valid_to'];
    outOfDate = json['out_of_date'];
    couponLink = json['coupon_link'];
    if (json.containsKey("coupon") && json['coupon'] != null) {
      simpleCoupon = SimpleCoupon.fromJson(json['coupon']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['order_id'] = this.orderId;
    data['provider_id'] = this.providerId;
    data['coupon_id'] = this.couponId;
    data['coupon_code'] = this.couponCode;
    data['qrcode'] = this.qrcode;
    data['active'] = this.active;
    data['used'] = this.used;
    data['used_in_branch_id'] = this.usedInBranchId;
    data['used_by_employee_id'] = this.usedByEmployeeId;
    data['used_at'] = this.usedAt;
    data['is_gift'] = this.isGift;
    data['promotion_code'] = this.promotionCode;
    data['is_bonus'] = this.isBonus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['price'] = this.price;
    data['serial_number'] = this.serialNumber;
    data['valid_to'] = this.validTo;
    data['out_of_date'] = this.outOfDate;
    data['coupon_link'] = this.couponLink;
    return data;
  }
}

/////
class OrderDetailData {
  int? id;
  String? orderRef;
  String? orderType;
  int? payViaPoints; //
  String? pointsRate;
  String? status;
  String? paymentMethodName;
  String? orderDate;
  String? totalFormatterd;
  String? subTotalAmountFormatted;
  String? discountAmountFormatted;
  String? orderTypeString;
  String? rewardedPointsDate;
  double? rewardedPointsAmount;
  String? redeemedPointsDate;
  double? redeemedPointsAmount;
  String? paymentDate;
  double? paymentAmount;
  String? paymentRef;
  List<OrderItem>? listorderitems;

  OrderDetailData(
      {this.id,
      this.orderRef,
      this.orderType,
      this.payViaPoints,
      this.pointsRate,
      this.status,
      this.paymentMethodName,
      this.orderDate,
      this.totalFormatterd,
      this.subTotalAmountFormatted,
      this.discountAmountFormatted,
      this.orderTypeString,
      this.rewardedPointsDate,
      this.rewardedPointsAmount,
      this.redeemedPointsDate,
      this.redeemedPointsAmount,
      this.paymentDate,
      this.paymentAmount,
      this.listorderitems,
      this.paymentRef});

  OrderDetailData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderRef = json['order_ref'];
    orderType = json['order_type'];
    payViaPoints = json['pay_via_points'];
    pointsRate = json['points_rate'];
    status = json['status'];
    paymentMethodName = json['payment_method_name'];
    orderDate = json['order_date'];
    totalFormatterd = json['total_formatterd'];
    subTotalAmountFormatted = json['sub_total_amount_formatted'];
    discountAmountFormatted = json['discount_amount_formatted'];
    orderTypeString = json['order_type_string'];
    //rewardedPointsDate = json['rewarded_points_date'];
    //rewardedPointsAmount = double.tryParse(json['rewarded_points_amount'].toString());
    //redeemedPointsDate = json['redeemed_points_date'];
    // redeemedPointsAmount = double.tryParse(json['redeemed_points_amount'].toString());
    // paymentDate = json['payment_date'];
    // paymentAmount = double.tryParse(json['payment_amount'].toString());
    paymentRef = json['payment_ref'];
    if (json.containsKey("order_items") && json['order_items'] != null) {
      var _list_orderitem = json['order_items'] as List;
      List<OrderItem> _listorderitem =
          _list_orderitem.map((i) => OrderItem.fromJson(i)).toList();
      listorderitems = _listorderitem;
    }
    if (json.containsKey("rewarded_points_date") &&
        json['rewarded_points_date'] != null) {
      rewardedPointsDate = json['rewarded_points_date'];
    }
    if (json.containsKey("rewarded_points_amount") &&
        json['rewarded_points_amount'] != null) {
      rewardedPointsAmount =
          double.tryParse(json['rewarded_points_amount'].toString());
    }
    if (json.containsKey("redeemed_points_date") &&
        json['redeemed_points_date'] != null) {
      redeemedPointsDate = json['redeemed_points_date'];
    }
    if (json.containsKey("redeemed_points_amount") &&
        json['redeemed_points_amount'] != null) {
      redeemedPointsAmount =
          double.tryParse(json['redeemed_points_amount'].toString());
    }
    if (json.containsKey("payment_date") && json['payment_date'] != null) {
      paymentDate = json['payment_date'];
    }
    if (json.containsKey("payment_amount") && json['payment_amount'] != null) {
      paymentAmount = double.tryParse(json['payment_amount'].toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_ref'] = this.orderRef;
    data['order_type'] = this.orderType;
    data['pay_via_points'] = this.payViaPoints;
    data['points_rate'] = this.pointsRate;
    data['status'] = this.status;
    data['payment_method_name'] = this.paymentMethodName;
    data['order_date'] = this.orderDate;
    data['total_formatterd'] = this.totalFormatterd;
    data['sub_total_amount_formatted'] = this.subTotalAmountFormatted;
    data['discount_amount_formatted'] = this.discountAmountFormatted;
    data['order_type_string'] = this.orderTypeString;
    data['rewarded_points_date'] = this.rewardedPointsDate;
    data['rewarded_points_amount'] = this.rewardedPointsAmount;
    data['redeemed_points_date'] = this.redeemedPointsDate;
    data['redeemed_points_amount'] = this.redeemedPointsAmount;
    data['payment_date'] = this.paymentDate;
    data['payment_amount'] = this.paymentAmount;
    data['payment_ref'] = this.paymentRef;
    return data;
  }
}

///
class OrderItem {
  int? qty;
  String? price;
  String? pointPrice;
  String? totalPrice;
  String? totalPoint;
  String? earnedPoints;
  String? totalEarnedPoints;
  String? itemTitle;
  CouponOrder? couponOrder;
  SubscriptionPackage? subscriptionPackage;
  PointPackage? pointPackage;

  OrderItem(
      {this.qty,
      this.price,
      this.pointPrice,
      this.totalPrice,
      this.totalPoint,
      this.earnedPoints,
      this.totalEarnedPoints,
      this.couponOrder,
      this.subscriptionPackage,
      this.pointPackage,
      this.itemTitle});

  OrderItem.fromJson(Map<String, dynamic> json) {
    qty = json['qty'];
    price = json['price'];
    pointPrice = json['point_price'];
    totalPrice = json['total_price'];
    totalPoint = json['total_point'];
    earnedPoints = json['earned_points'];
    totalEarnedPoints = json['total_earned_points'];
    itemTitle = json['item_title'];
    if (json.containsKey("coupon") && json['coupon'] != null) {
      couponOrder = CouponOrder.fromJson(json['coupon']);
    }
    if (json.containsKey("subscription_package") &&
        json['subscription_package'] != null) {
      subscriptionPackage =
          SubscriptionPackage.fromJson(json['subscription_package']);
    }
    if (json.containsKey("points_package") && json['points_package'] != null) {
      pointPackage = PointPackage.fromJson(json['points_package']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['point_price'] = this.pointPrice;
    data['total_price'] = this.totalPrice;
    data['total_point'] = this.totalPoint;
    data['earned_points'] = this.earnedPoints;
    data['total_earned_points'] = this.totalEarnedPoints;
    data['item_title'] = this.itemTitle;
    return data;
  }
}

class CouponOrder {
  int? id;
  String? nameAr;
  String? nameEn;
  String? providerNameEn;
  String? providerNameAr;
  String? image;
  String? imageFull;

  CouponOrder(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.providerNameEn,
      this.providerNameAr,
      this.image,
      this.imageFull});

  CouponOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    providerNameEn = json['provider_name_en'];
    providerNameAr = json['provider_name_ar'];
    image = json['image'];
    imageFull = json['image_full'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['provider_name_en'] = this.providerNameEn;
    data['provider_name_ar'] = this.providerNameAr;
    data['image'] = this.image;
    data['image_full'] = this.imageFull;
    return data;
  }

  Map<String, dynamic> _toMap() {
    return {
      'name_ar': nameAr,
      'name_en': nameEn,
      'provider_name_en': providerNameEn,
      'provider_name_ar': providerNameAr,
    };
  }

  dynamic getPropertyEffectedByLang(String propertyName) {
    var _mapRep = _toMap();
    if (_mapRep.containsKey(propertyName)) {
      return _mapRep[propertyName];
    }
    throw ArgumentError('propery not found');
  }
}

class DetailsPageData {
  int? id;
  String? titleAr;
  String? titleEn;
  String? slug;
  String? descriptionAr;
  String? descriptionEn;

  DetailsPageData(
      {this.id,
      this.titleAr,
      this.titleEn,
      this.slug,
      this.descriptionAr,
      this.descriptionEn});

  DetailsPageData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titleAr = json['title_ar'];
    titleEn = json['title_en'];
    slug = json['slug'];
    descriptionAr = json['description_ar'];
    descriptionEn = json['description_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title_ar'] = this.titleAr;
    data['title_en'] = this.titleEn;
    data['slug'] = this.slug;
    data['description_ar'] = this.descriptionAr;
    data['description_en'] = this.descriptionEn;
    return data;
  }

  Map<String, dynamic> _toMap() {
    return {
      'title_en': titleEn,
      'title_ar': titleAr,
      'description_ar': descriptionAr,
      'description_en': descriptionEn,
    };
  }

  dynamic getPropertyEffectedByLang(String propertyName) {
    var _mapRep = _toMap();
    if (_mapRep.containsKey(propertyName)) {
      return _mapRep[propertyName];
    }
    throw ArgumentError('propery not found');
  }
}

class SearchData {
  List<DataTag>? listdataTag;
  List<SimpleCoupon>? listDatacoupon;
  List<SimpleOffer>? listDataoffer;
  List<SimpleProvider>? listdataprovider;

  SearchData(
      {this.listdataTag,
      this.listDatacoupon,
      this.listDataoffer,
      this.listdataprovider});

  SearchData.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("data_coupons") && json['data_coupons'] != null) {
      var _list_datacoupon = json['data_coupons'] as List;
      List<SimpleCoupon> _listdataCoupon =
          _list_datacoupon.map((i) => SimpleCoupon.fromJson(i)).toList();
      listDatacoupon = _listdataCoupon;
    }
    if (json.containsKey("data_offers") && json['data_offers'] != null) {
      var _list_dataOffer = json['data_offers'] as List;
      List<SimpleOffer> _listsdataOffer =
          _list_dataOffer.map((i) => SimpleOffer.fromJson(i)).toList();
      listDataoffer = _listsdataOffer;
    }
    if (json.containsKey("data_providers") && json['data_providers'] != null) {
      var _list_dataProviders = json['data_providers'] as List;
      List<SimpleProvider> _listdataProvider =
          _list_dataProviders.map((i) => SimpleProvider.fromJson(i)).toList();
      listdataprovider = _listdataProvider;
    }

    if (json.containsKey("data_tags") && json['data_tags'] != null) {
      var _list_dataTag = json['data_tags'] as List;
      List<DataTag> _listDataTag =
          _list_dataTag.map((i) => DataTag.fromJson(i)).toList();
      listdataTag = _listDataTag;
    }
  }
}

class DataTag {
  int? id;
  String? nameAr;
  String? nameEn;

  DataTag({this.id, this.nameAr, this.nameEn});

  DataTag.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    return data;
  }

  Map<String, dynamic> _toMap() {
    return {
      'name_en': nameEn,
      'name_ar': nameAr,
    };
  }

  dynamic getPropertyEffectedByLang(String propertyName) {
    var _mapRep = _toMap();
    if (_mapRep.containsKey(propertyName)) {
      return _mapRep[propertyName];
    }
    throw ArgumentError('propery not found');
  }
}

class FinalSearchData {
  SearchedCoupons? SearchedCoupon;
  SearchedOffers? Searchedoffer;
  SearchedProvider? Searchedprovider;

  FinalSearchData(
      {this.SearchedCoupon, this.Searchedoffer, this.Searchedprovider});

  FinalSearchData.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("searched_providers") &&
        json['searched_providers'] != null) {
      Searchedprovider = SearchedProvider.fromJson(json['searched_providers']);
    }
    if (json.containsKey("searched_coupons") &&
        json['searched_coupons'] != null) {
      SearchedCoupon = SearchedCoupons.fromJson(json['searched_coupons']);
    }
    if (json.containsKey("searched_special_offers") &&
        json['searched_special_offers'] != null) {
      Searchedoffer = SearchedOffers.fromJson(json['searched_special_offers']);
    }
  }
}

class SearchedProvider {
  int? nextPage;
  int? totalResults;
  List<SimpleProvider>? listSimpleProvider;

  SearchedProvider({this.nextPage, this.totalResults, this.listSimpleProvider});

  SearchedProvider.fromJson(Map<String, dynamic> json) {
    totalResults = json['total_results'];
    if (json.containsKey("providers") && json['providers'] != null) {
      var _list_providers = json['providers'] as List;
      List<SimpleProvider> _listProviders =
          _list_providers.map((i) => SimpleProvider.fromJson(i)).toList();
      listSimpleProvider = _listProviders;
    }
    if (json.containsKey("next_page") && json['next_page'] != null) {
      nextPage = json['next_page'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['next_page'] = this.nextPage;
    data['total_results'] = this.totalResults;
    return data;
  }
}

class SearchedCoupons {
  int? nextPage;
  int? totalResults;
  List<SimpleCoupon>? listSimpleCoupons;

  SearchedCoupons({this.nextPage, this.totalResults, this.listSimpleCoupons});

  SearchedCoupons.fromJson(Map<String, dynamic> json) {
    // nextPage = json['next_page'];
    totalResults = json['total_results'];
    if (json.containsKey("coupons") && json['coupons'] != null) {
      var _list_coupons = json['coupons'] as List;
      List<SimpleCoupon> _listcoupons =
          _list_coupons.map((i) => SimpleCoupon.fromJson(i)).toList();
      listSimpleCoupons = _listcoupons;
    }
    if (json.containsKey("next_page") && json['next_page'] != null) {
      nextPage = json['next_page'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['next_page'] = this.nextPage;
    data['total_results'] = this.totalResults;
    return data;
  }
}

class SearchedOffers {
  int? nextPage;
  int? totalResults;
  List<SimpleOffer>? listSimpleOffer;

  SearchedOffers({this.nextPage, this.totalResults, this.listSimpleOffer});

  SearchedOffers.fromJson(Map<String, dynamic> json) {
    nextPage = json['next_page'];
    totalResults = json['total_results'];
    if (json.containsKey("special_offers") && json['special_offers'] != null) {
      var _list_offers = json['special_offers'] as List;
      List<SimpleOffer> _listoffers =
          _list_offers.map((i) => SimpleOffer.fromJson(i)).toList();
      listSimpleOffer = _listoffers;
    }

    if (json.containsKey("next_page") && json['next_page'] != null) {
      nextPage = json['next_page'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['next_page'] = this.nextPage;
    data['total_results'] = this.totalResults;
    return data;
  }
}

class IsActiveData {
  String? userType;
  User? user;
  Customer? customer;

  IsActiveData({this.userType, this.user, this.customer});

  IsActiveData.fromJson(Map<String, dynamic> json) {
    userType = json['user_type'];
    if (json.containsKey("user") && json['user'] != null) {
      user = User.fromJson(json['user']);
    }
    if (json.containsKey("customer") && json['customer'] != null) {
      customer = Customer.fromJson(json['customer']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_type'] = this.userType;
    return data;
  }
}

class CategoryDetailsData {
  List<SimpleCoupon>? listBestcoupon;
  List<SimpleOffer>? listBestoffer;
  List<SimpleProvider>? listBestprovider;
  List<FlashDeal>? listFlashDeal;
  List<Category>? listSubCategory;
  List<CategorySection>? listCategorirsSection;

  CategoryDetailsData(
      {this.listBestcoupon,
      this.listBestoffer,
      this.listFlashDeal,
      this.listSubCategory,
      this.listCategorirsSection,
      this.listBestprovider});

  CategoryDetailsData.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("best_coupons") && json['best_coupons'] != null) {
      var _list_bestcoupon = json['best_coupons'] as List;
      List<SimpleCoupon> _listbestCoupon =
          _list_bestcoupon.map((i) => SimpleCoupon.fromJson(i)).toList();
      listBestcoupon = _listbestCoupon;
    }
    if (json.containsKey("best_offers") && json['best_offers'] != null) {
      var _list_bestOffer = json['best_offers'] as List;
      List<SimpleOffer> _listsbestOffer =
          _list_bestOffer.map((i) => SimpleOffer.fromJson(i)).toList();
      listBestoffer = _listsbestOffer;
    }
    if (json.containsKey("best_providers") && json['best_providers'] != null) {
      var _list_bestProvider = json['best_providers'] as List;
      List<SimpleProvider> _listsbestProvider =
          _list_bestProvider.map((i) => SimpleProvider.fromJson(i)).toList();
      listBestprovider = _listsbestProvider;
    }
    if (json.containsKey("flash_deals") && json['flash_deals'] != null) {
      var _list_flashdeal = json['flash_deals'] as List;
      List<FlashDeal> _listflashdeal =
          _list_flashdeal.map((i) => FlashDeal.fromJson(i)).toList();
      listFlashDeal = _listflashdeal;
    }
    if (json.containsKey("sub_categories") && json['sub_categories'] != null) {
      var _list_category = json['sub_categories'] as List;
      List<Category> _listcategory =
          _list_category.map((i) => Category.fromJson(i)).toList();
      listSubCategory = _listcategory;
    }
    if (json.containsKey("sections") && json['sections'] != null) {
      var _list_categorySection = json['sections'] as List;
      List<CategorySection> _listcategorySection = _list_categorySection
          .map((i) => CategorySection.fromJson(i))
          .toList();
      listCategorirsSection = _listcategorySection;
    }
  }
}

class ProvidersReview {
  int? id;
  String? review;
  int? rating;
  String? createdAtFormatted;
  Customer? customer;

  ProvidersReview({this.id, this.review, this.rating, this.createdAtFormatted});

  ProvidersReview.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    review = json['review'];
    rating = json['rating'];
    createdAtFormatted = json['created_at_formatted'];
    if (json.containsKey("customer") && json['customer'] != null) {
      customer = Customer.fromJson(json['customer']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['review'] = this.review;
    data['rating'] = this.rating;
    data['created_at_formatted'] = this.createdAtFormatted;
    return data;
  }
}

class CouponReview {
  int? id;
  String? review;
  int? rating;
  String? createdAtFormatted;
  Customer? customer;

  CouponReview({this.id, this.review, this.rating, this.createdAtFormatted});

  CouponReview.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    review = json['review'];
    rating = json['rating'];
    createdAtFormatted = json['created_at_formatted'];
    if (json.containsKey("customer") && json['customer'] != null) {
      customer = Customer.fromJson(json['customer']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['review'] = this.review;
    data['rating'] = this.rating;
    data['created_at_formatted'] = this.createdAtFormatted;
    return data;
  }
}

class OfferReview {
  int? id;
  String? review;
  int? rating;
  String? createdAtFormatted;
  Customer? customer;

  OfferReview({this.id, this.review, this.rating, this.createdAtFormatted});

  OfferReview.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    review = json['review'];
    rating = json['rating'];
    createdAtFormatted = json['created_at_formatted'];
    if (json.containsKey("customer") && json['customer'] != null) {
      customer = Customer.fromJson(json['customer']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['review'] = this.review;
    data['rating'] = this.rating;
    data['created_at_formatted'] = this.createdAtFormatted;
    return data;
  }
}

class WhishListIdData {
  List<int> listcoupon = [];
  List<int> listoffer = [];
  List<int> listprovider = [];

  WhishListIdData(
      {required this.listcoupon,
      required this.listoffer,
      required this.listprovider});

  WhishListIdData.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("coupons") && json['coupons'] != null) {
      var _list_bestcoupon = json['coupons'] as List;
      // List<SimpleCoupon> _listbestCoupon =
      //     _list_bestcoupon.map((i) => SimpleCoupon.fromJson(i)).toList();
      listcoupon = _list_bestcoupon.cast<int>();
    }
    if (json.containsKey("special_offers") && json['special_offers'] != null) {
      var _list_bestOffer = json['special_offers'] as List;
      // List<SimpleOffer> _listsbestOffer =
      //     _list_bestOffer.map((i) => SimpleOffer.fromJson(i)).toList();
      listoffer = _list_bestOffer.cast<int>();
    }
    if (json.containsKey("providers") && json['providers'] != null) {
      var _list_bestProvider = json['providers'] as List;
      // List<SimpleProvider> _listsbestProvider =
      //     _list_bestProvider.map((i) => SimpleProvider.fromJson(i)).toList();
      listprovider = _list_bestProvider.cast<int>();
    }
  }
}

class WhishListData {
  List<SimpleCoupon> listcoupon = [];
  List<SimpleOffer> listoffer = [];
  List<SimpleProvider> listprovider = [];

  WhishListData(
      {required this.listcoupon,
      required this.listoffer,
      required this.listprovider});

  WhishListData.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("coupons") && json['coupons'] != null) {
      var _list_bestcoupon = json['coupons'] as List;
      List<SimpleCoupon> _listbestCoupon =
          _list_bestcoupon.map((i) => SimpleCoupon.fromJson(i)).toList();
      listcoupon = _listbestCoupon;
    }
    if (json.containsKey("special_offers") && json['special_offers'] != null) {
      var _list_bestOffer = json['special_offers'] as List;
      List<SimpleOffer> _listsbestOffer =
          _list_bestOffer.map((i) => SimpleOffer.fromJson(i)).toList();
      listoffer = _listsbestOffer;
    }
    if (json.containsKey("providers") && json['providers'] != null) {
      var _list_bestProvider = json['providers'] as List;
      List<SimpleProvider> _listsbestProvider =
          _list_bestProvider.map((i) => SimpleProvider.fromJson(i)).toList();
      listprovider = _listsbestProvider;
    }
  }
}

class FormItemData {
  int index = 0;
  String? type;
  bool? required;
  String? subtype;
  String? labelEn;
  String? labelAr;
  String? descriptionEn;
  String? descriptionAr;
  String? className;
  String? name;
  bool? access;
  bool? multiple;
  List<SelectItemValue> listvalues = [];

  FormItemData(
      {this.type,
      this.required,
      this.subtype,
      this.labelEn,
      this.labelAr,
      this.descriptionEn,
      this.descriptionAr,
      this.className,
      this.name,
      this.multiple,
      required this.listvalues,
      this.access});

  FormItemData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    required = json['required'];
    subtype = json['subtype'];
    labelEn = json['label_en'];
    labelAr = json['label_ar'];
    descriptionEn = json['description_en'];
    descriptionAr = json['description_ar'];
    className = json['className'];
    name = json['name'];
    access = json['access'];
    multiple = json['multiple'];
    if (json.containsKey("values") && json['values'] != null) {
      var _list_values = json['values'] as List;
      List<SelectItemValue> _listvalues =
          _list_values.map((i) => SelectItemValue.fromJson(i)).toList();
      listvalues = _listvalues;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['required'] = this.required;
    data['subtype'] = this.subtype;
    data['label_en'] = this.labelEn;
    data['label_ar'] = this.labelAr;
    data['description_en'] = this.descriptionEn;
    data['description_ar'] = this.descriptionAr;
    data['className'] = this.className;
    data['name'] = this.name;
    data['access'] = this.access;
    data['multiple'] = this.multiple;
    return data;
  }

  Map<String, dynamic> _toMap() {
    return {
      'label_en': labelEn,
      'label_ar': labelAr,
    };
  }

  dynamic getPropertyEffectedByLang(String propertyName) {
    var _mapRep = _toMap();
    if (_mapRep.containsKey(propertyName)) {
      return _mapRep[propertyName];
    }
    throw ArgumentError('propery not found');
  }
}

class SelectItemValue {
  String? labelEn;
  String? labelAr;
  bool? selected;

  SelectItemValue({this.labelEn, this.labelAr, this.selected});

  SelectItemValue.fromJson(Map<String, dynamic> json) {
    labelEn = json['label_en'];
    labelAr = json['label_ar'];
    selected = json['selected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label_en'] = this.labelEn;
    data['label_ar'] = this.labelAr;
    data['selected'] = this.selected;
    return data;
  }

  Map<String, dynamic> _toMap() {
    return {
      'label_en': labelEn,
      'label_ar': labelAr,
    };
  }

  dynamic getPropertyEffectedByLang(String propertyName) {
    var _mapRep = _toMap();
    if (_mapRep.containsKey(propertyName)) {
      return _mapRep[propertyName];
    }
    throw ArgumentError('propery not found');
  }
}

class IntroData {
  int? id;
  String? title;
  String? brief;
  String? image;

  IntroData({this.id, this.title, this.brief, this.image});

  IntroData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    brief = json['brief'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['brief'] = this.brief;
    data['image'] = this.image;
    return data;
  }
}
